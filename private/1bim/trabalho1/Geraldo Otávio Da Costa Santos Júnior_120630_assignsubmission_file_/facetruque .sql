DROP DATABASE IF EXISTS facetruque;

CREATE DATABASE facetruque;

\c facetruque

create table usuario (
    codigo serial primary key,
    email text unique not null,
    nome text not null,
    senha varchar(4) not null,
    pub_user text
);

create table grupo (
    codigo serial primary key,
    nome text not null,
    data date default current_date,
    hora time default current_time,
    pub_grupo text not null,
    user_grupo_codigo integer
);

create table usuario_grupo (
    user_codigo integer references usuario(codigo),
    usuario_grupo_codigo integer references grupo(codigo),
    dono_codigo_grupo integer references usuario(codigo),
    primary key (user_codigo, usuario_grupo_codigo)
    );


create table album_foto (
    codigo serial primary key,
    titulo text ,
    descricao text,
    user_codigo integer references usuario(codigo)
);

create table foto (
    codigo serial primary key,
    legenda text not null,
    nome text not null,
    albu_foto_codigo integer references album_foto(codigo)
);


create table publicacao (
    codigo serial primary key,
    data timestamp default now(),
    user_codigo integer references usuario(codigo),
    grup_codigo integer references grupo(codigo)
);

create table midia(
    codigo serial primary key,
    nome text,
    legenda text,
    pub_codigo integer references publicacao(codigo)
);

create table amizade (
    codigo_amizade serial primary key,
    nome text,
    email text,
    senha text,
    acompanha_feed boolean default false,
    user_ami_codigo integer references usuario(codigo)
);

insert into usuario(email, nome, senha, pub_user) values
('jojo@jojo.gmail.com', 'Jotaro Kujo', '1111','Za WarudoOOOOOOOOO...'),
('joli@joline.gmail.com', 'Jorine Kujo', '2222', 'Então pega essa M se é importante...'),
('joje@educar.hotmail.com', 'Jojeph Kujo', '3333', 'Ai meu braçoo..'),
('joku@educar.hotmail.com', 'Jonathan Kujo', '4444', 'bonitao..'),
('joja@educar.hotmail.com', 'Joana Kujo', '5555', 'Vai saber..');


insert into grupo (nome, pub_grupo, user_grupo_codigo ) values
('Jojo Bizarre', 'Vai ter porrada .....',1),
('Jaja Bizarre', 'Vai ter mais porrada .....',2),
('Jeje Bizarre', 'Vai ter menos porrada .....',3),
('Jiji Bizarre', 'Vai ter a mesma porrada .....',4),
('Juju Bizarre', 'Sou jogo de arcade .....',5);

insert into usuario_grupo (user_codigo, usuario_grupo_codigo, dono_codigo_grupo) values
(1, 2, 1),
(2, 3, 2),
(3, 4, 3),
(4, 1, 4),
(5, 5, 5);

insert into album_foto ( titulo, descricao, user_codigo) values
('stardust', 'temporada', 1),
('star patinho', 'sei la eu', 2),
('Stone Ocean', 'Isso não é jogo?', 3),
('Crusaders', 'inventei mesmo', 4),
('Igor doidaum', 'ata, isso nem existe', 5);

insert into foto (legenda, nome, albu_foto_codigo) values
('dustStar', 'foto1', 1),
('patinho star', 'foto2', 2),
('Ocean Stone', 'foto3', 3),
('saderStar', 'foto4', 4),
('doidaum Igor', 'foto5', 5);

insert into publicacao (user_codigo, grup_codigo) values
( 1, 4),
( 4, 5),
( 5, 3),
( 3, 2),
( 2, 1);

insert into midia (nome, legenda, pub_codigo) values
('video1', 'teste 1', 1),
('video2', 'teste 11', 2),
('video3', 'teste 111', 3),
('video4', 'teste 1111', 4),
('video5', 'teste 11111', 5);

insert into amizade (nome, email, senha, acompanha_feed, user_ami_codigo) values
('Jotaro Kujo','jojo@jojo.gmail.com', '1111','true', 1),
('Jorine Kujo',  'joli@joline.gmail.com', '2222','true', 2),
('Jojeph Kujo', 'joje@educar.hotmail.com', '3333','false', 3),
('Jonathan Kujo', 'joku@educar.hotmail.com', '4444','false', 4),
('Joana Kujo', 'joja@educar.hotmail.com', '5555', 'true', 5);

/*RESPOSTA
SELECT usuario.nome, usuario.pub_user, grupo.pub_grupo, grupo.data, 
(SELECT cast(grupo.hora as time)),amizade.acompanha_feed , 
midia.nome,  midia.legenda FROM usuario 
JOIN usuario_grupo ON usuario.codigo = usuario_grupo.dono_codigo_grupo 
JOIN publicacao ON usuario.codigo = publicacao.user_codigo 
JOIN amizade ON user_ami_codigo = publicacao.codigo 
JOIN grupo ON publicacao.codigo = grupo.codigo 
JOIN midia ON publicacao.codigo = midia.pub_codigo
WHERE amizade.acompanha_feed = 'true' 
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8
ORDER BY 2, 3 DESC; */