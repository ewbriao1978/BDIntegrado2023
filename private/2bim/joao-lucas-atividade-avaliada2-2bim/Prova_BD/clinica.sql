DROP DATABASE IF EXISTS joao_exe1;
CREATE DATABASE joao_exe1;
\c joao_exe1;

CREATE TABLE convenio (
    id serial PRIMARY KEY,
    descricao varchar(50) NOT NULL,
    valor_mensal real CHECK (valor_mensal > 0)
);

CREATE TABLE paciente (
    id serial PRIMARY KEY,
    nr_paciente integer NOT NULL,
    rg character(10),
    nome varchar(20) NOT NULL,
    data_nasc date NOT NULL,
    sexo character (1) NOT NULL,
    estado_civil varchar(20),
    telefone varchar(15),
    endereco text,
    UNIQUE (nr_paciente)
);

CREATE TABLE medico (
    id serial PRIMARY KEY,
    crm varchar(10) NOT NULL,
    nome varchar(20) NOT NULL,
    especialidade text NOT NULL,
    UNIQUE (crm)
);

CREATE TABLE consulta (
    numero serial PRIMARY KEY,
    paciente_id integer REFERENCES paciente (id),
    medico_id integer REFERENCES medico (id),
    data date NOT NULL,
    diagnostico text NOT NULL
);

CREATE TABLE exame (
    id serial PRIMARY KEY,
    nome varchar(50) NOT NULL,
    valor real CHECK (valor > 0),
    consulta_numero integer REFERENCES consulta (numero)
);

INSERT INTO convenio (descricao, valor_mensal) VALUES
('Alfa1', 500.00),
('Standart', 250.99);

INSERT INTO paciente (nr_paciente, rg, nome, data_nasc, sexo, estado_civil, telefone, endereco) VALUES
(1, '3120685726', 'joao', '1999-9-16', 'M', 'Solteiro', '(53) 984784575', 'Avenida Portugal, Nº: 692'),
(2, '8767112888', 'pedro', '2021-01-03', 'M', 'Solteiro', '(53) 984784575', 'Rua Aguidabam Nº: 989');

INSERT INTO medico (crm, nome, especialidade) VALUES
('8698', 'jorge', 'Cardiologista'),
('7220', 'Betito', 'Oftalmologista');

INSERT INTO consulta (paciente_id, medico_id, data, diagnostico) VALUES
(1, 1, '2022-06-26', 'Realizar Exame'),
(1, 2, '2022-05-21', 'Trocar óculos'),
(2, 2, '2022-05-19', 'Pressão Alta'),
(2, 1, '2022-06-15', 'Novo colirio');

INSERT INTO exame (nome, valor, consulta_numero) VALUES
('Eletrocardiograma', 100.00, 1),
('Teste de visão', 250.00, 2),
('Chegagem de pressão', 80.00, 3),
('Análise ocular', 600.00, 4);

/*
// exercicio4;
DROP USER IF EXISTS fulano;
CREATE USER fulano SUPERUSER;
ALTER USER FULANO with encrypted password '<password>';

DROP USER IF EXISTS ciclano;
CREATE USER ciclano WITH PASSWORD 'ciclano';
GRANT SELECT ON convenio TO ciclano;
GRANT SELECT ON paciente TO ciclano;
GRANT SELECT ON medico TO ciclano;
GRANT SELECT ON consulta TO ciclano;
GRANT SELECT ON exame TO ciclano;
*/
