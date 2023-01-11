CREATE DATABASE administradora;

\c administradora;

CREATE TABLE condominio (
    id serial primary key,
    nome text,
    endereco text
);

CREATE TABLE pessoa (
    id serial primary key,
    nome text,
    cpf char(11),
    UNIQUE (cpf)
);

CREATE TABLE unidade (
    id serial primary key,
    numero text,
    bloco text,
    condominio_id integer references condominio (id),
    locatario_id integer references pessoa (id)
);

CREATE TABLE proprietario (
    pessoa_id integer references pessoa (id),
    unidade_id integer references unidade (id),
    primary key (pessoa_id, unidade_id)
);








