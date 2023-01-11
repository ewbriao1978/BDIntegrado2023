DROP DATABASE IF EXISTS gravadora;

CREATE DATABASE gravadora;

\c gravadora

create table autor (
    id serial primary key,
    nome text not null
);

create table musica (
    id serial primary key,
    nome text not null,
    duracao time not null
);

create table autor_musica (
    autor_id integer references autor(id),
    musica_id integer references musica(id),
    primary key (autor_id, musica_id)
);

create table gravadora (
    id serial primary key,
    nome text not null,
    endereco text not null,
    telefone text not null,
    contato text,
    site text
);

create table cd (
    id serial primary key,
    nome text not null,
    preco real check (preco > 0) not null,
    data_lanc date default current_date,
    gravadora_id integer references gravadora(id)
);

create table musica_cd (
    id serial primary key,
    faixa integer not null,
    musica_id integer references musica(id)
);

insert into gravadora (nome, endereco, telefone, contato, site) values
('Picas', 'Pequenas', '111111111', 'noses', 'bombando.com.br'),
('Glorias', 'Pequenas', '111111111', 'eles', 'mee.com.br'),
('Marias', 'Pequenas', '111111111', 'elas', 'tururu.com.br'),
('SonGoku', 'Pequenas', '111111111', 'todes', 'enos.com.br');

insert into autor (nome) values
('Renato Russo'),
('Dado Lala'),
('Tururu Legal'),
('She-Hulk');

insert into cd (nome, preco, data_lanc, gravadora_id) values
('xongas', 98.1, '1995-05-05', 1),
('Glorias', 11, '1995-06-06', 2),
('Marias', 12.1, '2000-08-08', 3),
('SonGoku', 17.77, '2000-07-07', 4);

insert into musica(nome, duracao) values
('mina', '12:00:00'),
('mino', '02:00:00'),
('mine', '03:00:00'),
('min', '08:00:00'),
('hora', '09:00:00'),
('dia', '10:00:00');

insert into autor_musica(autor_id, musica_id) values
(1, 1),
(2, 1),
(3, 3),
(3, 4),
(1, 5),
(4, 6);

insert into musica_cd(faixa, musica_id) values
(1, 1),
(2, 2),
(3, 6),
(4, 5);

/*
5) resposta
select autor.nome 
    from autor 
        where autor.nome like 'R%' 
        and autor.nome like '%o'; 

6) resposta
select autor.nome 
    from musica 
        join autor_musica on autor_musica.musica_id = musica.id 
        join autor on autor.id = autor_musica.musica_id
            where autor.nome = ''; 

7) resposta
select cd.nome, data_lanc 
    from cd     
        where EXTRACT(year from data_lanc) >= 1995 
        and EXTRACT(year from data_lanc) <= 2000;



8) resposta
select DISTINCT(cd.nome), avg(cd.preco), max(cd.preco), min(cd.preco), count(*) as quantidade 
    from gravadora 
        join cd on gravadora.id = cd.gravadora_id 
            group by 1 
                order by 2 desc;


9) resposta
select musica.nome, count(*) as quantAutores 
    from musica 
        join autor_musica on autor_musica.musica_id = musica.id 
        join autor on autor.id = autor_musica.musica_id 
            group by 1 
                having count(autor.nome) >=2  
; 
   */     
