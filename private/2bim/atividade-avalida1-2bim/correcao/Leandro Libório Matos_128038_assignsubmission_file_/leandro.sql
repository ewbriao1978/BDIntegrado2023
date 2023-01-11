DROP DATABASE IF EXISTS prova;


CREATE DATABASE prova;

\c prova


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
soma := nro1 * 10 + nro2 * 9 + nro3 * 8 + nro4 * 7 + nro5 * 6 + nro6 * 5 + nro7 * 4 +
nro8 * 3 + nro9 * 2;
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
$$ LANGUAGE 'plpgsql';







DROP SCHEMA IF EXISTS externo;

DROP SCHEMA IF EXISTS interno;

CREATE SCHEMA externo;

CREATE SCHEMA interno;

SET search_path TO public, externo, interno;

CREATE TABLE externo.telespectador (
    id serial PRIMARY KEY,
    cpf CHARACTER(11) UNIQUE CHECK (validaCPF(cpf) IS TRUE),
    nome text NOT NULL
);

CREATE TABLE externo.filme (
    id serial PRIMARY KEY,
    titulo text NOT NULL,
    duracao INTEGER CHECK (duracao > 0)
);

CREATE TABLE sala (
    id serial PRIMARY KEY,
    name text NOT NULL,
    capacidade INTEGER CHECK (capacidade > 0)
);

CREATE TABLE externo.sessao (
    id serial PRIMARY KEY,
    sala_id INTEGER REFERENCES sala (id),
    filme_id INTEGER REFERENCES filme (id),
    data date NOT NULL,
    hora TIMESTAMP NOT NULL
);

CREATE TABLE externo.ingresso (
    id serial PRIMARY key,
    telespectador_id INTEGER REFERENCES telespectador (id),
    sessao_id  INTEGER REFERENCES sessao (id),
    valor_ingresso real,
    corredor CHARACTER(1),
    poltrona INTEGER CHECK (poltrona > 0)
);

CREATE TABLE interno.funcionario (
    id serial PRIMARY KEY, 
    nome text NOT NULL,
    setor text CHECK (setor != 'LIMPEZA' || 'ATENDIMENTO' || 'OPERACAO')
);

CREATE TABLE interno.turno (
    sala_id INTEGER REFERENCES sala (id),
    funcionario_id INTEGER REFERENCES funcionario (id),
    data_hora_entrada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_hora_saida TIMESTAMP
);



/* 
insert into funcionario VALUES (1, 'l', LIMPEZA);
INSERT INTO turno VALUES (1, 1, CURRENT_TIMESTAMP , '20220610')

INSERT INTO sala VALUES (1, 'sala 01', 20);

INSERT INTO filme VALUES (1, 'kung fu panda', 2);


INSERT INTO sessao VALUES (1, 1, 1, current_timestamp, '20:00:00');


select data_hora_entrada from turno  extract(day from data_hora_entrada) as dia;


CREATE FUNCTION salario(funcionario_id INTEGER, valor INTEGER) RETURNS INTEGER AS
$$
DECLARE


view:

select sala.nome, filme.nome, telespectador.nome, sessao.data, sessao.nome, ingresso.corredor, ingresso.poltrona 
from sala inner join sessao.sala_id = sala.id

select sala.name, sessao.data from sessao inner join sala on sessao.sala_id = sala.id;

*/
