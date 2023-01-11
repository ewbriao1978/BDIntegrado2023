DROP DATABASE IF EXISTS noveleiros;

CREATE DATABASE noveleiros;

\c noveleiros;

CREATE TABLE novelas (
    codigo serial primary key,
    nome text,
    data_primeiro_capitulo date,
    data_ultimo_capitulo date,
    horario_exibicao time    
);

CREATE TABLE atores (
    codigo serial primary key,
    nome text,
    idade integer,
    cidade text,
    salario real,
    sexo char(1) check (sexo = 'M' or sexo = 'F')
);

CREATE TABLE personagens (
    codigo serial primary key,
    nome text,
    idade integer,
    situacao_financeira char(1) NOT NULL check(situacao_financeira = 'A' or situacao_financeira = 'B' or situacao_financeira = 'C'),
    cod_ator integer references atores (codigo)
);

CREATE TABLE novelas_personagens (
    cod_novela integer references novelas (codigo),
    cod_personagem integer references personagens (codigo),
    primary key (cod_novela, cod_personagem)
);

CREATE TABLE capitulos (
    codigo serial primary key,
    nome text,
    data_exibicao date,
    cod_novela integer references novelas (codigo)
);

INSERT INTO novelas (nome, data_primeiro_capitulo, data_ultimo_capitulo, horario_exibicao) 
VALUES ('Mulheres de Areia', '1990-01-01', '1990-06-01', '21:00:00');

INSERT INTO novelas (nome, data_primeiro_capitulo, data_ultimo_capitulo, horario_exibicao) 
VALUES ('Mistérios de uma Vida', '2022-01-01', '2022-04-11', '21:00:00');

INSERT INTO novelas (nome, data_primeiro_capitulo, data_ultimo_capitulo, horario_exibicao) 
VALUES ('Vida da gente', '2010-01-01', '2010-04-11', '18:00:00');

INSERT INTO novelas (nome, data_primeiro_capitulo, data_ultimo_capitulo, horario_exibicao) 
VALUES ('Quanto mais vida melhor', '2010-01-01', '2010-04-11', '18:00:00');

INSERT INTO novelas (nome, data_primeiro_capitulo, data_ultimo_capitulo, horario_exibicao) 
VALUES ('Convida a gente', '2010-01-01', '2010-04-11', '18:00:00');

INSERT INTO novelas (nome, data_primeiro_capitulo, data_ultimo_capitulo, horario_exibicao) 
VALUES ('vida', '2010-01-01', '2010-04-11', '18:00:00');


INSERT INTO novelas (nome, data_primeiro_capitulo, data_ultimo_capitulo, horario_exibicao) 
VALUES ('O Clone', '2022-01-01', '2022-04-11', NULL);

INSERT INTO atores (nome, idade, cidade, salario, sexo) VALUES ('Gloria Pires', 50, 'Rio de Janeiro', 50000, 'F');

INSERT INTO atores (nome, idade, cidade, salario, sexo) VALUES ('Antonio Fagundes', 65, 'Marau', 150000, 'M');


INSERT INTO atores (nome, idade, cidade, salario, sexo) VALUES ('Marcos Frota', 65, 'Floripa', 300, 'M');

INSERT INTO atores (nome, idade, cidade, salario, sexo) VALUES ('Alexandre Frota', 50, 'salvador', 150000, 'M');

INSERT INTO personagens (nome, idade, situacao_financeira, cod_ator) VALUES ('Ruth', 50, 'C', 1);
INSERT INTO personagens (nome, idade, situacao_financeira, cod_ator) VALUES ('Tonho da Lua', 30, 'C', 3);

INSERT INTO novelas_personagens (cod_novela, cod_personagem) VALUES (1, 1);
 

-- 2) noveleiros=# SELECT data_ultimo_capitulo FROM novelas WHERE nome = 'Mistérios de uma Vida';
-- 3) noveleiros=# SELECT * FROM novelas WHERE horario_exibicao IS NULL;
-- 4) noveleiros=# SELECT * FROM atores WHERE cidade like 'M%';
-- 5) noveleiros=# SELECT count(*) FROM novelas WHERE nome ilike 'vida %' OR nome ilike '% vida' OR nome ilike '% vida %' or upper(nome) = 'VIDA';
-- 6) noveleiros=# SELECT count(*) FROM atores INNER JOIN personagens ON (atores.codigo = personagens.cod_ator) WHERE atores.nome = 'Gloria Pires';
-- 7) noveleiros=# SELECT nome FROM personagens ORDER BY nome ASC;
-- 8) noveleiros=# SELECT nome, idade FROM personagens ORDER BY idade DESC;
-- 9) noveleiros=# SELECT count(*) FROM atores;
-- 10) noveleiros=# SELECT count(*) FROM novelas;
-- 11) noveleiros=# SELECT count(*) FROM atores WHERE sexo = 'F';
-- 12) noveleiros=# SELECT avg(idade) FROM personagens;
-- 13) noveleiros=# select count(*) from personagens where idade < 15;
-- 14) noveleiros=# SELECT atores.nome FROM atores INNER JOIN personagens ON (atores.codigo = personagens.cod_ator) WHERE atores.idade = personagens.idade;
-- 15) noveleiros=# SELECT atores.nome FROM atores WHERE salario in (select max(salario) FROM atores);
-- 15-off-topic) noveleiros=# SELECT rank () OVER (order by salario desc), atores.nome FROM atores ORDER BY salario desc;
-- 16) noveleiros=# SELECT min(salario) FROM atores;
-- 17) noveleiros=# SELECT sum(salario) FROM atores;


























