create database faceIgor;

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
);