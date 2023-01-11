DROP DATABASE IF EXISTS prova;

CREATE DATABASE prova;

\c prova;

DROP SCHEMA IF EXISTS externo;
DROP SCHEMA IF EXISTS interno;

-- criando um schema
CREATE SCHEMA externo;
-- criando um schema
CREATE SCHEMA interno;

-- adicionando o esquema no conjunto de esquemas
SET search_path TO public, externo, interno;

-- ==========================================================================

CREATE OR REPLACE FUNCTION validaCPF(char(11)) RETURNS boolean AS
$$
DECLARE
    num1 integer; num2 integer; num3 integer; num4 integer; num5 integer; num6 integer; num7 integer; num8 integer; num9 integer; num10 integer; num11 integer; soma1 integer; soma2 integer; resto2 integer; resto1 integer;
BEGIN
    num1 := substring($1, 1, 1);
    num2 := substring($1, 2, 1);
    num3 := substring($1, 3, 1);
    num4 := substring($1, 4, 1);
    num5 := substring($1, 5, 1);
    num6 := substring($1, 6, 1);
    num7 := substring($1, 7, 1);
    num8 := substring($1, 8, 1);
    num9 := substring($1, 9, 1);
    num10 := substring($1, 10, 1);
    num11 := substring($1, 11, 1);

    soma1 := num1*10 + num2*9 + num3*8 + num4*7 + num5*6 + num6*5 + num7*4 + num8*3 + num9*2;

    resto1 := (soma1 * 10) % 11;

    soma2 := num1*11 + num2*10 + num3*9 + num4*8 + num5*7 + num6*6 + num7*5 + num8*4 + num9*3 + num10*2;

    resto2 := (soma2 * 10) % 11;

    IF resto1 = 10 THEN
        resto1 := 0;
    END IF;

    IF resto2 = 10 THEN
        resto2 := 0;
    END IF;

    IF (resto1 = num10) AND (resto2 = num11) THEN
        return true;
    ELSE
        return false;
    END IF;
END;
$$ LANGUAGE 'plpgsql';

-- =======================================================================

CREATE TABLE externo.telespectador(
    id SERIAL PRIMARY KEY,
    cpf CHAR(11) UNIQUE CHECK(validaCPF(cpf)),
    nome TEXT NOT NULL
);

CREATE TABLE externo.filme (
    id SERIAL PRIMARY KEY,
    titulo TEXT NOT NULL,
    duracao INTEGER CHECK(duracao > 0)
);

CREATE TABLE public.sala (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    capacidade INTEGER CHECK (capacidade > 0)
);

CREATE TABLE externo.sessao(
    id SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    hora TIME NOT NULL,
    sala_id INTEGER REFERENCES sala(id),
    filme_id INTEGER REFERENCES filme(id)
);

CREATE TABLE externo.ingresso(
    id SERIAL PRIMARY KEY,
    valor_ingresso REAL,
    corredor CHAR(1) NOT NULL,
    poltrona INTEGER CHECK(poltrona > 0),
    telespectador_id INTEGER REFERENCES externo.telespectador(id),
    sessao_id INTEGER REFERENCES sessao(id)
);

CREATE TABLE interno.funcionario (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    setor TEXT CHECK(setor = 'LIMPEZA' OR setor = 'ATENDIMENTO' OR setor = 'OPERAÇÃO')
);

CREATE TABLE interno.turno (
    sala_id INTEGER REFERENCES sala(id),
    funcionario_id INTEGER REFERENCES funcionario(id),
    data_hora_entrada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_hora_saida TIMESTAMP,
    PRIMARY KEY (sala_id, funcionario_id, data_hora_entrada)
);

-- ========================================================================

/* CREATE OR REPLACE FUNCTION salarioMensal(INTEGER, REAL) RETURNS VOID AS
$$
DECLARE
BEGIN
    SELECT 
END;
$$ LANGUAGE 'plpgsql'; */

CREATE OR REPLACE FUNCTION novoTurno() RETURNS TRIGGER AS
$$
DECLARE
    aux_rand INTEGER;
BEGIN
    aux_rand := 0;
    SELECT id FROM sala ORDER BY RANDOM() LIMIT 1 INTO aux_rand;
    INSERT INTO turno(sala_id, funcionario_id, data_hora_entrada) VALUES (aux_rand, NEW.id, CURRENT_DATE + INTERVAL '1 DAY' + '08:00:00');
    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER tgNovoTurno AFTER INSERT ON funcionario FOR EACH ROW EXECUTE PROCEDURE novoTurno();



INSERT INTO sala(nome, capacidade) VALUES
    ('1A', 100),
    ('2A', 150),
    ('3A', 75),
    ('1B', 100),
    ('2B', 120);

INSERT INTO externo.telespectador(cpf, nome) VALUES
    ('44868634020', 'Juliano'),
    ('44854854049', 'Maria');

INSERT INTO externo.filme (titulo, duracao) VALUES 
    ('MATRIX REVOLUTION', 120),
    ('BATMAM', 126);

INSERT INTO externo.sessao(data, hora, sala_id, filme_id) VALUES
    ('2022-07-10', '22:00:00', 1, 1),
    ('2022-07-10', '22:00:00', 2, 2);

INSERT INTO externo.ingresso(valor_ingresso, corredor, poltrona, telespectador_id, sessao_id) VALUES
    (25.00, 'A', 1, 1, 1),
    (25.00, 'B', 1, 2, 1);

INSERT INTO interno.funcionario (nome, setor) VALUES
    ('Jucilene', 'OPERAÇÃO'),
    ('Maria', 'LIMPEZA'),
    ('Jucilene', 'ATENDIMENTO');

INSERT INTO interno.turno (sala_id, funcionario_id, data_hora_entrada, data_hora_saida) VALUES
    (1, 1, '2022-06-01 08:00:00', '2022-06-01 17:00:00'),
    (1, 1, '2022-07-01 08:00:00', '2022-07-01 17:00:00'),
    (1, 1, '2022-07-02 08:00:00', '2022-07-02 17:00:00'),
    (1, 1, '2022-07-03 08:00:00', '2022-07-03 17:00:00'),
    (1, 1, '2022-07-04 08:00:00', '2022-07-04 17:00:00');



-- view criada no schema public.
CREATE VIEW info_ingresso AS SELECT public.cliente.nome as cliente_nome, venda.vendedor.nome as vendedor_nome, venda.equipamento.descricao FROM public.cliente INNER JOIN venda.compra ON (public.cliente.id = venda.compra.cliente_id) INNER JOIN venda.vendedor ON (venda.vendedor.id = venda.compra.vendedor_id) INNER JOIN venda.equipamento ON (venda.equipamento.id = venda.compra.equipamento_id);

SELECT public.sala.nome, filme.titulo, telespectador.nome, to_char(sessao.data, 'DD/MM/YYYY') as data, sessao.hora, ingresso.corredor, ingresso.poltrona
FROM telespectador INNER
JOIN ingresso ON (telespectador.id = ingresso.telespectador_id) INNER
JOIN sessao ON (ingresso.sessao_id = sessao.id) INNER
JOIN filme ON (sessao.filme_id = filme.id) INNER
JOIN sala ON (sessao.sala_id = sala.id);