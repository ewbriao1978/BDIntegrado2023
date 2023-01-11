DROP DATABASE IF EXISTS prova;

CREATE DATABASE prova;

\c prova;

DROP SCHEMA IF EXISTS interno;
DROP SCHEMA IF EXISTS externo;

CREATE SCHEMA interno;
CREATE SCHEMA externo;

SET search_path TO public, interno, externo;


CREATE TABLE externo.telespectador(
    id serial PRIMARY KEY,
    cpf character(11),
    nome text NOT NULL,
    UNIQUE (cpf)
);

CREATE TABLE externo.filme(
    id serial PRIMARY KEY,
    titulo text NOT NULL,
    duracao integer 
CREATE TABLE sala(
    id serial PRIMARY KEY,
    nome text NOT NULL,
    capacidade INTEGER
CREATE TABLE externo.sessao(
   id serial PRIMARY KEY,
   filme_id INTEGER REFERENCES externo.filme (id),
   sala_id INTEGER REFERENCES public.sala (id),
   data date NOT NULL,
   hora timestamp NOT NULL 
);

CREATE TABLE externo.ingresso(
    id serial PRIMARY KEY,
    telespectador_id INTEGER REFERENCES externo.telespectador (id),
    sesao_id INTEGER REFERENCES externo.sessao (id),
    valor_ingresso REAL,
    corredor character(1) NOT NULL,
    poltrona INTEGER 

 CREATE TABLE interno.funcionario(
     id serial PRIMARY KEY,
     nome text NOT NULL,
     setor text CHECK (setor in ('limpeza', 'atendimento', 'operacao'))
 );

 CREATE TABLE interno.turno(
    sala_id INTEGER REFERENCES sala (id),
    funcionario_id INTEGER REFERENCES interno.funcionario(id),
    data_hora_entrada timestamp DEFAULT CURRENT_TIMESTAMP,
    data_hora_saida timestamp,
    PRIMARY KEY (sala_id, funcionario_id, data_hora_entrada)
 );

 INSERT INTO externo.telespectador (cpf, nome) VALUES
('04524686045', 'Samara'),
('57004738019','Mabia'),
('85325268023', 'Igor'),
('50504053000', 'Renato '),
('60540328014', 'Jessica');

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
--
RAISE NOTICE '%', nro1;
nro2 := SUBSTRING(cpf,2, 1);
--
RAISE NOTICE '%', nro2;
nro3 := SUBSTRING(cpf,3, 1);
--
RAISE NOTICE '%', nro3;
nro4 := SUBSTRING(cpf,4, 1);
--
RAISE NOTICE '%', nro4;
nro5 := SUBSTRING(cpf,5, 1);
--
RAISE NOTICE '%', nro5;
nro6 := SUBSTRING(cpf,6, 1);
--
RAISE NOTICE '%', nro6;
nro7 := SUBSTRING(cpf,7, 1);
--
RAISE NOTICE '%', nro7;
nro8 := SUBSTRING(cpf,8, 1);
--
RAISE NOTICE '%', nro8;
nro9 := SUBSTRING(cpf,9, 1);
--
RAISE NOTICE '%', nro9;
nro10 := SUBSTRING(cpf,10, 1);
--
RAISE NOTICE '%', nro10;
nro11 := SUBSTRING(cpf,11, 1);
--
RAISE NOTICE '%', nro11;
--
--DIGITO 1
--https://raw.githubusercontent.com/IgorAvilaPereira/bd2022_1sem/main/aula090522.sql
--3/406/06/2022 15:46
--https://raw.githubusercontent.com/IgorAvilaPereira/bd2022_1sem/main/aula090522.sql
soma := nro1 * 10 + nro2 * 9 + nro3 * 8 + nro4 * 7 + nro5 * 6 + nro6 * 5 + nro7 * 4 + nro8
* 3 + nro9 * 2;
resto := (soma * 10) % 11;
IF resto = 10 THEN
resto := 0;
END IF;
IF resto = nro10 THEN
resultadoDigito1 := TRUE;
END IF;
-- DIGITO 2
soma := nro1 * 11 + nro2 * 10 + nro3 * 9 + nro4 * 8 + nro5 * 7 + nro6 * 6 + nro7 * 5 +
nro8 * 4 + nro9 * 3 + nro10 * 2;
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
$$ LANGUAGE 'plpgsql'



