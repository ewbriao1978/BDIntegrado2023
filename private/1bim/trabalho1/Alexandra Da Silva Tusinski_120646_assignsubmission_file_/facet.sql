drop database if exist facet;
drop table foto;
drop table album;
drop table amigo_publicacao;
drop table amigo;
drop table grupo_publicacao;
drop table midia;
drop table publicacao;
drop table dono;
drop table grupo_usuario;
drop table grupo;
drop table usuario;

create database facet;

create table usuario(
  codigo serial primary key,
  nome text not null,
  e_mail text,
  senha character (4)
);

insert into usuario(nome, e_mail, senha) values
  ('Ana', 'ana@gmail.com','1234'),
  ('Beti', 'beti@hotmail.com','4321'),
  ('Carla', 'carla@ig.com','4567'),
  ('Julia', 'juju@gmail.com','7891'),
  ('Bento', 'be@hotmail.com','1456');


  create table grupo(
    codigo serial primary key,
    nome text,
    data date default current_date
  );

  insert into grupo(nome, data) values
    ('solteiros', '10/01/01'),
    ('ciclismo', '02/02/02'),
    ('namoro', '10/10/01');
    ('historia', '07/07/07');


create table grupo_usuario(
  grupo_codigo integer references grupo(codigo),
  usuario_codigo integer references usuario(codigo),
  data date default current_date,
  hora time default current_time,
  primary key (grupo_codigo, usuario_codigo)
);

insert into grupo_usuario(grupo_codigo, usuario_codigo, data, hora) values
  (1,1,'12/12/21', '08:00'),
  (1,2, '13/11/22','10;00'),
  (1,3, '10/10/10', '11:00'),
  (2,1, '12/02/13', '14:00'),
  (2,4, '20/10/10', '13:00'),
  (3,1, '21/11/11', '13:00'),
  (3,5, '14/07/14', '16;00');

create table dono(
  usuario_codigo integer references usuario(codigo),
  grupo_codigo integer references grupo(codigo),
  primary key (usuario_codigo, grupo_codigo)
);

insert into dono(usuario_codigo, grupo_codigo) values
  (1,1),
  (2,2),
  (3,3),
  (4,4);


  create table publicacao(
    codigo serial primary key,
    data date default current_date,
    hora time default current_time,
    usuario_codigo integer references usuario(codigo)

  );

  insert into publicacao(data, hora, usuario_codigo) values
    ('11/10/10', '18:00', 1),
    ('11/11/11', '17;00', 3),
    ('10/09/09', '03:00', 5),
    ('12/02/02', '07:00', 2),
    ('11/10/10', '18:30', 4);


    create table midia(
      codigo serial primary key,
      nome text,
      legenda text,
      publicacao_codigo integer references publicacao(codigo)
    );

    insert into midia(nome, legenda, publicacao_codigo) values
      ('festa', 'f1',1),
      ('ferias', 'fe1', 2),
      ('aniver', 'ani22', 3),
      ('trabalho', 'trb', 4);

create table grupo_publicacao(
  grupo_codigo integer references grupo(codigo),
  publicacao_codigo integer references publicacao(codigo),
  primary key (grupo_codigo, publicacao_codigo)
);

insert into grupo_publicacao(grupo_codigo, publicacao_codigo) values
  (1,1),
  (2,2),
  (3,3);

create table amigo(
  codigo serial primary key,
  usuario_codigo integer references usuario(codigo)
);

insert into amigo(usuario_codigo) values
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(2,1),
(2,3),
(2,4),
(3,1),
(3,2),
(3,4),
(4,1),
(4,2),
(4,3),
(5,1);


create table amigo_publicacao(
  amigo_codigo integer references amigo(codigo),
  publicacao_codigo integer references publicacao(codigo),
  primary key (amigo_codigo, publicacao_codigo)
);

insert into amigo_publicacao(amigo_codigo, publicacao_codigo) values
  (1,2),
  (1,3),
  (1,4),
  (1,5),
  (2,1),
  (2,3),
  (2,4),
  (3,1),
  (3,2),
  (3,4),
  (5,1);


create table album(
  codigo serial primary key,
  titulo text,
  descricao text,
  usuario_codigo integer references usuario(codigo)
);

insert into album(titulo, descricao, usuario_codigo) values
  ('familia', 'paterna', 1),
  ('amigos', 'amigo_secreto', 1),
  ('familia', 'linda', 2),
  ('filhos', 'luana', 2),
  ('family', 'my', 3),
  ('eu', 'me', 4),
  ('nos', 'nos', 5);

create table foto(
  codigo serial primary key,
  legenda text,
  nome text,
  album_codigo integer references album(codigo)
);

insert into foto(legenda, nome, album_codigo) values
  ('vó', 'vovo', 1),
  ('mae', 'Clara', 1),
  ('amigas', 'julia', 2),
  ('pai', 'antonio', 3),
  ('caçula', 'Lu', 4),
  ('marido', 'tom', 5),
  ('curtindo', 'vida', 6),
  ('amor', 'marido', 7);
