DROP DATABASE IF EXISTS cinema;
CREATE DATABASE cinema;
\c cinema;

DROP SCHEMA IF EXISTS externo;
DROP SCHEMA IF EXISTS interno;
CREATE SCHEMA externo;
CREATE SCHEMA interno;
SET search_path TO public, externo, interno;

CREATE TABLE externo.telespectador (
    id serial primary key,
    cpf character(11) CHECK(validaCPF(cpf) IS TRUE),
    nome text NOT NULL,
    unique(cpf)
);

CREATE TABLE externo.filme (
    id serial primary key,
    titulo text NOT NULL,
    duracao integer CHECK (duracao > 0)
);

CREATE TABLE public.sala (
    id serial primary key,
    nome text NOT NULL,
    capacidade integer CHECK (capacidade > 0)
);

CREATE TABLE externo.sessao (
    id serial primary key,
    filme_id integer references filme (id),
    sala_id integer references sala (id),
    data date NOT NULL,
    hora time NOT NULL
);

CREATE TABLE externo.ingresso (
    id serial primary key,
    telespectador_id integer references telespectador (id),
    sessao_id integer references sessao (id),
    valor_ingresso real CHECK (valor_ingresso > 0),
    corredor character(1) NOT NULL,
    poltrona integer CHECK (poltrona > 0)
);

CREATE TABLE interno.funcionario (
    id serial primary key,
    nome text NOT NULL,
    setor text NOT NULL
);

CREATE TABLE interno.turno (
    sala_id integer references sala (id),
    funcionario_id integer references funcionario (id),
    data_hora_entrada timestamp DEFAULT CURRENT_TIMESTAMP,
    data_hora_saida timestamp,
    primary key (sala_id, funcionario_id, data_hora_entrada)
);

CREATE FUNCTION validaCPF(character(11)) RETURNS boolean AS
$$
DECLARE
    resultado boolean;
    cpf ALIAS FOR $1;
    nro1 integer;
    nro2 integer;  
    nro3 integer;
    nro4 integer;
    nro5 integer;
    nro6 integer;
    nro7 integer;
    nro8 integer;
    nro9 integer;
    nro10 integer;
    nro11 integer;
    soma integer;
    resto integer;
    resultadoDigito1 boolean;
    resultadoDigito2 boolean;
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
        IF cpf = '00000000000' OR 
		    cpf = '11111111111' OR 
		    cpf = '22222222222' OR 
		    cpf = '33333333333' OR 
		    cpf = '44444444444' OR 
		    cpf = '55555555555' OR 
		    cpf = '66666666666' OR 
		    cpf = '77777777777' OR 
		    cpf = '88888888888' OR 
		    cpf = '99999999999' THEN
            RETURN FALSE;
        END IF;
        nro1 := SUBSTRING(cpf,1, 1);
        nro2 := SUBSTRING(cpf,2, 1);
        nro3 := SUBSTRING(cpf,3, 1);
        nro4 := SUBSTRING(cpf,4, 1);
        nro5 := SUBSTRING(cpf,5, 1);
        nro6 := SUBSTRING(cpf,6, 1);
        nro7 := SUBSTRING(cpf,7, 1);
        nro8 := SUBSTRING(cpf,8, 1);
        nro9 := SUBSTRING(cpf,9, 1);
        nro10 := SUBSTRING(cpf,10, 1);
        nro11 := SUBSTRING(cpf,11, 1);
        --DIGITO 1
        soma := nro1 * 10 + nro2 * 9 + nro3 * 8 + nro4 * 7 + nro5 * 6 + nro6 * 5 + nro7 * 4 + nro8 * 3 + nro9 * 2;
        resto := (soma * 10) % 11;   
        IF resto = 10 THEN
            resto := 0;
        END IF;
        IF resto = nro10 THEN
            resultadoDigito1 := TRUE;
        END IF;
        --DIGITO 2
        soma := nro1 * 11 + nro2 * 10 + nro3 * 9 + nro4 * 8 + nro5 * 7 + nro6 * 6 + nro7 * 5 + nro8 * 4 + nro9 * 3 + nro10 * 2;
        resto := (soma * 10) % 11;   
        IF resto = 10 THEN
            resto := 0;
        END IF;    
        IF resto = nro11 THEN
            resultadoDigito2 := TRUE;
        END IF;
        resultado := resultadoDigito1 AND resultadoDigito2;
        RETURN resultado;
    EXCEPTION
        WHEN OTHERS THEN RAISE NOTICE 'CPF Inválido!';
        RETURN FALSE;
    END;    
END;
$$ LANGUAGE 'plpgsql';

INSERT INTO externo.telespectador (cpf, nome) VALUES
('02615318080', 'Felipe'),
('42870801068', 'Maria'),
('03236088095', 'José');

INSERT INTO externo.filme (titulo, duracao) VALUES
('Top Gun Maverick', 2),
('Donnie Darko', 1),
('Lord of the Rings', 3);

INSERT INTO public.sala (nome, capacidade) VALUES
('Sala Deluxe', 400),
('Sala Standart', 100),
('Sala Premium', 250);

INSERT INTO externo.sessao (filme_id, sala_id, data, hora) VALUES
(2, 1, '05-02-2022', '08:00:00'),
(3, 2, '15-03-2022', '22:00:00'),
(1, 3, '10-05-2022', '19:30:00');

INSERT INTO externo.ingresso (telespectador_id, sessao_id, valor_ingresso, corredor, poltrona) VALUES
(3, 1, 41.90, 'G', 25),
(1, 2, 15.75, 'H', 10),
(2, 3, 24.40, 'A', 5);

INSERT INTO interno.funcionario (nome, setor) VALUES
('Guilherme', 'OPERAÇÃO'),
('Joana', 'ATENDIMENTO'),
('Alex', 'LIMPEZA');

INSERT INTO interno.turno (sala_id, funcionario_id, data_hora_entrada, data_hora_saida) VALUES
(1, 3, '2022-02-05 07:00:00'),
(3, 2, '2022-03-15 18:30:00'),
(2, 1, '2022-02-21 21:00:00');


CREATE VIEW view_cinema AS SELECT public.sala.nome as sala.nome, externo.filme.titulo as filme_titulo, externo.telespectador.nome as telespectador_nome, externo.sessao.data as sessao_data, externo.sessao.hora as sessao_hora, externo.ingresso.corredor as corredor, externo.ingresso.poltrona as poltrona FROM externo.sessao INNER JOIN  public.sala ON sessao.sala_id = sala.id INNER JOIN 


CREATE OR REPLACE FUNCTION criaTurno() RETURNS TRIGGER AS 
$$
DECLARE
    sala_id integer;
    funcionario_id integer;
    data_hora_entrada timestamp;
    data_hora_saida timestamp;
  
BEGIN
    sala_id := SELECT sala.id FROM public.sala ORDER BY RANDOM(sala_id) LIMIT 1;
    SELECT INTO funcionario_id FROM interno.funcionario WHERE id = NEW.funcionario_id;
    data_hora_entrada := CURRENT_DATE + INTERVAL '1 day';
    RETURN NEW;

    INSERT INTO interno.turno (sala_id, funcionario_id, data_hora_entrada, data_hora_saida) VALUES (sala_id, funcionario_id, data_hora_entrada, CURRENT_DATE + INTERVAL '2 day');
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER criaTurno AFTER INSERT OR UPDATE ON empregados
FOR EACH ROW EXECUTE PROCEDURE criaTurno();

