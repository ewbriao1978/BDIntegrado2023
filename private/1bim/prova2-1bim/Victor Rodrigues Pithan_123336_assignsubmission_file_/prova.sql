DROP DATABASE IF EXISTS prova;

CREATE DATABASE prova;

\c prova;

CREATE TABLE autor (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL
);

CREATE TABLE musica (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    duracao TIME
);

CREATE TABLE gravadora (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    endereco TEXT,
    telefone TEXT,
    contato TEXT,
    site TEXT
);

CREATE TABLE cd (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    data_lancamento DATE DEFAULT NOW(),
    preco REAL CHECK(preco > 0),
    cd_indicado INTEGER REFERENCES cd(id) CHECK (cd_indicado != id),
    gravadora_id INTEGER REFERENCES gravadora(id)
);

CREATE TABLE autor_musica (
    id SERIAL PRIMARY KEY,
    autor_id INTEGER REFERENCES autor (id),
    musica_id INTEGER REFERENCES musica (id)
);

CREATE TABLE musica_cd (
    musica_id INTEGER REFERENCES musica (id),
    cd_id INTEGER REFERENCES cd (id),
    numero_faixa INTEGER NOT NULL,
    PRIMARY KEY (musica_id, cd_id)
);

INSERT INTO autor (nome) VALUES
    ('Renato Russo'),
    ('Jorge Aragão'),
    ('Anitta'),
    ('Alexandre Pires');

INSERT INTO musica (nome, duracao) VALUES
    ('Geração Coca-Cola', '00:04:32'),
    ('Faroeste Caboclo', '00:08:42'),
    ('Diga onde você vai, que eu vou varrendo', '00:03:15'),
    ('Funk ...', '00:04:10'),
    ('Alecrim Dourado', '00:03:00'),
    ('Samba ...', '00:05:10'),
    ('Loren loren ...', '00:10:00');

INSERT INTO gravadora (nome, endereco, telefone, contato, site) VALUES
    ('SONY', 'RUA DAS LARANJEIRAS, 1801', '(51) 999999999', 'sony@email.com', 'www.sony.com'),
    ('ENTERPRING', 'RUA DOS ESQUECIDOS, 758', '(51) 888888888', 'enterprising@email.com', 'www.enterprising.com'),
    ('MUSIC', 'RUA GENERAL MASCHERANO, 968', '(51) 7777777', 'music@email.com', 'www.music.com'),
    ('GENERATIONS', 'RUA SILVA PAES, 369', '(51) 666666666', 'generations@email.com', 'www.generations.com');

INSERT INTO cd (nome, data_lancamento, preco, cd_indicado, gravadora_id) VALUES
    ('RENATO RUSSO PARA SEMPRE', '1996-01-01', 120, NULL, 1),
    ('GRUPO DO PAGODE', '1999-12-15', 60, 1, 4),
    ('SOLTA O GRAVE', '2018-05-07', 110, 2, 2),
    ('GALINHA PINTADINHA', '2020-04-01', 200, 3, 3),
    ('Funk da Anita', '2020-04-01', 150, 3, 2);

INSERT INTO autor_musica (autor_id, musica_id) VALUES
    -- RENATO RUSSO
    (1, 1),
    (1, 2),
    -- JORGE ARAGÃO
    (2, 6),
    -- ANITA
    (3, 4),
    -- ALEXANDRE PIRES
    (4, 3),
    (4,6),

    (NULL, 7);

INSERT INTO musica_cd (musica_id, cd_id, numero_faixa) VALUES
    (1, 1, 1),
    (2, 1, 2),
    (3, 2, 1),
    (4, 3, 1),
    (5, 4, 1),
    (6, 2, 1),
    (4, 5, 1);

 -- 5) SELECT autor.nome FROM autor WHERE autor.nome ilike 'R%O';

 -- 6) SELECT musica.nome FROM musica INNER JOIN autor_musica ON (musica.id = autor_musica.musica_id) WHERE autor_musica.autor_id is null;

 -- 7) SELECT cd.nome, cd.data_lancamento FROM cd WHERE cd.data_lancamento BETWEEN '1995-01-01' AND '2000-12-31';

 -- 8) SELECT gravadora.nome, AVG(cd.preco) AS preco_medio, MAX(cd.preco) AS preco_maximo, MIN(cd.preco) AS preco_minimo, count(gravadora.nome) AS qtd_cd FROM gravadora INNER JOIN cd ON (gravadora.id = cd.gravadora_id) GROUP BY gravadora.nome;

 -- 9) SELECT musica.nome, count(*) AS qtd_autor FROM musica INNER JOIN autor_musica ON (musica.id = autor_musica.musica_id) INNER JOIN autor ON (autor_musica.autor_id = autor.id) GROUP BY musica.nome;