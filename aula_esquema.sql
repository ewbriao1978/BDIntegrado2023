DROP DATABASE IF EXISTS aula_esquema;

CREATE DATABASE aula_esquema;

\c aula_esquema;

CREATE SCHEMA esquema;

SET search_path TO public, esquema;


CREATE TABLE tabelax (
    id serial primary key,
    nome text
);

CREATE TABLE esquema.tabelay (
    id serial primary key,
    nome text,
    salario real
);

