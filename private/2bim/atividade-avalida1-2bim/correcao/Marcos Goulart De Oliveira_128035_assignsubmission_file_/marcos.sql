drop database if exists exercicio1;
create database exercicio1;

drop schema if exists externo;
drop schema if exists interno;

create schema externo;
create schema interno;

set search_path to public, externo, interno;

drop table if exists turno;
drop table if exists funcionario;
drop table if exists ingresso;
drop table if exists sessao;
drop table if exists sala;
drop table if exists filme;
drop table if exists telespectador;

CREATE OR REPLACE FUNCTION validaCPF(cpf text) RETURNS boolean AS
$$
    DECLARE
        num1 INTEGER;
        num2 INTEGER;
        num3 INTEGER;
        num4 INTEGER;
        num5 INTEGER;
        num6 INTEGER;
        num7 INTEGER;
        num8 INTEGER;
        num9 INTEGER;
        num10 INTEGER;
        num11 INTEGER;
        soma1 INTEGER;
        soma2 INTEGER;
        resto1 REAL;
        resto2 REAL;
        eh_igual BOOLEAN DEFAULT FALSE;
    BEGIN
        num1 := CAST(substring(cpf from 1 for 1) AS INTEGER);
        num2 := CAST(substring(cpf from 2 for 1) AS INTEGER);
        num3 := CAST(substring(cpf from 3 for 1) AS INTEGER);
        num4 := CAST(substring(cpf from 4 for 1) AS INTEGER);
        num5 := CAST(substring(cpf from 5 for 1) AS INTEGER);
        num6 := CAST(substring(cpf from 6 for 1) AS INTEGER);
        num7 := CAST(substring(cpf from 7 for 1) AS INTEGER);
        num8 := CAST(substring(cpf from 8 for 1) AS INTEGER);
        num9 := CAST(substring(cpf from 9 for 1) AS INTEGER);
        num10 := CAST(substring(cpf from 10 for 1) AS INTEGER);
        num11 := CAST(substring(cpf from 11 for 1) AS INTEGER);
        soma1 := num1 * 10 + num2 * 9 + num3 * 8 + num4 * 7 + num5 * 6 + num6 * 5 +
        num7 * 4 + num8 * 3 + num9 * 2;
        resto1 := (soma1 * 10) % 11;
        IF resto1 = 10 THEN
            resto1 := 0;
        END IF;

        soma2 := num1 * 11 + num2 * 10 + num3 * 9 + num4 * 8 + num5 * 7 + num6 * 6 + num7 * 5 + num8 * 4 + num9 * 3 + num10 * 2;resto2 := (soma2 * 10) % 11;
        
        IF (resto2 = 10) THEN
            resto2 := 0;
        END IF;

        IF ((num1 = num2) AND (num1 = num3) AND (num1 = num4) AND (num1 = num5) AND (num1 = num6) AND (num1 = num7) AND (num1 = num8) AND (num1 = num9) AND (num1 = num10) AND (num1 = num11)) THEN
            eh_igual := TRUE;
        END IF;
        IF ((resto1 = num10) AND (resto2 = num11) AND (eh_igual = FALSE)) THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END
$$ LANGUAGE 'plpgsql';

create table externo.telespectador(
    id serial primary key,
    cpf character(11) unique check(validaCPF(cpf) = true),
    nome text not null
);

create table externo.filme(
    id serial primary key,
    titulo text not null,
    duracao integer check(duracao > 0)
);

create table public.sala(
    id serial primary key,
    nome text not null,
    capacidade integer check(capacidade > 0)
);

create table externo.sessao(
    id serial primary key,
    filme_id integer references filme(id),
    sala_id integer references sala(id),
    data date not null,
    hora time not null
);

create table externo.ingresso(
    id serial primary key,
    telespectador_id integer references telespectador(id),
    sessao_id integer references sessao(id),
    valor_ingresso real,
    corredor character(1) not null,
    poltrona integer check (poltrona > 0)
);

create table interno.funcionario(
    id serial primary key,
    nome text not null,
    setor text check (setor = 'LIMPEZA' or setor = 'ATENDIMENTO' or setor = 'OPERAÇÃO')
);

create table interno.turno(
    sala_id integer references sala(id),
    funcionario_id integer references funcionario(id),
    data_hora_entrada timestamp default current_timestamp,
    data_hora_saida timestamp,
    primary key (sala_id, funcionario_id, data_hora_entrada)
);

create or replace function calcula_salario(integer) returns numeric(10, 2) as 
$$ 
    declare
        valor_hora integer;
        setor text;
        horas_trabalhadas integer;
        salario numeric(10,2);
    begin
        select into setor funcionario.setor from funcionario where id = $1;
        if setor = 'LIMPEZA' then
            valor_hora := 10;
	end if;
        if setor = 'ATENDIMENTO' then
            valor_hora := 15;
	end if;
	if setor = 'OPERAÇÃO' then 
            valor_hora := 20;
        end if;

        select into horas_trabalhadas sum(extract(hours from data_hora_saida - data_hora_entrada)) from turno where funcionario_id = $1 and (extract(month from data_hora_entrada) = extract(month from current_timestamp) or extract(month from data_hora_saida) = extract(month from current_timestamp));
        
        return cast((horas_trabalhadas * valor_hora) as numeric(10, 2));
    end;
$$ language 'plpgsql';

insert into funcionario (nome, setor) values ('jorge', 'LIMPEZA');
insert into funcionario (nome, setor) values ('daleson', 'ATENDIMENTO');
insert into funcionario (nome, setor) values ('junin', 'OPERAÇÃO');

insert into sala(nome, capacidade) values('sala1', 5);

insert into turno(sala_id, funcionario_id, data_hora_entrada, data_hora_saida) values(1, 1, '2022-05-25 08:00:00', '2022-05-25 12:00:00');
insert into turno(sala_id, funcionario_id, data_hora_entrada, data_hora_saida) values(1, 1, '2022-06-01 08:00:00', '2022-06-01 12:00:00');
insert into turno(sala_id, funcionario_id, data_hora_entrada, data_hora_saida) values(1, 1, '2022-06-02 13:00:00', '2022-06-02 17:00:00');
insert into turno(sala_id, funcionario_id, data_hora_entrada, data_hora_saida) values(1, 1, '2022-06-02 08:30:00', '2022-06-02 15:00:00');

insert into turno(sala_id, funcionario_id, data_hora_entrada, data_hora_saida) values(1, 2, '2022-05-25 08:00:00', '2022-05-25 12:00:00');
insert into turno(sala_id, funcionario_id, data_hora_entrada, data_hora_saida) values(1, 2, '2022-06-01 08:00:00', '2022-06-01 12:00:00');
insert into turno(sala_id, funcionario_id, data_hora_entrada, data_hora_saida) values(1, 2, '2022-06-02 13:00:00', '2022-06-02 17:00:00');

insert into turno(sala_id, funcionario_id, data_hora_entrada, data_hora_saida) values(1, 3, '2022-05-25 08:00:00', '2022-05-25 12:00:00');
insert into turno(sala_id, funcionario_id, data_hora_entrada, data_hora_saida) values(1, 3, '2022-06-01 08:00:00', '2022-06-01 12:00:00');
insert into turno(sala_id, funcionario_id, data_hora_entrada, data_hora_saida) values(1, 3, '2022-06-02 13:00:00', '2022-06-02 17:00:00');

create or replace function insere_primeiro_turno() returns trigger as $$
    declare
        sala_id integer;
    begin
        select into sala_id id from sala order by random() limit 1;
        
        insert into turno(sala_id, funcionario_id, data_hora_entrada) values(sala_id, new.id, cast((current_date + 1 ||' 08:00:00') as timestamp));
	return null;
    end;
$$ language plpgsql;

create trigger primeiro_turno after insert on funcionario for each row execute procedure insere_primeiro_turno();

create view viewzada as 
    select sala.nome, filme.titulo, telespectador.nome, sessao.data, sessao.hora, ingresso.corredor, ingresso.poltrona
    from ingresso inner join telespectador on ingresso.telespectador.id = telespectador.id
    inner join sessao on telespectador.sessao_id = sessao.id 
    inner join filme on sessao.filme_id = filme.id
    inner join sala on sessao.sala_id = sala.id;