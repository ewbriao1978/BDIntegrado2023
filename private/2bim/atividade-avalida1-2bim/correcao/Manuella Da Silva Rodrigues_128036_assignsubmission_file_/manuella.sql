--primeira questao

DROP DATABASE IF EXISTS avaliacao2;

CREATE DATABASE avaliacao2;

\c avaliacao2;


DROP SCHEMA IF EXISTS externo;
DROP SCHEMA IF EXISTS interno;
DROP SCHEMA IF EXISTS public;

CREATE SCHEMA externo;
CREATE SCHEMA interno;
CREATE SCHEMA public;

DROP FUNCTION IF EXISTS validaCPF;

SET search_patch TO public, externo, interno;

CREATE TABLE public.sala (
    id serial primary key,
    nome text NOT NULL,
    capacidade integer check (capacidade > 0)
);

CREATE TABLE externo.telespectador (
    id serial primary key,
    cpf character(11) CHECK (validaCPF(cpf) IS TRUE),
    nome text NOT NULL,
    unique(cpf)
);

CREATE TABLE externo.filme (
    id serial primary key,
    titulo text NOT NULL,
    duracao integer check (duracao > 0)
);

CREATE TABLE externo.sessao (
    id serial primary key,
    data date NOT NULL,
    hora time NOT NULL,
    filme_id integer references externo.filme(id),
    sala_id integer references public.sala(id)
);

CREATE TABLE externo.ingresso (
    id serial primary key,
    valor_ingresso real,
    corredor character(1) NOT NULL,
    poltrona integer CHECK (poltrona>0),
    telespectador_id integer references externo.telespectador(id),
    sessao_id integer references externo.sessao(id)

);

CREATE TABLE interno.funcionario (
    id serial primary key,
    nome text NOT NULL,
    setor text,
    constraint check_nome_setor check (setor in ('limpeza', 'atendimento', 'operacao'))
);

CREATE TABLE interno.turno (
    data_hora_entrada timestamp default current_timestamp,
    data_hora_saida timestamp,
    sala_id integer references public.sala(id),
    funcionario_id integer references interno.funcionario(id)
);


--questao2
CREATE OR REPLACE FUNCTION validaCPF(character(11)) RETURNS boolean AS
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

--exercicio 3
--nao consegui

--exercicio4

--CREATE TRIGGER t_addfuncionario AFTER INSERT ON funcionario FOR EACH ROW EXECUTE PROCEDURE funcionario_log_func();

--CREATE OR REPLACE FUNCTION funcionario_log_func()
--RETURNS trigger AS $$
--BEGIN
    --VALUES (new.sala_id)
    --select extract 
--END
--$$ LANGUAGE plpgsql;


--exercicio 5
CREATE VIEW infoIngressos AS SELECT interno.sala.nome as nome_da_sala, externo.filme.titulo as titulo_do_filme, externo.telespectador.nome,
externo.sessao.data as data_da_sessao, externo.sessao.hora as hora_da_sessao, externo.ingresso.corredor as letra_do_corredor, externo.ingresso.poltrona as numero_poltrona
FROM public.sala INNER JOIN externo.sessao ON (public.sala.id = externo.sessao.sala_id) INNER JOIN externo.filme ON (externo.filme.id = externo.sessao.filme_id) INNER JOIN
externo.ingresso ON (externo.ingresso.sessao_id = externo.sessao.id) INNER JOIN externo.telespectador ON (externo.telespectador.id = externo.ingresso.telespectador_id);

--aonde o formato da data da sessao deve ser dd/mm/aa

