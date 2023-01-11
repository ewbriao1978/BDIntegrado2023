DROP DATABASE IF EXISTS redesocial;

CREATE DATABASE redesocial;

\c redesocial;

CREATE TABLE usuario (
    id serial primary key,
    nome text NOT NULL,
    email text NOT NULL,
    senha text,
    unique(email)
);

CREATE TABLE seguidor (
    usuario_id integer references usuario,
    seguidor_id integer references usuario,
    primary key (usuario_id, seguidor_id)
);

CREATE TABLE amigo (
    usuario_id integer references usuario (id),
    amigo_id integer references usuario (id),
    primary key (usuario_id, amigo_id)
);

CREATE TABLE grupo (
    id serial primary key,
    nome text NOT NULL,
    dt_criacao date DEFAULT CURRENT_DATE,
    dono_id integer references usuario (id)
);

CREATE TABLE usuario_grupo (
    usuario_id integer references usuario (id),
    grupo_id integer references usuario (id),
    data_hora timestamp DEFAULT CURRENT_TIMESTAMP,
    primary key (usuario_id, grupo_id)
);

CREATE TABLE album (
    id serial primary key,
    titulo text NOT NULL,
    descricao text NOT NULL,
    usuario_id integer references usuario (id)
);

CREATE TABLE foto (
    nome_arquivo text primary key,
    legenda text NOT NULL,
    album_id integer references album (id)  
);

CREATE TABLE publicacao (
    id serial primary key,
    texto text NOT NULL,
    data_hora_criacao timestamp DEFAULT CURRENT_TIMESTAMP,
    usuario_id integer references usuario (id) ON DELETE CASCADE,
    grupo_id integer references grupo (id)
);

CREATE TABLE arquivo (
    nome_arquivo text primary key,
    legenda text NOT NULL,
    publicacao_id integer references publicacao (id)
);

INSERT INTO usuario (nome, email, senha) VALUES
('Felipe', 'felipe@email.com', MD5('felipe')),
('Brenda', 'brenda@email.com', MD5('brenda')),
('Lucas', 'lucas@email.com', MD5('lucas')),
('Nicole', 'nicole@email.com', MD5('nicole')),
('Geraldo', 'geraldo@email.com', MD5('geraldo')),
('Judith', 'judith@email.com', MD5('judith')),
('Marcio', 'marcio@email.com', MD5('marcio')),
('Igor', 'igor@email.com', MD5('igor'));

INSERT INTO seguidor (usuario_id, seguidor_id) VALUES
(1, 2),
(2, 1),
(1, 3),
(1, 7),
(7, 1),
(2, 4),
(2, 6),
(6, 2),
(3, 5),
(5, 3),
(5, 4),
(4, 8),
(8, 4),
(4, 3),
(5, 8),
(6, 1),
(6, 7),
(7, 6),
(7, 8),
(8, 7),
(7, 4),
(8, 1),
(8, 5),
(8, 6);

INSERT INTO amigo (usuario_id, amigo_id) VALUES
(1, 2),
(1, 7),
(1, 8),
(2, 4),
(2, 6),
(3, 5),
(3, 4),
(4, 8),
(5, 8),
(6, 1),
(7, 8);

INSERT INTO grupo (nome, dt_criacao, dono_id) VALUES
('Banco de Dados', '2022-02-21', 8),
('TADS', '2021-06-01', 7),
('Stack Overflow', '2020-10-25', 5),
('Plano Critico', '2019-05-02', 4);

INSERT INTO usuario_grupo (usuario_id, grupo_id, data_hora) VALUES
(8, 1, '2022-02-21 22:00:00'),
(7, 2, '2021-06-01 20:30:00'),
(5, 3, '2020-10-25 09:15:00'),
(4, 4, '2019-05-02 11:10:00'),
(1, 1, '2022-02-22 19:00:00'),
(1, 2, '2021-08-03 18:30:00'),
(2, 4, '2020-01-16 07:30:00'),
(3, 1, '2022-03-06 08:00:00'),
(4, 2, '2021-11-05 20:25:00'),
(5, 1, '2022-04-15 09:20:00'),
(5, 2, '2021-07-01 21:40:00'),
(8, 2, CURRENT_TIMESTAMP);

INSERT INTO album (titulo, descricao, usuario_id) VALUES
('Cidade', 'Pontos turisticos de Rio Grande', 6),
('Animais', 'Animais de estimação', 4),
('Culinária', 'Pratos especiais', 8),
('Projetos', 'Projetos de modelagem conceitual', 1);

INSERT INTO foto (nome_arquivo, legenda, album_id) VALUES
('cassino.jpg', 'Praia do Cassino', 1),
('museu.jpg', 'Museu oceanográfico', 1),
('gato.jpeg', 'Gato dormindo', 2),
('cachorro.jpeg', 'Cachorro correndo', 2),
('pizza.png', 'Pizza de calabresa', 3),
('banco.png', 'Modelo ER de redesocial', 4);

INSERT INTO publicacao (texto, usuario_id, grupo_id) VALUES
('Texto de publicação A, usuário Felipe', 1, NULL),
('Texto de publicação B, usuário Felipe, grupo TADS', 1, 2),
('Texto de publicação C, usuário Brenda, grupo Plano Crítico', 2, 4),
('Texto de publicação D, usuário Lucas', 3, NULL),
('Texto de publicação E, usuário Nicole', 4, NULL),
('Texto de publicação F, usuário Geraldo, grupo Stack Overflow', 5, 3),
('Texto de publicação G, usuário Geraldo', 5, NULL),
('Texto de publicação H, usuário Judith', 6, NULL),
('Texto de publicação I, usuário Marcio, grupo TADS', 7, 2),
('Texto de publicação J, usuário Marcio', 7, NULL),
('Texto de publicação K, usuário Igor', 8, NULL),
('Texto de publicação L usuário Igor', 8, NULL),
('Texto de publicação M, usuário Igor, grupo Banco de Dados', 8, 1),
('Texto de publicação N, usuário Igor, grupo Banco de Dados', 8, 1);

INSERT INTO arquivo (nome_arquivo, legenda, publicacao_id) VALUES
('dicas_sql.pdf', 'Comandos SQL para criação de banco de dados', 14),
('locadora.sql', 'Exercicio realizado em aula', 13),
('matriz_curricular.docx', 'Matriz curricular do curso', 9),
('calculadora.java', 'Calculadora desenvolvida na linguagem Java', 6);