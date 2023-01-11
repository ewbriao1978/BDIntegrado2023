DROP DATABASE IF EXISTS gravadora;

CREATE DATABASE gravadora;

\c gravadora;

CREATE TABLE autor(
    id serial primary key,
    nome text NOT NULL

);
CREATE TABLE musica(
    id serial primary key,
    duracao time,
    nome text NOT NULL
);
CREATE TABLE autor_musica(
    autor_id integer references autor(id),
    musica_id integer references musica(id),
    primary key (autor_id, musica_id)

);
CREATE TABLE cd(
    id_faixa integer references musica(id),
    id serial primary key,
    preco numeric NOT NULL CHECK (preco > 0),
    data_lancamento date default current_date

);
CREATE TABLE recomendar(
    id_cd primary key integer references cd(id),
    cd_recomenda primary key integer references cd(id),
    primary key (id_cd, cd_recomenda)

);
CREATE TABLE musica_cd(
    musica_id integer references musica(id),
    cd_id integer references cd(id),
    primary key (musica_id, cd_id)

);
CREATE TABLE gravadora(
    id serial primary key,
    nome text NOT NULL,
    endereco text,
    contato text,
    telefone text,
    sitee text

);
CREATE TABLE cd_gravadora(
    cd_id integer references cd(id),
    gravadora_id integer references gravadora(id),
    primary key (cd_id, gravadora_id)

);
INSERT INTO autor(id,nome) VALUES
(1,'Ranato Russo');
(2,'Anita');
(3,'Luiza Sonza');
(4,'Baco exu do blues');

INSERT INTO musica (id,duracao,nome) VALUES
(11,'6','Olhos castanhos');
(12,'3','Envolver');
(13,'2','cigana')
(14,'4','Penhasco';
(15,'3','Dois amores');
(16,'5','Melhor sozinha');

INSERT INTO autor_musica(autor_id,musica_id) VALUES
(1,1);
(2,12);
(4,3);
(3,14);
(4,5);
(3,16);

INSERT INTO gravadora(nome,endereço,telefone,contato,sitee) VALUES
('gravadora01','rua vinte quatro de maio 777','111111111','gravadora01@gmail.com','www.gravadora01.com.br');
('gravadora02','rua silva paes 777','222222222','gravadora01@gmail.com','www.gravadora02.com.br');
('gravadora03','rua neto 777','333333333','gravadora01@gmail.com','www.gravadora03.com.br');
('gravadora04','rua dom bosco 777','444444444','gravadora01@gmail.com','www.gravadora04.com.br');


INSERT INTO cd(nome,preco,data_lancamento) VALUES
('CD1','200','1997/15/12/');
('CD2','150','1999/29/09');
('CD3','180','2021/30/11');
('CD4','120','2022/20/10');


/* 5- select nome from autor where cidade like ‘R%’;


