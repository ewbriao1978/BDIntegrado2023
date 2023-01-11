DROP DATABASE IF EXISTS aula090522;

CREATE DATABASE aula090522;

\c aula090522;

CREATE TABLE funcionario (
    id serial primary key,
    cpf character(11),
    nome text,
    salario real,
    unique(cpf)
);

CREATE TABLE funcionario_excluido (
    id integer,
    cpf character(11),
    nome text,
    salario real,
    data_exclusao DATE DEFAULT CURRENT_DATE,
    UNIQUE(cpf)
);

INSERT INTO funcionario (cpf, nome, salario) VALUES 
('51076078028', 'Doctor Strange', 20000),
('57004738019','Wanda', 15000),
('85325268023', 'America Chaves', 10000),
('50504053000', 'Renato Russo', 20000),
('60540328014', 'Renato Gusmão', 30000);


CREATE FUNCTION menorSalario() RETURNS real AS
$$
DECLARE
    menor_salario REAL;  
BEGIN
    SELECT INTO menor_salario MIN(salario) FROM funcionario;
    RETURN menor_salario;
END;
$$ LANGUAGE 'plpgsql';

-- com retorno múltiplo de parâmetros
CREATE FUNCTION nomeValorMaiorSalario(OUT nome_maior_salario TEXT, OUT maior_salario REAL) AS
$$
DECLARE
BEGIN
    SELECT INTO maior_salario, nome_maior_salario MAX(salario), nome FROM funcionario GROUP BY nome;
END;
$$ LANGUAGE 'plpgsql';

-- com record
CREATE FUNCTION nomeValorMaiorSalarioComRecord() RETURNS RECORD AS 
$$
DECLARE
    registro RECORD;
BEGIN
    SELECT INTO registro MAX(salario), nome FROM funcionario GROUP BY nome;
    RETURN registro;        
END;
$$ LANGUAGE 'plpgsql';

-- com type
CREATE FUNCTION nomeValorMaiorSalarioComText() RETURNS text AS 
$$
DECLARE
    maior_salario REAL;
    nome_maior_salario TEXT;
BEGIN
    SELECT INTO maior_salario, nome_maior_salario MAX(salario), nome FROM funcionario GROUP BY nome;
    RETURN nome_maior_salario || ' - ' || maior_salario;
END;
$$ LANGUAGE 'plpgsql';

-- aumentar em 10%
CREATE FUNCTION aumentarSalario10() RETURNS void AS
$$
BEGIN
    UPDATE funcionario SET salario = salario * 1.10;
END;
$$ LANGUAGE 'plpgsql';


-- aumentar em x
CREATE FUNCTION aumentarSalarioX(real) RETURNS void AS
$$
DECLARE
    aumento ALIAS FOR $1;
BEGIN    
    UPDATE funcionario SET salario = salario * (1 + aumento);
END;
$$ LANGUAGE 'plpgsql';


CREATE FUNCTION excluirPorId(integer) RETURNS void AS
$$
DECLARE
    registro funcionario%ROWTYPE;
BEGIN
      SELECT INTO registro * FROM funcionario WHERE id = $1;
      INSERT INTO funcionario_excluido (id, nome, cpf, salario) VALUES
      (registro.id, registro.nome, registro.cpf, registro.salario);
      DELETE FROM funcionario WHERE id = $1;
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION restaurarPorId(integer) RETURNS void AS
$$
DECLARE
    registro funcionario%ROWTYPE;
BEGIN
      SELECT INTO registro * FROM funcionario_excluido WHERE id = $1;
      INSERT INTO funcionario (nome, cpf, salario) VALUES
      (registro.nome, registro.cpf, registro.salario);
      DELETE FROM funcionario_excluido WHERE id = $1;
END;
$$ LANGUAGE 'plpgsql';


CREATE FUNCTION mediaSalarioRenato() RETURNS real AS
$$
DECLARE
    media REAL;
BEGIN
     SELECT INTO media AVG(salario) FROM funcionario WHERE nome ILIKE ('RENATO%');
    RETURN media;
END;
$$ LANGUAGE 'plpgsql';


-- transforma nomes em maiúsculo
CREATE FUNCTION transformaNomeEmMaiusculo() RETURNS void AS
$$
BEGIN    
    UPDATE funcionario SET nome = UPPER(nome);
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION validaCPF(character(11)) RETURNS boolean AS
$$
DECLARE
    resultado BOOLEAN;
    cpf ALIAS FOR $1;
    nro1 INTEGER;
    nro2 INTEGER;  
    nro3 INTEGER;
    nro4 INTEGER;
    nro5 INTEGER;
    nro6 INTEGER;
    nro7 INTEGER;
    nro8 INTEGER;
    nro9 INTEGER;
    nro10 INTEGER;
    nro11 INTEGER;
    soma INTEGER;
    resto INTEGER;
    resultadoDigito1 BOOLEAN;
    resultadoDigito2 BOOLEAN;
BEGIN
    BEGIN
        -- 66167566020
        resultado := FALSE;
        resultadoDigito1 := FALSE;
        resultadoDigito2 := FALSE;
        IF cpf is NULL THEN
            RETURN FALSE;
        END IF;
        IF LENGTH(cpf) != 11 THEN
            RETURN FALSE;
        END IF;
        IF cpf = '00000000000' or 
		    cpf = '11111111111' or 
		    cpf = '22222222222' or 
		    cpf = '33333333333' or 
		    cpf = '44444444444' or 
		    cpf = '55555555555' or 
		    cpf = '66666666666' or 
		    cpf = '77777777777' or 
		    cpf = '88888888888' or 
		    cpf = '99999999999' THEN
            return FALSE;
        END IF;
        nro1 := SUBSTRING(cpf,1, 1);
    --    RAISE NOTICE '%', nro1;
        nro2 := SUBSTRING(cpf,2, 1);
    --    RAISE NOTICE '%', nro2;    
        nro3 := SUBSTRING(cpf,3, 1);
    --    RAISE NOTICE '%', nro3;
        nro4 := SUBSTRING(cpf,4, 1);
    --    RAISE NOTICE '%', nro4;
        nro5 := SUBSTRING(cpf,5, 1);
    --    RAISE NOTICE '%', nro5;
        nro6 := SUBSTRING(cpf,6, 1);
    --    RAISE NOTICE '%', nro6;
        nro7 := SUBSTRING(cpf,7, 1);
    --    RAISE NOTICE '%', nro7;
        nro8 := SUBSTRING(cpf,8, 1);
    --    RAISE NOTICE '%', nro8;
        nro9 := SUBSTRING(cpf,9, 1);
    --    RAISE NOTICE '%', nro9;
        nro10 := SUBSTRING(cpf,10, 1);
    --    RAISE NOTICE '%', nro10;
        nro11 := SUBSTRING(cpf,11, 1);
    --    RAISE NOTICE '%', nro11;
    --    DIGITO 1
        soma := nro1 * 10 + nro2 * 9 + nro3 * 8 + nro4 * 7 + nro5 * 6 + nro6 * 5 + nro7 * 4 + nro8 * 3 + nro9 * 2;
        resto := (soma * 10) % 11;   
        IF resto = 10 THEN
            resto := 0;
        END IF;
        IF resto = nro10 THEN
            resultadoDigito1 := TRUE;
        END IF;
    --  DIGITO 2
        soma := nro1 * 11 + nro2 * 10 + nro3 * 9 + nro4 * 8 + nro5 * 7 + nro6 * 6 + nro7 * 5 + nro8 * 4 + nro9 * 3 + nro10 * 2;
        resto := (soma * 10) % 11;   
        IF resto = 10 THEN
            resto := 0;
        END IF;    
        IF resto = nro11 THEN
            resultadoDigito2 := TRUE;
        END IF;
        resultado := resultadoDigito1 AND resultadoDigito2;
        return resultado;
    EXCEPTION
        WHEN OTHERS THEN RAISE NOTICE 'DEU RUIM';
        RETURN FALSE;
    END;    
END;
$$ LANGUAGE 'plpgsql';


CREATE FUNCTION sorteiaFuncionario() RETURNS text as
$$
DECLARE
    resultado TEXT;
BEGIN
    SELECT INTO resultado nome FROM funcionario ORDER BY RANDOM() LIMIT 1;
    RETURN resultado;
END;
$$ LANGUAGE 'plpgsql';



