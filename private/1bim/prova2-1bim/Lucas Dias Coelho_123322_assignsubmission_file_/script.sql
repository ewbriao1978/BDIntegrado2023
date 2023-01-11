DROP DATABASE IF EXISTS gravadora;

CREATE DATABASE gravadora;

\c gravadora;

CREATE TABLE autor (
    id SERIAL PRIMARY KEY NOT NULL,
    nome TEXT NOT NULL
);

CREATE TABLE musica (
    id SERIAL PRIMARY KEY NOT NULL,
    nome TEXT NOT NULL,
    duracao TIME
);

CREATE TABLE autor_musica (
    autor_id INTEGER REFERENCES autor (id), 
    musica_id INTEGER NOT NULL REFERENCES musica (id),
    PRIMARY KEY (autor_id, musica_id)
);

CREATE TABLE gravadora (
    id SERIAL PRIMARY KEY NOT NULL,
    nome TEXT NOT NULL,
    endereco TEXT,
    telefone TEXT,
    contato TEXT,
    website TEXT
);

CREATE TABLE cd (
    id SERIAL PRIMARY KEY NOT NULL,
    nome TEXT NOT NULL,
    preco REAL NOT NULL CHECK (preco > 0),
    data_lancamento DATE DEFAULT CURRENT_DATE,
    gravadora_id INTEGER NOT NULL REFERENCES gravadora (id),
    cd_id INTEGER REFERENCES cd (id)
);

CREATE TABLE musica_cd (
    musica_id INTEGER NOT NULL REFERENCES musica (id),
    cd_id INTEGER NOT NULL REFERENCES cd (id), 
    faixa INTEGER NOT NULL,
    PRIMARY KEY (cd_id, musica_id)
); 

INSERT INTO gravadora (nome, endereco, telefone, contato, website) VALUES 
('GuriFan', 'Rua K, numero 888. Parq. Sao Pedro, Rio Grande/RS', '(53) 99999-8888', 'gurifan@email.com', 'gurifan.com.br'),
('Kongzilla', 'Rua L, numero 777. Parq. Marinha, Rio Grande/RS', '(53) 99999-7777', 'kong@email.com', 'kong.com.br'),
('Rock Paulera', 'Rua M, numero 666. Bolaxa, Rio Grande/RS', '(53) 99999-6666', 'rp@email.com', 'rockpaulera.com.br'),
('Pagode Raiz', 'Rua N, numero 555. Cassino, Rio Grande/RS', '(53) 99999-5555', 'pagodin@email.com', 'pagodin.com.br');

INSERT INTO autor (nome) VALUES 
('Renato Russo'),
('Paulo Uruguaio'),
('Danilo Angolano'),
('César Tailandes');

INSERT INTO cd (nome, preco, data_lancamento, gravadora_id, cd_id) VALUES
('Uruguaina Chuvosa, Alegrete Ensolarado', 23.50,'1999-10-10', 1, 2),
('Quebradao da Quebrada', 33.50, '1999-10-10', 2, 1),
('Massacration - Worst Hits', 1.99, '2004-02-08', 3, 1),
('Pagodin do Amor e da Ousadia', 199.90, '2007-07-03', 4, 2);

INSERT INTO musica (nome, duracao) VALUES
('Musica Generica da Fronteira', '03:07'),
('Ousado e Alegre', '05:02'),
('Ford Ka 99 Tunado', '03:54'),
('Churras da Lage com a Moza', '04:12');

INSERT INTO autor_musica (autor_id, musica_id) VALUES
(1, 1),
(2, 1),
(1, 3),
(3, 4),
(4, 4);

-- INSERT INTO autor_musica (musica_id) VALUES 
-- (2);

INSERT INTO musica_cd (musica_id, cd_id, faixa) VALUES 
(1, 1, 1),
(2, 1, 2),
(2, 2, 1),
(3, 3, 1),
(3, 1, 2),
(4, 4, 1);

SELECT autor.nome FROM autor WHERE nome LIKE 'R%o';