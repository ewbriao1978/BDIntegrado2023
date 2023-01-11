DROP DATABASE IF EXISTS seguradora;
CREATE DATABASE seguradora;

\c seguradora;

CREATE TABLE cliente (
    cpf character(11) primary key,
    cnh text,
    nome text,
    endereco text,
    telefone text
);

CREATE TABLE carro (
    chassi character(17) primary key,
    placa character(7),
    kilometros real,
    descricao text,
    cliente_cpf character(11) references cliente (cpf)
);

CREATE TABLE acidente (
    id serial primary key,
    valor real,
    hora time,
    data date,
    local text,
    descricao text,
    carro_chassi character(17) references carro (chassi)    
);


INSERT INTO cliente (cpf, cnh, nome, endereco, telefone) VALUES
('11111111111','1000/Igor' , 'Igor', 'Alfredo Huch', '(53) 99999999'),
('22222222222','2000/Denise' ,'Denise', 'Jardim do sol', '(53) 88888888'),
('33333333333', '3000/Nicole','Nicole', 'Cassino', '(53) 77777777'),
('44444444444', '4000/Denis','Denis', 'pelotas', '(53) 6666666666');

INSERT INTO carro (chassi, placa, kilometros, descricao, cliente_cpf) VALUES
('11111111111111111','ixl9090', 10000, 'celta', '11111111111'),
('22222222222222222','isl8081', 20000, 'ford ka', '22222222222'),
('44444444444444444','ity1234', 100000, 'fusca', '44444444444'),
('33333333333333333','iws7784', 30000, 'gol bolinha', '33333333333');

INSERT INTO acidente (valor, hora, data, local, descricao, carro_chassi) VALUES 
(10000, '20:00', '2022-04-11', 'vila maria', 'muito violento o acidente', '11111111111111111'),
(15000, '21:00', '2022-04-10', 'parque sao pedro', 'leves danos', '11111111111111111'),
(20000, '22:00', '2022-04-09', 'bgv', 'colisão frontal','33333333333333333'),
(5000, '19:00',  '2022-04-08', 'bgv2', 'colisão frontal2 pra empatar','33333333333333333'),
(20000, '22:00', '2013-04-09', '24 de maio', 'onibus com ciclista','33333333333333333'),
(30000, '21:00', '2013-12-12', 'av. presidente vargas', 'caminhão com ford de ka','22222222222222222'),
(20000, '22:00', '2016-04-09', 'bgv', 'colisão frontal','33333333333333333'),
(50000, '20:00', '2012-04-11', 'cidade nova', 'acidente muito caro para seguradora', '11111111111111111');


-- 2) seguradora=# SELECT acidente.* FROM acidente INNER JOIN carro ON (acidente.carro_chassi = carro.chassi) INNER JOIN cliente ON (cliente.cpf = carro.cliente_cpf) WHERE cliente.nome = 'Igor';
-- neste caso, acidentes que envolvem veiculos do proprietario Igor
-- 3) seguradora=# select count(*) from acidente WHERE data BETWEEN '2022-04-01' AND '2022-05-01';
-- neste caso, acidentes entre abril e maio
-- 4) seguradora=# DELETE FROM acidente WHERE data < current_date-cast('5 YEAR' as interval);
-- neste caso, excluir acidente mais antigos que 5 anos da nota atual.
-- off-topic: SELECT extract(year from cast(current_timestamp as date)), extract(month from cast(current_timestamp as date)); 
-- 5) opcao 1: seguradora=# SELECT cliente.nome, acidente.valor, acidente.data FROM cliente INNER JOIN carro ON (cliente.cpf = carro.cliente_cpf) INNER JOIN acidente ON (acidente.carro_chassi = carro.chassi) WHERE acidente.data BETWEEN '2013-01-01' AND '2013-12-31';
-- 5) opcao 2: seguradora=# SELECT cliente.nome, acidente.valor, acidente.data FROM cliente INNER JOIN carro ON (cliente.cpf = carro.cliente_cpf) INNER JOIN acidente ON (acidente.carro_chassi = carro.chassi) WHERE extract(year from  acidente.data) = 2013;
-- 6) seguradora=# SELECT cliente.nome, acidente.valor, acidente.data FROM cliente INNER JOIN carro ON (cliente.cpf = carro.cliente_cpf) INNER JOIN acidente ON (acidente.carro_chassi = carro.chassi) WHERE (extract(year from  acidente.data) BETWEEN 2012 AND 2013) AND acidente.valor >= 50000;
-- 7) seguradora=#  SELECT carro.placa, sum(acidente.valor) FROM carro INNER JOIN acidente ON (acidente.carro_chassi = carro.chassi) WHERE extract(year from  acidente.data) = 2022 GROUP BY carro.placa HAVING sum(acidente.valor) in (SELECT sum(acidente.valor) FROM carro INNER JOIN acidente ON (acidente.carro_chassi = carro.chassi) WHERE extract(year from  acidente.data) = 2022  GROUP BY carro.placa order by sum(acidente.valor) desc limit 1 )  ORDER BY sum(acidente.valor) DESC;
-- 8) opcao 1: seguradora=# SELECT DISTINCT cliente.nome FROM cliente FULL JOIN carro ON (cliente.cpf = carro.cliente_cpf) FULL JOIN  acidente  ON(acidente.carro_chassi = carro.chassi) EXCEPT SELECT DISTINCT cliente.nome FROM cliente FULL JOIN carro ON (cliente.cpf = carro.cliente_cpf) FULL JOIN acidente  ON(acidente.carro_chassi = carro.chassi) WHERE (extract(year from acidente.data) BETWEEN 2011 AND 2013);
-- 8) opcao 2: seguradora=# SELECT DISTINCT cliente.nome FROM cliente FULL JOIN carro ON (cliente.cpf = carro.cliente_cpf) FULL JOIN acidente  ON(acidente.carro_chassi = carro.chassi) WHERE cpf not in (SELECT DISTINCT cliente.cpf FROM cliente FULL JOIN carro ON (cliente.cpf = carro.cliente_cpf) FULL JOIN acidente  ON(acidente.carro_chassi = carro.chassi) WHERE (extract(year from acidente.data) BETWEEN 2011 AND 2013)); 


































