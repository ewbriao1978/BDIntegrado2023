DROP DATABASE IF EXISTS livraria_online;

CREATE DATABASE livraria_online;

\c livraria_online;

CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    cpf CHARACTER(11),
    cnpj CHARACTER(14),
    nome TEXT NOT NULL,
    email TEXT UNIQUE,
    senha TEXT,
    rua TEXT,
    bairro TEXT,
    complemento TEXT,
    nro TEXT    
);

CREATE TABLE autor (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL
);

CREATE TABLE compra (
    id SERIAL PRIMARY KEY,
    data_hora TIMESTAMP,
    cliente_id INTEGER REFERENCES cliente (id)
);

CREATE TABLE livro (
    isbn TEXT PRIMARY KEY,
    titulo TEXT,
    sinopse TEXT,
    data_lancamento DATE
);

CREATE TABLE autor_livro (
    autor_id INTEGER REFERENCES
    autor (id),
    livro_isbn TEXT REFERENCES
    livro (isbn),
    PRIMARY KEY (autor_id, livro_isbn)
);

CREATE TABLE editora (
    id SERIAL PRIMARY KEY,
    nome TEXT,
    telefone TEXT,
    endereco TEXT,
    responsavel TEXT
);

CREATE TABLE exemplar (
    nro_sequencia INTEGER,
    livro_isbn TEXT REFERENCES livro (isbn),
    compra_id INTEGER REFERENCES compra (id),
    editora_id INTEGER REFERENCES editora (id),
    preco real,
    PRIMARY KEY (nro_sequencia, livro_isbn)
);

CREATE TABLE empresa (
    cnpj CHARACTER(14) PRIMARY KEY,
    nome_fantasia TEXT,
    razao_social TEXT,
    dono TEXT
);

INSERT INTO empresa (cnpj, nome_fantasia, dono) VALUES
('11111111111111','IGOR CORPORATION LTDA.', 'EU');

INSERT INTO cliente (nome, cpf) VALUES 
('ALEXANDRA', '11111111111'),
('FLAVIO','22222222222');

INSERT INTO autor (nome) VALUES
('ZACK SNYDER'),
('IRMÃS ZAOFSODIJFSDIO');

INSERT INTO livro (isbn, titulo) VALUES
('123','LIGA INJUSTIÇADA DA DC'),
('4321XBC','MATRIX 4 TEM SEU VALOR: O LIVRO');

INSERT INTO autor_livro (autor_id, livro_isbn) VALUES
(1, '123'),
(2, '4321XBC');



-- listar todos os livros
-- livraria_online=# SELECT * FROM livro;

-- atualizar um livro em especifico
-- livraria_online=# UPDATE livro SET sinopse = '4 horas resolveram o problema do filme' WHERE isbn = '123';

-- deletar um determinado cliente (ex: id = 2)
-- livraria_online=# DELETE FROM cliente WHERE id = 2;

INSERT INTO compra (data_hora, cliente_id) VALUES
(CURRENT_TIMESTAMP,1);

INSERT INTO compra (data_hora, cliente_id) VALUES
('2022-11-08 08:00:00',1);

INSERT INTO editora (nome) VALUES('PANAMI');

INSERT INTO exemplar(nro_sequencia, livro_isbn, editora_id, compra_id, preco) VALUES
(1, '123', 1, 1, 100);
















