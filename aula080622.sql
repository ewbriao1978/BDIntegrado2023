DROP DATABASE IF EXISTS aula080622;


CREATE DATABASE aula080622;

\c aula080622;


CREATE TABLE responsavel (
    cpf character(11) primary key,
    nome text,
    unique(cpf)
);

CREATE TABLE paciente (
    id serial primary key,
    nome text,
    responsavel_cpf character(11) references responsavel (cpf)
);

CREATE TABLE dentista (
    cro character(5) primary key,
    nome text
);


CREATE TABLE tratamento (
    id serial primary key,
    descricao text not null
);

CREATE TABLE consulta (
    data date,
    valor real,
    tratamento_id integer references tratamento (id),
    paciente_id integer references paciente (id),
    dentista_cro character(5) references dentista (cro)    
);

INSERT INTO responsavel (cpf, nome) VALUES
('23245467688', 'Joana'),
('76654432210', 'Carlos'); 

INSERT INTO paciente (nome, responsavel_cpf) VALUES
('Ana', '23245467688'),
('Eduardo', '76654432210'),
('Margarida', NULL),
('Claudia', NULL),
('João', '23245467688');

INSERT INTO dentista (cro, nome) VALUES 
('23321', 'Daniela'),
('76675', 'Henrique'),
('35541','Janete');

INSERT INTO tratamento (descricao) VALUES
('Limpeza'),
('Obturação'),
('Manutenção da coroa'),
('Ortodentia'),
('Manutenção do canino'),
('Aparelho');

INSERT INTO consulta (data, valor, tratamento_id, paciente_id, dentista_cro) VALUES
('2018-07-12', 50, 1, 1, '23321'),
('2018-06-22', 40, 2, 2, '76675'),
('2018-06-22', 100, 3, 3, '76675'),
('2018-06-21',70, 4, 1, '23321'),
('2018-06-18', 0, 5, 4, '76675'),
('2018-06-15', 70, 6, 5, '23321');























