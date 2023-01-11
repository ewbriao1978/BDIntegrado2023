DROP DATABASE IF EXISTS gerenciador_faxinas;
CREATE DATABASE gerenciador_faxinas;
\c gerenciador_faxinas;

CREATE TABLE diarista (
    id serial PRIMARY KEY,
    cpf character(11), 
    nome text NOT NULL,
    UNIQUE(cpf)
);

CREATE TABLE responsavel (
    id serial PRIMARY KEY,
    cpf character(11), 
    nome text NOT NULL,
    UNIQUE(cpf)
);

CREATE TABLE tamanho (
    id serial PRIMARY KEY,
    descricao character(1) NOT NULL,
    valor real CHECK (valor > 0)
);

CREATE TABLE residencia (
    id serial PRIMARY KEY,
    cidade text NOT NULL,
    bairro text NOT NULL,
    rua text NOT NULL,
    numero integer CHECK (numero > 0),
    responsavel_id integer REFERENCES responsavel (id),
    tamanho_id integer REFERENCES tamanho (id)
);

CREATE TABLE faxina (
    diarista_id integer REFERENCES diarista (id),
    residencia_id integer REFERENCES residencia (id),
    data date DEFAULT CURRENT_DATE,
    realizada boolean NOT NULL,
    valor_final real CHECK (valor_final > 0),
    feedback text
);

INSERT INTO diarista (cpf, nome) VALUES
('79942853090','Maria'),
('92655649036', 'Rita'),
('44735445080', 'Francisco'),
('49036574005', 'Marcelo');

INSERT INTO responsavel (cpf, nome) VALUES
('75728271014', 'Mario'),
('29458103010', 'Lucia'),
('47005620054', 'Carlos'),
('47760506090', 'Marlene');

INSERT INTO tamanho (descricao, valor) VALUES
('P', 40.00),
('M', 60.00),
('G', 90.00);

INSERT INTO residencia (cidade, bairro, rua, numero, responsavel_id, tamanho_id) VALUES
('Rio Grande', 'Centro', 'General Canabarro', 180, 4, 3),
('Rio Grande', 'Cidade Nova', 'Major Carlos Pinto', 120, 1, 2),
('Pelotas', 'Centro', 'Lobo da Costa', 300, 2, 1),
('Rio Grande', 'Cassino', 'Itaqui', 330, 3, 2);

INSERT INTO faxina (diarista_id, residencia_id, data, realizada, valor_final, feedback) VALUES
(4, 1, '20-06-2022', true, 90.00, 'Muito bom'),
(2, 3, '20-06-2022', true, 45.00, 'Excelente'),
(3, 2, '20-06-2022', false, null, null),
(1, 4, '20-06-2022', true, 60.00, 'Precisa melhorar'),
(1, 1, '21-06-2022', false, null, null),
(4, 2, '21-06-2022', true, 65.00, 'Otimo atendimento');

CREATE OR REPLACE FUNCTION agendafaxina(diarista_id INTEGER, residencia_id INTEGER, faxina_nro INTEGER, frequencia integer, limite date) RETURNS TEXT AS
$$
DECLARE
 contador integer;
 data_aux date;
 limite_aux date; 
 diarista_id alias for $1;
 residencia_id alias for $2;
 faxina_nro alias for $3;
 frequencia alias for $4;
 limite alias for $5;

BEGIN
 limite_aux = limite;

IF (faxina_nro > 30) THEN 
    RETURN 'Número de faxinas supeior a 30';

ELSIF (frequencia != 15 AND frequencia != 30) THEN
    RETURN 'Frequecia deve ser quinzenal ou mensal';

ELSE
    data_aux = CURRENT_DATE;
    FOR contador in 1..faxina_nro LOOP
        IF (dataaux + freg < limiteaux) THEN
        INSERT INTO faxina (diarista_id, residencia_id, data, realizada, valor_final, feedback) VALUES
        (diarista_id, residencia_id, data_aux + frequencia, false, 0, null);
        data_aux = data_aux + frequencia;
        END IF;
    END LOOP;
END IF;

RETURN 'Faxina marcada';
END;
$$ LANGUAGE plpgsql;