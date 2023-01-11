DROP DATABASE IF EXISTS avaliacao1;

CREATE DATABASE avaliacao1;

\c avaliacao1;

DROP SCHEMA IF EXISTS funcionario;
DROP SCHEMA IF EXISTS telespectador;
DROP SCHEMA IF EXISTS sala;

CREATE SCHEMA interno;
CREATE SCHEMA externo;
CREATE SCHEMA validaCPF;

SET search_path TO public, interno, externo, validaCPF;

CREATE TABLE externo.telespectador(
    id serial primary key,
    cpf character(11) UNIQUE,
    nome text not null
);



CREATE TABLE externo.filme(
    id serial primary key,
    titulo text not null,
    duracao integer check(duracao > 0)
);

CREATE TABLE public.sala(
    id serial primary key,
    nome text not null,
    capacidade integer check(capacidade > 0)
);

CREATE TABLE externo.sessao(
    id serial primary key,
    filme_id integer references externo.filme(id),
    sala_id integer references sala(id),
    data date not null default CURRENT_DATE,
    hora time not null
);

CREATE TABLE externo.ingresso(
    id serial primary key,
    telespectador_id integer references externo.telespectador(id),
    sessao_id integer references  externo.sessao(id),
    valor_ingresso real,
    corredor character(1) not null,
    poltrona integer check(poltrona > 0)
);

CREATE TABLE interno.funcionario(
    id serial primary key,
    nome text not null,
    setor text -- (LIMPEZA, ATENDIMENTO, OPERACAO)
);

CREATE TABLE interno.turno(
    sala_id integer references sala(id),
    funcionario_id integer references interno.funcionario(id),
    data_hora_entrada timestamp,
    data_hora_saida timestamp
);


INSERT INTO externo.telespectador (cpf, nome) VALUES ('11111111111','Pyter');
INSERT INTO externo.telespectador (cpf, nome) VALUES ('93255020210','Paulo');
INSERT INTO externo.telespectador (cpf, nome) VALUES ('33333333333','Roger');
INSERT INTO externo.telespectador (cpf, nome) VALUES ('44444444444','Marcela');
INSERT INTO externo.telespectador (cpf, nome) VALUES ('55555555555','Max');


INSERT INTO interno.funcionario (nome, setor) VALUES ('Maximiliano', 'Limpeza');
INSERT INTO interno.funcionario (nome, setor) VALUES ('Rafael', 'Atendimento');
INSERT INTO interno.funcionario (nome, setor) VALUES ('Roberta', 'Operacao');


INSERT INTO public.sala (nome, capacidade) VALUES ('1A', 50);
INSERT INTO public.sala (nome, capacidade) VALUES ('2A', 20);
INSERT INTO public.sala (nome, capacidade) VALUES ('3A', 40);
INSERT INTO public.sala (nome, capacidade) VALUES ('4A', 150);
INSERT INTO public.sala (nome, capacidade) VALUES ('5A', 60);

INSERT INTO externo.filme (titulo, duracao) VALUES ('Mar Azul', 1);
INSERT INTO externo.filme (titulo, duracao) VALUES ('Mar Baltico', 2);
INSERT INTO externo.filme (titulo, duracao) VALUES ('Cover Jah', 1);
INSERT INTO externo.filme (titulo, duracao) VALUES ('Batalha Naval', 2);
INSERT INTO externo.filme (titulo, duracao) VALUES ('Santa Mae', 1);

INSERT INTO externo.sessao (filme_id,sala_id, data, hora) VALUES (1, 1, '2022-03-11','18:00:00');
INSERT INTO externo.sessao (filme_id,sala_id, data, hora) VALUES (2, 2, '2022-10-09','20:00:00');
INSERT INTO externo.sessao (filme_id,sala_id, data, hora) VALUES (3, 3, '2022-09-11','18:00:00');
INSERT INTO externo.sessao (filme_id,sala_id, data, hora) VALUES (4, 4, '2022-03-11','18:00:00');
INSERT INTO externo.sessao (filme_id,sala_id, data, hora) VALUES (5, 5, '2022-03-11','18:00:00');

INSERT INTO externo.ingresso (telespectador_id,sessao_id, valor_ingresso, corredor, poltrona) VALUES
(1, 1, 25,'B', 2);
INSERT INTO externo.ingresso (telespectador_id,sessao_id, valor_ingresso, corredor, poltrona) VALUES
(2, 2, 25,'C', 2);
INSERT INTO externo.ingresso (telespectador_id,sessao_id, valor_ingresso, corredor, poltrona) VALUES
(3, 3, 25,'D', 2);
INSERT INTO externo.ingresso (telespectador_id,sessao_id, valor_ingresso, corredor, poltrona) VALUES
(4, 4, 25,'B', 3);
INSERT INTO externo.ingresso (telespectador_id,sessao_id, valor_ingresso, corredor, poltrona) VALUES
(5, 5, 25,'A', 2);




--======================================================================================================
-- 2)

CREATE FUNCTION validaCPF.telespectador(character(11)) RETURNS boolean AS
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

--======================================================================================================================
-- 3)

CREATE FUNCTION  calculaSalario(valor_hora_dia1 real, total_hora_mes2 real) RETURNS real AS
$$ 
DECLARE

    valor_hora_dia1 ALIAS FOR $1;
    total_hora_mes2 ALIAS FOR $2;
     

BEGIN 

    RETURN valor_hora_dia1 * total_hora_mes2;
    

END;
$$ LANGUAGE 'plpgsql';

--=========================================================================================================================
-- 5)
CREATE VIEW sala_VIEW AS SELECT  sala.nome, filme.titulo, sessao.data, sessao.hora , ingresso.corredor,
ingresso.poltrona FROM  sala  INNER JOIN filme ON sala.id = filme.id   
INNER JOIN sessao ON sessao.sala_id = sala.id INNER JOIN ingresso ON sessao.id = ingresso.sessao_id ;



