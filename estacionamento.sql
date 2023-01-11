DROP DATABASE IF EXISTS estacionamento;

CREATE DATABASE estacionamento;

\c estacionamento;

CREATE TABLE cliente (
    cpf character(11) NOT NULL primary key,
    nome text,
    data_nascimento date,
    endereco text
);

CREATE TABLE modelo (
    id serial primary key,
    descricao text not null
);

CREATE TABLE veiculo (
    placa character(7) NOT NULL primary key,
    cor text,
    ano integer,
    modelo_id integer references modelo (id),
    cliente_cpf character(11) references cliente (cpf)
);

CREATE TABLE andar (
    num serial primary key,
    capacidade integer not null
);

CREATE TABLE estacionamento (
    id serial primary key,
    data_hora_entrada timestamp DEFAULT CURRENT_TIMESTAMP,
    data_hora_saida timestamp,    
    andar_num integer references andar (num),
    veiculo_placa character(7) references veiculo (placa)    
);


INSERT INTO modelo (descricao) VALUES 
('Kombi'),
('Fusca'),
('Brasilia');

INSERT INTO cliente (cpf, nome) VALUES 
('11111111111', 'Geraldo'),
('22222222222', 'Nicole'),
('33333333333', 'Deise');

INSERT INTO veiculo (placa, cor, modelo_id, cliente_cpf) VALUES
('ixl3434', 'preta', 1, '11111111111'),
('JJJ2020', 'vermelha', 2, '22222222222'),
('iuy8990', 'prata', 3, '33333333333'),
('izy6767', 'verde', 2, '11111111111'),
('izy5567', 'verde', 3, '11111111111');

INSERT INTO andar (capacidade) VALUES 
(100),
(200),
(300);

INSERT INTO estacionamento (andar_num, veiculo_placa) VALUES 
(1,'ixl3434'),
(2, 'JJJ2020'),
(2, 'iuy8990'),
(3, 'izy6767'),
(3, 'izy5567');

-- a)  SELECT cliente.nome, veiculo.placa FROM cliente INNER JOIN veiculo ON (cliente.cpf = veiculo.cliente_cpf);
-- b)  SELECT cliente.cpf, cliente.nome FROM cliente INNER JOIN veiculo ON (cliente.cpf = veiculo.cliente_cpf) WHERE veiculo.placa = 'JJJ2020';
-- c)  SELECT veiculo.placa, veiculo.cor FROM estacionamento INNER JOIN veiculo ON (estacionamento.veiculo_placa = veiculo.placa) WHERE estacionamento.id = 1;
-- d)  SELECT veiculo.placa, veiculo.ano FROM estacionamento INNER JOIN veiculo ON (estacionamento.veiculo_placa = veiculo.placa) WHERE veiculo.ano >= 2000;
-- e)  SELECT cliente.endereco, estacionamento.data_hora_entrada, estacionamento.data_hora_saida FROM cliente INNER JOIN veiculo ON (cliente.cpf = veiculo.cliente_cpf) INNER JOIN estacionamento ON (estacionamento.veiculo_placa = veiculo.placa) WHERE veiculo.placa = 'ixl3434';
-- f)  SELECT veiculo.cor, count(*) FROM estacionamento INNER JOIN veiculo ON (estacionamento.veiculo_placa = veiculo.placa) WHERE veiculo.cor = 'verde' GROUP BY veiculo.cor;
-- g)  SELECT cliente.nome, modelo.descricao FROM cliente INNER JOIN veiculo ON (cliente.cpf = veiculo.cliente_cpf) INNER JOIN modelo ON (modelo.id = veiculo.modelo_id) WHERE modelo.id = 1;
-- h)  SELECT estacionamento.id, estacionamento.andar_num, estacionamento.data_hora_entrada, estacionamento.data_hora_saida FROM veiculo INNER JOIN estacionamento ON (veiculo.placa = estacionamento.veiculo_placa) WHERE veiculo.placa = 'JJJ2020';
-- j)  SELECT estacionamento.id, cliente.nome FROM cliente INNER JOIN veiculo ON (cliente.cpf = veiculo.cliente_cpf) INNER JOIN estacionamento ON (estacionamento.veiculo_placa = veiculo.placa) WHERE estacionamento.id = 2;
-- n)  SELECT veiculo.placa, cliente.nome, modelo.descricao FROM cliente INNER JOIN veiculo ON (cliente.cpf = veiculo.cliente_cpf) INNER JOIN modelo ON (veiculo.modelo_id = modelo.id);






















