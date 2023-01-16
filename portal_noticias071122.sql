DROP DATABASE IF EXISTS portal_noticias071122;

CREATE DATABASE portal_noticias071122;

\c portal_noticias071122;

CREATE TABLE categoria(
    id SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL
);
CREATE TABLE jornalista(
    id SERIAL PRIMARY KEY,
    nome TEXT,
    data_nascimento DATE,
    cpf CHARACTER(11) UNIQUE,
    email TEXT,
    senha TEXT
);
CREATE TABLE noticia(
    id SERIAL PRIMARY KEY,
    titulo TEXT,
    texto TEXT,
    data date,
    hora time,
    eh_publica boolean DEFAULT TRUE,
    categoria_id integer references categoria(id),
    jornalista_id integer references jornalista(id)
);  
CREATE TABLE foto (
    id SERIAL PRIMARY KEY,
    nome text,
    legenda text,
    noticia_id integer references noticia (id)
);

CREATE TABLE assinante (
    cpf CHARACTER(11) PRIMARY KEY,
     nome text,
     data_nascimento date,
     email text,
     senha text
);

CREATE TABLE modalidade (
    id SERIAL PRIMARY KEY,
    valor money,
    nome text NOT NULL
);

CREATE TABLE plano (
    id SERIAL PRIMARY KEY,
    data_inicio DATE DEFAULT CURRENT_DATE,
    data_fim DATE,
    assinante_cpf character(11) references assinante (cpf),
    modalidade_id integer references modalidade (id)
);

CREATE TABLE pagamento (
    id SERIAL PRIMARY KEY,
    data date,
    hora time,
    valor money,
    plano_id integer references plano (id)
);






