DROP DATABASE IF EXISTS gravadora;

CREATE DATABASE gravadora;

\c gravadora;

CREATE TABLE autor (
id serial primary key,
nome text NOT NULL
);

CREATE TABLE musica (
id serial primary key,
nome text NOT NULL,
duracao time
);

CREATE TABLE recomendacao (
musica1_id integer references musica(id),
musica2_id integer references musica(id),
primary key (musica1_id, musica2_id)
);

CREATE TABLE autor_musica (
autor_id integer references autor(id),
musica_id integer references musica(id)
);

CREATE TABLE gravadora (
id serial primary key,
nome text NOT NULL,
endereco text,
telefone text,
contato text,
site text
);

CREATE TABLE cd (
id serial primary key,
nome text,
preco real NOT NULL CHECK(preco > 0),
data_lancamento date default '2022-04-25',
gravadora_id integer references gravadora(id)
);

CREATE TABLE musica_cd (
musica_id integer references musica(id),
cd_id integer references cd(id),
numero_faixa integer
);

INSERT INTO gravadora (id, nome, endereco, telefone, contato, site) VALUES
('1', 'gravadora1', 'av.1', '11111111', 'contato1@gmail.com', 'site1'),
('2', 'gravadora2', 'av.2', '22222222', 'contato2@gmail.com', 'site2'),
('3', 'gravadora3', 'av.3', '33333333', 'contato3@gmail.com', 'site3'),
('4', 'gravadora4', 'av.4', '44444444', 'contato4@gmail.com', 'site4');

INSERT INTO autor (id, nome) VALUES
('123', 'Renato Russo'),
('456', 'Manuella'),
('789', 'Igor'),
('435', 'Brenda');

INSERT INTO cd (id, nome, preco, data_lancamento, gravadora_id) VALUES
('34', 'cd34', '20', '2000-04-03', '1'),
('35', 'cd35', '50', '1995-05-08', '2'),
('36', 'cd36', '100', '2022-10-5', '3'),
('37', 'cd37', '23', '2020-06-03', '4');

INSERT INTO musica(id, nome, duracao) VALUES
('3534', 'anoitecer', '00:01:30'),
('0439', 'ensolarado', '00:02:40'),
('9854', 'sentadona', '00:03:00'),
('1524', 'modo turbo', '00:01:40');

INSERT INTO autor_musica(autor_id, musica_id) VALUES
('456', '3534'),
('456', '0439'),
(NULL, '9854'),
('123', '1524');


/*
5) select musica.nome, autor.nome from musica INNER JOIN autor_musica ON (autor_musica.musica_id = musica.id) INNER JOIN autor ON (autor_musica.autor_id = autor.id) where ano between 1995 AND 2000;
6)select autor_musica.autor_id, musica.nome FROM autor_musica INNER JOIN musica ON (autor_musica.musica_id = musica.id) where autor_musica.autor_id is null;
7) select cd.nome, cd.data_lancamento WHERE data_lancamento 
8)select cd.nome, cd.preco from cd INNER JOIN gravadora ON (cd.gravadora_id = gravadora.id) order by cd.gravadora_id;
9)select musica.nome, autor.id, autor.nome FROM musica INNER JOIN autor_musica ON (autor_musica.musica_id = musica.id) INNER JOIN autor ON (autor_musica.autor_id = autor.id);
*/
