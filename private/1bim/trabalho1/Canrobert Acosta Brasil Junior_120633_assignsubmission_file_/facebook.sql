CREATE DATABASE facebook;

\c facebook;

DROP TABLE IF EXISTS midia;
DROP TABLE IF EXISTS publicacao;
DROP TABLE IF EXISTS usuario_grupo;
DROP TABLE IF EXISTS grupo;
DROP TABLE IF EXISTS foto;
DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS amizade;
DROP TABLE IF EXISTS usuario;

CREATE TABLE usuario
(
	idusuario SERIAL PRIMARY KEY,
	nome TEXT NOT NULL,
	senha TEXT NOT NULL,
	email TEXT UNIQUE
);

CREATE TABLE amizade
(
	idamizade SERIAL PRIMARY KEY,
	acompanhando BOOLEAN NOT NULL,
	idusuario1 INTEGER NOT NULL,
	idusuario2 INTEGER NOT NULL,
	FOREIGN KEY ( idusuario1 ) REFERENCES usuario ( idusuario ),
	FOREIGN KEY ( idusuario2 ) REFERENCES usuario ( idusuario )
);

CREATE TABLE album 
(
	idalbum SERIAL PRIMARY KEY,
	nome TEXT NOT NULL,
	titulo TEXT NOT NULL,
	idusuario INTEGER NOT NULL,
	FOREIGN KEY ( idusuario ) REFERENCES usuario ( idusuario )
);

CREATE TABLE foto
(
	idfoto SERIAL PRIMARY KEY,
	legenda TEXT NOT NULL,
	nome_arquivo TEXT NOT NULL,
	idalbum INTEGER NOT NULL,
	FOREIGN KEY ( idalbum ) REFERENCES album ( idalbum )
);

CREATE TABLE grupo
(
	idgrupo SERIAL PRIMARY KEY,
	nome TEXT NOT NULL,
	criacao DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE usuario_grupo
(
	idusuario_grupo SERIAL PRIMARY KEY,
	datahora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	dono BOOLEAN NOT NULL CHECK ( 'TRUE' OR 'FALSE'),
	idgrupo INTEGER NOT NULL,
	idusuario INTEGER NOT NULL,
	FOREIGN KEY ( idgrupo ) REFERENCES grupo ( idgrupo ),
	FOREIGN KEY ( idusuario ) REFERENCES usuario ( idusuario )
);

CREATE TABLE publicacao
(
	idpublicacao SERIAL PRIMARY KEY,
	data_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	texto TEXT NOT NULL,
	idusuario INTEGER NOT NULL,
	idgrupo INTEGER,
	FOREIGN KEY (  idusuario ) REFERENCES usuario ( idusuario ),
	FOREIGN KEY (  idgrupo ) REFERENCES grupo ( idgrupo )
);

CREATE TABLE midia
(
	idmidia SERIAL PRIMARY KEY,
	nome TEXT NOT NULL,
	legenda TEXT NOT NULL,
	idpublicacao INTEGER NOT NULL,
	FOREIGN KEY (  idpublicacao ) REFERENCES publicacao ( idpublicacao )
);

INSERT INTO usuario ( nome, senha, email ) VALUES ( 'CANROBERT', MD5 ( 'teste' ), 'teste@test.com.br' );
INSERT INTO usuario ( nome, senha, email ) VALUES ( 'JOAO', MD5 ( 'jojo123' ), 'joao@teste.com.br' );
INSERT INTO usuario ( nome, senha, email ) VALUES ( 'MARIA', MD5 ( 'mary123' ), 'maria@teste.com.br' );

INSERT INTO amizade ( acompanhando, idusuario1, idusuario2 ) VALUES ( 'TRUE', 1, 3 );
INSERT INTO amizade ( acompanhando, idusuario1, idusuario2 ) VALUES ( 'FALSE', 1, 2 );
INSERT INTO amizade ( acompanhando, idusuario1, idusuario2 ) VALUES ( 'TRUE', 2, 3 );

INSERT INTO grupo ( nome, criacao ) VALUES ( 'Alunos do IFRS - Rio Grande', '2022-03-04');

INSERT INTO usuario_grupo ( datahora, dono, idgrupo, idusuario ) VALUES ( '2022-03-04 14:32:00', 'TRUE', 1, 1 );
INSERT INTO usuario_grupo ( datahora, dono, idgrupo, idusuario ) VALUES ( '2022-03-05 02:00:00', 'FALSE', 1, 2 );
INSERT INTO usuario_grupo ( datahora, dono, idgrupo, idusuario ) VALUES ( '2022-03-05 12:00:00', 'FALSE', 1, 3 );

INSERT INTO publicacao ( data_hora, texto, idusuario ) VALUES ( '2022-03-01 11:22:00', 'Lorem ipsum dolor', 3 );
INSERT INTO publicacao ( data_hora, texto, idusuario ) VALUES ( '2022-03-02 12:10:00', 'egestas quis varius in', 3 );
INSERT INTO publicacao ( data_hora, texto, idusuario, idgrupo ) VALUES ( '2022-03-04 14:35:00', 'Nulla et rutrum nibh', 3, 1 );
INSERT INTO publicacao ( texto, idusuario ) VALUES ( 'Donec diam est', 2 );

INSERT INTO midia ( nome, legenda, idpublicacao ) VALUES ( 'foto_bichinho_fofinho', 'Praesent luctus sagittis lacus', 2 );

/*SELECT RESPOSTA*/

SELECT * 
FROM usuario
	JOIN amizade 
		ON usuario.idusuario = amizade.idusuario1
	JOIN publicacao 
		ON amizade.idusuario2 = publicacao.idusuario
	LEFT JOIN midia 
		ON publicacao.idpublicacao = midia.idpublicacao
	FULL OUTER JOIN grupo 
		ON publicacao.idgrupo = grupo.idgrupo
WHERE usuario.idusuario = 1
	AND amizade.acompanhando = 'TRUE'
ORDER BY 
	publicacao.idpublicacao ASC
