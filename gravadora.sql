DROP DATABASE IF EXISTS gravadora;

CREATE DATABASE gravadora;

\c gravadora;

CREATE TABLE compositor (
    id serial PRIMARY KEY,
    nome text NOT NULL    
);

CREATE TABLE musica (
    id serial primary key,
    titulo text,
    letra text
);

CREATE TABLE cantor (
    id serial PRIMARY KEY,
    nome text NOT NULL
);

CREATE TABLE gravacao (
    id serial primary key,
    tempo time,
    cantor_id integer references cantor (id),
    musica_id integer references musica (id)
);


CREATE TABLE compositor_musica (
    compositor_id integer references compositor (id),
    musica_id integer references musica (id),
    primary key (compositor_id, musica_id)
);

INSERT INTO cantor (nome) VALUES ('Latino');
INSERT INTO compositor(nome) VALUES ('Peninha');
INSERT INTO musica(titulo) VALUES ('Alma Gemea');
INSERT INTO compositor_musica (compositor_id, musica_id) VALUES (1,1);

-- psql -U postgres
-- ALTER TABLE cantor ALTER COLUMN nome SET NOT NULL;











