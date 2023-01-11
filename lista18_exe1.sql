DROP DATABASE IF EXISTS lista18_exe1;

CREATE DATABASE lista18_exe1;

\c lista18_exe1;

CREATE TABLE vendedor (
    nro_vend SERIAL PRIMARY KEY,
    sexo_vend CHARACTER(1), 
    nome_vend TEXT
);

CREATE TABLE cliente (
    nro_cli SERIAL PRIMARY KEY,
    end_cli TEXT,
    nome_cli TEXT
);

CREATE TABLE vendedor_cliente (
    nro_vend INTEGER REFERENCES vendedor (nro_vend), 
    nro_cli INTEGER REFERENCES cliente (nro_cli),
    PRIMARY KEY (nro_vend, nro_cli)
);

