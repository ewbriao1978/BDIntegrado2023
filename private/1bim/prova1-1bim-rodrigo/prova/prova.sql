DROP DATABASE IF EXISTS prova;

create database prova;

\c prova

create table autor (
    id serial primary key,
    nome text not null
);
create table autor_musica (
    autor_id integer references autor (id),
    musica_id integer references musica (id)
);
create table musica (
    id serial primary key,
    nome text not null
);
create table duracao (
    tempo time,
    musica_id integer references musica (id),
    cd_id integer references cd (id)
),
create table cd (
    id serial primary key,
    nome text
    preco real default 0,
    data_lancamento date default current_date,
    gravadora_id integer references gravadora (id),
    numero_vendas int,
);
create table gravadora (
    id serial primary key,
    nome text not null,
    endereco text,
    telefone text,
    contato text,
    site text
);

insert into autor (nome) values
('Renato russo'),
('xuxa'),
('chitaozinho e chororo'),
('bono');

insert into autor_musica (autor_id, musica_id) values
(1 , 3),
(2 , 1),
(3, 2),
(4, 4);

insert into musica (nome) values
('baixinhos'),
('ai meu coracoa'),
('eduardoemonica'),
('whith or whithout');

insert into duracao (tempo, musica_id, autor_id) values
(23, 3, 1),
(34, 1, 2),
(22, 2, 3),
(64, 4, 4);

insert into cd (nome, preco, data_lancamento, gravdadora_id) values
('cd01', 15, '1996-02-02', 'oceano'),
('cd02', 34, '1999-08-05', 'guaiba'),
('cd03', 22, '2022-01-09', 'atlantida'),
('cd04', 43, '2021-04-06', 'gaucha');

insert into gravadora (nome, endereco, telefone, contato, site) values
('oceano', 'rio grande', '123456', 'ana', '@oceano'),
('atlandida', 'cassino', '234123', 'maria', '@atlandida'),
('gaucha', 'poa', '111111', 'jose', '@gaugha'),
('guaiba', 'guaiba', '1456222', 'joao', '@guaiba');

--5 prova=# select nome from autor where nome like 'R%' and '%o';

--6 prova=# (select musica.nome, autor.nome from musica inner join autor_musica on (musica.id = autor_musica.musica_id) inner join autor on (autor.id = autor_musica.autor_id) where group by musica.nome, autor.nome) except (select musica.nome, autor.nome from musica inner join autor_musica on (musica.id = autor_musica.musica_id) inner join autor on (autor.id = autor_musica.autor_id) where group by musica.nome, autor.nome = null));

--7 prova=# select nome, data_lancamento from cd where 1995 >= data_lancamento <= 2000;

--8 prova=# select gravadora.nome, cd.nome, cd.avg(preco), cd.max(preco), cd.min(preco), cd.sum from gravadora inner join cd on (gravadora.id = cd.gravadora_id) where group by gravadora.nome, cd.nome;

--9 prova=# select musica.nome, autor.nome from musica inner join autor_musica on (musica.id = autor_musica.musica_id) inner join autor on (autor.id = autor_musica.autor_id) where autor.nome >= 2; 