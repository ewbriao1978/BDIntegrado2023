DROP DATABASE IF EXISTS aula080622_2; 

CREATE DATABASE aula080622_2;

\c aula080622_2;

CREATE TABLE area (
    cod character(3) primary key,
    descricao text not null
);

CREATE TABLE curso (
    cod character(6) primary key,
    nome text not null,
    area_cod character(3) references area (cod)
);


CREATE TABLE funcionario (
    matricula character(5) primary key,    
    nome text,
    data_admissao date,
    curso_cod character(6) references curso (cod)
);

CREATE TABLE cargo (
    cod serial primary key,
    nome text not null
);

CREATE TABLE avaliacao (
    id serial primary key,
    descricao text not null
);


CREATE TABLE funcionario_cargo (
    ano_conclusao integer,
    avaliacao_id integer references avaliacao (id),
    funcionario_matricula character(5) references funcionario (matricula),
    cargo_cod integer references cargo (cod),
    primary key (funcionario_matricula, cargo_cod, ano_conclusao)
);



