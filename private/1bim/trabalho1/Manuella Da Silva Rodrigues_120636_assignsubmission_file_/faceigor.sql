DROP DATABASE IF EXISTS faceigor;

CREATE DATABASE faceigor;

\c faceigor;

CREATE TABLE usuario (
id serial PRIMARY KEY,
nome character(100) NOT NULL,
email character(100) NOT NULL,
senha character(20) NOT NULL
);

CREATE TABLE solicitacao (
solicitante_id integer references usuario(id),
recebeu_solicitacao_id integer references usuario(id),
status_solicitacao boolean,
primary key (solicitante_id, recebeu_solicitacao_id)
);

CREATE TABLE amizade (
amigo_id integer references usuario(id),
usuario_id integer references usuario(id),
status_amizade character (1) NOT NULL

);

CREATE TABLE album (
id serial PRIMARY KEY,
titulo text NOT NULL,
descricao text,
usuario_id integer references usuario(id)
);

CREATE TABLE foto (
id serial PRIMARY KEY,
nome_arquivo text NOT NULL,
legenda text,
album_id integer references album(id)
);

CREATE TABLE grupo (
id serial PRIMARY KEY,
nome character(20) NOT NULL,
data_criacao date,
dono_grupo_id integer references usuario(id),
participante_grupo_id integer references usuario(id)
);

CREATE TABLE usuario_grupo (
usuario_id integer references usuario(id),
grupo_id integer references grupo(id),
primary key (usuario_id, grupo_id)
);

CREATE TABLE publicacao (
id serial PRIMARY KEY,
update text,
data_hora timestamp,
feed_id integer,
dono_do_post integer references usuario(id),
grupo_id integer references grupo(id)
);


CREATE TABLE arquivo_de_midia (
arquivo_de_midia_id serial PRIMARY KEY,
nome character(50),
legenda text,
publicacao_id integer references publicacao(id)
);

INSERT INTO usuario (id, nome, email, senha) VALUES
('1', 'manuella', 'manuella@gmail.com', 'senha123'),
('2', 'igor', 'igor@gmail.com', 'senha1234'),
('3', 'pedro', 'pedro@gmail.com', 'senha12345'),
('4', 'amanda', 'amanda@gmail.com', 'senha123456'),
('5', 'joao', 'joao@gmail.com', 'senha1234'),
('6', 'rodrigo', 'rodrigo@gmail.com', 'senha');

INSERT INTO solicitacao (solicitante_id, recebeu_solicitacao_id, status_solicitacao) VALUES
('2', '1', '1'),
('6', '1', '0');

INSERT INTO amizade (usuario_id, amigo_id, status_amizade) VALUES
('1', '2', 'A'),
('1', '3', 'A'),
('1', '4', 'S'),
('1', '5', 'A');


INSERT INTO album (id, titulo, descricao, usuario_id) VALUES
('231312', 'viagem', 'viagem ao canada', '1'),
('209302', 'viagem dois', 'viagem ao uruguai', '1'),
('839289', 'natal2022', 'natal em familia', '2'),
('090302', 'memorias', 'fotos antigas', '4'),
('182912', '2014', 'memorias de 2014', '5');

INSERT INTO foto (id, nome_arquivo, legenda, album_id) VALUES
('98', 'foto05102000', 'minha foto', '839289'),
('65', 'foto090890', 'entardecer', '090302'),
('222', 'foto04062012', 'encontrei por ai', '231312'),
('223', 'foto05062012', 'encontrei por ai de novo', '231312'),
('423', 'foto5656', 'eu te amo', '182912');

INSERT INTO grupo (id, nome, data_criacao, dono_grupo_id, participante_grupo_id) VALUES
('2321', 'ANIMAIS', '2015-03-04', '1', '2'),
('2326', 'BRECHO DA GALERA', '2011-06-06', '2', '1');

INSERT INTO publicacao (id, update, data_hora, feed_id, dono_do_post, grupo_id) VALUES
('23225', 'PUBLICACAO DE JOAO', '2000-12-01 12:00:00', '1', '5', null),
('23226', 'ESTOU SILENCIADA NAO DEVO APARECER NA TIMELINE', '2000-12-02 12:00:00', '1', '4', null),
('23227', 'PUBLICACAO DO PEDRO!!', '2000-12-31 12:00:00', '1', '3', null),
('23229', 'PUBLICACAO DO IGOR SOZINHO!!!', '2000-12-02 12:03:01', '1', '2', NULL),
('23228', 'PUBLICACAO DO IGOR NO GRUPO!!!', '2000-12-02 12:00:00', '1', '2', '2326');

INSERT INTO arquivo_de_midia (arquivo_de_midia_id, nome, legenda, publicacao_id) VALUES
('1234', 'a', 'arquivodemidia', '23229'),
('2323', 'b', 'legenda2', '23225'),
('5454', 'c', 'legenda3', '23227'),
('6666', 'd', 'legenda4', '23228');


SELECT publicacao.feed_id, publicacao.dono_do_post, publicacao.update, publicacao.grupo_id, publicacao.data_hora, arquivo_de_midia.arquivo_de_midia_id FROM publicacao INNER JOIN arquivo_de_midia on (arquivo_de_midia.publicacao_id = publicacao.id) INNER JOIN
amizade ON (publicacao.dono_do_post = amizade.amigo_id AND publicacao.feed_id = usuario_id) WHERE amizade.status_amizade = 'A';
