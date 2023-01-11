DROP DATABASE IF EXISTS prova;

CREATE DATABASE prova;

\c prova;

--1 
--criando um schema
CREATE SCHEMA externo;
CREATE SCHEMA interno;

SET search_path TO public, externo, interno;

-- tabelas do schema public
CREATE TABLE public.sala (
    id serial primary key,
    nome text not null,
    capacidade integer check (capacidade > 0)
);

-- tabelas do schema externo
create table externo.telespectador (
    id serial,
    cpf character(11) unique check value (TRUE, FALSE),                                              ,
    nome test not null
);
create table externo.ingresso (
    id serial,
    telespectador_id integer references telespectador (id),
    sessao_id integer references sessao (id),
    valor_ingresso real,
    corredor character(1) not null, 
    poltrona integer check (poltrona > 0)
);
create table externo.sessao (
    id serial primary key,
    filme_id integer references sala (id),
    data date not null,
    hora time not null
);
create table externo.filme (
    id serial,
    titulo text not null,
    duracao integer check (duracao > 0)
);
-- tabelas do schema interno
create table interno.funcionario(
    id serial,
    nome text not null,
    setor text check (limpeza, atendimento, operacao)
);
create table interno.turno (
    sala_id integer refernces sala (id),
    funcionario_id integer references funcionario (id),
    data_hora_entrada timestamp default current_timestamp,
    dta_hora_saida timestamp default current_timestamp
);

INSERT INTO sala (id, nome, capacidade) VALUES 
(100, 'sala1', 200),
(200, 'sala2', 130);
INSERT INTO telespectador (id, cpf, nome) VALUES
(1, 23454312300, 'jose'),
(2, 1234567511, 'maria');
INSERT INTO ingresso (id, filme_id, sala_id, data, hora) VALUES
(13, 202, 100, '2022-10-03', '13:00'),
(14, 204, 200, '2022-11-06', 14:00);
INSERT INTO sessao (id, filme_id, sala_id, data, hora) VALUES
(23, 001, 100, '2022-10-03', '13:00'),
(24,002, 200, '2022-11-06', 14:00)
INSERT INTO  filme (id, titulo, duracao) VALUES
(55, 'alien', '3'),
(65, 'predador', 2);
INSERT INTO funcionario (id, nome, setor) VALUES
(1000, 'pedro', 'limpeza'),
(1001, 'paulo', 'atendimento'),
(1002, 'ana', 'operacao');
INSERT INTO  turno (sala_id, funcionario_id, data_hora_entrada, dta_hora_saida) VALUES
(100, 1000, '20:00', '22:00'),
(200, 1002, '15:00', '18:00');


--2 Validaçao cpf

DROP FUNCTION IF EXISTS mascaraCPF;
DROP FUNCTION IF EXISTS validaCPF;

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
END;
$$ LANGUAGE 'plpgsql';

CREATE PROCEDURE valida_cpf_telespectador (cpf character(11), nome text) AS 
$$
DECLARE 

BEGIN
    select cpf from externo.telespectador 
END;
$$ language plpgsql;

--3
CREATE FUNCTION calculo_salario RETURNS real AS
$$
DECLARE
    salario REAL;  
    horas_trabalhadas_mes real;
BEGIN
    IF
        funcionario.limpeza THEN salario := 10 * horas_trabalhadas_mes
        funcionario.atendimento THEN salario := 15 * horas_trabalhadas_mes
        funcionario.operacao THEN salario := 20 * horas_trabalhadas_mes
    END IF;
    
    RETURN salario;
END;
$$ LANGUAGE 'plpgsql';



--4
CREATE OR REPLACE FUNCTION novo_turno_trabalho() RETURNS TRIGGER AS
$$
DECLARE
    novo_turno text;
    funcionario_novo text;
BEGIN
    SELECT INTO * FROM interno.funcionario WHERE id = NEW.funcionario.id;
    INSERT INTO funcionario_novo (id, nome, setor) VALUES
    (1004, 'jorge', 'operacao');
    SELECT INTO * FROM interno.turno WHERE id = NEW.funcionario_id;
    INSERT INTO novo_turno (sala_id, funcionario_id, data_hora_entrada, dta_hora_saida) VALUES
    (100, 1004, '17:00', '19:00');;

END;
$$ LANGUAGE 'plpgsql';

--5
CREATE VIEW view_venda AS SELECT public.sala.nome as filme.titulo as telespectador.nome, sessao.data, ingresso.poltrona FROM public.sala INNER JOIN sessao.id ON (public.sala.id = sessao.sala_id) INNER JOIN ingesso.poltrona ON (ingresso.sessao.id = sessao.id) INNER JOIN telespectador.cpf ON (telespectador.id = ingresso.telespectador_id);

CREATE FUNCTION novo_turno() RETURNS TRIGGER AS
$$
DECLARE
    funcionario_novo TEXT;
    turno_novo TEXT;
    hora_turno time;
BEGIN
    SELECT INTO funcionario_novo nome FROM interno.funcionario WHERE id = NEW.funcionario.id;
    SELECT INTO turno_novo sala_id FROM interno.turno WHERE id = NEW.turno.sala_id;
    SELECT INTO hora_turno sala_id FROM interno.turno WHERE id = NEW.data_hora_entrada;   

    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';


