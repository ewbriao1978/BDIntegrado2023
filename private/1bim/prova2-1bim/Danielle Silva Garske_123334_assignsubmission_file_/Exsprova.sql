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

CREATE TABLE gravadora (
	id serial primary key,
	nome text,
	endereco character,
	telefone text,
	contato text,
	site text,
	cantor_id integer  references cantor (id),
	musica_id integer  references musica (id)
);

CREATE TABLE cd (
	id serial primary key,
	data_lancamento current_date,
	preco numeric not null

);

----EXERCICIO 4 ----

INSERT INTO gravadora (id, nome, endereco, telefone, contato, site) VALUES
('1', 'ABC', 'Rua XV de Novembro, 28', '32308905', 'abc@gmail.com', 'www.abc.com'),
('2', 'SCATOLOVE', 'Rua 25 de abril, 10', '30259600', 'scatolove@bol.br','www.scatolove.com' ),
('3', 'GRSK', 'Rua Oito,80' '32308605', 'garske@gmail.com', 'www.grsk.com'),
('4', 'LPK', 'Rua Bento Gonçalves,123', '32365051' 'lpk@yahoo.com.br','www.lpkbr.com');

INSERT INTO autor (id,nome) VALUES
('777', 'Adam Levine'),
('666', 'Isa Salles'),
('999', 'Lucas Silveira'),
('555', 'Renato Russo');

INSERT INTO cd (id, nome, data_lancamento, preco, gravadora) VALUES
('13', ' CLÁSSICOS ABC', '1995-01-02','50'),
('14', 'SCATOLOVE', '2020-02-01','190'),
('15', 'MARÉ VIVA', '2020-07-08','30'),
('16', 'TÃO JOVENS', '1997-05-06','150');

INSERT INTO musica (id, numero, autor, duracao) VALUES
('99', '7', 'Lucas Silveira','5:55'),
('10', '13', 'Isa Salles','2:30'),
('11', '2', 'Renato Russo''4:10'),
('12', '9', 'Lucas Silveira', '3:35'),
('18', '21', 'Adam Levine','2:50'),
('7', '35', 'NULL','1:45');

-- 5) select nome from autor where like ‘R% and O’;
-- 6) 
-- 7) select count(*) from data_lancamento WHERE data BETWEEN '1995-01-02' AND '2000-12-01';
-- 8)
-- 9) select nome fom musica where autor
