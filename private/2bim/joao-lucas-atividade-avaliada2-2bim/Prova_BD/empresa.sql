DROP DATABASE IF EXISTS joao_exe1;
CREATE DATABASE joao_exe1;
\c joao_exe1;

CREATE TABLE funcionario (
    id serial PRIMARY KEY,
    cpf character(11) NOT NULL,
    rg character(10) NOT NULL,
    nome varchar(50) NOT NULL,
    data_nascimento date,
    sexo character(1) NOT NULL,
    estado_civil varchar(20),
    nacionalidade varchar(20),
    data_admissao date DEFAULT CURRENT_DATE,
    telefone varchar(15), 
    endereco text,
    UNIQUE (cpf)
);

CREATE TABLE cargo (
    id serial PRIMARY KEY,
    descricao varchar(50) NOT NULL
);

CREATE TABLE ocupacao (
    funcionario_id integer REFERENCES funcionario (id),
    cargo_id integer REFERENCES cargo (id),
    data_inicio date DEFAULT CURRENT_DATE,
    data_fim date,
    PRIMARY KEY (funcionario_id, cargo_id)
);

CREATE TABLE dependente (
    id serial,
    nome varchar(20) NOT NULL,
    data_nascimento date,
    funcionario_id integer REFERENCES funcionario (id),
    PRIMARY KEY (id, funcionario_id)
);

INSERT INTO funcionario (cpf, rg, nome, data_nascimento, sexo, estado_civil, nacionalidade, telefone, endereco) VALUES
('04628030073', '3120685726', 'fernando', '1999-12-16', 'M', 'Casado', 'Brasileiro', '(53) 98478-4575', 'Avenida Portugal, Nº: 692');

INSERT INTO cargo (descricao) VALUES
('HelpDesk'),
('Analista'),
('Desenvolvedor'),
('Gerente de TI'),
('Vendedor'),
('Analista de Projetos');

INSERT INTO dependente (nome, data_nascimento, funcionario_id) VALUES
('Arthur Rocha', '2015-08-22', 1);

INSERT INTO ocupacao (funcionario_id, cargo_id) VALUES
(1, 2);




