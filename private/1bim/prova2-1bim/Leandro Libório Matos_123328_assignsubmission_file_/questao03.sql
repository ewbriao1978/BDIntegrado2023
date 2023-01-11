DROP DATABASE IF EXISTS gravadora;

CREATE DATABASE gravadora;

\c gravadora

CREATE TABLE autor (
id serial primary key,
nome text not null
);

CREATE TABLE musica (
id serial PRIMARY KEY NOT NULL,
nome text NOT NULL,
duracao time NOT NULL
);

CREATE TABLE autor_musica (
autor_id integer NULL REFERENCES autor (id),
musica_id integer REFERENCES musica (id),
primary key (autor_id, musica_id)
);

CREATE TABLE gravadora (
id serial primary key NOT NULL,
nome text NOT NULL,
endereco text NOT NULL,
contato text NOT NULL,
site text NOT NULL,
telefone numeric NOT NULL
);

CREATE TABLE cd (
id serial primary key NOT NULL,
data_de_lanc date DEFAULT current_date,
preco numeric NOT NULL CHECK (preco > 0),
nome text NOT NULL,
cd_id integer REFERENCES cd (id),
gravadora_id integer REFERENCES gravadora (id)
);

CREATE TABLE musica_cd (
musica_id integer REFERENCES musica (id),
cd_id integer REFERENCES cd (id),
primary key (musica_id, cd_id),
numero_da_faixa numeric NOT NULL
);

INSERT INTO gravadora (id, nome, endereco, contato, site, telefone) VALUES 
(1, 'sony', 'av atlantica', 'sonymusic@gmail.com', 'www.sonymusic.com', 32584679),
(2, 'record', 'av dom pedro', 'recormusic@outlook.com', 'www.recormusic.com', 32467848),
(3, 'rosalia', 'av espanha', 'rosaliamusic@gmail.com', 'wwww.rosaliamusic.com', 32594895),
(4, 'som livre', 'av da paz', 'somlivre@gmail.com', 'www.somlivre.com', 32741598);

INSERT INTO autor (id, nome) VALUES
(1, 'joao de barro'),
(2, 'reginaldo russo'),
(3, 'catarina'),
(4, 'joaquim da costa');

INSERT INTO cd (id, data_de_lanc, preco, nome, cd_id, gravadora_id) VALUES
(1, current_date, 30, 'el mal querer', 2, 1),
(2, current_date, 40,'natural', 1, 2),
(3, '1995-08-23', 20, 'night visions', 2, 4),
(4, '2000-04-12', 30, 'year', 1, 3);

INSERT INTO musica (id, nome, duracao) VALUES
(1, 'nova', '03:15'),
(2, 'antiga', '02:30'),
(3, 'noventa', '04:00'),
(4, 'banco', '03:45');

INSERT INTO autor_musica (autor_id, musica_id) VALUES
(1, 3),
(1, 4),
(2, 3);

SELECT autor.nome FROM autor WHERE nome ilike 'r_____________o';