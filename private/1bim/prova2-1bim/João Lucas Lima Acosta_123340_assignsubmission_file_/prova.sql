CREATE DATABASE gravadora;

\c gravadora;

CREATE TABLE autor (
id serial NOT NULL primary key,
nome text NOT NULL

);

CREATE TABLE musica (
id serial primary key,
id_faixa serial NOT NULL,
nome text NOT NULL,
data_inicio date NOT NULL,
data_fim date NOT NULL,
musica_autor integer references autor (id)

);

CREATE TABLE cd (
id serial NOT NULL primary key,
nome text NOT NULL,
data_lancamento timestamp DEFAULT CURRENT_TIMESTAMP,
preco NOT NULL check(>0),
faixa references musica (id_faixa),
local_gravacao references gravadora (id);

);

CREATE TABLE gravadora (
id serial NOT NULL primary key,
nome text NOT NULL,
endereco text NOT NULL,
telefone text NOT NULL,
id_gravadora references cd (id)
 
);

INSERT INTO gravadora (nome, endereco, telefone) VALUES 
('gravadora01','rua1', '111111111'),
('gravadora02','rua2', '222222222'),
('gravadora03','rua3', '333333333'),
('gravadora04','rua4', '444444444');

INSERT INTO autor (nome) VALUES 
('Fulano da Silva'),
('Renato Russo'),
('Ciclana das Neves'),
('Roberto Gusmão');

INSERT INTO cd (nome, data_lancamento, preco) VALUES 
('album01','1995-04-15', 10),
('album02 ','1999-04-18', 50);

INSERT INTO musica (nome, data_inicio, data_fim, musica_autor) VALUES 
('musica01','1995-04-15', '1995-04-16','Renato Russo'),
('musica02','1999-04-18', '1999-08-15','Renato Russo');
('musica03','1999-04-30', '1999-08-07','');
('musica04','1999-11-18', '1999-07-15','Roberto Gusmão');






