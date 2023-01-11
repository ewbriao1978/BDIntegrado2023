 CREATE DATABASE lista21;
 \c lista21;

 CREATE TABLE pessoa_fisica (
 	id serial primary key,
 	cpf character(11) unique,
 	nome text
 );

 CREATE TABLE pessoa_juridica (
 	id serial PRIMARY KEY,	
 	cnpj character(14) unique,
 	nome text
 );
 CREATE TABLE pessoa_fisica (
 	id serial primary key,
 	cpf character(11) unique,
 	nome text
 );

 CREATE TABLE pessoa_juridica (
 	id serial PRIMARY KEY,	
 	cnpj character(14) unique,
 	nome text
 );
