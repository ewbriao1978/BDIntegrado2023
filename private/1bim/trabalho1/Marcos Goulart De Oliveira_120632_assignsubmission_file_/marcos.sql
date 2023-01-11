DROP DATABASE IF EXISTS marcos;

CREATE database marcos;

\c marcos;

create table Usuario(
    email text primary key not null,
    nome text not null,
    senha text not null
);

create table Amizade(
    id serial primary key,
    email_usuario text not null references Usuario(email),
    email_amigo text not null references Usuario(email),
    mutado boolean not null
);

create table Album(
    id serial primary key,
    email_usuario text not null references Usuario(email),
    titulo text,
    descricao text
);

create table Foto(
    id serial primary key,
    id_album integer not null references Album(id),
    nome text,
    legenda text
);

create table Grupo(
    id serial primary key,
    email_usuario text not null references Usuario(email),
    nome text not null,
    data_criacao date not null
);

create table Membro(
    id serial primary key,
    id_grupo Integer not null references Grupo(id),
    email_usuario text not null references Usuario(email)
);

create table Publicacao(
    id serial primary key,
    email_usuario text not null references Usuario(email),
    id_grupo integer references Grupo(id),
    data_hora_criacao timestamp not null,
    texto text
);

create table Arquivo_Midia(
    id serial primary key,
    id_publicacao integer references Publicacao(id),
    nome text,
    legenda text
);-- Cadastrar 5 Usuarios.
-- Usuario de teste é amigo de 4 deles e n recebe publicação de 1.
-- Cadastrar 3 Grupos.
-- usuario de teste participa de 2.
/* Cadastrar 2 publicações de casa usuario em cada grupo uma de cada com arquivo Midia e entre elas 
uma com 3 arquivos de midia.*/
/* Cadastrar 2 publicações de casa usuario fora do grupo uma de cada um com arquivo de midia e entre elas
uma com 2 arquivos de midia.*/

-- Usuarios
insert into Usuario (email, nome, senha) values('usuarioTeste@gmail.com', 'Usuario', md5('senha123'));
insert into Usuario (email, nome, senha) values('jorginho@gmail.com', 'Jorge', md5('baita senha'));
insert into Usuario (email, nome, senha) values('blaber@gmail.com', 'Robert', md5('essa e tri dificil'));
insert into Usuario (email, nome, senha) values('jockster@gmail.com', 'Luan', md5('senha'));
insert into Usuario (email, nome, senha) values('tockers@gmail.com', 'Gabriel', md5('sem criatividade'));

-- Amizades
insert into Amizade (email_usuario, email_amigo, mutado) values('usuarioTeste@gmail.com', 'jorginho@gmail.com', false);
insert into Amizade (email_usuario, email_amigo, mutado) values('usuarioTeste@gmail.com', 'blaber@gmail.com', false);
insert into Amizade (email_usuario, email_amigo, mutado) values('usuarioTeste@gmail.com', 'jockster@gmail.com', true);

-- Grupo
insert into Grupo (email_usuario, nome, data_criacao) values('tockers@gmail.com', 'Ilha dos Desafios', '2022-01-01');
insert into Grupo (email_usuario, nome, data_criacao) values('jorginho@gmail.com', 'Fut dos guri', '2018-10-21');
insert into Grupo (email_usuario, nome, data_criacao) values('usuarioTeste@gmail.com', 'Amigos do Usuario', '2021-07-04');

-- Grupos em que Usuario é membro
insert into Membro (id_grupo, email_usuario) values (2, 'usuarioTeste@gmail.com');
insert into Membro (id_grupo, email_usuario) values (3, 'usuarioTeste@gmail.com');

-- Grupos em que jorginho é membro
insert into Membro (id_grupo, email_usuario) values (1, 'jorginho@gmail.com');
insert into Membro (id_grupo, email_usuario) values (2, 'jorginho@gmail.com');
insert into Membro (id_grupo, email_usuario) values (3, 'jorginho@gmail.com');

-- Grupos em que blaber é membro
insert into Membro (id_grupo, email_usuario) values (1, 'blaber@gmail.com');
insert into Membro (id_grupo, email_usuario) values (2, 'blaber@gmail.com');
insert into Membro (id_grupo, email_usuario) values (3, 'blaber@gmail.com');

-- Grupos em que jockster é membro
insert into Membro (id_grupo, email_usuario) values (1, 'jockster@gmail.com');
insert into Membro (id_grupo, email_usuario) values (2, 'jockster@gmail.com');
insert into Membro (id_grupo, email_usuario) values (3, 'jockster@gmail.com');

-- Grupos em que tockers é membro
insert into Membro (id_grupo, email_usuario) values (1, 'tockers@gmail.com');
insert into Membro (id_grupo, email_usuario) values (2, 'tockers@gmail.com');
insert into Membro (id_grupo, email_usuario) values (3, 'tockers@gmail.com');

-- Publicações Usuario
insert into Publicacao(email_usuario, data_hora_criacao, texto) values ('usuarioTeste@gmail.com', '20220201 21:30:25', 'Oi!');
insert into Publicacao(email_usuario, data_hora_criacao, texto) values ('usuarioTeste@gmail.com', '20220201 21:30:30', 'Tudo bem?');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('usuarioTeste@gmail.com', 2,'20220202 23:10:03', 'Como que ta gurizada?');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('usuarioTeste@gmail.com', 2,'20220202 23:11:03', 'olha esse video');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('usuarioTeste@gmail.com', 3,'20220202 23:10:03', 'Como que ta gurizada?');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('usuarioTeste@gmail.com', 3,'20220202 23:15:15', 'Deem like nessa foto');
-- Arquivos de midia das publicações do usuario
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(2, 'imagem1.png', 'imagem irada'); 
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(4, 'video.png', 'video irado');
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(6, 'imagem2.png', 'imagem irada');

-- Publicações jorginho
insert into Publicacao(email_usuario, data_hora_criacao, texto) values ('jorginho@gmail.com', '20220201 12:30:26', 'primeira do jorginho!');
insert into Publicacao(email_usuario, data_hora_criacao, texto) values ('jorginho@gmail.com', '20220201 13:30:29', 'segunda do jorginho?');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('jorginho@gmail.com', 1,'20220203 23:10:03', 'terceira do jorginho');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('jorginho@gmail.com', 1,'20220204 23:11:03', 'quarta do jorginho');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('jorginho@gmail.com', 2,'20220205 23:10:03', 'quinta do jorginho');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('jorginho@gmail.com', 2,'20220206 23:11:03', 'sexta do jorginho');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('jorginho@gmail.com', 3,'20220207 23:10:03', 'setima do jorginho?');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('jorginho@gmail.com', 3,'20220208 23:10:03', 'oitava do jorginho');
-- Arquivos de midia das publicações do jorginho
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(8, 'imagemJorge1.png', 'imagem jorge'); 
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(10, 'videoJorge1.png', 'video jorge');
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(12, 'imagemJorge2.png', 'imagem2 jorge');
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(14, 'videoJorge2.png', 'video2 jorge');

-- Publicações blaber
insert into Publicacao(email_usuario, data_hora_criacao, texto) values ('blaber@gmail.com', '20220201 12:30:25', 'quarta do blaber!');
insert into Publicacao(email_usuario, data_hora_criacao, texto) values ('blaber@gmail.com', '20220201 13:30:30', 'sexta do jorginho?');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('blaber@gmail.com', 1,'20220201 15:10:03', 'oitava do blaber');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('blaber@gmail.com', 1,'20220201 14:11:03', 'setima do blaber');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('blaber@gmail.com', 2,'20220201 13:10:03', 'quinta do blaber');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('blaber@gmail.com', 2,'20220201 12:11:03', 'terceira do blaber');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('blaber@gmail.com', 3,'20220201 11:10:03', 'segunda do blaber?');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('blaber@gmail.com', 3,'20220201 10:10:03', 'primeira do blaber');
-- Arquivos de midia das publicações do blaber
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(16, 'imagemBlaber1.png', 'imagem blaber'); 
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(18, 'videoBlaber1.png', 'video blaber');
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(20, 'imagemBlaber2.png', 'imagem2 blaber');
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(22, 'videoBlaber2.png', 'video2 blaber');

-- Publicações jockster
insert into Publicacao(email_usuario, data_hora_criacao, texto) values ('jockster@gmail.com', '20220202 12:30:25', 'quarta do jockster!');
insert into Publicacao(email_usuario, data_hora_criacao, texto) values ('jockster@gmail.com', '20220202 13:30:30', 'sexta do jockster?');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('jockster@gmail.com', 1,'20220202 15:10:03', 'oitava do jockster');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('jockster@gmail.com', 1,'20220202 14:11:03', 'setima do jockster');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('jockster@gmail.com', 2,'20220202 13:10:03', 'quinta do jockster');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('jockster@gmail.com', 2,'20220202 12:11:03', 'terceira do jockster');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('jockster@gmail.com', 3,'20220202 11:10:03', 'segunda do jockster?');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('jockster@gmail.com', 3,'20220202 10:10:03', 'primeira do jockster');
-- Arquivos de midia das publicações do jockster
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(24, 'imagemJockster1.png', 'imagem jockster'); 
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(26, 'videoJockster1.png', 'video jockster');
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(28, 'imagemJockster2.png', 'imagem2 jockster');
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(30, 'videoJockster2.png', 'video2 jockster');

-- Publicações tockers
insert into Publicacao(email_usuario, data_hora_criacao, texto) values ('tockers@gmail.com', '20220203 12:30:25', 'quarta do tockers!');
insert into Publicacao(email_usuario, data_hora_criacao, texto) values ('tockers@gmail.com', '20220203 13:30:30', 'sexta do tockers?');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('tockers@gmail.com', 1,'20220203 15:10:03', 'oitava do tockers');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('tockers@gmail.com', 1,'20220203 14:11:03', 'setima do tockers');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('tockers@gmail.com', 2,'20220203 13:10:03', 'quinta do tockers');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('tockers@gmail.com', 2,'20220203 12:11:03', 'terceira do tockers');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('tockers@gmail.com', 3,'20220203 11:10:03', 'segunda do tockers?');
insert into Publicacao(email_usuario, id_grupo, data_hora_criacao, texto) values ('tockers@gmail.com', 3,'20220203 10:10:03', 'primeira do tockers');
-- Arquivos de midia das publicações do tockers
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(32, 'imagemTockers1.png', 'imagem tockers'); 
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(34, 'videoTockers1.png', 'video tockers');
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(36, 'imagemTockers2.png', 'imagem2 tockers');
insert into Arquivo_Midia(id_publicacao, nome, legenda) values(38, 'videoTockers2.png', 'video2 tockers');


select distinct p.email_usuario, p.texto, p.data_hora_criacao as Data_Publicacao, g.nome as Nome_do_Grupo 
from publicacao as p 
left join Amizade as a on p.email_usuario = a.email_amigo
left join Membro as m on p.id_grupo = m.id_grupo
left join Arquivo_Midia as am on p.id = am.id_publicacao
left join Grupo as g on p.id_grupo = g.id
where p.email_usuario = 'usuarioTeste@gmail.com' 
       or (a.email_usuario = 'usuarioTeste@gmail.com' and a.mutado = false and p.id_grupo is null) 
	   or (m.email_usuario = 'usuarioTeste@gmail.com' and (a.mutado = false or a.mutado is null))
order by p.data_hora_criacao desc;
