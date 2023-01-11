DROP DATABASE IF EXISTS redesocial;

CREATE DATABASE redesocial;

\c redesocial

CREATE TABLE usuario (
email text primary key,
nome text,
senha character(32)
);

CREATE TABLE seguidor_usuario (
usuario_seguidor_email text references usuario,
usuario_seguido_email text references usuario,
acompanha_o_feed boolean NOT NULL
);

CREATE TABLE album (
id serial primary key,
titulo text NOT NULL,
descricao text NULL,
usuario_email text references usuario
);

CREATE TABLE foto (
id serial primary key,
legenda text NULL,
nome_do_arquivo text NOT NULL,
album_id integer references album
);

CREATE TABLE publicacao (
id serial primary key,
data_hora_criacao timestamp,
texto text,
usuario_email text references usuario
);

CREATE TABLE arquivo_de_midia (
id serial primary key,
legenda text,
nome text,
publicacao_id integer references publicacao
);

CREATE TABLE grupo (
id serial primary key,
nome text,
data_de_criacao timestamp
);

CREATE TABLE usuario_criar_grupo (
usuario_email text references usuario,
grupo_id integer references grupo
);

CREATE TABLE usuario_participa_grupo (
usuario_email text references usuario,
grupo_id integer references grupo,
data_hora_criacao timestamp NOT NULL,
dono text
);

CREATE TABLE publicacao_grupo (
id serial primary key,
usuario_criador text,
grupo_id integer references grupo
);

INSERT INTO usuario (email, nome, senha) VALUES ('leandrol.matos@gmail.com', 'Leandro Matos', 'agora' );
