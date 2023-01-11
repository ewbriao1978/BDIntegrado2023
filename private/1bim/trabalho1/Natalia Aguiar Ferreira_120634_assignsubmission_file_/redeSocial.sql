CREATE DATABASE  redeSocial;

\c redeSocial

CREATE TABLE usuario(
    ID serial primary key NOT NULL,
    nome text,
    senha character(32),
    email  primary key

)CREATE TABLE amizade(
    usuario_id integer primary key NOT NULL,
    amigo_id integer primary key NOT NULL,
    seguindo boolean

)CREATE TABLE cria_grupo(
    usuario_email primary key references usuario(email),
    grupo_id 

)

CREATE TABLE album(
   ID serial primary key,
   descricao text,
   titulo text,
   usuario_id integer references usuario 

)CREATE TABLE foto(
    ID serial primary key,
    nome_arquivo text,
    legenda text,
    album_cod integer references album

)CREATE TABLE publicacao(
    id serial primary key,
    texto text,
    data_hora_publicacao timestamp,
    usuario_id integer references usuario,
    grupo_id integer references grupo

)CREATE TABLE arquivo_midia(
    ID serial primary key,
    nome text,
    legenda text,
    publicacao_id integer references publicacao
)

INSERT INTO usuario