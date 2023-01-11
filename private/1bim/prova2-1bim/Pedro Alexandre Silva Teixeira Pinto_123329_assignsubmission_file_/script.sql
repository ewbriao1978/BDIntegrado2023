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
    duracao time not null
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
    nome text not null,
    preco numeric not null check (preco > 0),
    dt_lancamento date default current_date,
    id_gravadora integer references gravadora (id)
);

CREATE TABLE indicacao (
    id_cd_indica integer references cd (id),
    id_cd_indicado integer references cd (id),
    primary key (id_cd_indica, id_cd_indicado)
);


CREATE TABLE autor_musica (
    id_musica integer references musica (id),
    id_autor integer references autor (id),
    id serial primary key
);

CREATE TABLE musica_cd (
    id serial primary key,
    id_musica integer references musica (id),
    id_cd integer references cd (id),
    numero_faixa integer not null
);

INSERT INTO gravadora (nome, endereco, telefone, contato, site)
    VALUES 
        ('Marvel', 'Era uma casa', '9999999999', 'marvel@marvel.com', 'marvel.com'),
        ('DC', 'Muita Engracada', '8888888888', 'dc@dc.com', 'dc.com'),
        ('Levram','Nao tinha teto','7777777777','levram','levram.com'),
        ('CD','Nao tinha nada','6666666666','cd@cd.com','cd.com')
    ;

INSERT INTO autor (nome)
    VALUES
        ('Spider Man'),
        ('Hulk'),
        ('Batman'),
        ('Super Man'),
        ('Renato Russo'),
        ('Rato Cabeludo'),
        ('Rato Careca'),
        ('Aluno Esperto')
    ;

INSERT INTO cd (nome, preco, dt_lancamento, id_gravadora)
    VALUES
        ('Sem lar pra ficar',1.99, '1996-01-01', 1),
        ('Ratoeira me pegou',100.01, '1999-12-12',3),
        ('Acabou a guerra',5,default,2),
        ('Pode falar o que aconteceu',2.17, '2012-12-12',4),
        ('Fechou',15,default,2)
    ;


INSERT INTO musica (nome, duracao)
    VALUES
        ('Grandes poderes, Grandes Responsabilidades','00:00:01'),
        ('Friza por que você matou a Marry Jane','00:01:00'),
        ('Hoje e o amanha de ontem','00:59:59'),
        ('Bolinho de chuva','00:33:33'),
        ('Arquivo comrropido','00:00:00')
    ;

INSERT INTO autor_musica(id_musica, id_autor)
    VALUES 
        (1,1),
        (2,1),
        (3,2),
        (3,6)
    ;

--4
--SELECT autor.*, musica.nome as Nome_Musica
--    FROM autor INNER JOIN
--        autor_musica ON (autor.id = autor_musica.id_autor)
--        INNER JOIN 
--            musica on (musica.id = autor_musica.id_musica)
    ;

--5
SELECT autor.nome as Nome_com_R
    FROM autor 
        WHERE nome ilike 'r%' and nome ilike '%o'
    ;

--6
SELECT musica.*, autor.nome as nome_autor
    FROM musica
        LEFT JOIN autor_musica
            ON (musica.id = autor_musica.id_musica)
        LEFT JOIN autor
            ON (autor.id = autor_musica.id_autor)
        WHERE autor.nome IS NULL 
        ORDER BY musica.id
    ;

--7
SELECT nome, dt_lancamento
    FROM cd
        WHERE extract(year from dt_lancamento) >= 1995 AND 
        extract(year from dt_lancamento) <= 2000
    ;

--8
SELECT  gravadora.nome, 
        AVG(cd.preco) as Media, 
        MAX(cd.preco) as Maior,
        MIN(cd.preco) as Menor,
        COUNT(cd) as Qtde_CD
    FROM gravadora 
        INNER JOIN cd
            on (cd.id_gravadora = gravadora.id)
        GROUP BY gravadora.nome
    ;


--9
SELECT autor.nome, COUNT (*) as Qtde_Autores
    FROM autor 
        INNER JOIN autor_musica 
            ON (autor_musica.id_autor = autor.id)
            GROUP BY (autor.nome)
            HAVING COUNT(*) >= 2
    ;



