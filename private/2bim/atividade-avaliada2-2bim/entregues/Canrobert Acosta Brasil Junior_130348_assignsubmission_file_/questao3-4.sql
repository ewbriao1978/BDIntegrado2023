DROP DATABASE IF EXISTS questao3;
CREATE DATABASE questao3;

\c questao3;

CREATE TABLE medico (
	id SERIAL PRIMARY KEY,
	nome TEXT,
	crm CHAR ( 6 ) UNIQUE
);

CREATE TABLE exame (
	id SERIAL PRIMARY KEY,
	descricao TEXT
);

CREATE TABLE convenio (
	id SERIAL PRIMARY KEY,
	nome TEXT
);

CREATE TABLE paciente (
	id SERIAL PRIMARY KEY,
	nome TEXT,
	nascimento DATE,
	sexo CHAR ( 1 ) CHECK ( sexo = 'M' OR sexo = 'F' ),
	estado_civil TEXT,
	rg CHAR ( 10 ),
	telefone TEXT,
	endereco TEXT,
	convenio_id INTEGER REFERENCES convenio ( id )
);

CREATE TABLE consulta (
	id SERIAL PRIMARY KEY,
	data DATE,
	diagnóstico TEXT,
	medico_id INTEGER REFERENCES medico ( id ),
	paciente_id INTEGER REFERENCES paciente ( id )
);

CREATE TABLE consulta_exame (
	consulta_id INTEGER REFERENCES consulta ( id ),
	exame_id INTEGER REFERENCES exame ( id ),
	data DATE,
	PRIMARY KEY ( consulta_id, exame_id )
);

CREATE USER fulano SUPERUSER INHERIT CREATEDB CREATEROLE PASSWORD 'fulano';
CREATE USER ciclano PASSWORD 'ciclano';
\c questao3;
GRANT SELECT ON consulta, consulta_exame, convenio, exame, medico, paciente TO ciclano;
