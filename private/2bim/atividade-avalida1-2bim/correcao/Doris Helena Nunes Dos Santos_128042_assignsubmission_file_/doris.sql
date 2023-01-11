DROP DATABASE IF EXISTS cinema;

CREATE DATABASE cinema;

\c cinema     

CREATE SCHEMA externo;

SET search_path
To public, externo;

CREATE SCHEMA interno;

SET search_path
To public, interno;

CREATE TABLE  externo.telespectador(
    id serial PRIMARY KEY,
    cpf CHARACTER(11) UNIQUE,
    nome TEXT NOT NULL ,
        
);

CREATE TABLE externo.sessao
(
    id serial PRIMARY KEY,
    data DATE NOT NULL,
    hora TIME NOT NULL,
    filme_id INTEGER REFERENCES filme(id),
    sala_id INTEGER REFERENCES sala (id)
);

CREATE TABLE externo.filme(
    id serial PRIMARY KEY,
    titulo TEXT NOT NULL,
    duracao INTEGER CHECK(duracao>0)
);

CREATE TABLE sala(
    id serial PRIMARY KEY,
    nome TEXT NOT NULL,
    capacidade INTEGER CHECK(capacidade>0)
);

CREATE TABLE inerno.funcionario(
    id serial PRIMARY KEY,
    nome TEXT NOT NULL,
    setor TEXT
);

CREATE TABLE externo.ingresso
(
    id serial PRIMARY KEY,
    valor_ingresso REAL,
    corredor CHARACTER(1) NOT NULL,
    poltrona INTEGER CHECK(poltrona >0),
    telespectador_id INTEGER REFERENCES telespectador (id),
    sessao_id INTEGER REFERENCES sessao (id)
);

CREATE TABLE interno.turno
(
    sala_id INTEGER REFERENCES sala(id),
    funcionario_id INTEGER REFERENCES funcionario(id),
    data_hora_entrada TIMESTAMP,
    data_hora_saida TIMESTAMP
);

INSERT INTO telespectador(cpf, nome) VALUES ('02848436018', 'Doris');
INSERT INTO telespectador(cpf, nome)VALUES ('12347536936', 'Pedro');
INSERT INTO telespectador(cpf, nome)VALUES('36015987654', 'Miguel');
INSERT INTO telespectador(cpf, nome)VALUES('11111111111', 'Julia');

INSERT INTO funcionario(nome, setor)
VALUES('Milene', 'atendimento');
INSERT INTO funcionario
    (nome, setor)
VALUES('Lucas', 'atendimento');
INSERT INTO funcionario
    (nome, setor)
VALUES('Cristina', 'limpeza');
INSERT INTO funcionario
    (nome, setor)
VALUES('Leonardo', 'operacao');
INSERT INTO funcionario
    (nome, setor)
VALUES('Mercedes', 'operacao');


CREATE VIEW view_cupom AS SELECT public.sala.nome FROM public.sala INNER JOIN externo.filme.titulo FROM externo.filme INNER JOIN externo.telespectador.nome FROM externo.telespectador INNER JOIN externo.sessao.data as externo.sessao.hora FROM externo.sessao INNER JOIN externo.ingresso.corredor as externo.ingresso.poltrona FROM externo.ingresso;

--CREATE FUNCTION turno() RETURNS TRIGGER AS $turno$

--BEGIN

--END;
--$turno$ LANGUAGE plpgsql;

--CREATE TRIGGER turno BEFORE INSERT OR UPDATE ON funcionario FOR EACH
--ROW EXECUTE PROEDURE turno();