DROP DATABASE IF EXISTS aula_heranca;

CREATE DATABASE aula_heranca;

\c aula_heranca;

CREATE TABLE pessoa (
    id serial primary key,
    nome text
);
CREATE TABLE pessoa_fisica (
    cpf character(11)
) inherits (pessoa);

CREATE TABLE pessoa_juridica (
    cnpj character(14)
) inherits (pessoa);


-- aula_heranca=# INSERT INTO pessoa_fisica (nome, cpf) VALUES ('Maicon', '11111111111');
-- aula_heranca=# INSERT INTO pessoa_juridica (nome, cnpj) VALUES ('Igor corporation ltda', '11111111111111');





