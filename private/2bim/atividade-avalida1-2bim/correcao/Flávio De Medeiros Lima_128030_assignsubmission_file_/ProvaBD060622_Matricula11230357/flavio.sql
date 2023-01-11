/*
   ProvaBD_06-06-22
   Matricula_11230357
*/

-- 1) Questão 1:
DROP DATABASE IF EXISTS provaq1;
CREATE DATABASE provaq1;

\c provaq1;

DROP SCHEMA IF EXISTS telespectador;
DROP SCHEMA IF EXISTS ingresso;
DROP SCHEMA IF EXISTS sessao;
DROP SCHEMA IF EXISTS filme;
DROP SCHEMA IF EXISTS sala;
DROP SCHEMA IF EXISTS funcionario;
DROP SCHEMA IF EXISTS turno;

SET search_path TO public, sala;

CREATE TABLE telespectador(
   id SERIAL PRIMARY KEY,
   nome TEXT NOT NULL,   
   UNIQUE (id),
   price NUMERIC NOT NULL CHECK(price > 0)
);
CREATE TABLE ingresso (
   id SERIAL PRIMARY KEY,
   telespectador_id INTEGER REFERENCES telespectador(id),
   sessao_id INTEGER REFERENCES sessao(id);
   valor_ingresso REAL,
   corredor CHARACTER(11) NOT NULL,
   poltrona INTEGER  --??? > 0
);
CREATE TABLE sessao(
   id SERIAL PRIMARY KEY,
   filme_id INTEGER REFERENCES filme(id),
   sala_id INTEGER REFERENCES sala(id),
   data DATE -- ???
   hora TIMESTAMP -- ???
);
CREATE TABLE filme(
   id SERIAL PRIMARY KEY,
   titulo TEXT NOT NULL,
   duracao INTEGER -- ??? > 0
);
CREATE TABLE sala(
   id SERIAL PRIMARY KEY,
   nome TEXT NOT NULL,
   capaciadade INTEGER -- ??? > 0
);
CREATE TABLE funcionario(
   id SERIAL PRIMARY KEY,
   nome TEXT NOT NULL,
   setor TEXT
);
CREATE TABLE turno(
   sala_id INTEGER REFERENCES sala(id),
   funcionario_id INTEGER REFERENCES funcionario(id),
   data_hora_entrada TIMESTAMP CURRENT_TIMESTAMP,
   data_hora_saida TIMESTAMP
);

-- 2) QUESTÃO 2:

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
        WHEN OTHERS THEN RAISE NOTICE 'Documento Inválido';
        RETURN FALSE;
    END;    
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION validaCPF_trigger() RETURNS TRIGGER AS
$$
DECLARE
    resultado BOOLEAN;
BEGIN
    resultado := validaCPF(NEW.cpf);
    IF (resultado = TRUE) THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Nao vai inserir ou atualizar!';
        RETURN NULL;
    END IF;
END;
$$ LANGUAGE 'plpgsql';


-- 3) QUESTÃO 3:
CREATE FUNCTION  calcularSalario(integer, real) RETURNS real AS
$$ 
DECLARE
      salario_hora real;
BEGIN
      SELECT funcionario
END;
$$ LANGUAGE 'plpgsql';

-- 4) QUESTÃO 4:
CREATE FUNCTION inserirNovoTurno(nome text, id integer) RETURNS boolean AS
$$
BEGIN
    INSERT INTO funcionario (nome, setor) VALUES(nome, setor);
    RETURN true;
END;
$$ LANGUAGE 'plpgsql';
-- 5) QUESTÃO 5:




