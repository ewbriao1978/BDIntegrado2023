drop database if exists gravadoras;

create database gravadoras;

\c gravadoras;

create table autor (
	id serial primary key,
	nome text not null
);


create table musica (
	id serial primary key,
	nome text,
	duracao time
);


create table cd (
    id serial,
    nome text not null,
    preco real not null check (preco > 0),
    data_lancamento date default current_date,
    numero_faixa integer   
);

create table recomendar_cd (
    id integer not null ,
    nome_cd text not null
);


create table musica_cd (
	musica_id integer references musica (id),
	cd_id integer references musica (id),
	primary key(musica_id, cd_id)
);


create table autor_musica (
	autor_id integer references autor (id),
	musica_id integer references musica (id),
	primary key (autor_id, musica_id)
);

create table gravadora (
	id serial primary key,
    nome text not null,
    endereco text,
    telefone text,
    contato text,
    site text,
	autor_id integer references autor (id)
);

insert into autor (nome) values
('Village People'),
('Mamonas Assassinas'),
('Caetano veloso');
insert into autor (nome) values
('RPM People SO');
insert into autor (nome) values
( '');

insert into musica (nome, duracao) values
('Vila Cezar', '00:05:22'),
('Sombra dos Lobos', '00:03:10'),
('Mama Africa', '00:02:45');

insert into musica (nome, duracao) values
('Gita', '00:05:22'),
( 'Pareee'  , '00:06:22');


insert into cd (nome, preco, data_lancamento, numero_faixa) values
('Barbatanas', 150.00, default, 2),
('The Mountain', 99.00, default, 1);

insert into cd (nome, preco, data_lancamento, numero_faixa) values
('Silver-Gold', 110.00, '1998-11-05', 4),
('The Wall', 500.00, '1999-05-06', 3);

insert into recomendar_cd (id, nome_cd) values
(2, ' CD - Vlantimes'),
(3, 'CD - Times of Square'),
(1, 'CD - Tiruajana');


insert into musica_cd (musica_id, cd_id) values
(1, 3),
(2, 2),
(3, 1);

insert into musica_cd (musica_id, cd_id) values
(1, 4);


insert into autor_musica (autor_id , musica_id) values
(1, 3),
(2, 1),
(3, 2);

insert into autor_musica (autor_id , musica_id) values
(1, 4);

insert into gravadora (nome, endereco, telefone, contato, site, autor_id) values
('Records', 'Rua Silva Paes, 45', '53991828233', 'records@gmail.com', 'www.records222.com.br', 3),
('Premium', 'Rua Colorado Lopes, 4555', '55-32320504', 'premiunrecords@hotmail.com', 'www.premiunrecords222.com.br', 2),
('Prime', 'Rua Arturo Brigadeiro, 09', '53991828222', 'prime@gmail.com', 'www.prime5555.com.br', 1);

insert into gravadora (nome, endereco, telefone, contato, site, autor_id) values
('Recomended-Music', 'Av Ceus de Anil, 25A', '53991888230', 'recomended@gmail.com', 'www.recomended011.com.br', 4);


-- 5) SELECT * FROM autor WHERE nome ilike 'R%O';


--6)SELECT autor.nome as autores FROM autor INNER JOIN musica ON musica.id = autor.id;


--7)SELECT cd.nome, cd.data_lancamento FROM cd   WHERE extract(year from cd.data_lancamento) <= 2000 AND 
--extract(year from cd.data_lancamento) >= 1995;

