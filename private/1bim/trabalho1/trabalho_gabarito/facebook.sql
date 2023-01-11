DROP DATABASE IF EXISTS facebook;

CREATE DATABASE facebook;

\c facebook;

CREATE TABLE usuario (
    id serial primary key,
    nome text,
    email text,
    senha text,
    unique (email)
);

CREATE TABLE seguidor (
    usuario_id integer references usuario (id),
    seguidor_id integer references usuario (id),
    acompanha_feed boolean DEFAULT TRUE,
    primary key (usuario_id, seguidor_id)
);

CREATE TABLE album (
    id serial primary key,
    nome text NOT NULL,
    usuario_id integer references usuario (id)
);

CREATE TABLE foto (
    id serial primary key,
    legenda text,
    arquivo text NOT NULL,
    album_id integer references album (id)
);

CREATE TABLE grupo (
    id serial primary key,
    nome text NOT NULL,
    data_hora_criacao timestamp DEFAULT now()    
);

CREATE TABLE membro (
    id serial primary key,
    usuario_id integer references usuario (id),
    grupo_id integer references grupo (id),
    eh_dono boolean DEFAULT FALSE,
    data_insercao timestamp DEFAULT now(),
    unique (usuario_id, grupo_id)
);

CREATE TABLE publicacao (
    id serial primary key,
    texto text,
    data_hora_criacao timestamp DEFAULT now(),
    usuario_id integer references usuario (id),
    membro_id integer references membro (id)
);

CREATE TABLE arquivo ( 
    id serial primary key,
    nome text,
    legenda text,    
    publicacao_id integer references publicacao (id)
);
