DROP DATABASE IF EXISTS redesocial;

CREATE DATABASE redesocial;

\c redesocial;

CREATE TABLE Usuário(
    E-mail text primary key,
    Nome text,
    Senha text
);

CREATE TABLE Álbum(
    id serial primary key,
    Título text,
    Descrição text,
    Usuário_email text references Usuário (Email)
);

CREATE TABLE Foto (
    id serial primary key,
    Nome text,
    Legenda text,
    Álbum_id integer references Álbum (id)
);

CREATE TABLE Relação(
    Usuário1_email text references Usuário (Email),
    Usuário2_email text references Usuário (Email),
    Usuário1_segue boolean,
    Usuário2_segue boolean,
    Amizade boolean
);

CREATE TABLE Publicação (
    id serial primary key,
    Data_criação timestamp,
    Texto text
);

CREATE TABLE Arquivo_Mídia(
    id serial primary key ,
    Legenda text,
    Nome text,
    Publicação_id integer references Publicação (id)
);