DROP DATABASE IF EXISTS redesocial;

CREATE DATABASE redesocial;

\c redesocial;

CREATE TABLE usuario(
    id_codigo INTEGER NOT NULL,
    nome TEXT NOT NULL,
    email TEXT NOT NULL,
    senha character(20) NOT NULL,
    PRIMARY KEY (id_codigo)
);

CREATE TABLE publicacao(
    id_codigo SERIAL NOT NULL,
    texto TEXT NOT NULL,
    data DATE NOT NULL,
    hora TIME NOT NULL,
    PRIMARY KEY(id_codigo) 
);
CREATE TABLE arquivo_midia(
    id_codigo INTEGER NOT NULL,
    nome TEXT NOT NULL,
    legenda TEXT NOT NULL,
    id_publicacao INTEGER REFERENCES publicacao(id_codigo),
    PRIMARY KEY(id_codigo)
);

CREATE TABLE album(
    id_codigo SERIAL NOT NULL,
    titulo TEXT NOT NULL,
    descricao TEXT NOT NULL,
    id_usuario INTEGER REFERENCES usuario(id_codigo),
    PRIMARY KEY(id_codigo)
);

CREATE TABLE foto(
    id_codigo SERIAL NOT NULL,
    nome TEXT NOT NULL,
    legenda TEXT NOT NULL,
    id_album INTEGER REFERENCES album(id_codigo),
    PRIMARY KEY(id_codigo)
);

CREATE TABLE grupo(
    id_codigo SERIAL NOT NULL,
    nome TEXT NOT NULL,
    membro TEXT NOT NULL,
    descricao TEXT NULL,
    dono TEXT NOT NULL,
    data_criacao date NOT NULL,
    id_usuario INTEGER REFERENCES usuario(id_codigo),
    PRIMARY KEY(id_codigo)
);

CREATE TABLE publicacao_grupo(
    id_usuario INTEGER REFERENCES usuario(id_codigo),
    id_grupo INTEGER REFERENCES grupo(id_codigo)
);

CREATE TABLE usuario_seguir(
    seguido integer not null,
    seguidor integer not null,
    foreign key (seguido) references usuario(id_codigo),
    foreign key (seguidor) references usuario(id_codigo),
    unique(seguido, seguidor)
);

INSERT INTO usuario(id_codigo, nome, email, senha) VALUES
(01, 'Afrodite', 'froditezinha@hotmail.com', '123s*434Love'),
(02, 'Apolo', 'lightoftruth@terra.com.br', '1Sol_Ngr&gos'),
(03, 'Atena', 'teninha47@outlook.com', 'como_uma_deusa#22'),
(04, 'Deméter', 'dezinha@gmail.com', '600022*Molpo'),
(05, 'Dionísio', 'bacoromano@hotmail.com', 'R3COH-6969'),
(06, 'Eros', 'flechamagica@gmail.com', '12d43Cupido'),
(07, 'Hades', 'hades@terra.com.br', '17181920'),
(08, 'Hélios', 'lelinho@gmail.com', 'solares2001'),
(09, 'Hera', 'hera_brava@deuzika.com', '010101010101'),
(10, 'Hermes', 'hermes@123milhas.com', 'boeing*747-400'),
(11, 'Poseidon', 'deusdosmares@poseidon.com', '6666666666'),
(12, 'Zeus', 'zeus@filhosecia.com', 'phadahfa');

INSERT INTO publicacao(texto, data, hora, id_codigo) VALUES
('Coragem que é segunda-feira!E tem prova e entrega de trabalho do Igor, putz!...deu ruim kkkk', '2022-04-25', '02:36:08', 12),
('Lorem ipsum dolor sit amet', '2022-04-01', '12:01:53', 01),
('Tema tis rolod muspi merol', '2022-04-01', '12:01:53', 02),
('Ipsum dolor amet sit lorem', '2022-04-01', '12:01:53', 11),
('Nulla quis enim ultrices purus', '2022-04-01', '12:01:53', 08);

INSERT INTO arquivo_midia(id_codigo, nome, legenda, id_publicacao) VALUES
(001, 'foto00213', 'Aniver da Afrodite', 1),
(002, 'vídeo_apolo', 'Dia de puro sol', 2),
(003, 'áudio00xz', 'Jantar com Hera', 8),
(004, 'foto001', 'Mansão de Zeus no Olímpo', 11),
(005, 'vídeo_Convite', 'Tá rolando a Festa, Igor. PS: traz teus alunos', 12);

INSERT INTO grupo(nome, membro, dono, data_criacao, id_usuario) VALUES
('Deuses do Olímpo', 'Eros', 'Zeus','2010-12-29', 06),
('Pescarias com Poseidon', 'Deméter', 'Poseidon','2012-03-31',04 ),
('Dionísio Tudo sobre Vinho', 'Atena', 'Dionísio','2015-02-18', 03),
('Como uma Deusa', 'Afrodite', 'Ártemis','2013-09-21', 01 );

INSERT INTO publicacao_grupo(id_usuario, id_grupo) VALUES
(09, 004),
(02, 001),
(07, 003),
(04, 002);


INSERT INTO album(titulo, descricao, id_usuario) VALUES
('MyMemories', 'the best of Mount Olympus', 03),
('Moments of a Goddess', 'youth on Olympus', 09),
('Enjoying crazy eternity', 'paties on Mount Olympus ', 07),
('Apollo Days', 'summers and more summers', 02);

INSERT INTO foto(nome, legenda) VALUES

('photoxxx0102', 'in the field'),
('photoxzy0132', 'in the beach'),
('photoxjk9002', 'in the Mount Olympus city'),
('photoxwx1802', 'in the house of Ares'),
('photoyyy0201', 'in the paties of Aphodite');

INSERT INTO usuario_seguir(seguido, seguidor) VALUES
(01, 02),
(01, 03),
(01, 04),
(01, 05);
 