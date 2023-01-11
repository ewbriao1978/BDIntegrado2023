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
    nome text NOT NULL,
    preco real NOT NULL CHECK (preco > 0),
    dt_lancamento date DEFAULT CURRENT_DATE,
    gravadora_id integer references gravadora (id)
);

CREATE TABLE autor_musica (
    autor_id integer references autor (id),
    musica_id integer references musica (id),
    primary key (autor_id, musica_id)
);

CREATE TABLE musica_cd (
    musica_id integer references musica (id),
    cd_id integer references cd (id),
    faixa integer CHECK (faixa > 0),
    primary key (musica_id, cd_id)
);

CREATE TABLE recomenda (
    cd_id integer references cd (id),
    cd_rec integer references cd (id) 
);

INSERT INTO autor (nome) VALUES
('Renato Russo'),
('Noel Gallagher'),
('Chico Buarque'),
('John Lennon');

INSERT INTO musica (nome, duracao) VALUES
('Pais e filhos', '03:45:00'),
('Songbird', '02:50:00'),
('Calice', '03:20:00'),
('Yesterday', '04:05:00');

INSERT INTO gravadora (nome, endereco, telefone, contato, site) VALUES
('Global Records', 'Street of dreams, 150', '(99)66558844', 'global@email.com', 'https://global.com'),
('Submarine', 'Rua alfredo Huch, 680', '(53)91356412', 'submarine@email.com', 'https://submarine.com'),
('Sony', 'Rua lternativa, 300', '(55)81259873', 'sony@email.com', 'https://sony.com'),
('Warner Music', 'Avenida alatória, 99', '(11)99412676', 'warnermusic@email.com', 'https://warnermusic.com');

INSERT INTO cd (nome, preco, dt_lancamento, gravadora_id) VALUES
('Clock Tower', 21.90, '1998-05-20', 4),
('Yellow Submarine', 44.80, '1996-06-01', 3),
('Nacional', 30.60, '2001-04-21', 1),
('Mix', 54.25, '2010-12-25', 1);

INSERT INTO autor_musica (autor_id, musica_id) VALUES
(1, 3),
(3, 3),
(2, 2),
(2, 4);

INSERT INTO musica_cd (musica_id, cd_id, faixa) VALUES 
(1, 3, 1),
(3, 3, 2),
(2, 1, 1),
(4, 1, 2),
(4, 4, 4),
(3, 4, 3),
(2, 4, 2),
(1, 4, 1),
(2, 2, 1),
(1, 2, 2);

INSERT INTO recomenda (cd_id, cd_rec) VALUES
(4, 1),
(3, 2),
(2, 1),
(1, 2)

-- 7. SELECT cd.nome, dt_lancamento FROM cd WHERE dt_lancamento > '1994-12-31' AND dt_lancamento < '2000-01-01';
-- 9. SELECT musica.nome AS "Musica", autor.nome AS "Autor" FROM autor_musica INNER JOIN musica ON musica.id = autor_musica.musica_id INNER JOIN autor ON autor_musica.autor_id = autor.id; 