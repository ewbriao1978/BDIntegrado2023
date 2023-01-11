DROP DATABASE IF EXISTS lorrana;

CREATE DATABASE lorrana;

\c lorrana;


CREATE TABLE usuario (
    id serial primary key,
    email text unique NOT NULL,
    nome text NOT NULL,
    senha text NOT NULL
);

CREATE TABLE amizade (
    idusuario integer references usuario (id),
    idusuarioAmigo integer references usuario (id),
    primary key (idusuario, idusuarioAmigo)

);
CREATE TABLE grupo (
    id serial primary key,
    nome text NOT NULL,
    donoGrupo integer references usuario (id),
    data date DEFAULT CURRENT_DATE,
    hora time DEFAULT CURRENT_TIME

);
CREATE TABLE segueUsuario (
    idusuario integer references usuario (id),
    usuario_seguido integer references usuario (id),
    primary key (idusuario, usuario_seguido)
);

CREATE TABLE segueGrupo (
    idusuario integer references usuario (id),
    idgrupo integer references grupo (id),
    data date DEFAULT CURRENT_DATE,
    hora time DEFAULT CURRENT_TIME,
    primary key (idusuario, idgrupo)
);

CREATE TABLE publicacao (
    id serial primary key,
    texto text,
    feed boolean NOT NULL,
    idCriador integer references usuario (id),
    data date DEFAULT CURRENT_DATE,
    hora time DEFAULT CURRENT_TIME
);

CREATE TABLE arquivoMidia (
    id serial primary key,
    legenda text,
    nome text,
    idPublicacao integer references publicacao (id)
);


CREATE TABLE album (
    id serial primary key,
    descricao text,
    titulo text,
    idusuario integer references usuario (id)

);

CREATE TABLE foto (
    id serial primary key,
    nomeArquivo text NOT NULL,
    legenda text,
    idAlbum integer references album (id)
);



CREATE TABLE compartilhaPublicacaoGrupo (
    idusuario integer references usuario (id),
    idgrupo integer references grupo (id),
    idpublicacao integer references publicacao (id),
    data date DEFAULT CURRENT_DATE,
    hora time DEFAULT CURRENT_TIME,
    primary key (idusuario, idgrupo, idpublicacao)
);

CREATE TABLE compartilhaPublicacaoUsuario (
    idusuario integer references usuario (id),
    idpublicacao integer references publicacao (id),
    data date DEFAULT CURRENT_DATE,
    hora time DEFAULT CURRENT_TIME,
    primary key (idusuario, idpublicacao) 
);

insert into usuario (email,nome,senha) values ('luana@gmail.com.br','Luana', md5('1234'));
insert into usuario (email,nome,senha) values ('carla@gmail.com.br','Carla', md5('1235'));
insert into usuario (email,nome,senha) values ('diego@gmail.com.br','Diego', md5('568'));
insert into usuario (email,nome,senha) values ('marcio@gmail.com.br','Marcio', md5('846984'));
insert into usuario (email,nome,senha) values ('ana@gmail.com.br','Ana', md5('566dwdw555'));

insert into amizade (idusuario,idusuarioAmigo) values (1,2);
insert into amizade (idusuario,idusuarioAmigo) values (3,1);
insert into amizade (idusuario,idusuarioAmigo) values (3,4);
insert into amizade (idusuario,idusuarioAmigo) values (4,1);

insert into segueUsuario (idusuario, usuario_seguido) values (1,2);
insert into segueUsuario (idusuario, usuario_seguido) values (2,1);
insert into segueUsuario (idusuario, usuario_seguido) values (3,1);
insert into segueUsuario (idusuario, usuario_seguido) values (3,4);
insert into segueUsuario (idusuario, usuario_seguido) values (4,1);
insert into segueUsuario (idusuario, usuario_seguido) values (1,4);


insert into publicacao (texto,feed, idCriador) values ('Meme do 1',FALSE, 1);
insert into publicacao (texto,feed, idCriador) values ('Meme do 2',FALSE, 2);
insert into publicacao (texto,feed, idCriador) values ('Meme do 3',TRUE, 3);
insert into publicacao (texto,feed, idCriador) values ('Meme do 4',TRUE, 4);

insert into arquivoMidia (legenda,nome,idPublicacao) values ('Engraçado meme 1', '15555codpng',1);
insert into arquivoMidia (legenda,nome,idPublicacao) values ('Engraçado meme 2', 'dwde5555codpng',2);
insert into arquivoMidia (legenda,nome,idPublicacao) values ('Engraçado meme 3', '1klld7775555codpng',3);
insert into arquivoMidia (legenda,nome,idPublicacao) values ('Engraçado meme 4', '15asjijisa555codpng',4);

insert into grupo (nome, donoGrupo) values ('Memes 2022', 1);
insert into grupo (nome, donoGrupo) values ('Clube do livro', 2);

insert into segueGrupo (idusuario,idgrupo) values (1,1);
insert into segueGrupo (idusuario,idgrupo) values (2,1);
insert into segueGrupo (idusuario,idgrupo) values (3,1);
insert into segueGrupo (idusuario,idgrupo) values (2,2);
insert into segueGrupo (idusuario,idgrupo) values (3,2);


insert into CompartilhaPublicacaoGrupo (idusuario,idgrupo,idPublicacao) values (1,1,1);
insert into CompartilhaPublicacaoGrupo (idusuario,idgrupo,idPublicacao) values (2,1,2);
insert into CompartilhaPublicacaoGrupo (idusuario,idgrupo,idPublicacao) values (2,1,4);
insert into CompartilhaPublicacaoGrupo (idusuario,idgrupo,idPublicacao) values (3,2,4);



SELECT u.nome,amigo,texto,feed,data, hora,legenda,am.nome, idpublicacao FROM (SELECT sqamigo.amigo, p.id, p.idCriador, p.texto, p.feed,p.data,p.hora  
   FROM (SELECT az.idusuarioAmigo as amigo FROM amizade az inner JOIN usuario u on az.idusuario = u.id 
            WHERE az.idusuario = 1 OR az.idusuarioAmigo = 1
        
        UNION    
        
        SELECT az.idusuario as amigo FROM amizade az 
            inner JOIN usuario u on az.idusuario = u.id WHERE az.idusuarioAmigo = 1) as sqamigo
    inner join publicacao p on p.idCriador = sqamigo.amigo where p.feed = true

    UNION 

    SELECT cpg.idusuario, p.id, p.idCriador, p.texto, p.feed,p.data,p.hora 
        FROM grupo g inner join segueGrupo sg on sg.idgrupo = g.id 
        inner join CompartilhaPublicacaoGrupo cpg on cpg.idgrupo = sg.idgrupo 
        inner join publicacao p on p.id = cpg.idPublicacao where sg.idusuario = 1) as p_amigos
    
    inner join usuario u on u.id = p_amigos.amigo
    right join arquivoMidia am on am.idPublicacao = p_amigos.id
    where p_amigos.amigo in (Select usuario_seguido FROM segueUsuario Where idusuario = 1) OR p_amigos.amigo in (1) 

order by p_amigos.data,p_amigos.hora desc;







