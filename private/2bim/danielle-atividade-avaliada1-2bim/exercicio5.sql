DROP DATABASE IF EXISTS exercicio5;
CREATE DATABASE exercicio5;

\c exercicio5;


CREATE TABLE telespectador (
       id_telespectador  serial primary key,
       cpf  character(11),
       nome text NOT NULL
);

 CREATE TABLE  ingresso (
        id serial primary key,
        telespectador_id integer,
        sessao_id integer,
        valor_ingresso real,
        corredor character(1),
        poltrona integer NOT NULL
);

CREATE TABLE sessao (
       id serial primary key,
      sala_id integer,
      data date NOT NULL,
      hora time NOT NULL
);

CREATE TABLE filme (
     id serial primary key,
    nome text,
    capacidade integer
);

INSERT INTO sessão ( telespectador, data, horario, corredor, poltrona) VALUES
(1, '09/07/2022', '19:00', 'G', '10'),
(2, '22/06/2022', '16:00', 'B', '17'),
(3,  '05/07/2022', '21:00', 'M', '19'),
(4,  '04/07/2022', '21:00', 'J', '15');


INSERT INTO salas (numero, descricao, capacidade) VALUES 
(10, 'Sala 3D 1', 100),
(11, 'Sala 3D 2', 100),
(12, 'Sala Convencional 1', 100),
(13, 'Sala Convencional 2', 100),
(14, 'Sala 3D 3', 50);

INSERT INTO salas_filmes (numero_sala, titulo_filme, data, horario) VALUES
(10, '25/06/2022', '19:00'),
(11, '22/06/2022', '16:00'),
(12,  '09/07/2022', '21:00'),
(13,  '05/07/2022', '21:00');
(14,  '04/07/2022', '21:00');

