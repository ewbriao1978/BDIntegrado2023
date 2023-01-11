CREATE DATABASE trabalho1;

\c trabalho1;


CREATE TABLE usuario (
    id serial primary key,
    email text unique not full,
    nome text,
    senha text
);

CREATE TABLE album (
    id serial primary key,
    descricao text,
    titulo text,
    id_usuario integer references usuario (id)
);

CREATE TABLE foto (
    id serial primary key,
    legenda text,
    nome_arquivo text,
    id_album integer references album (id)
);

CREATE TABLE publicacao (
    id serial primary key,
    data date default current_date,
    hora time,
    texto text,
    id_usuario integer references usuario(id),
    id_grupo integer references grupo(id)
);

CREATE TABLE arquivo_midia (
    id serial primary key,
    nome text,
    legenda text,
    id_publicacao integer references publicacao(id)
);

CREATE TABLE grupo (
    id serial primary key,
    nome text,
    data_criacao date,
);

CREATE TABLE usuario_grupo (
    id_usuario integer references usuario(id),
    id_grupo integer references grupo(id),
    id_dono_grupo integer references usuario(id),
    primary key (id_usuario, id_grupo)
);

CREATE TABLE amizade (
    id serial primary key,
    id_usuario integer references usuario(id),
    amigos boolean,
    seguir boolean
);

insert into usuario (email, nome, senha) values 
('alemao@hotmail.com', 'victor', 'n2arigudo'),
('diego@gmail.com', 'diego', 'mintira02'),
('luiz@mosaicco.com', 'luiz', 'eng2022mecanica'),
('roberto.oli@outlook.com', 'roberto', 'paranagua2022');

insert into grupo(nome, data_criacao) values
('familia Machado', '01-05-2001'),
('equipe de excelencia operacional', '01-05-2022'),
('mosaic brasil', '01-02-1878');

insert into album (descricao, titulo, id_usuario) values
('caribe', 'ferias2011', 1),
('formatura', 'tcc aprovado', 2),
('trabalho', 'blending', 3)
('ego', 'gerente', 4);

insert into foto (legenda, nome_arquivo, id_album) values
('fotofamilia', 'jantar', 1),
('colacao', 'colacaopartfinal', 2),
('sonhodeconsumo', 'ferrari', 4),
('salareuniao', 'reuniaofinal', 3);

insert into publicacao (data, hora, texto, id_usuario, id_grupo) values
('2022-05-02', '14:05:22', null, 1, 2),
('2021-11-24', '16:22:33', 'momentos felizes', 3, 1),

insert into arquivo_midia (nome, legenda, id_publicacao) values
('videoR1230', 'reprise', 2),
('img011', 'foto3x4', 2),
('png2', 'Sonhos', 1);

insert into usuario_grupo (id_usuario, id_grupo, id_dono_grupo) values
(1,2,1),
(2,2,1),
(4,1,4),
(3,3,3);

insert into amizade (id_usuario, id_usuario, amigos, seguir) values
(1, 2, 'true', 'false');










