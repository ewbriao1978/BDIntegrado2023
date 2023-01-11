DROP DATABASE IF EXISTS exercicio1;

CREATE DATABASE exercicio1;

\c exercicio1;



DROP TABLE IF EXISTS  TELESPECTADOR;
DROP TABLE IF EXISTS  INGRESSO;
DROP TABLE IF EXISTS  SESSAO;
DROP TABLE IF EXISTS  FILME;
DROP TABLE IF EXISTS  SALA;
DROP TABLE IF EXISTS  TURNO;
DROP TABLE IF EXISTS  FUNCIONARIO;



CREATE TABLE telespectador (
       id_telespectador  serial primary key,
       cpf  character(11),
       nome text NOT NULL
);




 CREATE TABLE  ingresso (
        id serial primary key,
        telespectador_id integer,
        sessao_id integer,
        valor_ingresso real,
        corredor character(1),
        poltrona integer NOT NULL
);

CREATE TABLE sessao (
       id serial primary key,
      sala_id integer,
      data date NOT NULL,
      hora time NOT NULL
);

CREATE TABLE filme (
     id serial primary key,
    nome text,
    capacidade integer
);

CREATE TABLE    turno (
    sala_id integer,
    funcionario_id integer,
    data_hora_entrada timestamp,
    data_hora_saida timestamp,

);

CREATE TABLE funcionario (
     id serial primary key,
      setor text 
);






