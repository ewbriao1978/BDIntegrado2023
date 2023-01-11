DROP DATABASE IF EXISTS fakebook;

CREATE DATABASE fakebook;

\c fakebook;

CREATE TABLE usuario (
	id SERIAL PRIMARY KEY,
	nome text NOT NULL,
	email text NOT NULL,
	senha char(32) NOT NULL
);

CREATE TABLE amigo (
	amigo1_id integer references usuario (id),
	amigo2_id integer references usuario (id)
	
);

CREATE TABLE seguidor(
	seguidor_id integer references usuario (id),
	seguido_id integer references usuario (id)	
);

CREATE TABLE album(
	id SERIAL PRIMARY KEY,
	legenda text,
	nome text,
	album_id integer references album (id)
);

CREATE TABLE grupo(
	id SERIAL PRIMARY KEY,
	nome text,
	dataHora datetime
)

CREATE TABLE publicacao(
	id SERIAL PRIMARY KEY,
	dataHora datetime,
	texto text,
	grupo_id integer references grupo (id),
	usuario_id integer references usuario (id)
);

CREATE TABLE arquivo(
	id SERIAL PRIMARY KEY,
	legenda text,
	nome text,
	publicacao_id integer references publicacao (id)
);

CREATE TABLE membros(
	usuario_id integer references usuario (id),
	grupo_id integer references grupo (id),
	ehDono boolean,
	dataHora datetime
);

SELECT dataHora, texto FROM publicação WHERE usuario_id = seguido_id OR grupo_id(publicacao) = grupo_id(membros) seila