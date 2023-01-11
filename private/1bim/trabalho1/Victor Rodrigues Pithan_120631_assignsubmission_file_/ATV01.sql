DROP DATABASE IF EXISTS fakeface;

CREATE DATABASE fakeface;

\c fakeface;

DROP TABLE IF EXISTS arquivo_midia;
DROP TABLE IF EXISTS publicacao;
DROP TABLE IF EXISTS usuario_grupo;
DROP TABLE IF EXISTS grupo;
DROP TABLE IF EXISTS foto;
DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS lista_amizade;
DROP TABLE IF EXISTS usuario;


CREATE TABLE usuario (
    id SERIAL PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    senha TEXT NOT NULL,
    nome TEXT NOT NULL
);

CREATE TABLE lista_amizade (
    cod SERIAL PRIMARY KEY,
    usuario_id INTEGER NOT NULL REFERENCES usuario (id),
    seguido_id INTEGER NOT NULL REFERENCES usuario (id),
    visualisa_feed BOOLEAN DEFAULT  'true',
    CHECK (usuario_id != seguido_id),
    UNIQUE (usuario_id, seguido_id)
);

CREATE TABLE album (
    id SERIAL PRIMARY KEY,
    titulo TEXT NOT NULL,
    descricao TEXT,
    usuario_id INTEGER NOT NULL REFERENCES usuario (id)
);

CREATE TABLE foto (
    id SERIAL PRIMARY KEY,
    legenda TEXT,
    nome TEXT NOT NULL,
    album_id INTEGER NOT NULL REFERENCES album (id)
);

CREATE TABLE grupo (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP CHECK (data_criacao <= CURRENT_TIMESTAMP),
    dono_grupo INTEGER NOT NULL REFERENCES usuario (id)
);

CREATE TABLE usuario_grupo (
    id SERIAL PRIMARY KEY,
    data_hora_entrada TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP CHECK (data_hora_entrada <= CURRENT_TIMESTAMP),
    usuario_id INTEGER NOT NULL REFERENCES usuario (id),
    grupo_id INTEGER NOT NULL REFERENCES grupo (id),
    UNIQUE(usuario_id, grupo_id)
);

CREATE TABLE publicacao (
    id SERIAL PRIMARY KEY,
    data_hora_criacao TIMESTAMP NOT NULL,
    texto TEXT NOT NULL,
    usuario_id INTEGER REFERENCES usuario (id),
    usuario_grupo_id INTEGER REFERENCES usuario_grupo (id),
    CHECK ((usuario_id is not null and usuario_grupo_id is null) or (usuario_id is null and usuario_grupo_id is not null))
);

CREATE TABLE arquivo_midia (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    legenda TEXT,
    publicacao_id INTEGER REFERENCES publicacao (id)
);

INSERT INTO usuario (email, senha, nome) VALUES
    ('mariazinha@gmail.com', MD5('123456'), 'Maria Aparecida'),
    ('joao.carlos@gmail.com', MD5('654321'), 'Joao Carlos'),
    ('edu.gaspar@hotmail.com', MD5('123654'), 'Eduardo Gaspar'),
    ('loren@yahoo.com.br', MD5('123987'), 'Lorena Heinz'),
    ('king.arty@hotmail.com', MD5('123654'), 'Arthur Loreiro'),
    ('madruga.antonio@hotmail.com', MD5('123654'), 'Antonio Madruga'),
    ('guti.mariana@hotmail.com', MD5('123654'), 'Mariana Gutierrez'),
    ('monica.goulart@gmail.com', MD5('456321'), 'Monica Goulart');

INSERT INTO lista_amizade (usuario_id, seguido_id, visualisa_feed) VALUES
    (1, 2, 'true'),
    (1, 3, 'false'),
    (1, 4, 'true'),
    (1, 5, 'true'),
    (1, 6, 'true'),
    (1, 7, 'true'),
    (1, 8, 'true'),

    (2, 1, 'true'),
    (2, 3, 'false'),
    (2, 4, 'true'),
    (2, 5, 'false'),

    (3, 5, 'false'),
    (3, 6, 'true'),
    (3, 7, 'false'),
    (3, 8, 'true'),

    (4, 3, 'false'),
    (6, 1, 'true'),
    (7, 1, 'true');

INSERT INTO  album (titulo, descricao, usuario_id) VALUES
    ('Viagem para Acapulco', 'Viagem feita no feriado', 1),
    ('Viagem para Floripa', 'Viagem feita nas ferias', 4),
    ('Album de Casamento', 'Casamento Realizado em Junho de 1980', 2),
    ('Cinema com a Galera', 'Dia de assistir Matrix com os parça', 3);

INSERT INTO foto (nome, legenda, album_id) VALUES
    ('Na praia', 'Bebendo com a galera', 1),
    ('Caindo no mar', 'Aprendendo a nadar', 2),
    ('Entrada Cinema', 'Assistindo a estréia do filme Batman', 4),
    ('Casamento', 'Entrando na igreja', 3);

INSERT INTO grupo (nome, data_criacao, dono_grupo) VALUES
    ('Grupo da Familia Aparecida', '2022-04-01 00:01', 1),
    ('Grupo da Familia Jackson', NOW(), 2);

INSERT INTO usuario_grupo (data_hora_entrada, usuario_id, grupo_id) VALUES
    (NOW(), 1, 1),
    (NOW(), 2, 1),
    (NOW(), 3, 1),
    (NOW(), 4, 1),
    (NOW(), 8, 1),
    (NOW(), 2, 2),
    (NOW(), 4, 2),
    (NOW(), 5, 2),
    (NOW(), 6, 2),
    (NOW(), 7, 2);

INSERT INTO publicacao (data_hora_criacao, texto, usuario_grupo_id) VALUES
    (cast(NOW() as TIMESTAMP) - cast('10 days' as interval), 'Loren ipsun loren erun I', 1),
    (cast(NOW() as TIMESTAMP) - cast('9 days' as interval), 'Loren ipsun loren erun II', 2),
    (cast(NOW() as TIMESTAMP) - cast('8 days' as interval), 'Loren ipsun loren erun III', 2),
    (cast(NOW() as TIMESTAMP) - cast('8 days' as interval) - cast('1 hour' as interval), 'Loren ipsun loren erun IV', 3),
    (cast(NOW() as TIMESTAMP) - cast('7 days' as interval), 'Loren ipsun loren erun V', 4),
    (cast(NOW() as TIMESTAMP) - cast('7 days' as interval) - cast('30 minutes' as interval), 'Loren ipsun loren erun VI', 5),
    (cast(NOW() as TIMESTAMP) - cast('6 days' as interval), 'Loren ipsun loren erun VII', 6),
    (cast(NOW() as TIMESTAMP) - cast('4 days' as interval), 'Loren ipsun loren erun VIII', 7),
    (cast(NOW() as TIMESTAMP) - cast('3 days' as interval), 'Loren ipsun loren erun IX', 8),
    (cast(NOW() as TIMESTAMP) - cast('2 days' as interval), 'Loren ipsun loren erun X', 9),
    (cast(NOW() as TIMESTAMP) - cast('1 days' as interval), 'Loren ipsun loren erun XI', 10);

INSERT INTO publicacao (data_hora_criacao, texto, usuario_id) VALUES
    (NOW(), 'MEU QUERIDO DIARIO', 2),
    (NOW(), '7 PASSOS PARA A FELICIDADE', 4),
    (NOW(), 'COMO PERDER PESO', 1),
    (NOW(), 'APRENDENDO A HACKEAR SUA MENTE', 3);

INSERT INTO arquivo_midia (nome, legenda, publicacao_id) VALUES
    ('Loren Epsun', 'Codigo I', 1),
    ('Loren Epsun', 'Codigo II', 2),
    ('Loren Epsun', 'Codigo III', 3),
    ('Loren Epsun', 'Codigo V', 5),
    ('Loren Epsun', 'Codigo VII', 7),
    ('Loren Epsun', 'Codigo XI', 9),

    ('Meu primeiro dia na universidade foi ...', 'Primeiro dia Universidade', 12),
    ('Meu segundo dia na universidade foi ...', 'Segundo dia Universidade', 12),
    ('Hoje houve trote na universidade e foi ...', 'Trote Universidade', 12),
    ('O primeiro passo para a felicidade ...', '1 Passo para a felicidade', 13),
    ('Primeiro deves começar a rotina de ...', 'Passo 1', 14),
    ('Ao acordar a primeira coisa a se ...', 'Passo 1', 15);

-- PUBLICAÇÃO DO FEED DE NOTICIAS ENTRE HOJE E UMA SEMANA ATRÁS DOS AMIGOS MARCADOS COMO 'SEGUIR FEED' E DOS GRUPOS AO QUAL FAZ PARTE.

-- CÓDIGO EM UMA LINHA PARA RODAR NO PSQL

-- SELECT tmp.NOME AS Usuario, usuario.nome AS Post_de, to_char(publicacao.data_hora_criacao, 'DD/MM/YYYY HH24:MI:SS') AS hora_publicacao, publicacao.texto, arquivo_midia.nome, arquivo_midia.legenda, usuario_grupo.grupo_id AS Grupo FROM usuario INNER JOIN usuario_grupo ON (usuario.id = usuario_grupo.usuario_id) INNER JOIN publicacao ON (usuario_grupo.id = publicacao.usuario_grupo_id) INNER JOIN (SELECT usuario.nome AS NOME, usuario_grupo.usuario_id AS ID_USUARIO, usuario_grupo.grupo_id AS ID_GRUPO FROM usuario_grupo INNER JOIN usuario ON (usuario_grupo.usuario_id = usuario.id)) AS tmp ON (usuario_grupo.grupo_id = tmp.ID_GRUPO) LEFT JOIN arquivo_midia ON (publicacao.id = arquivo_midia.publicacao_id) WHERE tmp.ID_USUARIO = 2 AND publicacao.data_hora_criacao BETWEEN (cast(now() AS TIMESTAMP) - cast('7 days' AS interval)) AND cast(now() AS TIMESTAMP) UNION (SELECT usuario.nome AS Usuario, tmp.amigo AS Post_de, to_char(publicacao.data_hora_criacao, 'DD/MM/YYYY HH24:MI:SS') AS hora_publicacao, publicacao.texto, arquivo_midia.nome, arquivo_midia.legenda, usuario_grupo.grupo_id AS Grupo FROM (SELECT lista_amizade.cod AS codigo, usuario.nome AS amigo, usuario.id AS AmigoID FROM lista_amizade INNER JOIN usuario ON (lista_amizade.seguido_id = usuario.id)) AS tmp INNER JOIN lista_amizade ON (tmp.codigo = lista_amizade.cod) INNER JOIN usuario ON (lista_amizade.usuario_id = usuario.id) INNER JOIN publicacao ON (tmp.AmigoID = publicacao.usuario_id) LEFT JOIN arquivo_midia ON (publicacao.id = arquivo_midia.publicacao_id) LEFT JOIN usuario_grupo ON (publicacao.usuario_grupo_id = usuario_grupo.grupo_id) WHERE usuario.id = 2 AND lista_amizade.visualisa_feed = 'true' AND publicacao.data_hora_criacao BETWEEN (cast(now() AS TIMESTAMP) - cast('7 days' AS interval)) AND cast(now() AS TIMESTAMP)) ORDER BY hora_publicacao DESC;


-- CÓDIGO FORMATADO

/* SELECT tmp.NOME AS Usuario, usuario.nome AS Post_de, to_char(publicacao.data_hora_criacao, 'DD/MM/YYYY HH24:MI:SS') AS hora_publicacao, publicacao.texto, arquivo_midia.nome, arquivo_midia.legenda, usuario_grupo.grupo_id AS Grupo
FROM usuario
    INNER JOIN usuario_grupo ON (usuario.id = usuario_grupo.usuario_id)
    INNER JOIN publicacao ON (usuario_grupo.id = publicacao.usuario_grupo_id)
    INNER JOIN
        (SELECT usuario.nome AS NOME, usuario_grupo.usuario_id AS ID_USUARIO, usuario_grupo.grupo_id AS ID_GRUPO
        FROM usuario_grupo
        INNER JOIN usuario ON (usuario_grupo.usuario_id = usuario.id)) AS tmp
    ON (usuario_grupo.grupo_id = tmp.ID_GRUPO) 
    LEFT JOIN arquivo_midia ON (publicacao.id = arquivo_midia.publicacao_id)
WHERE tmp.ID_USUARIO = 2
    AND publicacao.data_hora_criacao BETWEEN (cast(now() AS TIMESTAMP) - cast('7 days' AS interval)) AND cast(now() AS TIMESTAMP)
UNION
(SELECT usuario.nome AS Usuario, tmp.amigo AS Post_de, to_char(publicacao.data_hora_criacao, 'DD/MM/YYYY HH24:MI:SS') AS hora_publicacao, publicacao.texto, arquivo_midia.nome, arquivo_midia.legenda, usuario_grupo.grupo_id AS Grupo
FROM
    (SELECT lista_amizade.cod AS codigo, usuario.nome AS amigo, usuario.id AS AmigoID
    FROM lista_amizade
        INNER JOIN usuario ON (lista_amizade.seguido_id = usuario.id)) AS tmp
        INNER JOIN lista_amizade ON (tmp.codigo = lista_amizade.cod)
        INNER JOIN usuario ON (lista_amizade.usuario_id = usuario.id)
        INNER JOIN publicacao ON (tmp.AmigoID = publicacao.usuario_id)
        LEFT JOIN arquivo_midia ON (publicacao.id = arquivo_midia.publicacao_id)
        LEFT JOIN usuario_grupo ON (publicacao.usuario_grupo_id = usuario_grupo.grupo_id)
    WHERE usuario.id = 2
        AND lista_amizade.visualisa_feed = 'true'
        AND publicacao.data_hora_criacao BETWEEN (cast(now() AS TIMESTAMP) - cast('7 days' AS interval)) AND cast(now() AS TIMESTAMP))
ORDER BY hora_publicacao DESC; */