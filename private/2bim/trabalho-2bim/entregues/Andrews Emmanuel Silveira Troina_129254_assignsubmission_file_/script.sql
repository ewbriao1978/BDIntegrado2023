DROP DATABASE IF EXISTS andrewstroina;
CREATE DATABASE andrewstroina;

\c andrewstroina;

DROP TABLE IF EXISTS faxina;
DROP TABLE IF EXISTS residencia;
DROP TABLE IF EXISTS tamanho;
DROP TABLE IF EXISTS responsavel;
DROP TABLE IF EXISTS  diarista;


CREATE TABLE  diarista (
    id      SERIAL PRIMARY KEY, 
    nome    VARCHAR(50) NOT NULL, 
    cpf     VARCHAR(11) NOT NULL UNIQUE
);

CREATE TABLE  responsavel (
    id      SERIAL PRIMARY KEY, 
    nome    VARCHAR(50) NOT NULL, 
    cpf     VARCHAR(11) NOT NULL UNIQUE
);

CREATE TABLE  tamanho (
    id      SERIAL PRIMARY KEY, 
    nome    VARCHAR(50) NOT NULL UNIQUE, 
    preco   REAL        NOT NULL,
    CONSTRAINT CHECK_TAMANHO CHECK (nome in ('PEQUENA', 'MEDIA','GRANDE')),
    CONSTRAINT CHECK_PRECO CHECK (preco > 0)
);

CREATE TABLE  residencia (
    id          SERIAL PRIMARY KEY, 
    cidade      VARCHAR(50) NOT NULL,
    bairro      VARCHAR(50) NOT NULL,
    rua         VARCHAR(50) NOT NULL,
    numero      VARCHAR(50) NOT NULL,
    complemento VARCHAR(50),
    tamanho_id      INTEGER NOT NULL,
    responsavel_id  INTEGER NOT NULL,
    CONSTRAINT FK_TAMANHO FOREIGN KEY (tamanho_id) REFERENCES tamanho (id),
    CONSTRAINT FK_RESPONSAVEL FOREIGN KEY (responsavel_id) REFERENCES responsavel (id)
);

CREATE TABLE  faxina (
    id              SERIAL PRIMARY KEY, 
    data            DATE    NOT NULL,
    faxinaConcluida BOOLEAN NOT NULL DEFAULT FALSE,
    diaristaFaltou  BOOLEAN,
    valorPago       REAL,
    feedback        TEXT,
    diarista_id     INTEGER,
    residencia_id   INTEGER NOT NULL,
    CONSTRAINT FK_DIARISTA FOREIGN KEY (diarista_id) REFERENCES diarista (id) on update cascade ON DELETE SET NULL,
    CONSTRAINT FK_RESIDENCIA FOREIGN KEY (residencia_id) REFERENCES residencia (id)
);

--inserts diarista

INSERT INTO diarista (nome, cpf) VALUES ('Cleiton', '12345678901');
INSERT INTO diarista (nome, cpf) VALUES ('Andrews', '12345678902');
INSERT INTO diarista (nome, cpf) VALUES ('Yasmin',  '12345678903');
INSERT INTO diarista (nome, cpf) VALUES ('Hanry',   '12345678904');
INSERT INTO diarista (nome, cpf) VALUES ('Marla',   '12345678905');
    
--inserts responsavel
INSERT INTO responsavel (nome, cpf) VALUES ('Sarah',    '12345678906');
INSERT INTO responsavel (nome, cpf) VALUES ('Maria',    '12345678907');
INSERT INTO responsavel (nome, cpf) VALUES ('Amelia',   '12345678908');
INSERT INTO responsavel (nome, cpf) VALUES ('Tadeu',    '12345678909');
INSERT INTO responsavel (nome, cpf) VALUES ('Marla',    '12345678900');

--inserts tamanho
INSERT INTO tamanho (nome, preco) VALUES ('PEQUENA', 50.00);
INSERT INTO tamanho (nome, preco) VALUES ('MEDIA', 100.00);
INSERT INTO tamanho (nome, preco) VALUES ('GRANDE', 150.00);

--inserts residencia
INSERT INTO residencia (
        cidade,
        bairro,
        rua,
        numero,
        complemento,
        tamanho_id,
        responsavel_id)
    VALUES (
        'Rio Grande',
        'Parque Marinha',
        'Rua dos Recifes',
        '329',
        'fundos',
        '1', --pequena
        '1' --sarah
    );

INSERT INTO residencia (
        cidade,
        bairro,
        rua,
        numero,
        complemento,
        tamanho_id,
        responsavel_id)
    VALUES (
        'Rio Grande',
        'Parque São Pedro',
        'Rua K',
        '32',
        'A',
        '2', --média
        '2' -- maria
    );

INSERT INTO residencia (
        cidade,
        bairro,
        rua,
        numero,
        complemento,
        tamanho_id,
        responsavel_id)
    VALUES (
        'Pelotas',
        'Três Vendas',
        'Rua das Capivaras',
        '29',
        'apartamento 8',
        '3', --grande
        '3' --amelia
    );

INSERT INTO residencia (
        cidade,
        bairro,
        rua,
        numero,
        complemento,
        tamanho_id,
        responsavel_id)
    VALUES (
        'Rio Grande',
        'Centro',
        '24 de Maio',
        '400',
        'acima da loja 5',
        '2', --média
        '4' --tadeu
    );

INSERT INTO residencia (
        cidade,
        bairro,
        rua,
        numero,
        tamanho_id,
        responsavel_id)
    VALUES (
        'Rio Grande',
        'Cassino',
        'Avenida Rio Grande',
        '4',
        '1', --pequena
        '4' --tadeu
    );

--inserts faxina
INSERT INTO faxina (
        data,
        faxinaConcluida,
        diaristaFaltou,
        valorPago,
        feedback,
        diarista_id,
        residencia_id
        )
    VALUES (
        '27-06-2022',
        TRUE,
        FALSE,
        50.00, -- pequena
        'trabalho bem feito',
        '1', --cleiton
        '1' --rua dos recifes
    );

INSERT INTO faxina (
        data,
        faxinaConcluida,
        diaristaFaltou,
        valorPago,
        feedback,
        diarista_id,
        residencia_id
    )
    VALUES (
        '26-06-2022',
        FALSE,
        TRUE,
        50.00, -- pequena
        'nao compareceu',
        '1', --cleiton
        '1' --rua dos recifes
    );

INSERT INTO faxina (
        data,
        faxinaConcluida,
        diaristaFaltou,
        valorPago,
        feedback,
        diarista_id,
        residencia_id
        )
    VALUES (
        '25-06-2022',
        FALSE,
        TRUE,
        50.00, -- pequena
        'diarista nao veio',
        '1', --cleiton
        '1' --rua dos recifes
    );

INSERT INTO faxina (
        data,
        faxinaConcluida,
        diaristaFaltou,
        valorPago,
        feedback,
        diarista_id,
        residencia_id
        )
    VALUES (
        '21-06-2022',
        TRUE,
        FALSE,
        125.00, -- média
        'Trabalho maravilhoso',
        '2', --andrews
        '2' --rua k
    );

    
INSERT INTO faxina (
        data,
        faxinaConcluida,
        diaristaFaltou,
        valorPago,
        feedback,
        diarista_id,
        residencia_id
        )
    VALUES (
        '22-06-2022',
        FALSE,
        TRUE,
        0.00, -- grande
        'fiquei esperando e ninguem veio',
        '3', --yasmin
        '3' --capivaras
    );

    
INSERT INTO faxina (
        data,
        faxinaConcluida,
        diaristaFaltou,
        valorPago,
        feedback,
        diarista_id,
        residencia_id
        )
    VALUES (
        '23-06-2022',
        TRUE,
        FALSE,
        40.00, -- média
        'estragou um móvel',
        '4', --hanry
        '4' --24 de maio
    );

    
INSERT INTO faxina (
        data,
        faxinaConcluida,
        diaristaFaltou,
        valorPago,
        feedback,
        diarista_id,
        residencia_id
        )
    VALUES (
        '27-06-2022',
        TRUE,
        TRUE,
        50.00, -- pequena
        'ok',
        '4', --hanry
        '5' --avenida rio grande
    );

    -----------------------------------------------------------

-- Crie um STORE PROCEDURE que permita agendar quinzenalmente
-- ou mensalmente faxinas em uma determinada residência:

-- A diarista e a residência devem ser considerados parâmetros de entrada.
-- Por outro lado, pode-se realizar o stored procedure de 2 formas: Opções:

--  -> 1) Utilizar uma data limite (ex: até 31/12 do ano atual)
--     2) Utilizar uma quantidade máxima de agendamentos (ex: marcar 30 faxinas mensalmente)

-- 2)                                                                      15 ou 30
CREATE FUNCTION agendarFaxina(diarista_id INTEGER, residencia_id INTEGER, intervalo INTEGER) RETURNS BOOLEAN AS $$
DECLARE
    i INTEGER := 1;
BEGIN

    INSERT INTO faxina (
        data,
        diarista_id,
        residencia_id
        )
    VALUES (
        CURRENT_DATE,
        diarista_id,
        residencia_id
    );

    WHILE (
        SELECT EXTRACT(YEAR FROM (CURRENT_DATE + (i * intervalo)))) < (SELECT EXTRACT(YEAR FROM CURRENT_DATE))+1 LOOP
        INSERT INTO faxina (
            data,
            diarista_id,
            residencia_id
            )
        VALUES (
            CURRENT_DATE + (i * intervalo),
            diarista_id,
            residencia_id
        );

        i := i + 1;
    END LOOP;

    RETURN TRUE;
END;
$$ LANGUAGE 'plpgsql';


-- Crie um STORE PROCEDURE que calcule a porcentagem de presenças
-- que uma diarista obteve em suas faxinas ao longo do ano:
--     Ex: 75% de presença

CREATE OR REPLACE FUNCTION calcular_presencas(dia_id INTEGER) RETURNS REAL AS $$
DECLARE
    presencas   REAL;
    faltas      REAL;
    total       REAL;
BEGIN

    SELECT INTO presencas COUNT(*) FROM faxina WHERE diarista_id = dia_id AND diaristaFaltou = FALSE;
    SELECT INTO faltas 	  COUNT(*) FROM faxina WHERE diarista_id = dia_id AND diaristaFaltou = TRUE;
	IF ((faltas + presencas) > 0) AND (presencas > 0) THEN
		total := 100 - ((presencas * 100) / (faltas + presencas));
	ELSE
		total := 0;
	END IF;

    RETURN total;

END;
$$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION presencas(dia_id INTEGER) RETURNS TEXT AS $$
DECLARE
    total       REAL;
BEGIN

    SELECT INTO total calcular_presencas(dia_id);



    RETURN total || '%';
END;
$$ LANGUAGE 'plpgsql';

-- Crie uma TRIGGER que exclua a diarista caso suas presenças fiquem menores que 75%
-- (quando a diarista já tem no mínimo 5 faxinas cadastradas)

CREATE OR REPLACE FUNCTION exclui_diarista() RETURNS TRIGGER AS $$
DECLARE
    presencas   REAL;
    faltas      REAL;
    total       REAL := 0;
BEGIN

    SELECT INTO presencas COUNT(*) FROM faxina WHERE diarista_id = OLD.diarista_id AND diaristaFaltou = FALSE;
    SELECT INTO faltas    COUNT(*) FROM faxina WHERE diarista_id = OLD.diarista_id AND diaristaFaltou = TRUE;
    SELECT INTO total calcular_presencas(OLD.diarista_id); -- division by zero
 RAISE NOTICE '%', presencas;
 RAISE NOTICE '%', faltas;
 RAISE NOTICE '%', total;

    IF (presencas + faltas) > 5 AND (total < 75) THEN
	RAISE NOTICE '%', OLD.diarista_id;

        DELETE FROM diarista WHERE id = OLD.diarista_id;
        
        RETURN NEW;
    END IF;
    RETURN NEW;

END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER exclui_diarista AFTER UPDATE ON faxina
FOR EACH ROW EXECUTE PROCEDURE exclui_diarista();

-- execuções --Tem que dar mais uns INSERTS pra verificar as presenças
-- SELECT agendarFaxina(1,1,15);
-- SELECT presencas(1);
-- UPDATE faxina SET diaristaFaltou = TRUE WHERE diarista_id = 1;