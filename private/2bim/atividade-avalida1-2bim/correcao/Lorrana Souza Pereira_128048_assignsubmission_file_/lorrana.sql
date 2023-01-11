DROP DATABASE IF EXISTS script;

CREATE DATABASE script;

\c script;

DROP SCHEMA IF EXISTS interno;
DROP SCHEMA IF EXISTS externo;

DROP FUNCTION IF EXISTS validaCPF;

CREATE SCHEMA interno;
CREATE SCHEMA externo;

SET search_path TO public, interno, externo;



-- DROP TABLE IF EXISTS turno;
-- DROP TABLE IF EXISTS funcionario;
-- DROP TABLE IF EXISTS ingresso;
-- DROP TABLE IF EXISTS sessao;
-- DROP TABLE IF EXISTS sala;
-- DROP TABLE IF EXISTS filme;
-- DROP TABLE IF EXISTS telespectador;

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

CREATE TABLE externo.telespectador (
    id serial primary key,
    cpf character(11) CHECK(validaCPF(cpf) IS TRUE),
    nome text NOT NULL,
    CONSTRAINT CPF_telespectador_UNIQUE UNIQUE (cpf)
);

CREATE TABLE externo.filme (
    id serial primary key,
    titulo text,
    duracao integer,
    CONSTRAINT Check_duracao CHECK (duracao > 0)
);
CREATE TABLE sala (
    id serial primary key,
    nome text NOT NULL,
    capacidade integer,
    CONSTRAINT Check_capacidade CHECK (capacidade > 0)

);
CREATE TABLE externo.sessao (
    id serial primary key,
    filme_id integer,
    sala_id integer,
    data date NOT NULL,
    hora time NOT NULL,
    CONSTRAINT FK_filme FOREIGN KEY (filme_id)
        REFERENCES filme (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE externo.ingresso (
    id serial primary key,
    telespectador_id integer,
    sessao_id integer,
    valor_ingresso real,
    corredor character(1) NOT NULL,
    poltrona integer,
    CONSTRAINT Check_poltrona CHECK (poltrona > 0),
    CONSTRAINT FK_telespectador FOREIGN KEY (telespectador_id)
        REFERENCES  telespectador (id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT FK_sessao FOREIGN KEY (sessao_id)
        REFERENCES sessao (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE interno.funcionario (
    id serial primary key,
    nome text NOT NULL,
    setor text,
    CONSTRAINT Check_setor CHECK (setor in ('LIMPEZA','ATENDIMENTO','OPERAÇÃO'))

);


CREATE TABLE interno.turno (
    sala_id integer,
    funcionario_id integer,
    data_hora_entrada timestamp DEFAULT CURRENT_TIMESTAMP,
    data_hora_saida timestamp,
    primary key (sala_id,funcionario_id,data_hora_entrada)

);

INSERT INTO telespectador(cpf,nome) VALUES ('88888888888','Lorrana');
INSERT INTO telespectador(cpf,nome) VALUES ('03791582054','Lorrana');
INSERT INTO funcionario(nome,setor) VALUES ('Leonardo', 'LIMPEZA');
INSERT INTO funcionario(nome,setor) VALUES ('Igor', 'ATENDIMENTO');
INSERT INTO funcionario(nome,setor) VALUES ('Valeria', 'OPERAÇÃO');

INSERT INTO sala(nome,capacidade) VALUES ('SALA HD',2);
INSERT INTO sala(nome,capacidade) VALUES ('SALA 3D',1);

INSERT INTO filme(titulo,duracao) VALUES ('MEU MALVADO FAVORITO',70);
INSERT INTO sessao(filme_id,sala_id,data,hora) VALUES (1,1,'12/06/2022','10:00');
INSERT INTO ingresso(telespectador_id, sessao_id,valor_ingresso,corredor,poltrona) 
VALUES (2,1,20,'G',4);

INSERT INTO turno(sala_id, funcionario_id, data_hora_entrada, data_hora_saida) VALUES (1,1,'01/06/2022 08:00:00', '01/06/2022 22:00:00'); --14
INSERT INTO turno(sala_id, funcionario_id, data_hora_entrada, data_hora_saida) VALUES (1,1,'02/06/2022 08:00:00', '02/06/2022 21:00:00'); --13



-- 3

CREATE FUNCTION calculaSalario(integer) RETURNS integer AS
$$
DECLARE
 id_func ALIAS FOR $1;
 horas integer; 
 total_horas integer;
 setor_func text;
BEGIN
 SELECT INTO horas sum (extract(hour FROM data_hora_saida) - extract(hour FROM data_hora_entrada))
    FROM funcionario func INNER JOIN turno t on func.id = t.funcionario_id WHERE id = id_func and 
    extract (year from data_hora_saida) = extract (year from current_date) and 
    extract (month from data_hora_saida) = extract (month from current_date) and
    extract (year from data_hora_entrada) = extract (year from current_date) and 
    extract (month from data_hora_entrada) = extract (month from current_date);
  SELECT INTO setor_func setor from funcionario;
 
 IF setor_func in ('LIMPEZA') THEN
    total_horas = 10 * horas;
 END IF;
 IF setor_func in ('ATENDIMENTO') THEN
    total_horas = 15 * horas;
 END IF;
 IF setor_func in ('OPERAÇÃO') THEN
    total_horas = 20 * horas;
 END IF;
 RETURN total_horas;
END;
$$ LANGUAGE 'plpgsql';


-- 4 )
CREATE FUNCTION turno_func() RETURNS TRIGGER AS
$$
DECLARE
 valor_sala integer;
BEGIN
    SELECT INTO valor_sala id from sala ORDER BY RANDOM() LIMIT 1;
    INSERT INTO turno(sala_id, funcionario_id, data_hora_entrada) 
    VALUES (valor_sala,NEW.id,CURRENT_DATE + 1 + cast('8:00:00' as time)); 
    return new;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER turno_func AFTER INSERT ON funcionario
FOR EACH ROW EXECUTE PROCEDURE turno_func();

-- 5 )


CREATE VIEW view_info AS SELECT s.nome as sala, f.titulo, t.nome, to_char(ses.data, 'DD/MM/YYYY') , ses.hora, i.corredor, i.poltrona 
FROM sessao ses INNER JOIN ingresso i on ses.id = i.sessao_id 
INNER JOIN telespectador t on t.id = i.telespectador_id INNER JOIN filme f 
on f.id = ses.filme_id INNER JOIN sala s on s.id = ses.sala_id;

