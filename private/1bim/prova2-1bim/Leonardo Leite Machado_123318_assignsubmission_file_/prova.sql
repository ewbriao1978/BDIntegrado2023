DROP DATABASE IF EXISTS prova;

CREATE DATABASE prova;

\c prova;

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
    nome text not null,
    endereco text,
    site text,
    contato text,
    telefone text
);

CREATE TABLE cd (
    id serial primary key,
    nome text,
    preco real not null check (preco > 0),
    data_lancamento date default current_date,
    id_gravadora integer references gravadora (id),
    recomendo boolean,
    id_outrocd integer check (recomendo <> false)    
);


CREATE TABLE autor_musica (
    id_autor integer references autor (id),
    id_musica integer references musica (id)
);

CREATE TABLE musica_cd (
    id_musica integer references musica (id),
    id_cd integer references cd (id),
    id_faixa serial primary key
);


INSERT INTO gravadora(nome, endereco, site, contato, telefone) values
('record', 'presidente vargas 123', 'recordmusic.com.br', 'record@music.com', '1155668798'),
('universal', 'las vegas 007', 'universal007.com.br', 'universalvegas@uol.com', '4455233584'),
('sosmusic', 'prefeito vargas 321', 'sosmusic.com.br', 'sos@music.com', '1155623368'),
('lualmusic', 'rua camaqua 2208', 'lualbr.com.br', 'lualbr@music.com', '5553981154466');

INSERT INTO autor(nome) values
('roberto carlo'),
('renato alemao'),
('elvis santana'),
('joao gordo');

INSERT INTO cd(nome, preco, data_lancamento, id_gravadora, recomendo, id_outrocd) values
('sonho', 9.99, '01-05-1995', 1, 'true', 2),
('loucuras', 7.85, '02-06-1998', 2, 'false', null),
('anos de ouro', 11.99, '24-12-1996', 3, 'true', 2),
('nutella', 0.99, '02-02-2020', 4, 'true', 3);

INSERT INTO musica(nome, duracao) values
('anjos', 03:44),
('loucou', 02:22),
('ano certo', 03:35),
('nutallo', 00:35);

INSERT INTO autor_musica(id_autor, id_musica) values
(1,2),
(2,1),
(3,1),
(null,3),
(1,4);

INSERT INTO musica_cd(id_musica, id_cd) values
(1,1),
(2,2),
(3,3),
(4,4);















