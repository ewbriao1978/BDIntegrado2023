DROP DATABASE IF EXISTS hospital;

CREATE DATABASE hospital;

\c hospital;

CREATE TABLE paciente (
    codigo serial primary key,
    nome text not null,
    cpf character(11) NOT NULL,
    rg character(10),
    endereco text,
    data_nascimento date,
    telefone text,
    unique(cpf)
);

CREATE TABLE medico (
    codigo serial primary key,
    nome text not null,
    telefone text,
    crm text,
    unique(crm)
);


CREATE TABLE exame (
    codigo serial primary key,
    data date DEFAULT CURRENT_DATE,
    descricao text NOT NULL,
    hora time DEFAULT CURRENT_TIME,
    valor real,
    paciente_codigo integer references paciente (codigo) ON DELETE CASCADE,
    medico_codigo integer references medico (codigo)
);



CREATE TABLE especialidade (
    codigo serial primary key,
    nome text not null
);

CREATE TABLE medico_especialidade (
    medico_codigo integer references medico (codigo),
    especialidade_codigo integer references especialidade (codigo),
    primary key (medico_codigo, especialidade_codigo)
);



INSERT INTO paciente (nome, cpf) VALUES 
('Betito', '11111111111'),
('Márcio', '22222222222'),
('Igor', '33333333333');

INSERT INTO especialidade (nome) VALUES 
('Oftamologia'),
('Pediatria'),
('Geriatria');

INSERT INTO medico (nome, crm) VALUES
('Dra. Cibele', '111'),
('Dra Raquel', '222'),
('Dr. Luciano', '333');


INSERT INTO medico_especialidade (medico_codigo, especialidade_codigo) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO exame (descricao, valor, medico_codigo, paciente_codigo) VALUES 
('Fazer exame de catarata', 100, 1, 3),
('fazer o teste do pezinho', 200, 2, 1),
('teste dos ossos', 1000, 3, 2), 
('PULMÃO', 2000, 3, 2);

-- 17) hospital=# SELECT exame.descricao FROM paciente INNER JOIN exame ON (paciente.codigo = exame.paciente_codigo) wHERE paciente.nome = 'Betito' AND extract(year from data) = 2022;

-- 18) hospital=# SELECT medico.nome FROM medico INNER JOIN medico_especialidade ON (medico.codigo = medico_especialidade.medico_codigo) INNER JOIN especialidade ON (especialidade.codigo = medico_especialidade.especialidade_codigo) WHERE especialidade.nome = 'Pediatria';

-- 19) hospital=# SELECT medico.nome, count(*) FROM medico INNER JOIN exame ON (medico.codigo = exame.medico_codigo) GROUP BY medico.nome;

-- 20) hospital=# SELECT paciente.nome, sum(exame.valor) FROM paciente INNER JOIN exame ON (paciente.codigo = exame.paciente_codigo) WHERE extract(year from exame.data) = 2022  GROUP BY paciente.nome;


-- 21) hospital=# SELECT paciente.nome FROM paciente INNER JOIN exame ON (paciente.codigo = exame.paciente_codigo) INNER JOIN medico ON (medico.codigo = exame.medico_codigo) WHERE medico.nome = 'Dra Raquel';


-- 22) hospital=# SELECT especialidade.nome, count(paciente.codigo) FROM paciente INNER JOIN exame ON (paciente.codigo = exame.paciente_codigo) INNER JOIN medico ON (medico.codigo = exame.medico_codigo) INNER JOIN medico_especialidade ON (medico.codigo = medico_especialidade.medico_codigo) INNER JOIN especialidade ON (medico_especialidade.especialidade_codigo = especialidade.codigo) GROUP BY especialidade.nome;




