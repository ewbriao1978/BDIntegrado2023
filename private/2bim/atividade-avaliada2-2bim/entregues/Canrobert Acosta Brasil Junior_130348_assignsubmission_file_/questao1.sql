DROP DATABASE IF EXISTS questao1;
CREATE DATABASE questao1;

\c questao1;

CREATE TABLE funcionario (
	id SERIAL PRIMARY KEY,
	cpf CHAR ( 11 ) UNIQUE,
	nome TEXT,
	nascimento DATE,
	nacionalidade TEXT,
	sexo CHAR ( 1 ) CHECK ( sexo = 'M' OR sexo = 'F' ),
	estado_civil TEXT,
	rg CHAR ( 10 ),
	admissao DATE,
	endereco TEXT,
	telefone TEXT
);

CREATE TABLE cargo (
	id SERIAL PRIMARY KEY,
	nome TEXT
);

CREATE TABLE funcionarioCargo (
	funcionario_id INTEGER REFERENCES funcionario ( id ),
	cargo_id INTEGER REFERENCES cargo ( id ),
	dt_inicio DATE,
	dt_fim DATE,
	PRIMARY KEY ( funcionario_id, cargo_id )
);

CREATE TABLE dependente (
	id SERIAL PRIMARY KEY,
	nome TEXT,
	nascimento DATE,
	funcionario_id INTEGER REFERENCES funcionario ( id )
);
