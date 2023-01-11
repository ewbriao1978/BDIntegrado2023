DROP DATABASE aula230522;
CREATE DATABASE aula230522;

\c aula230522;

CREATE TABLE empregados (
    codigo int4 PRIMARY KEY NOT NULL ,
    nome VARCHAR(30),
    salario int4,
    ultima_data timestamp,
    ultimo_usuario VARCHAR(50)
);

CREATE TABLE empregados_audit (
    operacao CHAR(1) NOT NULL,
    usuario  VARCHAR NOT NULL,
    data TIMESTAMP NOT NULL,
    nome VARCHAR NOT NULL,
    salario integer
);

CREATE TABLE emp_audit (
    usuario VARCHAR NOT NULL,
    data TIMESTAMP NOT NULL,
    id INTEGER NOT NULL,
    coluna text NOT NULL,
    valor_antigo TEXT NOT NULL,
    valor_novo TEXT NOT NULL
);

-- ==============================

CREATE OR REPLACE FUNCTION empregados_gatilho () RETURNS TRIGGER AS 
$$
BEGIN
    IF NEW.nome IS NULL THEN
        RAISE EXCEPTION 'o nome do empregado NAO pode ser NULO';
    END IF;
    IF NEW.salario IS NULL THEN
        RAISE EXCEPTION '% NAO pode ter salario NULO', NEW.nome;
    END IF;
    IF NEW.salario <= 0 THEN
        RAISE EXCEPTION 'O empregado NAO pode ter salario <= 0';
    END IF;
    NEW.ultima_data  := 'now';
    NEW.ultimo_usuario := CURRENT_USER;
    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER empregados_gatilho BEFORE INSERT OR UPDATE ON empregados
FOR EACH ROW EXECUTE PROCEDURE empregados_gatilho();


-- ==============================

CREATE OR REPLACE FUNCTION processa_empregados_audit() RETURNS TRIGGER AS
$$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO empregados_audit (operacao, usuario, data, nome)
            VALUES ('E', USER, NOW(), OLD.nome);
        RETURN OLD;    
    ELSIF (TG_OP = 'UPDATE') THEN
         INSERT INTO empregados_audit (operacao, usuario, data, nome)
            VALUES ('A', USER, NOW(), NEW.nome);
        RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO empregados_audit (operacao, usuario, data, nome)
            VALUES ('I', USER, NOW(), NEW.nome);
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE 'plpgsql'; 

CREATE TRIGGER empregados_audit AFTER INSERT OR UPDATE OR DELETE ON empregados FOR EACH ROW EXECUTE PROCEDURE processa_empregados_audit();
-- ======================================================

CREATE OR REPLACE FUNCTION processa_emp_audit() RETURNS TRIGGER AS
$$
BEGIN
    IF (NEW.codigo != OLD.codigo) THEN
        RAISE EXCEPTION 'NAO eh permitido atualizar o campo de codigo';
    END IF;
    IF (NEW.nome != OLD.nome) THEN
        INSERT INTO emp_audit (usuario, data , id, coluna, valor_antigo, valor_novo) VALUES (USER, CURRENT_TIMESTAMP, NEW.codigo, 'nome', OLD.nome, NEW.nome);
    END IF;
    IF (NEW.salario  != OLD.salario) THEN
         INSERT INTO emp_audit (usuario, data , id, coluna, valor_antigo, valor_novo) VALUES (USER, CURRENT_TIMESTAMP, NEW.codigo, 'salario', OLD.salario, NEW.salario);
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE 'plpgsql'; 

CREATE TRIGGER emp_audit AFTER UPDATE ON empregados FOR EACH ROW EXECUTE PROCEDURE processa_emp_audit();

INSERT INTO empregados (codigo, nome, salario) VALUES 
(1, 'joão', 1000),
(2, 'JOSÉ', 1500),
(3, 'MARIA', 2500);

UPDATE empregados SET salario = 2500 WHERE codigo = 2;

UPDATE empregados SET nome = 'Maria cecilia' WHERE codigo = 3;






















