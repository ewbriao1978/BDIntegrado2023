DROP DATABASE IF EXISTS gravadora;
CREATE DATABASE gravadora;

\c gravadora;

DROP TABLE IF EXISTS musica_cd;
DROP TABLE IF EXISTS autor_musica;
DROP TABLE IF EXISTS cd;
DROP TABLE IF EXISTS gravadora;
DROP TABLE IF EXISTS musica;
DROP TABLE IF EXISTS autor;

CREATE TABLE autor (
	id SERIAL PRIMARY KEY,
	nome TEXT NOT NULL
);

CREATE TABLE musica (
	id SERIAL PRIMARY KEY,
	nome TEXT NOT NULL,
	duracao TIME
);

CREATE TABLE gravadora (
	id SERIAL PRIMARY KEY,
	nome TEXT NOT NULL,
	endereco TEXT,
	telefone TEXT,
	contato TEXT,
	site TEXT
);

CREATE TABLE cd (
	id SERIAL PRIMARY KEY,
	nome TEXT,
	preco REAL NOT NULL CHECK ( preco > 0 ),
	recomendacao INTEGER,
	lancamento DATE DEFAULT CURRENT_DATE,
	gravadora_id INTEGER,
	FOREIGN KEY ( gravadora_id ) REFERENCES gravadora ( id )
);

CREATE TABLE autor_musica (
	autor_id INTEGER,
	musica_id INTEGER NOT NULL,
	FOREIGN KEY ( autor_id ) REFERENCES autor ( id ),
	FOREIGN KEY ( musica_id ) REFERENCES musica ( id ),
	PRIMARY KEY ( autor_id, musica_id )
);

CREATE TABLE musica_cd (
	musica_id INTEGER NOT NULL,
	cd_id INTEGER NOT NULL,
	faixa TEXT NOT NULL,
	FOREIGN KEY ( musica_id ) REFERENCES musica ( id ),
	FOREIGN KEY ( cd_id ) REFERENCES cd ( id ),
	PRIMARY KEY ( musica_id, cd_id )
);

INSERT INTO gravadora ( nome, endereco, telefone, contato, site ) VALUES ( 'Som livre', 'rua das araras, 1', '5312345678', 'teste@teste.com,br', 'loremipsum.com.br' );
INSERT INTO gravadora ( nome, endereco, telefone, contato, site ) VALUES ( 'Tabajara', 'rua dos corvos, 3', '5387654321', 'tst@tst.com.br', 'dolor.com.br' );
INSERT INTO gravadora ( nome, endereco, telefone, contato, site ) VALUES ( 'Perna de Anão', 'rua dos abutres, 5', '5313572468', 'test@test.com.br', 'egestasquis.com,br ' );
INSERT INTO gravadora ( nome, endereco, telefone, contato, site ) VALUES ( 'Nas coxas', 'rua dos morcegos, 7', '5324681357', 'testi@testi.com.br', 'Praesentluctus.com.br' );

INSERT INTO autor ( nome ) VALUES ( 'Renato Russo' );
INSERT INTO autor ( nome ) VALUES ( 'Roberto Gusmão' );
INSERT INTO autor ( nome ) VALUES ( 'Igor Guigui' );
INSERT INTO autor ( nome ) VALUES ( 'Betito Lindo' );

INSERT INTO cd ( nome, preco, recomendacao, lancamento, gravadora_id ) VALUES ( 'Os garotos da rua de trás', 22.5, 2, '1995-04-22', 3 );
INSERT INTO cd ( nome, preco, recomendacao, lancamento, gravadora_id ) VALUES ( 'Ganço Rosa', 50, 4, '1997-02-01', 2 );
INSERT INTO cd ( nome, preco, recomendacao, lancamento, gravadora_id ) VALUES ( 'Vermelho Quente Molho Pimenta', 15.75, 1, '1999-03-15', 4 );
INSERT INTO cd ( nome, preco, recomendacao, lancamento, gravadora_id ) VALUES ( 'Bagunça Organizada', 10, 3, '2000-12-24', 1 );

INSERT INTO musica ( nome, duracao ) VALUES ( 'Eu quero that way', '00:03:55' );
INSERT INTO musica ( nome, duracao ) VALUES ( 'Minha doce criança', '00:12:33' );
INSERT INTO musica ( nome, duracao ) VALUES ( 'Californices', '00:05:03' );
INSERT INTO musica ( nome, duracao ) VALUES ( 'Eu amo o prof. Igor', '01:12:05' );

INSERT INTO musica_cd ( musica_id, cd_id, faixa ) VALUES ( '1', '1', '3' );
INSERT INTO musica_cd ( musica_id, cd_id, faixa ) VALUES ( '2', '2', '1' );
INSERT INTO musica_cd ( musica_id, cd_id, faixa ) VALUES ( '3', '3', '5' );
INSERT INTO musica_cd ( musica_id, cd_id, faixa ) VALUES ( '4', '4', '9' );

INSERT INTO autor_musica ( autor_id, musica_id ) VALUES ( '1', '2' );
INSERT INTO autor_musica ( autor_id, musica_id ) VALUES ( '2', '2' );
INSERT INTO autor_musica ( autor_id, musica_id ) VALUES ( '1', '3' );

--SELECTS RESPOSTAS

--1) SELECT * FROM autor WHERE nome ilike 'R%O';

--2) SELECT musica.nome FROM musica LEFT JOIN (SELECT musica.id FROM musica JOIN autor_musica ON musica.id = autor_musica.musica_id JOIN autor ON autor_musica.autor_id = autor.id) as tmp1 ON musica.id = tmp1.id WHERE tmp1.id IS NULL;

--3) SELECT cd.nome, cd.lancamento FROM cd WHERE date_part('year', lancamento) >= '1995' AND date_part('year', lancamento) <= '2000'

--4) SELECT gravadora.nome, AVG ( cd.preco ) as preco_medio, MAX ( cd.preco ) as maior_preco, MIN ( cd.preco ) as menor_preco FROM cd JOIN gravadora ON cd.gravadora_id = gravadora.id GROUP BY gravadora.nome

--5) SELECT musica.nome, COUNT ( autor.nome ) as qtd_autores FROM musica JOIN autor_musica ON musica.id = autor_musica.musica_id JOIN autor ON autor_musica.autor_id = autor.id GROUP BY musica.nome HAVING ( COUNT ( autor.nome ) >= 2 )
