-- EX.03


DROP DATABASE IF EXISTS fakebook;

CREATE DATABASE fakebook;

\c fakebook;

CREATE TABLE autor (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL
);

CREATE TABLE musica (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    duracao TIME
);

CREATE TABLE autor_musica (
    autor_id INTEGER REFERENCES autor (id),
	musica_id INTEGER REFERENCES musica (id)
);

CREATE TABLE gravadora (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    telefone TEXT,
    contato TEXT,
    site TEXT
);
-- preferi fazer o endereço mais completo, apesar de no exercicio pedir um tipo texto, já que uma gravadora pode ter vários endereços, blz?
CREATE TABLE endereco (
    id SERIAL,
    rua TEXT,
    numero TEXT,
    bairro TEXT,
    complemento TEXT,
    cidade TEXT ,
    uf TEXT,
    gravadora_id INTEGER REFERENCES gravadora (id),
    PRIMARY KEY (id, gravadora_id)
);

CREATE TABLE cd (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    preco REAL NOT NULL CHECK (preco > 0),
    data TIMESTAMP NOT NULL DEFAULT CURRENT_DATE,
    gravadora_id INTEGER REFERENCES gravadora (id)
);

CREATE TABLE indicacao (
    cd_id INTEGER REFERENCES cd (id),
    indicado_id INTEGER REFERENCES cd (id),
    PRIMARY KEY (cd_id, indicado_id)
);

CREATE TABLE musica_cd (
    musica_id INTEGER REFERENCES musica (id),
    cd_id INTEGER REFERENCES cd (id),
    faixa INTEGER NOT NULL,
    PRIMARY KEY (faixa)
);



-- EX.04

INSERT INTO gravadora  (nome, telefone, contato, site)
    VALUES ('sony', '999999999', 'sony@sony.com', 'sony.sony.com');

INSERT INTO gravadora  (nome, telefone, contato, site)
    VALUES ('bmg', '777777777', 'sony@sony.com', 'sony.sony.com');

INSERT INTO gravadora  (nome, telefone, contato, site)
    VALUES ('universal', '666666666', 'sony@sony.com', 'sony.sony.com');

INSERT INTO gravadora  (nome, telefone, contato, site)
    VALUES ('summereletrohits', '888888888', 'sony@sony.com', 'sony.sony.com');


INSERT INTO endereco  (gravadora_id, rua, numero, bairro, cidade, uf)
    VALUES (1, 'bagual', '123', 'parque marinha', 'rio grande', 'rs');

INSERT INTO endereco  (gravadora_id, rua, numero, bairro, cidade, uf)
    VALUES (2, 'enseadas', '345', 'parque sao pedro', 'rio grande', 'rs');

INSERT INTO endereco  (gravadora_id, rua, numero, bairro, cidade, uf)
    VALUES (3, '24 de maio', '456', 'centro', 'rio grande', 'rs');

INSERT INTO endereco  (gravadora_id, rua, numero, bairro, cidade, uf)
    VALUES (4, 'italia', '567', 'vila maria', 'rio grande', 'rs');


INSERT INTO autor (nome)
    VALUES ('renato russo');

INSERT INTO autor (nome)
    VALUES ('legiao urbana');

INSERT INTO autor (nome)
    VALUES ('three days grace');

INSERT INTO autor (nome)
    VALUES ('caravan palace');

--todos os cds lançados agora por default
INSERT INTO cd (nome, preco, gravadora_id, data)
    VALUES ('metal contra as nuvens', 25, 1, '21/12/1996'); 

INSERT INTO cd (nome, preco, gravadora_id, data)
    VALUES ('agua mole pedra dura', 25, 2, '05/05/1999'); 

INSERT INTO cd (nome, preco, gravadora_id)
    VALUES ('human race', 25, 3); 

INSERT INTO cd (nome, preco, gravadora_id)
    VALUES ('miracle', 25, 4);


INSERT INTO musica (nome, duracao)
    VALUES ('faroeste caboclo', '00:09:30');

INSERT INTO musica (nome, duracao)
    VALUES ('sera', '00:04:30');

INSERT INTO musica (nome, duracao)
    VALUES ('high road', '00:03:30');

INSERT INTO musica (nome, duracao)
    VALUES ('miracle', '00:05:30');

INSERT INTO musica (nome, duracao)
    VALUES ('sem_autor', '00:00:30');

INSERT INTO autor_musica (autor_id, musica_id)
    VALUES (1,1);

INSERT INTO autor_musica (autor_id, musica_id)
    VALUES (2,1);

INSERT INTO autor_musica (autor_id, musica_id)
    VALUES (2,2);

INSERT INTO autor_musica (autor_id, musica_id)
    VALUES (3,3);

INSERT INTO autor_musica (autor_id, musica_id)
    VALUES (4,4);

INSERT INTO autor_musica (musica_id)
    VALUES (5);


INSERT INTO musica_cd (musica_id, cd_id, faixa)
    VALUES (1,1,1);

INSERT INTO musica_cd (musica_id, cd_id, faixa)
    VALUES (2,2,2);

INSERT INTO musica_cd (musica_id, cd_id, faixa)
    VALUES (3,3,3);

INSERT INTO musica_cd (musica_id, cd_id, faixa)
    VALUES (4,4,4);


INSERT INTO indicacao (cd_id, indicado_id)
    VALUES (1,2);

INSERT INTO indicacao (cd_id, indicado_id)
    VALUES (2,1);

INSERT INTO indicacao (cd_id, indicado_id)
    VALUES (3,4);

INSERT INTO indicacao (cd_id, indicado_id)
    VALUES (4,3);


--EX.05
SELECT nome FROM autor WHERE nome LIKE 'r%' AND nome LIKE '%o';

--EX.06
SELECT * FROM musica INNER JOIN autor_musica ON musica.id = autor_musica.musica_id WHERE autor_musica.autor_id = NULL;
--meh, nao deu


