DROP DATABASE IF EXISTS somlivre;

CREATE DATABASE somlivre;

\c somlivre;

CREATE TABLE gravadora(
   id SERIAL NOT NULL,
   nome TEXT NOT NULL, 
   endereco TEXT,
   telefone TEXT,
   contato TEXT,
   PRIMARY KEY(id)
);

CREATE TABLE cd(
    id SERIAL NOT NULL,
    nome TEXT,
    preco REAL NOT NULL, /* AND > 0 */
    data_lancamento DATE,
    id_gravadora INTEGER REFERENCES gravadora(id)
    PRIMARY KEY (id)
);

CREATE TABLE musica_cd(
    id_cd INTEGER REFERENCES cd(id),
    id_musica INTEGER REFERENCES musica(id)
);

CREATE TABLE musica(
    id SERIAL NOT NULL,
    nome TEXT NOT NULL,
    duracao CURRENT TIME,
    PRIMARY KEY (id)
);

CREATE TABLE autor(
    id SERIAL NOT NULL,
    nome TEXT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE autor_musica(
    id_autor INTEGER REFERENCES autor(id),
    id_musica INTEGER REFERENCES musica(id)
);

INSERT INTO gravadora(nome, endereco, telefone, contato)VALUES
('Som Livre', 'Av. Brasil, 100','(11) 88249-5959','comercial@somlivre.com.br'),
('Polygram', 'Rua. Pinheiros, 2310','(21) 33249-9059','comercial@polygram.com.br'),
('Record', 'Av. Paulista, 300','(11) 44221-1919','contato@record.com.br');

INSERT INTO cd (nome, preco, data_lancamento, id_gravadora)VALUES
('SPC', '39.90', '2022-04-25', 1),
('O Papa é Pop', '59.90', '2022-04-25', 2),
('Galpão Criolo', '35.90', '2022-04-25', 3);

INSERT INTO musica_cd (id_cd, id_musica)VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO musica (nome, duracao)VALUES
('Sai da minha aba', '02:45:26'),
('Pra ser Sincero', '03:09:19'),
('Origens', '04:02:48');

INSERT INTO autor (nome)VALUES
('Fernando Pires'),
('Alemão de Poa'),
('Nico Fagundes');

INSERT INTO autor_musica (id_autor, id_musica)VALUES
(1,1),
(2,2),
(3,3);