DROP DATABASE IF EXISTS cinema;
CREATE DATABASE cinema;

\c cinema;

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

DROP SCHEMA IF EXISTS externo;
DROP SCHEMA IF EXISTS interno;

CREATE SCHEMA externo;
CREATE SCHEMA interno;

SET search_path TO public, externo, interno;

CREATE TABLE externo.telespectador (
	id SERIAL PRIMARY KEY,
	cpf CHARACTER ( 11 ) UNIQUE CHECK ( validaCPF ( cpf ) IS TRUE ),
	nome TEXT NOT NULL
);

CREATE TABLE externo.filme (
	id SERIAL PRIMARY KEY,
	titulo TEXT NOT NULL,
	duracao INTEGER CHECK ( duracao > 0 )
);

CREATE TABLE public.sala (
	id SERIAL PRIMARY KEY,
	nome TEXT NOT NULL,
	capacidade INTEGER CHECK ( capacidade > 0 )
);

CREATE TABLE interno.funcionario (
	id SERIAL PRIMARY KEY,
	nome TEXT NOT NULL,
	setor TEXT
);

CREATE TABLE externo.sessao (
	id SERIAL PRIMARY KEY,
	filme_id INTEGER REFERENCES externo.filme ( id ),
	sala_id INTEGER REFERENCES public.sala ( id ),
	data DATE NOT NULL,
	hora TIME NOT NULL
);

CREATE TABLE interno.turno (
	sala_id INTEGER REFERENCES public.sala ( id ),
	funcionario_id INTEGER REFERENCES interno.funcionario ( id ),
	data_hora_entrada TIMESTAMP,
	data_hora_saida TIMESTAMP,
	PRIMARY KEY ( sala_id, funcionario_id, data_hora_entrada )
);

CREATE TABLE externo.ingresso (
	id SERIAL PRIMARY KEY,
	telespectador_id INTEGER REFERENCES externo.telespectador ( id ),
	sessao_id INTEGER REFERENCES sessao ( id ),
	valor_ingresso REAL,
	corredor CHAR ( 1 ) NOT NULL,
	poltrona INTEGER CHECK ( poltrona > 0 )
);

INSERT INTO public.sala (nome, capacidade) VALUES ('SALA 1', 200);

INSERT INTO externo.filme ( titulo, duracao ) VALUES ( 'Se Eu Fosse Voce', 2 );

INSERT INTO externo.telespectador ( cpf, nome ) VALUES ( '04324921008', 'JUNIOR' );

INSERT INTO externo.sessao ( filme_id, sala_id, data, hora ) VALUES ( 1, 1, '2022-06-06', '15:00:00' );

INSERT INTO externo.ingresso ( telespectador_id, sessao_id, valor_ingresso, corredor, poltrona ) VALUES ( 1, 1, 15.00, 'A', 13 );

INSERT INTO interno.funcionario (nome, setor) VALUES ('CAN', 'ATENDIMENTO');
INSERT INTO interno.funcionario (nome, setor) VALUES ('ROBERT', 'LIMPEZA');
INSERT INTO interno.funcionario (nome, setor) VALUES ('CARLA', 'OPERACAO');



INSERT INTO interno.turno (sala_id, funcionario_id, data_hora_entrada, data_hora_saida) VALUES (1, 1, '2022/06/03 08:00:00', '2022/06/03 15:00:00');
INSERT INTO interno.turno (sala_id, funcionario_id, data_hora_entrada, data_hora_saida) VALUES (1, 1, '2022/06/03 15:00:00', '2022/06/03 23:00:00');
INSERT INTO interno.turno (sala_id, funcionario_id, data_hora_entrada, data_hora_saida) VALUES (1, 2, '2022/06/03 08:00:00', '2022/06/03 15:00:00');
INSERT INTO interno.turno (sala_id, funcionario_id, data_hora_entrada, data_hora_saida) VALUES (1, 2, '2022/06/05 15:00:00', '2022/06/05 23:00:00');
INSERT INTO interno.turno (sala_id, funcionario_id, data_hora_entrada, data_hora_saida) VALUES (1, 3, '2022/06/04 08:00:00', '2022/06/04 15:00:00');
INSERT INTO interno.turno (sala_id, funcionario_id, data_hora_entrada, data_hora_saida) VALUES (1, 3, '2022/06/02 15:00:00', '2022/06/02 23:00:00');

CREATE FUNCTION salario_funcionario ( INTEGER ) RETURNS text AS 
$$
DECLARE
	salario_mes TEXT;
	id_func ALIAS FOR $1;
BEGIN
	SELECT INTO salario_mes
	CASE
	WHEN tmp1.setor = 'LIMPEZA' THEN horas_trabalhadas * 10
	WHEN tmp1.setor = 'ATENDIMENTO' THEN horas_trabalhadas * 15
	WHEN tmp1.setor = 'OPERACAO' THEN horas_trabalhadas * 20
	END
	FROM 
	(SELECT funcionario.setor, EXTRACT ( HOUR FROM data_hora_saida-data_hora_entrada ) AS horas_trabalhadas 
	FROM interno.turno
	JOIN interno.funcionario ON turno.funcionario_id = funcionario.id 
	WHERE funcionario.id = $1 AND EXTRACT ( MONTH FROM data_hora_entrada ) = EXTRACT ( MONTH FROM CURRENT_TIMESTAMP ) 
	AND EXTRACT ( MONTH FROM data_hora_saida ) = EXTRACT( MONTH FROM CURRENT_TIMESTAMP ) ) AS tmp1;
	RETURN salario_mes;
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION cria_turno() RETURNS TRIGGER AS
$$
DECLARE
	sala_turno INTEGER;
	dia_seguinte TIMESTAMP;
	funcionario_id INTEGER;
BEGIN
	SELECT INTO sala_turno sala.id FROM sala ORDER BY RANDOM () LIMIT 1;
	SELECT INTO dia_seguinte CURRENT_DATE + INTERVAL '1 Day' + INTERVAL '8 HOURS';
	
	funcionario_id := NEW.id;
	
	INSERT INTO interno.turno (sala_id, funcionario_id, data_hora_entrada) VALUES (sala_turno, funcionario_id, dia_seguinte);
	RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER cria_turno AFTER INSERT ON interno.funcionario
FOR EACH ROW EXECUTE PROCEDURE cria_turno();

CREATE VIEW ingresso_view AS SELECT sala.nome AS sala_nome, filme.titulo, telespectador.nome AS telespectador_nome, to_char(sessao.data,'DD/MM/YYYY') AS data_sessao, sessao.hora, ingresso.corredor, ingresso.poltrona FROM externo.ingresso
JOIN externo.sessao ON ingresso.sessao_id = sessao.id
JOIN public.sala ON sessao.sala_id = sala.id
JOIN externo.filme ON sessao.filme_id = filme.id
JOIN externo.telespectador ON ingresso.telespectador_id = telespectador.id;






