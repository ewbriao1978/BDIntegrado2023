DROP DATABASE IF EXISTS facebook;

CREATE DATABASE facebook;

\c facebook;

CREATE  TABLE usuario (
email text primary key,
nome text not null,
senha text not null
);

CREATE TABLE albuns (
id serial primary key,
descricao text,
titulo text
);

CREATE TABLE fotos (
codigo serial primary key,
nome_arquivo text,
legenda text
);

CREATE TABLE grupo (
id serial primary key,
nome text not null,
dono text not null,
participante text,
dataCriacao date
);

CREATE TABLE publicacao (
id serial primary key,
data date,
hora time not null,
texto text
);

CREATE TABLE arquivos_midia (
codigo serial primary key,
nome text not null,
legenda text
) ;
