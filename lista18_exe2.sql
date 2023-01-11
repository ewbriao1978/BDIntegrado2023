DROP DATABASE IF EXISTS lista18_exe2;

CREATE DATABASE lista18_exe2;

\c lista18_exe2;

CREATE TABLE departamento (
    cod_departamento SERIAL PRIMARY KEY, 
    nome_depto TEXT NOT NULL, 
    sigla_depto CHARACTER(4)
);

CREATE TABLE curso (
    cod_curso SERIAL PRIMARY KEY, 
    nome_curso TEXT NOT NULL
);
CREATE TABLE orientador (
    cod_orient SERIAL PRIMARY KEY, 
    nome_orient TEXT NOT NULL, 
    fone_orient TEXT
);

CREATE TABLE aluno (
    nro_aluno SERIAL PRIMARY KEY, 
    nome_aluno TEXT, 
    cod_departamento INTEGER REFERENCES departamento (cod_departamento), 
    cod_curso INTEGER REFERENCES curso (cod_curso), 
    cod_orient INTEGER REFERENCES orientador (cod_orient)
);

