CREATE DATABASE lista18_exe3;

\c lista18_exe3;

CREATE TABLE fundador(
    cod_fund SERIAL PRIMARY KEY, 
    nome_fundador TEXT NOT NULL, 
    nacionalidade_fundador TEXT
);

CREATE TABLE empresa (
    cod_empresa SERIAL PRIMARY KEY, 
    nome_empresa TEXT NOT NULL, 
    end_empresa TEXT, 
    cod_fundador INTEGER REFERENCES fundador (cod_fund)
);
CREATE TABLE filial(
    filial_nro INTEGER,
    cod_empresa INTEGER REFERENCES empresa (cod_empresa), 
    filial_local TEXT NOT NULL, 
    filial_data_abertura DATE,
    PRIMARY KEY (filial_nro, cod_empresa)
);
