-- 3ª Modelagem Física (Implementação)

DROP DATABASE IF EXISTS empresa;

CREATE DATABASE empresa;

\c empresa;

CREATE TABLE fornecedor (
    cnpj text primary key,
    razao_social text,
    endereco text,
    cidade text
);

CREATE TABLE produto (
    codigo serial primary key,
    descricao text,
    valor real,
    estoque integer,
    fornecedor_cnpj text references fornecedor (cnpj)
);

CREATE TABLE cliente (
    id serial primary key,
    nome text,
    cidade text,
    endereco text    
);


CREATE TABLE nota (
    numero integer primary key,
    data date,
    tipo_pagamento text,
    cliente_id integer references cliente (id)
);

CREATE TABLE item (
    qtde integer,
    produto_codigo integer references produto (codigo),
    nota_numero integer references nota (numero)
);

INSERT INTO fornecedor (cnpj, razao_social, endereco, cidade) VALUES 
('1762409200018', 'Alpha Soluções em Informática',	'Rua 9 de Julho, 738',	'Marília'),
('47132482000176', 'MicroSystem Informática',	'Av. da Saudade, 98',	'Bauru'),
('56021482000112',	'J.W. Sistemas', 'Rua Paes	Leme, 172', 'Marília'),
('17624092000185',	'Igor Corporation LTDA', 'Presidente vargas', 'Rio Grande'),
('27385372000136', 'ADABAS S/A', 'Rua 9 de Julho, 829', 'Marília');

INSERT INTO cliente (nome, endereco, cidade) VALUES 
('Francisco Santos','Rua XV de Novembro, 16', NULL),	
('Claudete Pereira', NULL, NULL),
('José Souza', 'Rua das Bromélias, 871', NULL),	
('Sônia Santos Oliveira', NULL, 'Bauru');


INSERT INTO produto (codigo, descricao, estoque, valor, fornecedor_cnpj) VALUES
(100, 'Micro Pentium IV', 14, 850, '56021482000112'),
(200, 'Impressora EPSON', 8	, 280, '27385372000136'),
(300, 'Scanner Genius', 9, 190,  NULL),
(400, 'Disquete 3M', 30,  10,  '17624092000185');

INSERT INTO nota (numero, data, tipo_pagamento, cliente_id) VALUES 
(1001, '2002-05-18', 'A Vista', 2),
(1002, '2002-05-18', 'A Vista', NULL),
(1003, '2002-05-19', 'A Prazo', 4),
(1004, '2002-05-20', 'A Vista', 3),
(1005, '2002-05-20', 'A Vista', 3);


INSERT INTO item (nota_numero, produto_codigo, qtde) VALUES 
(1001, 100, 1),
(1001, 400, 5),
(1002, 200, 1),
(1003, 300, 1),
(1004, 200, 2),
(1004, 300, 1),
(1005, 200, 2);


-- 1) empresa=# SELECT produto.estoque, produto.descricao, fornecedor.razao_social FROM fornecedor INNER JOIN produto ON (fornecedor.cnpj = produto.fornecedor_cnpj);
-- 2) empresa=# SELECT nota.numero, nota.data, cliente.nome, sum(produto.valor * item.qtde) FROM cliente INNER JOIN nota ON (nota.cliente_id = cliente.id) INNER JOIN item ON (nota.numero = item.nota_numero) INNER JOIN produto ON (item.produto_codigo = produto.codigo) GROUP BY nota.numero, nota.data, cliente.nome;
-- 3) empresa=# SELECT cliente.nome, sum(produto.valor * item.qtde) FROM cliente INNER JOIN nota ON (nota.cliente_id = cliente.id) INNER JOIN item ON (nota.numero = item.nota_numero) INNER JOIN produto ON (item.produto_codigo = produto.codigo) GROUP BY cliente.nome;
-- 4) SELECT fornecedor.razao_social FROM fornecedor LEFT JOIN produto ON (produto.fornecedor_cnpj = fornecedor.cnpj) EXCEPT SELECT fornecedor.razao_social FROM fornecedor INNER JOIN produto ON (produto.fornecedor_cnpj = fornecedor.cnpj); 
-- 5) empresa=# SELECT nota.tipo_pagamento, sum(produto.valor * item.qtde) FROM cliente INNER JOIN nota ON (nota.cliente_id = cliente.id) INNER JOIN item ON (nota.numero = item.nota_numero) INNER JOIN produto ON (item.produto_codigo = produto.codigo) GROUP BY nota.tipo_pagamento;






















