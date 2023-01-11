DROP DATABASE IF EXISTS prova01;

CREATE DATABASE prova01;

\c prova01;
-- 1.
CREATE SCHEMA externo;
CREATE SCHEMA interno;

SET search_path TO public, externo, interno;

DROP TABLE IF EXISTS externo.ingresso;
DROP TABLE IF EXISTS externo.sessao;
DROP TABLE IF EXISTS externo.filme;
DROP TABLE IF EXISTS externo.telespectador;
DROP TABLE IF EXISTS interno.turno;
DROP TABLE IF EXISTS interno.funcionario;
DROP TABLE IF EXISTS sala;


-- ############################ STORED PROCEDURES ############################

-- 2.
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
            RAISE NOTICE '"cpf" CANNOT HAVE NULL VALUE, XABUM OCURRED.';
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




-- 4.

-- criar um novo turno de trabalho
-- deve começar amanha as 8h
-- order by random(), limit = 1, current_date + interval '1day'.

CREATE FUNCTION novoTurno() RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO turno (sala_id, funcionario_id, data_hora_entrada, data_hora_saida) VALUES
        ((SELECT id FROM sala ORDER BY RANDOM() LIMIT 1),  NEW.id, (CURRENT_DATE + INTERVAL '1day' + INTERVAL '8hours'), (CURRENT_DATE + INTERVAL '1day' + INTERVAL '16hours'));
    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

-- ############################## CREATE TABLES ##############################

--1.
CREATE TABLE sala (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    capacidade INTEGER CHECK (capacidade > 0)
);

CREATE TABLE interno.funcionario (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    setor TEXT CHECK (setor = 'LIMPEZA' OR setor = 'ATENDIMENTO' OR setor = 'OPERACAO')
);

CREATE TABLE interno.turno (
    sala_id INTEGER REFERENCES sala (id) ON DELETE SET NULL ON UPDATE CASCADE,
    funcionario_id INTEGER REFERENCES funcionario (id) ON DELETE SET NULL ON UPDATE CASCADE,
    data_hora_entrada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_hora_saida TIMESTAMP,
    PRIMARY KEY (sala_id, funcionario_id, data_hora_entrada)
);

CREATE TABLE externo.telespectador (
    id SERIAL PRIMARY KEY,
    cpf CHARACTER(11) CHECK (validacpf(cpf) = true), -- 2.
    nome TEXT NOT NULL,
    UNIQUE(cpf)
);

CREATE TABLE externo.filme (
    id SERIAL PRIMARY KEY,
    titulo TEXT NOT NULL,
    duracao INTEGER CHECK (duracao > 0)
);

CREATE TABLE externo.sessao (
    id SERIAL PRIMARY KEY,
    filme_id INTEGER REFERENCES filme (id) ON DELETE SET NULL ON UPDATE CASCADE,
    sala_id INTEGER REFERENCES sala (id) ON DELETE SET NULL ON UPDATE CASCADE,
    data DATE NOT NULL,
    hora TIME NOT NULL
);

CREATE TABLE externo.ingresso (
    id SERIAL PRIMARY KEY,
    telespectador_id INTEGER REFERENCES telespectador (id) ON DELETE SET NULL ON UPDATE CASCADE,
    sessao_id INTEGER REFERENCES sessao (id) ON DELETE SET NULL ON UPDATE CASCADE,
    valor_ingresso REAL,
    corredor CHARACTER (1) NOT NULL,
    poltrona INTEGER CHECK (poltrona > 0)
);




-- ################################ TRIGGERS ################################

-- 4.
CREATE TRIGGER novoTurno AFTER INSERT OR UPDATE ON interno.funcionario
FOR EACH ROW EXECUTE PROCEDURE novoTurno();

-- 3.

-- pegar as horas trabalhadas do funcionario
-- verificar hora entrada e hora saida no msm mes
-- calcular o valor da hora
-- variavel select cai no stores procedure

CREATE FUNCTION pegaSalario(id INTEGER) RETURNS boolean AS
$$
DECLARE
    registro RECORD;
    func funcionario%ROWTYPE;
    hora integer;
    horaTrabalhada integer;
BEGIN
    SELECT INTO func * FROM funcionario WHERE func.id = $1;

    IF func.setor = 'LIMPEZA' THEN
        HORA := 10;
    ELSIF func.setor = 'ATENDIMENTO' THEN
        HORA := 15;
    ELSE
        HORA := 20;
    END IF;

    FOR registro IN SELECT DISTINCT interno.turno.data_hora_entrada FROM interno.turno WHERE func.id = interno.turno.funcionario_id LOOP
        horaTrabalhada := HORA * (interno.turno.data_hora_entrada - interno.turno.data_hora_saida);
    END LOOP;
RAISE NOTICE 'A % A', horaTrabalhada; --sei la, volta NULL
END;
$$ LANGUAGE 'plpgsql';


-- ################################## VIEW ##################################


CREATE VIEW view_ AS SELECT sala.nome AS sala, externo.filme.titulo AS filme, externo.telespectador.nome AS fulano, externo.sessao.data AS data, externo.sessao.hora AS hora, externo.ingresso.corredor AS corredor, externo.ingresso.poltrona AS poltrona FROM sala INNER JOIN externo.sessao ON (sala.id = externo.sessao.sala_id) INNER JOIN externo.filme ON (externo.filme.id = externo.sessao.filme_id) INNER JOIN externo.ingresso ON (externo.sessao.id = externo.ingresso.sessao_id) INNER JOIN externo.telespectador ON (externo.telespectador.id = externo.ingresso.telespectador_id);
