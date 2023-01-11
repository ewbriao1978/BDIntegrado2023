-- 3)
create database gravadora;

create table Autor (
    id serial primary key,
    nome text not null
);

create table Musica(
    id serial primary key,
    nome text not null,
    duracao time
);

create table Autor_Musica(
    id serial primary key,
    id_autor integer not null references Autor(id),
    id_musica integer not null references Musica(id)
);

create table Gravadora(
    id serial primary key,
    nome text not null,
    site text,
    telefone text,
    contato text
);

create table CD(
    id serial primary key,
    id_gravadora integer references Gravadora(id),
    nome text,
    preco real check (preco > 0),
    data_lancamento date default current_date,
    recomendacao integer references CD(id)
);

create table Musica_CD(
    id serial primary key,
    id_musica integer not null references Musica(id),
    id_cd integer not null references CD(id),
    faixa integer not null
);

-- 4)
insert into gravadora(nome, site, telefone, contato) values('gravadora do zezinho', 'www.zezinho.com.br', '(11)11111-1111', 'zezinho@gmail.com');
insert into gravadora(nome, site, telefone, contato) values('gravadora2', 'www.gravadora2.com.br', '(22)22222-2222', 'gravadora2@gmail.com');
insert into gravadora(nome, site, telefone, contato) values('gravadora3', 'www.gravadora3.com.br', '(33)33333-3333', 'gravadora3@gmail.com');
insert into gravadora(nome, site, telefone, contato) values('gravadora4', 'www.gravadora4.com.br', '(44)44444-4444', 'gravadora4@gmail.com');

insert into autor(nome) values('Renato Russo');
insert into autor(nome) values('Seu Jorge');
insert into autor(nome) values('Luan Santana');
insert into autor(nome) values('Cassia Eller');

insert into cd(id_gravadora, nome, preco, data_lancamento) values (1, 'cd do rennato', 20.99, '1995-01-01');
insert into cd(id_gravadora, nome, preco, data_lancamento, recomendacao) values (2, 'cd do seu jorge', 30.99, '2000-01-01', 1);
insert into cd(id_gravadora, nome, preco, recomendacao) values (3, 'cd do luan santana', 14.99, 2);
insert into cd(id_gravadora, nome, preco, data_lancamento, recomendacao) values (4, 'cd da cassia eller', 30.99, '1991-01-01', 3);

insert into musica(nome, duracao) values('musica do Renato com a Cassia', '00:02:12');
insert into autor_musica(id_musica, id_autor) values(1, 1);
insert into autor_musica(id_musica, id_autor) values(1, 4);
insert into musica (nome, duracao) values('musica sem autor', '00:01:00');
insert into musica(nome, duracao) values('musica solo do Renato', '00:06:15');
insert into autor_musica(id_musica, id_autor) values(3, 1);
insert into musica(nome, duracao) values('musica do seu jorge', '00:02:30');
insert into autor_musica(id_musica, id_autor) values(4, 2);

-- 5)
select nome from autor where nome like 'R%' and nome like '%o';

-- 6)
select musica.nome from musica left join autor_musica on (musica.id = autor_musica.id_musica) except select musica.nome from musica inner join autor_musica ON (musica.id = autor_musica.id_musica);

-- 7)
select nome, data_lancamento from cd where data_lancamento >= '1995-01-01' and data_lancamento <= '2000-12-31';

-- 9)
select musica.nome, count(autor.nome) as quantidade_autor from musica 
    inner join autor_musica on musica.id = autor_musica.id_musica
    inner join autor on autor_musica.id_autor = autor.id
    group by musica.nome
    having count(autor.nome) > 1;
