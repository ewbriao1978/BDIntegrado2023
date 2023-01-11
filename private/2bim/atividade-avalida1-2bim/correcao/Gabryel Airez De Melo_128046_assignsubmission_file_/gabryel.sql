drop DATABASE if EXISTS prova;

create DATABASE prova;

\c prova;

drop table if exists sala cascade;

drop SCHEMA if EXISTS schema_externo cascade;
drop SCHEMA if EXISTS schema_interno cascade;

CREATE SCHEMA schema_externo;
CREATE SCHEMA schema_interno;

drop function if exists validaCPF;

drop view if exists visualizar_sessao;

set search_path TO schema_externo, schema_interno;

CREATE FUNCTION validaCPF(character(11)) RETURNS boolean AS
$$
DECLARE
    resultado BOOLEAN;
    cpf ALIAS FOR $1;
    nro1 INTEGER;
    nro2 INTEGER;  
    nro3 INTEGER;
    nro4 INTEGER;
    nro5 INTEGER;
    nro6 INTEGER;
    nro7 INTEGER;
    nro8 INTEGER;
    nro9 INTEGER;
    nro10 INTEGER;
    nro11 INTEGER;
    soma INTEGER;
    resto INTEGER;
    resultadoDigito1 BOOLEAN;
    resultadoDigito2 BOOLEAN;
BEGIN
    resultado := FALSE;
    resultadoDigito1 := FALSE;
    resultadoDigito2 := FALSE;
    
    IF cpf is NULL THEN
        RETURN FALSE;
    END IF;
    IF LENGTH(cpf) != 11 THEN
        RETURN FALSE;
    END IF;
    IF cpf = '00000000000' or 
		cpf = '11111111111' or 
		cpf = '22222222222' or 
		cpf = '33333333333' or 
		cpf = '44444444444' or 
		cpf = '55555555555' or 
		cpf = '66666666666' or 
		cpf = '77777777777' or 
		cpf = '88888888888' or 
		cpf = '99999999999' THEN
        return FALSE;
    END IF;

    nro1 := SUBSTRING(cpf,1, 1);
    nro2 := SUBSTRING(cpf,2, 1);
    nro3 := SUBSTRING(cpf,3, 1);
    nro4 := SUBSTRING(cpf,4, 1);
    nro5 := SUBSTRING(cpf,5, 1);
    nro6 := SUBSTRING(cpf,6, 1);
    nro7 := SUBSTRING(cpf,7, 1);
    nro8 := SUBSTRING(cpf,8, 1);
    nro9 := SUBSTRING(cpf,9, 1);
    nro10 := SUBSTRING(cpf,10, 1);
    nro11 := SUBSTRING(cpf,11, 1);

    soma := nro1 * 10 + nro2 * 9 + nro3 * 8 + nro4 * 7 + nro5 * 6 + nro6 * 5 + nro7 * 4 + nro8 * 3 + nro9 * 2;
    resto := (soma * 10) % 11;   
    IF resto = 10 THEN
        resto := 0;
    END IF;
    IF resto = nro10 THEN
        resultadoDigito1 := TRUE;
    END IF;
--  DIGITO 2
    soma := nro1 * 11 + nro2 * 10 + nro3 * 9 + nro4 * 8 + nro5 * 7 + nro6 * 6 + nro7 * 5 + nro8 * 4 + nro9 * 3 + nro10 * 2;
    resto := (soma * 10) % 11;   
    IF resto = nro11 THEN
        resultadoDigito2 := TRUE;
    END IF;
    IF resto = nro10 THEN
        resultadoDigito1 := TRUE;
    END IF;
    resultado := resultadoDigito1 AND resultadoDigito2;
    return resultado;
exception
    when others then raise notice 'CPF Inválido.';
    return FALSE;
END;
$$ LANGUAGE 'plpgsql';

create table sala (
    id serial,
    nome text not null,
    capacidade integer check(capacidade > 0),
    primary key(id)
);

create table schema_externo.telespectador (
    id serial,
    cpf char(11) unique check(validaCPF(cpf) IS TRUE),
    nome text not null,
    primary key(id)
);

create table schema_externo.filme (
    id serial,
    titulo text not null,
    duracao integer check (duracao > 0),
    primary key(id)
);

create table schema_externo.sessao (
    id serial,
    filme_id integer,
    sala_id integer,
    data date not null,
    hora time not null,
    foreign key (filme_id) references filme(id),
    foreign key (sala_id) references sala(id),
    primary key(id)
);

create table schema_externo.ingresso (
    id serial,
    telespectador_id integer,
    sessao_id integer,
    valor_ingresso real,
    corredor char(1),
    poltrona integer check(poltrona > 0),
    foreign key(telespectador_id) references telespectador(id),
    foreign key(sessao_id) references sessao(id),
    primary key(id)
);

create table schema_interno.funcionario (
    id serial,
    nome text not null,
    setor text check(setor = 'LIMPEZA' or setor = 'ATENDIMENTO' or setor = 'OPERAÇÃO'),
    primary key(id)
);

create table schema_interno.turno (
    sala_id integer,
    funcionario_id integer,
    data_hora_entrada timestamp default CURRENT_TIMESTAMP,
    data_hora_saida timestamp,
    foreign key (sala_id) references sala(id),
    foreign key (funcionario_id) references funcionario(id)
);

-- teste --

insert into schema_interno.funcionario (nome, setor) values ('GABRIEL', 'LIMPEZA');
insert into schema_interno.funcionario (nome, setor) values ('GUILHERME', 'ATENDIMENTO');
insert into schema_interno.funcionario (nome, setor) values ('JONATAN', 'OPERAÇÃO');

insert into sala (nome, capacidade) values ('CINEPIC 1', 100);
insert into sala (nome, capacidade) values ('CINEPIC 2', 100);

insert into schema_interno.turno (sala_id, funcionario_id, data_hora_entrada, data_hora_saida) values (1,1,'2020-06-01 08:00', '2020-06-01 16:00');
insert into schema_interno.turno (sala_id, funcionario_id, data_hora_entrada, data_hora_saida) values (1,2,'2020-06-02 08:00', '2020-06-02 16:00');
insert into schema_interno.turno (sala_id, funcionario_id, data_hora_entrada, data_hora_saida) values (1,3,'2020-06-03 08:00', '2020-06-03 16:00');

insert into schema_externo.telespectador (cpf, nome) values ('03064462008', 'GABRYEL');
insert into schema_externo.telespectador (cpf, nome) values ('35544635072', 'RENATO');

insert into schema_externo.filme (titulo, duracao) values ('TOP GUN MAVERICK', 2);
insert into schema_externo.filme (titulo, duracao) values ('JURASSIC WOLRD', 1);

insert into schema_externo.sessao (filme_id, sala_id, data, hora) values (1, 1, '2022-06-05', '22:00');
insert into schema_externo.sessao (filme_id, sala_id, data, hora) values (2, 2, '2022-06-05', '22:00');

insert into schema_externo.ingresso (telespectador_id, sessao_id, valor_ingresso, corredor, poltrona) values (1,1, 20, 'G', 15);
insert into schema_externo.ingresso (telespectador_id, sessao_id, valor_ingresso, corredor, poltrona) values (2,2, 25, 'F', 20);

-- teste --

create function salario_mensal(integer, real) returns real as
$$
DECLARE
    id_funcionario ALIAS FOR $1;
    valor_hora ALIAS FOR $2;
    quantidade_horas time;
BEGIN
    if extract(month from schema_interno.turno.data_hora_entrada) and extract(month from schema_interno.turno.data_hora_saida) = extract(month from current_date) THEN
        quantidade_horas := cast(schema_interno.turno.data_hora_saida as time) - cast(schema_interno.turno.data_hora_entrada as time);
    end if;
    RETURN quantidade_horas;
END;
$$ LANGUAGE 'plpgsql';

create function novo_turno(text, text) returns boolean as
$$
DECLARE
    nome_func ALIAS FOR $1;
    setor_func ALIAS FOR $2;
    data_inicio_turno data;
    hora_inicio_turno time;
    sala_inicio integer;
BEGIN
    hora_inicio_turno := '08:00';

    select into data_inicio_turno cast((current_date + cast('1 day' as interval)) + hora_inicio_turno as timestamp) from schema_interno.turno; 
    select into sala_inicio RANDOM(id) from sala;

    RETURN FALSE;
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION novo_turno_trigger() RETURNS TRIGGER as
$$
DECLARE
    resultado timestamp;
BEGIN

    resultado := novo_turno();

    IF (resultado = current_date + cast('1 day' as interval)) THEN
        RAISE NOTICE 'Inicio de turno amanhã às 8h.';
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Erro.';
        RETURN NULL;
    END IF;

END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER novo_turno_trigger BEFORE INSERT OR UPDATE ON schema_interno.turno FOR EACH ROW EXECUTE PROCEDURE novo_turno_trigger();

CREATE VIEW visualizar_sessao AS select sala.nome as sala_nome, schema_externo.filme.titulo as titulo_filme, 
    schema_externo.telespectador.nome as telespectador_nome, to_char(schema_externo.sessao.data, 'DD/MM/YYYY') as data_sessao, schema_externo.sessao.hora as hora_sessao, 
    schema_externo.ingresso.corredor, schema_externo.ingresso.poltrona from sala
    inner join schema_externo.sessao on sessao.sala_id = sala.id
    inner join schema_externo.filme on sessao.filme_id = schema_externo.filme.id
    inner join schema_externo.ingresso on sessao_id = schema_externo.sessao.id
    inner join schema_externo.telespectador on schema_externo.ingresso.telespectador_id = schema_externo.telespectador.id;