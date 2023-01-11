DROP DATABASE IF EXISTS socialnetwork;

CREATE DATABASE socialnetwork;

\c socialnetwork;

CREATE TABLE usuario (
  id SERIAL PRIMARY KEY NOT NULL, 
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(60) NOT NULL UNIQUE,
  senha CHAR(32) NOT NULL
);

CREATE TABLE album (
  id SERIAL PRIMARY KEY NOT NULL,
  titulo VARCHAR(100) NOT NULL,
  descricao TEXT NOT NULL,
  usuario_id INTEGER NOT NULL REFERENCES usuario (id)
);

CREATE TABLE foto (
  id SERIAL PRIMARY KEY NOT NULL,
  nome VARCHAR(100) NOT NULL,
  album_id INTEGER NOT NULL REFERENCES album (id)
);

CREATE TABLE usuario_seguidor (
  usuario_id INTEGER REFERENCES usuario (id),
  seguidor_id INTEGER REFERENCES usuario (id),
  PRIMARY KEY(usuario_id, seguidor_id)
);

CREATE TABLE grupo (
  id SERIAL PRIMARY KEY NOT NULL,
  nome VARCHAR(100) NOT NULL,
  adm_id INTEGER REFERENCES usuario (id)
);

CREATE TABLE publicacao (
  id SERIAL PRIMARY KEY NOT NULL,
  legenda TEXT NOT NULL,
  data_criacao DATE NOT NULL,
  hora_criacao TIME NOT NULL,
  usuario_id INTEGER REFERENCES usuario (id),
  grupo_id INTEGER REFERENCES grupo (id)
);

CREATE TABLE arquivo_de_midia (
  id SERIAL PRIMARY KEY NOT NULL,
  nome VARCHAR(100) NOT NULL,
  legenda TEXT,
  publicacao_id INTEGER REFERENCES publicacao (id)
);

CREATE TABLE usuario_publicacao (
  usuario_id INTEGER REFERENCES usuario (id),
  publicacao_id INTEGER REFERENCES publicacao (id),
  PRIMARY KEY (usuario_id, publicacao_id)
);

CREATE TABLE usuario_grupo (
  usuario_id INTEGER REFERENCES usuario (id),
  grupo_id INTEGER REFERENCES grupo (id),
  data_criacao DATE NOT NULL,
  hora_criacao TIME NOT NULL,
  PRIMARY KEY (usuario_id, grupo_id)
);

INSERT INTO usuario (nome, email, senha) VALUES 
('Lucas', 'lucas@email.com', md5('lucas')),
('Matheus', 'matheus@email.com', md5('matheus')),
('Rodrigo', 'rodrigo@email.com', md5('rodrigo')),
('Alana', 'alana@email.com', md5('alana')),
('Nicole', 'nicole@email.com', md5('nicole')),
('Marta', 'marta@email.com', md5('marta'));

INSERT INTO album (titulo, descricao, usuario_id) VALUES 
('Ferias', 'blablabla', 1),
('Futebol', 'blablabla', 1),
('Fim de semana', 'blablabla', 2),
('Europa', 'blablabla', 3),
('Casa da Vó', 'blablabla', 4),
('Floripa', 'blablabla', 5),
('Gramado', 'blablabla', 6),
('Canela', 'blablabla', 6);

INSERT INTO foto (nome, album_id) VALUES 
('Na praia', 1),
('Na piscina', 1),
('Goooool', 2),
('Time', 2),
('Role com os parcas', 3),
('Paris', 4),
('Londres', 4),
('Bruxelas', 4),
('Vozinha', 5),
('Praia dos Ingles', 6),
('Ponte Marcilio Dias', 6),
('Chegando em Gramado', 7),
('Chegando em Canela', 8);

INSERT INTO usuario_seguidor (usuario_id, seguidor_id) VALUES 
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(2, 3),
(2, 1),
(3, 4),
(4, 5),
(5, 1),
(6, 1);

INSERT INTO grupo (nome, adm_id) VALUES 
('Gurizada do TADS', 1),
('Gartic Online', 2);

INSERT INTO publicacao (legenda, data_criacao, hora_criacao, usuario_id, grupo_id) VALUES 
('publicacao1', '2016-09-01'::DATE, '16:30'::TIME, 1, 1),
('publicacao2', '2018-09-01'::DATE, '20:30'::TIME, 5, 1),
('publicacao3', '2018-09-01'::DATE, '20:30'::TIME, 6, 1),
('publicacao4', '2021-09-01'::DATE, '12:30'::TIME, 2, 2),
('publicacao5', '2015-09-01'::DATE, '18:30'::TIME, 4, 2);

INSERT INTO publicacao (legenda, data_criacao, hora_criacao, usuario_id) VALUES 
('publicacao6', '2017-09-01'::DATE, '09:10'::TIME, 3),
('publicacao7', '2012-09-01'::DATE, '16:00'::TIME, 3);

INSERT INTO arquivo_de_midia (nome, legenda, publicacao_id) VALUES 
('foto1.png', 'blabla', 1),
('foto2.png', 'blabla', 1),
('foto3.png', 'blabla', 2),
('foto4.png', 'blabla', 3),
('video1.mp4', 'blabla', 4),
('video2.mp4', 'blabla', 5),
('video3.mp4', 'blabla', 6),
('audio1.mp3', 'blabla', 7),
('audio4.mp4', 'blabla', 7),
('texto1.txt', 'blabla', 7);

INSERT INTO usuario_publicacao(usuario_id, publicacao_id) VALUES 
(1, 6),
(1, 7),
(1, 1),
(1, 2),
(1, 3),
(2, 6),
(2, 7),
(2, 4),
(2, 5),
(3, 6),
(3, 7),
(4, 6),
(4, 7),
(4, 4),
(4, 5),
(5, 6),
(5, 7),
(5, 1),
(5, 2),
(5, 3),
(6, 6),
(6, 7),
(6, 1),
(6, 2),
(6, 3);

INSERT INTO usuario_grupo(usuario_id, grupo_id, data_criacao, hora_criacao) VALUES 
(1, 1, '2020-01-01'::DATE, '12:00'::TIME),
(5, 1, '2021-01-01'::DATE, '13:00'::TIME),
(6, 1, '2022-01-01'::DATE, '19:50'::TIME),
(2, 2, '2019-01-01'::DATE, '12:00'::TIME),
(4, 2, '2020-01-01'::DATE, '16:30'::TIME); 