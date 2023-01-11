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
    contato text

);

CREATE TABLE autorMusica (
    idautor integer references autor (id),
    idmusica integer references musica (id),
    primary key(idautor,idmusica)

);

CREATE TABLE CD (
    id serial primary key,
    nome text,
    preco real NOT NULL CHECK (preco > 0),
    data_lancamento date NOT NULL DEFAULT current_date,
    idgravadora integer NOT NULL references gravadora (id)

);

CREATE TABLE MusicaCD (
    idmusica integer references musica (id),
    idcd integer references CD (id),
    faixa integer,
    primary key(idmusica,idcd)

);

CREATE TABLE Indicacao (
    idcd integer references CD (id),
    idIndicacao integer NOT NULL references CD (id),
    primary key(idcd)

);

insert into gravadora (nome, endereco,telefone,contato) values ('Traps', 'Rua Marluz', '55 (53) 999702174', 'contato@rock.com.br');
insert into gravadora (nome, endereco,telefone,contato) values ('Funkcity', 'Rua Alecrim', '55 (53) 999702174', 'contato@funkcity.com.br');
insert into gravadora (nome, endereco,telefone,contato) values ('Pagodotudo', 'Rua São Miguel', '55 (53) 999702174', 'contato@pagodotudo.com.br');
insert into gravadora (nome, endereco,telefone,contato) values ('Records', 'Rua Vale', '55 (53) 999702174', 'contato@serta.com.br');

insert into autor (nome) values ('Renata Coutinho');
insert into autor (nome) values ('Luiza Sonza');
insert into autor (nome) values ('Thiaguinho');
insert into autor (nome) values ('Matue');
insert into autor (nome) values ('Renato Russo');
insert into autor (nome) values ('Roberto Gusmão');

insert into CD (nome,preco,data_lancamento,idgravadora) values ('Sucessos',50.70,'01/12/2000',4);
insert into CD (nome,preco,data_lancamento,idgravadora) values ('Flores',100.40,'02/02/2018',2);
insert into CD (nome,preco,data_lancamento,idgravadora) values ('Mais ouvida',78.70,'04/05/1996',3);
insert into CD (nome,preco,data_lancamento,idgravadora) values ('Mais ouvida 2',100.30,'04/05/1996',3);
insert into CD (nome,preco,data_lancamento,idgravadora) values ('Trap tue',46.25,'18/10/2020',1);

insert into musica (nome,duracao) values ('666','1:30');
insert into musica (nome,duracao) values ('boa menina','3:00');
insert into musica (nome,duracao) values ('Aquela lua','2:40');
insert into musica (nome,duracao) values ('Rosas','2:10');
insert into musica (nome,duracao) values ('Envolver','2:30');


insert into autorMusica (idautor,idmusica) values (1,1);
insert into autorMusica (idautor,idmusica) values (4,1);
insert into autorMusica (idautor,idmusica) values (2,2);
insert into autorMusica (idautor,idmusica) values (4,3);
--CHECK IN CDINDICADO DIFERENTE DE CD
--5
SELECT nome FROM autor where nome ilike 'r%_%o';
--6
SELECT nome FROM musica m where id not in (SELECT idmusica FROM autorMusica);
--7
SELECT nome FROM cd where extract(year from (cast(data_lancamento as date))) between '1995' and '2000';
--8
SELECT g.nome, avg(c.preco) as preco_medio, max(c.preco) as preco_maximo, min(c.preco) as preco_minimo from gravadora g inner join CD c on g.id = c.idgravadora
group by g.id;