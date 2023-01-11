DROP DATABASE IF EXISTS voo;

CREATE DATABASE voo;

\c voo;

CREATE TABLE voo (
    id serial primary key,
    origem text,
    destino text
);

CREATE TABLE pessoa (
    id serial primary key,
    nome text not null   
);

CREATE TABLE reserva (
    id serial primary key,
    voo_id integer references voo (id),
    pessoa_id integer references pessoa (id)
);


CREATE TABLE cidade (
    id serial primary key,
    nome text not null
);

CREATE TABLE aeroporto (
    id serial primary key,
    nome text not null,
    cidade_id integer references cidade (id)
);

CREATE TABLE aeronave (
    id serial primary key,
    modelo text not null
);

CREATE TABLE classe (
    id serial primary key,
    nome text not null
);

CREATE TABLE trecho (
    id serial primary key,
    data_hora timestamp DEFAULT now(),
    origem_id integer references aeroporto (id),
    destino_id integer references aeroporto (id),
    classe_id integer references classe (id),
    aeronave_id integer references aeronave (id)
);

CREATE TABLE voo_trecho (
    voo_id integer references voo (id),
    trecho_id integer references trecho (id),
    primary key (voo_id, trecho_id)
);

INSERT INTO pessoa (nome) VALUES ('iGOR');

INSERT INTO classe (nome) VALUES ('Luxo');
INSERT INTO classe (nome) VALUES ('Economica');
INSERT INTO classe (nome) VALUES ('masterfucker.');

INSERT INTO cidade (nome) VALUES ('POA');
INSERT INTO cidade (nome) VALUES ('Sao Paulo');
INSERT INTO cidade (nome) VALUES ('Salvador');
INSERT INTO cidade (nome) VALUES ('Porto Seguro');

INSERT INTO aeroporto (nome, cidade_id) VALUES ('Salgado filho', 1);
INSERT INTO aeroporto (nome, cidade_id) VALUES ('guarulhos', 2);
INSERT INTO aeroporto (nome, cidade_id) VALUES ('congonhas', 2);
INSERT INTO aeroporto (nome, cidade_id) VALUES ('aero salvador', 3);
INSERT INTO aeroporto (nome, cidade_id) VALUES ('aeroporto seguro', 4);

INSERT INTO voo (origem, destino) VALUES ('POA', 'Porto seguro');
INSERT INTO reserva (pessoa_id, voo_id) VALUES (1,1);


