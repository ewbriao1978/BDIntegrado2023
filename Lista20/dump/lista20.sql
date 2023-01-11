DROP DATABASE IF EXISTS lista20;

CREATE DATABASE lista20;

\c lista20;

CREATE TABLE pessoa (
    id serial primary key,
    nome text,
    sobrenome text
);

CREATE TABLE dependente (
    id serial primary key,
    nome text,
    sobrenome text,
    pessoa_id integer references pessoa (id) ON DELETE CASCADE
);


INSERT INTO pessoa (nome, sobrenome) VALUES 
('Igor', 'Pereira'),
('Rafael', 'Betito'),
('Márcio', 'Torres');

INSERT INTO dependente (nome, sobrenome, pessoa_id) VALUES
('João', 'Pereira', 1),
('Guilherme', 'Betito', 2);



