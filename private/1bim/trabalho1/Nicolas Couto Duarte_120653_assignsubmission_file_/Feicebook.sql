
drop database if exists feicebook;

create database Feicebook;

\c feicebook

create table usuario(
  cod serial primary key,
  email text unique not null,
  nome text not null,
  senha text not null
);

create table amizade(
usuario_cod integer not null references usuario(cod),
amigo_cod integer not null references usuario(cod),
seguindo boolean default true,
primary key (usuario_cod, amigo_cod)
);

create table grupos (
nome text not null,
cod serial primary key,
data_de_criação timestamp not null
);

create table usuario_grupo(
usuario_cod integer not null  references usuario (cod),
grupos_cod integer not null references grupos (cod),
Edono boolean default false,
Ecriador boolean default false,
data_hora_que_entrou timestamp not null,
primary key (usuario_cod, grupos_cod)
);



create table albuns(
  cod serial primary key,
  descrição text ,
 titulo text , 
 usuario_cod integer references usuario (cod)
);


create table fotos(
  cod serial primary key,
  nome_do_arquivo text  not null,
  legenda text,
  albuns_cod integer references albuns (cod)
);


create table publicação(
  cod serial primary key,
  texto text not null,
 data_hora_da_publicação timestamp not null , 
 usuario_cod integer not null references usuario (cod) ,
 grupos_cod integer references grupos (cod)
);


create table arquivos_de_midia(
  cod serial primary key,
  nome text not null,
 legenda text , 
 publicação_cod integer not null references publicação (cod)
);


insert into usuario (email, nome,senha) values
('antonio@gamil.com', 'antonio','MD5'),
('carlos@gamil.com', 'carlos','MD5'),
('adalberto@gamil.com', 'adalberto','MD5'),
('tamisa@gamil.com', 'tamisa','MD5'),
('Roberta@gamil.com', 'Roberta','MD5'),
('scithica@gamil.com', 'scithica','MD5'),
('Ferrata@gamil.com', 'Ferrata','MD5'),
('Sabina@gamil.com', 'Sabina','MD5'),
('Augusta@gamil.com', 'Augusta','MD5'),
('Galicca@gamil.com', 'Galicca','MD5');

insert into amizade (usuario_cod, amigo_cod,seguindo) values
('1', '2','true'),
('2', '1','true'),
('3', '6','true'),
('6', '3','true'),
('5', '10','true'),
('7', '4','true'),
('9', '8','true'),
('2', '5','true'),
('4', '7','true'),
('6', '1','true'),
('10', '5','true'),
('8', '9','true'),
('5', '2','true'),
('1', '9','true');

insert into grupos (nome,data_de_criação) values
('impares',now()),
('pares',now());

insert into usuario_grupo (usuario_cod,grupos_cod,Edono,Ecriador,data_hora_que_entrou) values
('1','1', 'true','true',now()),
('3','1', 'false','false',now()),
('5','1', 'false','false',now()),
('7','1', 'false','false',now()),
('9','1', 'false','false',now()),
('2','2', 'true','true',now()),
('4','2', 'false','false',now()),
('6','2', 'false','false',now()),
('8','2', 'false','false',now()),
('10','2', 'false','false',now());

insert into albuns (descrição,titulo,usuario_cod) values
('eu e minha galera','me and the boys','2'),
('eu e minha familia','familia da pesada','1'),
('minhas grandes jogadas no LOL','Warda isso direito','4'),
('fotos de quando eu era uma criança','de 30 anos','9');

insert into fotos ( nome_do_arquivo,legenda,albuns_cod) values
('meus fechamento','me and the boys','1'),
('meus sangue','familia da pesada','2'),
('minha felicidade kkk','Warda isso direito','3'),
('primeira barba','já corte','4'),
('meus fechamento2','me and the boys2','1'),
('meus sangue2','familia da pesada2','2'),
('minha felicidade kkk2','Warda isso direito2','3'),
('primeira barba2','já corte2','4');



insert into publicação (texto,data_hora_da_publicação,usuario_cod,grupos_cod) values
('tava fazendo bolo e olha no que deu',now(),'1',1),
('tava fazendo banheira de nutella e deu no que olha',now(),'2',2),
('gatos e bebes = likes',now(),'9',null),
('texto motivacional que nunguém vai se motivar',now(),'2',2),
('tava fazendo bolo e deu no que olha',now(),'1',null);

insert into arquivos_de_midia (nome,legenda,publicação_cod) values
('video de bolo','BOLO EXPLOMDIUUU','1'),
('video de bolo2','BOLO EXPLOMDIUUU','5'),
('BANHEIRA DE NUTELLA','SOU UMA FUUUCAAA','2'),
('GATOS BEBES','LIKE LIKE LIKE','3'),
('TEXTÃO ','texto com uma imagen do alberto aistem sem motivo nenhum pois ele nunca falo isso','4');



-- versão1

select publicação.texto,publicação.data_hora_da_publicação,publicação.usuario_cod,arquivos_de_midia.nome,
arquivos_de_midia.legenda from publicação inner join amizade on (publicação.usuario_cod = amizade.usuario_cod) 
inner join usuario on (usuario.cod = amizade.amigo_cod)
inner join arquivos_de_midia on (publicação.cod = publicação_cod)
where usuario.cod = 8;

--  versão2
select publicação.texto,publicação.data_hora_da_publicação,publicação.usuario_cod,arquivos_de_midia.nome,
arquivos_de_midia.legenda from publicação inner join amizade on (publicação.usuario_cod = amizade.usuario_cod) 
inner join usuario on (usuario.cod = amizade.amigo_cod)
inner join arquivos_de_midia on (publicação.cod = publicação_cod)
where usuario.cod = 8 and seguindo = true;

--  versão3 vindo duplicado
select publicação.texto,publicação.data_hora_da_publicação,publicação.usuario_cod,arquivos_de_midia.nome,
arquivos_de_midia.legenda from publicação inner join amizade on (publicação.usuario_cod = amizade.usuario_cod) 
inner join usuario_grupo on (publicação.grupos_cod = usuario_grupo.grupos_cod)
inner join usuario on (usuario.cod = amizade.amigo_cod or usuario.cod = usuario_grupo.usuario_cod )
inner join arquivos_de_midia on (publicação.cod = publicação_cod)
where usuario.cod = 8 or usuario.cod = 8 and seguindo = true;




