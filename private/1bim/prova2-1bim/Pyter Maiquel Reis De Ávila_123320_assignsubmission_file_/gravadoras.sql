DROP DATABASE IF EXISTS gravadoras;

CREATE DATABASE gravadoras;

\c gravadoras;

CREATE TABLE autor(
    id serial PRIMARY KEY,
    nome text NOT NULL
);

CREATE TABLE música(
    id serial PRIMARY KEY,
    nome text NOT NULL,
    duração time
);

CREATE TABLE gravadora(
    id serial PRIMARY KEY,
    nome text NOT NULL,
    endereço text,
    telefone text,
    contato text,
    website text
);


CREATE TABLE cd(
    id serial PRIMARY KEY,
    nome text NOT NULL,
    preço real NOT NULL CHECK (preço > 0),
    data_lançamento date default current_date,
    cd_recomenda_id integer REFERENCES cd(id),
    gravadora_id integer REFERENCES gravadora(id)
);


CREATE TABLE faixas(
    cd_id integer REFERENCES cd (id),
    música_id integer REFERENCES música (id)
);

CREATE TABLE música_autores(
    autor_id integer REFERENCES autor(id),
    música_id integer REFERENCES música(id)
);

INSERT INTO gravadora (nome, endereço, telefone, contato, website) VALUES
('Betito Records', 'algum lugar do cassino', '32320666', 'betitorecords@hotmail.com.br', 'betitorecords.com'),
('Roquenrola Productions', 'são paulo', '123456789', 'roquerola@gmail.com', 'roquenrola.com.br'),
('Musica Orientada á Objetos', 'rio grande', '11112222', 'moo123@live.com', 'musicaobjetos.com.br'),
('Copyright-free Music', 'vídeos do igor', '987654321', 'foradoyoutube@yahoo.com', 'cpfreemusic.com');

INSERT INTO autor (nome) VALUES
('Renato Molusco'),
('Roberto Sarro'),
('Betito'),
('Igor Aulas');

INSERT INTO cd (nome, preço, data_lançamento, cd_recomenda_id, gravadora_id) VALUES
('Banco from hell',19.99, '1998-12-20', 2, 1),
('Rosque', 6.66, '1996-06-06', 1, 2),
('Arraychadinha', 25.00, '2020-02-22', 2, 3),
('Videoaulas', 23.00, '2022-04-04', 3, 4);

INSERT INTO música (nome, duração) VALUES
('Não eu não vou dar referência bibliográfica','00:03:00'),
('Videoaula Como instalar PgAdmin','00:00:41'),
('Roque','00:04:23'),
('Stringuiriguidum','00:02:50');

INSERT INTO música_autores(autor_id, música_id) VALUES
(1,3),
(1,1),
(3,1),
(4,2),
(2,3);

/* SELECT * from autor where nome like 'R% %o';
*/




