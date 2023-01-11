DROP DATABASE IF EXISTS prova2sem;

CREATE DATABASE prova2sem;

\c prova2sem;

DROP SCHEMA IF EXISTS interno;
DROP SCHEMA IF EXISTS externo;

CREATE SCHEMA interno;
CREATE SCHEMA externo;

SET search_path TO public, interno, externo;

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

-- ex: select pessoa.nome, pessoa.cpf, mascaraCPF(pessoa.cpf) from pessoa;     
CREATE FUNCTION mascaraCNPJ(character(14)) RETURNS text AS
$$ 
DECLARE
    cnpj CHARACTER(14);
    cnpj_formatado TEXT;
BEGIN
    cnpj = $1;
    cnpj_formatado := SUBSTRING(cnpj,1, 2) || '.' || SUBSTRING(cnpj,3, 3) || '.' || SUBSTRING(cnpj,6, 3) || '/' || SUBSTRING(cnpj,9, 4) || '-' || SUBSTRING(cnpj,13, 2); 
    return cnpj_formatado;    
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION mascaraCPF(character(11)) RETURNS text AS
$$ 
DECLARE
    cpf CHARACTER(11);
    cpf_formatado TEXT;
BEGIN
    cpf = $1;
    cpf_formatado := SUBSTRING(cpf,0, 4) || '.' || SUBSTRING(cpf,4, 3) || '.' || SUBSTRING(cpf,7, 3) || '-' || SUBSTRING(cpf,10, 3);
    return cpf_formatado;    
END;
$$ LANGUAGE 'plpgsql';


CREATE TABLE externo.telespectador(
    id SERIAL PRIMARY KEY,
    cpf character(11) NOT NULL CHECK (validaCPF(cpf) IS TRUE),
    unique(cpf),
    nome text NOT NULL
);

CREATE TABLE externo.filme(
    id SERIAL PRIMARY KEY,
    titulo text NOT NULL,
    duracao integer CHECK (duracao > 0)
);

CREATE TABLE public.sala(
    id SERIAL PRIMARY KEY,
    nome text NOT NULL,
    hora time NOT NULL,
    capacidade INTEGER CHECK (capacidade > 0)
);


CREATE TABLE externo.sessao(
    id SERIAL PRIMARY KEY,
    filme_id INTEGER REFERENCES externo.filme(id),
    sala_id INTEGER REFERENCES public.sala(id),
    Data_sessao date NOT NULL,
    hora time NOT NULL
);


CREATE TABLE externo.ingresso(
    id SERIAL PRIMARY KEY,
    telespectador_id INTEGER REFERENCES externo.telespectador(id),
    sessao_id INTEGER REFERENCES externo.sessao(id),
    valor_ingresso real,
    corredor character(1) NOT NULL,
    poltrona INTEGER CHECK (poltrona > 0)
);

CREATE TABLE interno.funcionario(
    id SERIAL PRIMARY KEY,
    nome text NOT NULL,
    setor text CHECK (setor = 'LIMPEZA'or setor ='ATENDIMENTO'or setor ='OPERACAO')
);

CREATE TABLE interno.turno(
    sala_id INTEGER REFERENCES public.sala(id),
    funcionario_id INTEGER REFERENCES interno.funcionario(id),
    data_hora_entrada timestamp DEFAULT CURRENT_TIMESTAMP,
    data_hora_saida timestamp
);

CREATE FUNCTION criar_turno() RETURNS TRIGGER AS
$$
DECLARE
novo_turno_data timestamp;
sala_turno INTEGER;
funcionario_novo INTEGER;
BEGIN

SELECT INTO sala_turno id FROM public.sala WHERE id = public.sala_id ORDER BY RANDOM() LIMIT 1;
SELECT INTO funcionario_novo FROM interno.funcionario WHERE id = NEW.funcionario_id;

INSERT INTO interno.turno(funcionario_id, data_hora_entrada, sala_id) VALUES (funcionario_novo,CURRENT_DATE + INTERVAL '1 day', sala_turno);
RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER criar_turno AFTER INSERT ON interno.funcionario
FOR EACH ROW EXECUTE PROCEDURE criar_turno();

--CREATE FUNCTION calcula_salario (integer, text) RETURNS INTEGER AS
--$$
--DECLARE 
--soma_horas INTEGER;






