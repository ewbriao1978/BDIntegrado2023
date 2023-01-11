DROP DATABASE IF EXISTS univeridade;

CREATE DATABASE universidade;

\c universidade;

DROP TABLE requisito;
DROP TABLE disciplina;
DROP TABLE curso;
DROP TABLE departamento;

CREATE TABLE departamento (
    codigo serial primary key,
    nome text NOT NULL
);

CREATE TABLE curso (
    codigo serial primary key,
    nome text NOT NULL,
    nivel text NOT NULL CHECK (nivel = 'graduação' OR nivel = 'mestrado' OR nivel = 'especialização' OR nivel = 'doutorado' or nivel = 'técnico'),
    turno text NOT NULL CHECK (turno = 'diurno' OR turno = 'noturno'),
    departamento_codigo integer references departamento (codigo)    
);

CREATE TABLE disciplina (
    codigo serial primary key,
    nome text NOT NULL,
    credito integer,
    carga_horaria integer,
    ementa text,
    semestre integer,
    curso_codigo integer references curso (codigo)
);

CREATE TABLE requisito (
    disciplina_codigo integer references disciplina (codigo),
    disciplina_codigo_requisito integer references disciplina (codigo),
    primary key (disciplina_codigo, disciplina_codigo_requisito)
);

INSERT INTO departamento (nome) VALUES 
('D.C'),
('Eletro'),
('Automação'),
('Geoprocessamento'),
('Enfermagem');
INSERT INTO curso (nome, nivel, turno, departamento_codigo) VALUES
('Tecnologia em Análise e Desenvolvimento de Sistemas', 'graduação', 'noturno', 1),
('Técnico em Informática para Internet','técnico', 'diurno', 1),
('Eletrotécnica', 'técnico', 'diurno', 2),
('Geoprocessamento', 'técnico', 'diurno', 4),
('Técnico em Enfermagem', 'técnico', 'diurno', 5);
INSERT INTO disciplina (nome, credito, carga_horaria, ementa, semestre, curso_codigo) VALUES 
('Banco de Dados', 7, 75, 'A melhor ementa', 2, 1),
('Lógica de Programação', 9, 120, 'A pior ementa', 1, 1),
('Matemática Discreta', 4, 50, 'ementa eh com javier', 1, 1),
('Programação Orientada a objetos', 9, 120, 'aí deves falar com o márcio', 2, 1),
('Arquitetura e Projetos de Sistemas', 8, 100, 'podes falar com o igor top', 3, 1),
('LógicaGEO', 4, 50, 'carga menor que info', 1, 4);

INSERT INTO requisito (disciplina_codigo, disciplina_codigo_requisito) VALUES
(1, 2),
(1, 3),
(4, 2),
(5, 1),
(5, 2),
(5, 3);


-- 10) SELECT disciplina.nome, disciplina.credito, disciplina.carga_horaria FROM curso INNER JOIN disciplina ON (curso.codigo = disciplina.curso_codigo) WHERE curso.nome = 'Tecnologia em Análise e Desenvolvimento de Sistemas' ORDER BY disciplina.semestre, disciplina.nome;

-- 11) SELECT sum(disciplina.carga_horaria) FROM curso INNER JOIN disciplina ON (curso.codigo = disciplina.curso_codigo) WHERE curso.nome = 'Tecnologia em Análise e Desenvolvimento de Sistemas';

-- 12) universidade=# SELECT curso.nome, SUM(disciplina.carga_horaria) as total FROM curso INNER JOIN disciplina ON (curso.codigo = disciplina.curso_codigo) group by curso.nome having sum(disciplina.carga_horaria) in (SELECT DISTINCT min(disciplina.carga_horaria) FROM curso INNER JOIN disciplina ON (curso.codigo = disciplina.curso_codigo) group by curso.codigo);

-- 13) universidade=# SELECT curso.nome FROM departamento INNER JOIN curso ON (departamento.codigo = curso.departamento_codigo) WHERE departamento.nome = 'D.C';

-- 14) universidade=# SELECT departamento.nome, count(curso.codigo) FROM departamento LEFT JOIN curso ON (departamento.codigo = curso.departamento_codigo) GROUP BY departamento.nome;

-- 15) universidade=# SELECT disciplina.semestre, sum(disciplina.credito) FROM disciplina INNER JOIN curso ON (curso.codigo = disciplina.curso_codigo) WHERE curso.nome = 'Tecnologia em Análise e Desenvolvimento de Sistemas' group by disciplina.semestre ORDER BY disciplina.semestre ASC;








 
