DROP DATABASE IF EXISTS igorcorp;

CREATE DATABASE igorcorp;

\c igorcorp;

DROP SCHEMA IF EXISTS venda;
DROP SCHEMA IF EXISTS manutencao;

-- criando um schema
CREATE SCHEMA venda;
-- criando um schema
CREATE SCHEMA manutencao;

-- adicionando o esquema no conjunto de esquemas
SET search_path TO public, venda, manutencao;

-- tabelas do schema public
CREATE TABLE public.cliente (
    id SERIAL PRIMARY KEY,
    nome TEXT
);

-- tabelas do schema venda
CREATE TABLE venda.vendedor (
    id SERIAL PRIMARY KEY,
    nome TEXT
);

CREATE TABLE venda.equipamento (
    id SERIAL PRIMARY KEY,
    descricao TEXT,
    valor REAL,
    disponivel BOOLEAN DEFAULT TRUE
);



CREATE TABLE venda.compra (
    id serial primary key,
    data_compra TIMESTAMP,
    vendedor_id INTEGER REFERENCES venda.vendedor (id),
    cliente_id INTEGER REFERENCES public.cliente (id),    
    equipamento_id INTEGER REFERENCES venda.equipamento (id)
);

CREATE TABLE venda.historico (
    id serial primary key,
    data_compra TIMESTAMP,
    vendedor_nome TEXT,
    cliente_nome TEXT,    
    equipamento_descricao TEXT,
    valor REAL
);

-- tabelas no schema manutencao
CREATE TABLE manutencao.equipamento (
    id SERIAL PRIMARY KEY,
    descricao TEXT    
);

CREATE TABLE manutencao.tecnico (
    id SERIAL PRIMARY KEY,
    nome TEXT
);

CREATE TABLE manutencao.conserto (
    id SERIAL PRIMARY KEY,
    data_conserto TIMESTAMP,
    valor real,
    defeito TEXT,
    solucao TEXT,
    tecnico_id INTEGER REFERENCES manutencao.tecnico (id),
    cliente_id INTEGER REFERENCES public.cliente (id),
    equipamento_id INTEGER REFERENCES manutencao.equipamento (id)
);

-- view criada no schema public.
CREATE VIEW view_venda AS SELECT public.cliente.nome as cliente_nome, venda.vendedor.nome as vendedor_nome, venda.equipamento.descricao FROM public.cliente INNER JOIN venda.compra ON (public.cliente.id = venda.compra.cliente_id) INNER JOIN venda.vendedor ON (venda.vendedor.id = venda.compra.vendedor_id) INNER JOIN venda.equipamento ON (venda.equipamento.id = venda.compra.equipamento_id);

CREATE FUNCTION depois_venda() RETURNS TRIGGER AS
$$
DECLARE
    vendedor_nome TEXT;
    cliente_nome TEXT;
    equipamento_descricao TEXT;
    data_compra TIMESTAMP;
    valor_historico REAL;
BEGIN
    SELECT INTO vendedor_nome nome FROM venda.vendedor WHERE id = NEW.vendedor_id;

    SELECT INTO cliente_nome nome FROM public.cliente WHERE id = NEW.cliente_id;

    SELECT INTO equipamento_descricao, valor_historico descricao, valor FROM venda.equipamento WHERE id = NEW.equipamento_id;

    data_compra := NEW.data_compra;

    INSERT INTO venda.historico (vendedor_nome, cliente_nome, equipamento_descricao, valor, data_compra) VALUES (vendedor_nome, cliente_nome, equipamento_descricao, valor_historico, data_compra);

    UPDATE venda.equipamento SET disponivel = FALSE WHERE id = NEW.equipamento_id;    

    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER depois_venda AFTER INSERT ON venda.compra
FOR EACH ROW EXECUTE PROCEDURE depois_venda();


INSERT INTO venda.vendedor (nome) VALUES ('Pyter');
INSERT INTO manutencao.tecnico (nome) VALUES ('Can');
INSERT INTO public.cliente (nome) VALUES ('Lorrana');
INSERT INTO venda.equipamento (descricao, valor) VALUES ('MP4 TEKPIX', 200);
INSERT INTO venda.compra (data_compra, cliente_id, vendedor_id, equipamento_id) VALUES (CURRENT_TIMESTAMP, 1, 1, 1);







