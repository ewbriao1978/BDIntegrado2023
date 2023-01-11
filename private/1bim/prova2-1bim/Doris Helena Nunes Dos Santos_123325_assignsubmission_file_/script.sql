
DROP DATABASE gravadoras;

CREATE DATABASE gravadoras;


CREATE TABLE gravadora (
    id serial NOT NULL,
    nome varchar NOT NULL,
    telefone varchar NOT NULL,
    endereço varchar NOT NULL,
    contato varchar,
    site varchar,
    PRIMARY KEY (id)
);

CREATE TABLE cd (
    id serial NOT NULL,
    nome varchar NOT NULL,
    preço REAL NOT NULL CHECK (preço>0),
    data_lancamento DATE,
    PRIMARY KEY (id), 
    id integer REFERENCES gravadora (gravadora_id)
   
);

CREATE TABLE musica (
    id serial NOT NULL,
    nome varchar NOT NULL,
    duração TIME,
    PRIMARY KEY (id),
    id integer REFERENCES autor (autor_id)

);

CREATE TABLE autor(
    id serial NOT NULL,
    nome varchar NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE cd_musica (
    musica_id serial REFERENCES musica (id),
    cd_id serial REFERENCES cd (id)
    
);

CREATE TABLE autor_musica (
    musica_id serial REFERENCES musica(id),
    autor_id serial REFERENCES autor(id)
    
);


INSERT INTO gravadora(nome, telefone, endereco, contato, site) VALUES
('sony','53994345223','joao manoel, 123, ferreira, são paulo','sony@yahoo.com.br','www.sony.music'),
('music', '53994322223', 'silva paes, 32, Rural, Rio Grande', 'music@gmail.com','www.music.son'),
('pop', '55994345000', 'republica, 555, canoas, porto alegre', 'popsom@popsom.com.br','www.musicpop.com.br'),
('rock', '51844345225', 'abc, 47, julio de castilhos, santa catarina', 'rock@outlook.com','www.rocknaveia.com.br'),
('blus', '59694345223', 'jundiai, 8, bela fonte, pelotas', 'blus@yahoo.com.br','www.bluspelotas.com.br');

INSERT INTO autor (nome) VALUES
('Renato Russo'),
('Avril Lavigne'),
('Marilia Mendonca'),
('Charlie brown jr');

INSERT INTO cd(nome, preco, data_lancamento) VALUES
('Destraido', 59.90,1997-10-10),
('star', 70.50, 2000-11-15),
('sofrencia', 29.90, 1995-05-21),
('soh os loucos sabem', 21.45, 1997-12-02);

INSERT INTO musica (nome, duracao)VALUES
('tenho andado distraido','00:05:01'),
('lets go','00:01:03'),
('estrelinha','00:01:30'),
('soh os loucos sabem','00:01:00');

