-- 1) implemente no SGBD PostgreSQL o banco de dados projetado pelo modelo relacional abaixo.
-- Obs: respeite nomes de tabelas/colunas, restrições de integridade e definição de schemas.

DROP DATABASE IF EXISTS cinema_prova;
CREATE DATABASE cinema_prova;

-- conectando ao banco
\c cinema_prova;

DROP SCHEMA IF EXISTS externo;
DROP SCHEMA IF EXISTS interno;

-- criando um schema
CREATE SCHEMA externo;
-- criando um schema
CREATE SCHEMA interno;

-- adicionando o esquema no conjunto de esquemas
SET search_path TO public, externo, interno;

CREATE TABLE externo.telespectador (
	id SERIAL PRIMARY KEY,
	nome TEXT NOT NULL,
	cpf CHARACTER(11),
	UNIQUE(cpf)
);

CREATE TABLE externo.filme (
	id SERIAL PRIMARY KEY,
	titulo TEXT NOT NULL,
	ano_lancamento integer,
	duracao integer check(duracao > 0)
);

CREATE TABLE public.sala (
	id serial primary key,
	nome text not null,
	capacidade integer check (capacidade > 0) 
);

CREATE TABLE externo.sessao (
	id serial primary key,
	data date NOT NULL,
	hora time NOT NULL,
	filme_id integer references filme (id),
	sala_id integer references sala (id)
);
	
CREATE TABLE externo.ingresso (
	id SERIAL PRIMARY KEY,
	telespectador_id integer references telespectador (id),
	sessao_id integer references sessao (id),
	valor_ingresso real,
	corredor character(1) NOT NULL,
	poltrona integer check (poltrona > 0)
);

CREATE TABLE interno.funcionario (
	id serial primary key,
	nome text not null,
	setor text check (setor = 'LIMPEZA' or setor = 'ATENDIMENTO' or setor = 'OPERAÇÃO')
);

CREATE TABLE interno.turno (
	sala_id integer references sala (id),
	funcionario_id integer references funcionario (id),
	data_hora_entrada timestamp DEFAULT CURRENT_TIMESTAMP,
	data_hora_saida timestamp,
	primary key (sala_id, funcionario_id, data_hora_entrada)
);

INSERT INTO externo.telespectador (nome, cpf) VALUES
('igor', '01763917037'),
('nanah', '17658586072');

INSERT INTO externo.filme (titulo, duracao) VALUES
('TOP GUN: Maverick', 90),
('THE BATMAN', 120);

INSERT INTO public.sala (nome, capacidade) VALUES 
('4k', 100),
('8k', 200);

INSERT INTO externo.sessao (filme_id, sala_id, data, hora) VALUES
(1, 1, CURRENT_DATE, '08:00'),
(2, 1, CURRENT_DATE, '10:00');


INSERT INTO externo.ingresso (sessao_id, telespectador_id, corredor, poltrona) VALUES 
(1, 1, 'A', 1),
(1, 2, 'B', 1);


INSERT INTO interno.funcionario (nome, setor) VALUES 
('joao', 'LIMPEZA'),
('ana', 'ATENDIMENTO'),
('pedro', 'OPERAÇÃO');

INSERT INTO interno.turno (sala_id, funcionario_id, data_hora_entrada, data_hora_saida) VALUES
(1,1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + (60 ||' minutes')::interval),
(1,2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + (120 ||' minutes')::interval),
(1,3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + (180 ||' minutes')::interval),
(1,1, CURRENT_TIMESTAMP+ (61 ||' minutes')::interval, CURRENT_TIMESTAMP+ (300 ||' minutes')::interval);

-- 2) Construa um stored procedure de checagem de cpf para a coluna cpf da tabela telespectador.
-- Obs: Será precisa acrescentar a clásula (check) para esta coluna
-- Obs: A função construída nas aulas pode ser usada. Se não tiver a função em mãos, será preciso implementá-la novamente do zero.

-- 3) Crie um STORED PROCEDURE para calcular o salário de um determinado funcionário, mediante o nro de horas trabalhadas por ele no mês corrente
-- Este stored procedure deve ter como parâmetros: o id do funcionário e o valor da hora trabalhada
-- Funcionários da LIMPEZA ganham R$ 10 por hora trabalhada, ATENDIMENTO R$ 15 e OPERAÇÃO R$ 20.
-- Pra facilitar o cálculo do salário, considere somente horas inteiras de cada turno de trabalho. EX: em um turno que durou 3 horas, 30 minutos e 45 segundos somente as 3 horas devem ser consideradas para o cálculo.
-- Para isso, insira no B.D pelo menos um funcionário de cada setor (LIMPEZA, ATENDIMENTO ou OPERAÇÃO) e 3 turnos diferentes de trabalho para cada funcionário em 2 meses diferentes. 
CREATE FUNCTION calcula_salario(func_id integer, valor_por_hora integer) RETURNS real AS
$$
DECLARE
	mes_corrente integer;
	horas integer;
	registro record;
BEGIN
	mes_corrente := extract(month from CURRENT_DATE);
	horas := 0;
	FOR registro in	SELECT *,  data_hora_saida - data_hora_entrada as horas_trabalhadas FROM interno.turno WHERE funcionario_id = func_id AND extract(month from data_hora_entrada) = mes_corrente AND extract(month from data_hora_saida) = mes_corrente LOOP
		horas := horas + extract(hour from registro.horas_trabalhadas);	
	END LOOP;
	RETURN horas*valor_por_hora;
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION calcula_salario2(func_id integer, valor_por_hora integer) RETURNS real AS
$$
DECLARE
	registro RECORD;
BEGIN
	SELECT INTO registro funcionario_id, (extract(hour from sum(data_hora_saida - data_hora_entrada))*valor_por_hora) as salario FROM interno.turno WHERE funcionario_id = func_id and extract(month FROM data_hora_saida) = extract(month from CURRENT_TIMESTAMP) and extract(month FROM data_hora_entrada) = extract(month from CURRENT_TIMESTAMP) group by funcionario_id;
	RETURN registro.salario;
END;
$$ LANGUAGE 'plpgsql';

-- 4) Construa uma trigger que, a cada novo funcionário, crie um novo turno de trabalho para este funcionário recém cadastrado.
-- Este novo turno deve começar no dia seguinte ao dia atual do cadastramento/inserção e começar as 08:00 (oito da manhã).
-- A sala onde este funcionário irá trabalhar em seu primeiro turno de trabalho deve ser escolhida aleatoriamente entre as salas já existentes. 
-- Obs: Os tipos das colunas da tabela turno (que representa o turno de trabalho) não devem ser alterados.
CREATE FUNCTION atribui_primeiro_turno() RETURNS trigger AS
$$
DECLARE
	salaID integer;
	turno text;
BEGIN	
	turno := replace(cast(CURRENT_DATE + INTERVAL '1 day' as text), '00:00:00', '') || '08:00:00';
	SELECT INTO salaID id FROM sala ORDER BY srandom() LIMIT 1;
	INSERT INTO interno.turno (sala_id, funcionario_id, data_hora_entrada) VALUES 
	(salaID, NEW.id, cast(turno as timestamp));
	RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER atribui_primeiro_turno AFTER INSERT ON interno.funcionario FOR EACH ROW EXECUTE PROCEDURE atribui_primeiro_turno();

-- 5) Crie uma view que retorne o nome da sala, o titulo do filme, o nome do telespectador, seu corredor, sua poltrona e o dia e hora da sessão
CREATE VIEW view_sessao AS SELECT public.sala.nome as sala_nome, externo.filme.titulo as filme_titulo, externo.telespectador.nome as telespectador_nome, externo.sessao.data, externo.sessao.hora, externo.ingresso.corredor, externo.ingresso.poltrona FROM externo.ingresso INNER JOIN externo.sessao ON (externo.ingresso.sessao_id = externo.sessao.id) INNER JOIN public.sala ON (public.sala.id = externo.sessao.sala_id) INNER JOIN externo.filme ON (externo.filme.id = externo.sessao.filme_id) INNER JOIN externo.telespectador ON (externo.telespectador.id = externo.ingresso.telespectador_id);


