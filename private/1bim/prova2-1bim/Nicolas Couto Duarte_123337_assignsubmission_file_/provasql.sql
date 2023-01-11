\c postgres

drop database gravadoras;

create database gravadoras;

\c gravadoras

create table autor (
	id serial primary key,
	nome text not null
);

create table música (
	id serial primary key,
	nome  text not null ,
	duração time  
);


create table gravadora (
	id serial primary key,
	nome  text not null ,
	endereço text,
    telefone text,
    contato text,
    site  text
);

create table CD (
	id serial primary key,
	nome  text not null ,
    preço int not null check (preço > 0),
    data_de_lançamento date default now(),
    gravadora_id  integer references gravadora (id),
    indica_id integer references  CD (id)
);

create table autor_musica (
autor_id  integer references  autor (id),
musica_id  integer references  música (id),
PRIMARY KEY (musica_id,autor_id )
);

create table CD_musica (
CD_id  integer references  CD (id),
musica_id  integer references  música (id),
faixa integer not null,
PRIMARY KEY (CD_id, musica_id )
);

insert into gravadora (nome,endereço,telefone,contato,site) values
('angelical', 'rua barão de cotegipe 232, Rio grande,RS','984080845','angelical@gmail.com','angelical.com'),
('Hippop', 'rua general pai 489, Rio grande,RS','98405545','hippop@gmail.com','Hippop.com'),
('astral', 'rua dos alfineiros 734, Rio grande,RS','988980845','astral@gmail.com','astral.com'),
('Dreams', 'rua beco da linguiça, Rio grande,RS','984045064','Dreams@gmail.com','Dreams.com');


insert into autor(nome) values
('Renato Russo'),
('pitty'),
('Lucas lucco'),
('Alceu valença'),
('Renato Russa');

insert into CD (nome,preço,data_de_lançamento,gravadora_id,indica_id) values
('album de 30 anos do Renato',100,'1996-02-04',1,2),
('album de 30 anos da pitty',100,'2000-06-01',2,3),
('album de 30 anos do Lucas lucco',100,'2020-08-08',3,4),
('album de 30 anos do Alceu valença',100,'1996-08-04',4,1);


insert into música (nome,duração) values
('Faroeste tá louco','00:10:00'),
('pais e filhos','00:03:00'),
('Aham','00:02:50'),
('Jesus of suburbia','00:09:10');



insert into autor_musica (autor_id,musica_id) values
(3,3),
(4,3),
(1,1),
(1,2);


insert into CD_musica (CD_id,musica_id,faixa) values 
(1,1,1),
(1,2,2),
(3,3,1);

-- consulta exercicio 5 

Select autor.nome from autor where  nome like 'R%o';

-- consulta exercicio 6 não funciona mas tentei
select * from música inner join autor_musica on (música.id != autor_musica.musica_id) except select * from música inner join autor_musica on (música.id = autor_musica.musica_id) where música.id = autor_musica.musica_id;


-- consulta exercicio 7 
select CD.nome, CD.data_de_lançamento from CD where  Extract(year from data_de_lançamento) >= 1995 and  Extract(year from data_de_lançamento) <= 2000;

