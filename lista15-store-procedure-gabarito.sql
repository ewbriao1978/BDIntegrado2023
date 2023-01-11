DROP DATABASE IF EXISTS lista15;
CREATE DATABASE lista15;

\c lista15;

-- 1
CREATE TABLE cliente (
    id serial primary key,
    cpf character(11),
    nome text,
    rg character(11),
    sexo char(1),
    uf char(2)
);
CREATE TABLE operadora (
    id serial primary key,
    nome text,
    cnpj character(14)
);
CREATE TABLE plano (
    id serial primary key,
    valor real,
    descricao text,
    operadora_id integer references operadora (id)
);
CREATE TABLE telefone (
    id serial primary key,
    numero text,
    cliente_id integer references cliente (id)
);
CREATE TABLE contrato (
    id serial primary key,
    plano_id integer references plano (id),
    telefone_id integer references telefone (id),
    data_inicio date DEFAULT CURRENT_DATE,
    data_fim date,
    valor_final real
);
INSERT INTO cliente (cpf, nome) VALUES 
('11111111111', 'Igor'),
('22222222222', 'Betito');
INSERT INTO telefone (numero, cliente_id) VALUES
('(53) 000000000', 1),
('(53) 111111111', 1),
('(54) 222222222', 2);
INSERT INTO operadora (cnpj, nome) VALUES
('83264208000145', 'Vivo'),
('93284129000150', 'Tim'),
('81161477000150', 'Claro');
INSERT INTO plano (valor, descricao, operadora_id) VALUES
(150, 'Vivo Básico', 1),
(250, 'Vivo Deluxe', 1),
(200, 'Tim black', 2),
(100, 'Claro básico', 3),
(300, 'Claro Deluxe Power', 3);
INSERT INTO contrato (plano_id, telefone_id, valor_final) VALUES 
(1,1, 150),
(2,2, 250),
(4,3, 100);

-- 2
CREATE TABLE PRODUTO (
    CODIGO integer primary key,
    CATEGORIA CHAR(1),
    VALOR real
);
INSERT INTO PRODUTO VALUES (1001,'A',7.55);
INSERT INTO PRODUTO VALUES (1002,'B',5.95);
INSERT INTO PRODUTO VALUES (1003,'C',3.45);

-- 3
 CREATE TABLE LUCRO (
     ANO INTEGER PRIMARY KEY,
     VALOR REAL
 ); 
 INSERT INTO LUCRO VALUES (2007,1200000);
 INSERT INTO LUCRO VALUES (2008,1500000);
 INSERT INTO LUCRO VALUES (2009,1400000); 

 CREATE TABLE SALARIO (
     MATRICULA INTEGER PRIMARY KEY,
     VALOR REAL
 );
 INSERT INTO SALARIO VALUES (1001,2500);
 INSERT INTO SALARIO VALUES (1002,3200); 


-- 1)
CREATE FUNCTION dahDescontoOuCriaContrato(integer, integer) RETURNS boolean AS
$$
DECLARE    
    registro RECORD;
    plano_barato RECORD;
    plano_caro RECORD;
    telefone_id integer;
    telefone_aux integer;
BEGIN   
--    cliente_id $1, operadora_id $2
    SELECT INTO registro cliente.nome as cliente_nome, operadora.nome as operadora_nome, plano.descricao as plano_descricao, telefone.numero as telefone_numero FROM cliente INNER JOIN telefone ON(cliente.id = telefone.cliente_id) INNER JOIN contrato ON (contrato.telefone_id = telefone.id) INNER JOIN plano ON (contrato.plano_id = plano.id) INNER JOIN operadora ON (operadora.id = plano.operadora_id) WHERE cliente.id = $1 and operadora.id = $2;

--    se o cliente não tem contrato com a operadora
    IF registro.cliente_nome IS NULL THEN    
       
--        buscando o plano mais barato desta operadora
        SELECT INTO plano_barato id, descricao, valor FROM plano WHERE operadora_id = $2 ORDER BY valor LIMIT 1;
  
--      buscando o primeiro telefone cadastrado daquele cliente em potencial
        SELECT INTO telefone_id telefone.id FROM telefone WHERE cliente_id = $1 LIMIT 1;

        --    se há telefone cadastrado
        IF telefone_id IS NOT NULL THEN
--          crio um contrato
            INSERT INTO contrato (plano_id, telefone_id, valor_final) VALUES(plano_barato.id,   telefone_id, plano_barato.valor);

--  APAGA CONTRATOS ANTERIORES DE operadores diferentes 
        telefone_aux := telefone_id;
            
        DELETE FROM contrato WHERE contrato.telefone_id = telefone_aux and contrato.id NOT IN (SELECT id FROM contrato WHERE contrato.telefone_id = telefone_aux AND plano_id IN (SELECT id FROM plano WHERE plano.operadora_id = $2));

            RETURN TRUE;
             
        ELSE 
--           senao, xabum!!!
            RAISE EXCEPTION 'cliente não tem telefone cadastrado';
            RETURN FALSE;
        END IF; 
    ELSE
        SELECT INTO plano_caro contrato.id as contrato_id, plano.id AS plano_id, plano.valor, telefone.id as telefone_id FROM cliente INNER JOIN telefone ON(cliente.id = telefone.cliente_id) INNER JOIN contrato ON (contrato.telefone_id = telefone.id) INNER JOIN plano ON (contrato.plano_id = plano.id) INNER JOIN operadora ON (operadora.id = plano.operadora_id) WHERE cliente.id = $1 ORDER BY valor DESC LIMIT 1;
        
        UPDATE contrato SET valor_final = valor_final/2 WHERE id = plano_caro.contrato_id;

        RETURN TRUE;
    END IF;
    RETURN FALSE;
END;
$$ LANGUAGE 'plpgsql';


-- 2
CREATE FUNCTION reajuste() RETURNS void AS 
$$
BEGIN
    UPDATE produto SET valor = valor*1.05 WHERE categoria = 'A';
    UPDATE produto SET valor = valor*1.10 WHERE categoria = 'B';
    UPDATE produto SET valor = valor*1.15 WHERE categoria = 'C';

END;
$$ LANGUAGE 'plpgsql';


-- 3
CREATE FUNCTION aprovado_ou_reprovado(ra text, nome text, a1 real, a2 real, a3 real, a4 real) RETURNS VOID AS
$$
DECLARE
   maior REAL;
   media REAL;
   resultado TEXT;
BEGIN
   IF a1 >= a2 THEN
        maior := a1;
    ELSE
        maior := a2;   
    END IF;
    media := (maior + a3 + a4)/3;
    IF media >= 6 THEN
        resultado := 'APROVADO';
    ELSE
        resultado := 'REPROVADO';
    END IF;
    CREATE TABLE IF NOT EXISTS aluno (
        ra text primary key,
        nome text,
        a1 real,
        a2 real, 
        a3 real, 
        a4 real,
        media real,
        resultado text
    );
    INSERT INTO aluno (ra, nome, a1, a2, a3, a4, media, resultado) VALUES (ra, nome, a1, a2,a3,a4, media, resultado);
END;
$$ LANGUAGE 'plpgsql';


-- 4
CREATE FUNCTION bonus(integer, integer) RETURNS real AS 
$$
DECLARE
    lucro real;
    salario real;
BEGIN
    select into lucro valor from lucro where ano = $2;
    select into salario valor from salario where matricula = $1;
    return lucro * 0.01 + salario * 0.05;
END;
$$ LANGUAGE 'plpgsql';














