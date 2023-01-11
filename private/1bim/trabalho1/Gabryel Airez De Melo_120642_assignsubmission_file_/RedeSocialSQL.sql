DROP DATABASE IF EXISTS redeSocial;

CREATE DATABASE redeSocial;

\c redeSocial;

CREATE TABLE usuario (
    email varchar(50) not null unique,
    senha varchar(25) not null,
    nome varchar(50),
    primary key (email)
);

CREATE TABLE grupo (
    id integer not null,
    nome varchar(25) not null,
    data_criacao date,
    primary key (id)
);

CREATE TABLE grupo_usuario (
    usuario varchar(50) not null unique,
    grupo integer not null,
    foreign key (usuario) references usuario(email),
    foreign key (grupo) references grupo(id),
    primary key (usuario, grupo)
);

CREATE TABLE publicacao (
    id integer not null,
    data date,
    hora time,
    texto text,
    primary key (id)
);

CREATE TABLE arquivo_midia (
    id integer not null,
    nome varchar(25),
    legenda text,
    primary key (id)
);

CREATE TABLE album (
    id serial not null,
    titulo text,
    descricao text,
    primary key (id)
);

CREATE TABLE arqv_midia_album (
    arquivo_midia integer not null,
    album serial not null,
    foreign key (arquivo_midia) references arquivo_midia(id),
    foreign key (album) references album(id),
    primary key (arquivo_midia, album)
);

CREATE TABLE foto (
    id integer not null,
    legenda text,
    nome_arquivo varchar(25),
    primary key (id)
);