DROP DATABASE IF EXISTS gravadora;

CREATE DATABASE gravadora;

\c gravadora;

CREATE TABLE autor (
    id serial primary key,
    nome text not null
);

CREATE TABLE musica (
    id serial primary key,
    nome text not null,
    duracao time
);

CREATE TABLE musica_autor (
    musica_id integer references musica (id),
    autor_id integer references autor (id),
    primary key (musica_id, autor_id)
);

CREATE TABLE gravadora (
    id serial primary key,
    nome text not null,
    endereco text,
    telefone text,
    contato text,
    site text
);

CREATE TABLE cd (
    id serial primary key,
    gravadora_id integer references gravadora (id),
    nome text not null,
    preco real not null check (preco > 0),
    data_lancamento date DEFAULT CURRENT_DATE
);

CREATE TABLE faixa (
    musica_id integer references musica (id),
    cd_id integer references cd (id),
    numero_faixa integer not null,
    primary key (musica_id, cd_id)
);

INSERT INTO gravadora (nome) VALUES 
('Universal'),
('Trama'),
('Sony'),
('Poligram');

INSERT INTO autor (nome) VALUES 
('Peninha'),
('Renato Russo'),
('Michael Sullivan'),
('Massadas'),
('José Augusto');

INSERT INTO musica (nome) VALUES 
('Alma Gemea'),
('País e Filhos'),
('Tarde De Domingo'),
('Que país é esse?'),
('Envolver');

INSERT INTO musica_autor (musica_id, autor_id) VALUES 
(1,1),
(2,2),
(3,3),
(4,2),
(2,4);

INSERT INTO cd (nome, preco, data_lancamento, gravadora_id) VALUES 
('Legião Urbana - CD', 10.0, '1990-05-05', 1),
('Tim maia', 23.0, '1995-04-06', 2),
('Fabio Jr.', 12.0, '2000-11-10', 1),
('Rita Lee.', 10.0, '2000-11-10', 1);

-- 1) Selecione o nome da gravadora e o nome dos CDs onde o codigo da gravadora seja 2 ou 3.
/*
gravadora=# SELECT gravadora.nome, cd.nome FROM gravadora INNER JOIN cd ON (gravadora.id = cd.gravadora_id) WHERE gravadora.id = 2 or gravadora.id = 3;
*/

-- 2) Selecione as músicas que tem mais de um autor (quantidade de autores >= 2)
/*
gravadora=# SELECT musica.nome, count(*) FROM autor INNER JOIN musica_autor ON (autor.id = musica_autor.autor_id) INNER JOIN musica ON (musica.id = musica_autor.musica_id) GROUP BY musica.nome HAVING count(*) >= 2;
*/

-- 3) Selecione o nome do CD e a data de lançamento dos CDs que foram lançados entre os anos de 1995 (inclusive) e 2000 (inclusive)
/*
gravadora=# SELECT nome, data_lancamento FROM cd WHERE extract(year from data_lancamento) >= 1995 AND extract(year from data_lancamento) <= 2000;
*/

-- 4) Mostre os autores que seu nome comece com R e termine com O.
/*
gravadora=# SELECT autor.nome FROM autor WHERE autor.nome ILIKE 'R%O';
*/

-- 5) Mostre o nome da música e o nome do autor ordenados pelo id da música
/*
gravadora=# SELECT musica.nome, autor.nome FROM autor INNER JOIN musica_autor ON (autor.id = musica_autor.autor_id) INNER JOIN musica ON (musica.id = musica_autor.musica_id) ORDER BY musica.id;
*/

-- 6) Mostre o nome e o código dos CDs da gravadora de código 2.
-- pendente

-- 7) Liste o nome das músicas e seus correspondentes autores.
/*
gravadora=# SELECT autor.nome, musica.nome FROM autor INNER JOIN musica_autor ON (autor.id = musica_autor.autor_id) INNER JOIN musica ON (musica.id = musica_autor.musica_id) ORDER BY musica.nome;
*/

-- 8) Conte quantas músicas não possuem autores.
/*
gravadora=# SELECT count(*) FROM musica WHERE id NOT IN (SELECT musica_id FROM musica_autor);
*/

/*
9) Mostre para cada gravadora: o nome, o preço medio de seus CDs, o maior
preço entre seus cds, o menor preço entre seus cds e a quantidade de CDs.
*/
/*
gravadora=# SELECT gravadora.nome, avg(cd.preco), max(cd.preco), min(cd.preco), count(*) FROM gravadora INNER JOIN cd ON (gravadora.id = cd.gravadora_id) GROUP BY gravadora.nome;
*/

-- Conte as musicas compostas por cada autor
/*
gravadora=# select autor.nome, count(*) from autor INNER JOIN musica_autor ON (autor.id = musica_autor.autor_id) INNER JOIN musica ON (musica.id = musica_autor.musica_id) GROUP BY autor.nome;
*/

-- Construa a instrução sql necessária pra atualizar o nome da gravadora com id = 2
/*
gravadora=# UPDATE gravadora SET nome = 'Gravadora Igor' WHERE id = 2;
*/

-- Mostre os autores que não tem nenhum musica cadastrada
-- gravadora=# SELECT nome FROM autor WHERE id NOT IN (SELECT autor_id FROM musica_autor);

-- Música que não tem autores cadastrados
-- gravadora=# SELECT musica.nome FROM musica WHERE id NOT IN (SELECT musica_id FROM musica_autor);

