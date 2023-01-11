DROP DATABASE IF EXISTS locadora;

CREATE DATABASE locadora;

\c locadora;

CREATE TABLE cliente (
    id serial primary key,
    nome text not null,
    endereco text,
    telefone text
);

CREATE TABLE ator (
    id serial primary key,
    nome text not null,
    nome_artistico text,
    data_nascimento date
);

CREATE TABLE categoria (
    id serial primary key,
    nome text not null
);

CREATE TABLE filme (
    id serial primary key,
    titulo text not null,
    categoria_id integer references categoria (id)
);

CREATE TABLE fita (
    id serial primary key,
    ordem integer DEFAULT 1,
    filme_id integer references filme (id)
);

CREATE TABLE cliente_fita (
    cliente_id integer references cliente (id),
    fita_id integer references fita (id),
    primary key (cliente_id, fita_id)
);

CREATE TABLE filme_ator (
    ator_id integer references ator (id),
    filme_id integer references filme(id),
    primary key (ator_id, filme_id)
);  





