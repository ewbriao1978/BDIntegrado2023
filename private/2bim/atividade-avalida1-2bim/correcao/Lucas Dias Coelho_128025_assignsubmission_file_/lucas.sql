-- criação do banco de dados
drop database if exists cinema;

create database cinema;

-- conexão ao banco de dados
\c cinema;

-- criação dos schemas
drop schema if exists externo;
drop schema if exists interno;

create schema externo;
create schema interno;

set search_path to public, externo, interno;

-- store procedure de validação do cpf
create function validaCPF(character(11)) returns boolean as
$$
declare
    resultado boolean;
    cpf ALIAS FOR $1;
    nro1 integer;
    nro2 integer;  
    nro3 integer;
    nro4 integer;
    nro5 integer;
    nro6 integer;
    nro7 integer;
    nro8 integer;
    nro9 integer;
    nro10 integer;
    nro11 integer;
    soma integer;
    resto integer;
    resultadoDigito1 boolean;
    resultadoDigito2 boolean;
begin
    -- 66167566020
    resultado := false;
    resultadoDigito1 := false;
    resultadoDigito2 := false;
    if cpf is null then
        return false;
    end if;
    if length(cpf) != 11 then
        return false;
    end if;
    if cpf = '00000000000' or 
       cpf = '11111111111' or 
       cpf = '22222222222' or 
       cpf = '33333333333' or 
       cpf = '44444444444' or 
       cpf = '55555555555' or 
       cpf = '66666666666' or 
       cpf = '77777777777' or 
       cpf = '88888888888' or 
       cpf = '99999999999' then
       return false;
    end if;
    nro1 := substring(cpf,1, 1);
--    raise notice '%', nro1;
    nro2 := substring(cpf,2, 1);
--    raise notice '%', nro2;    
    nro3 := substring(cpf,3, 1);
--    raise notice '%', nro3;
    nro4 := substring(cpf,4, 1);
--    raise notice '%', nro4;
    nro5 := substring(cpf,5, 1);
--    raise notice '%', nro5;
    nro6 := substring(cpf,6, 1);
--    raise notice '%', nro6;
    nro7 := substring(cpf,7, 1);
--    raise notice '%', nro7;
    nro8 := substring(cpf,8, 1);
--    raise notice '%', nro8;
    nro9 := substring(cpf,9, 1);
--    raise notice '%', nro9;
    nro10 := substring(cpf,10, 1);
--    raise notice '%', nro10;
    nro11 := substring(cpf,11, 1);
--    raise notice '%', nro11;
--  DIGITO 1
    soma := nro1 * 10 + nro2 * 9 + nro3 * 8 + nro4 * 7 + nro5 * 6 + nro6 * 5 + nro7 * 4 + nro8 * 3 + nro9 * 2;
    resto := (soma * 10) % 11;   
    if resto = 10 then
        resto := 0;
    end if;
    if resto = nro10 then
        resultadoDigito1 := true;
    end if;
--  DIGITO 2
    soma := nro1 * 11 + nro2 * 10 + nro3 * 9 + nro4 * 8 + nro5 * 7 + nro6 * 6 + nro7 * 5 + nro8 * 4 + nro9 * 3 + nro10 * 2;
    resto := (soma * 10) % 11;   
    if resto = 10 then
        resto := 0;
    end if;    
    if resto = nro11 then
        resultadoDigito2 := true;
    end if;
    resultado := resultadoDigito1 and resultadoDigito2;
    return resultado;
end;
$$ language 'plpgsql';

-- criação das tabelas do schema public
create table public.sala (
    id serial primary key,
    nome text not null,
    capacidade integer check(capacidade > 0)
);

-- criação das tabelas do schema externo
create table externo.telespectador (
    id serial primary key,
    cpf char(11) unique check(validaCPF(cpf) is true),
    nome text not null
);

create table externo.filme (
    id serial primary key,
    titulo text not null,
    duracao integer check(duracao > 0)
);

create table externo.sessao (
    id serial primary key,
    filme_id integer references externo.filme (id),
    sala_id integer references public.sala (id),
    data date not null,
    hora time not null
);

create table externo.ingresso (
    id serial primary key,
    telespectador_id integer references externo.telespectador (id),
    sessao_id integer references externo.sessao (id),
    valor_ingresso real,
    corredor char(1) not null,
    poltrona integer check(poltrona > 0) 
);

-- criação das tabelas do schema interno
create table interno.funcionario (
    id serial primary key,
    nome text not null,
    setor text check(setor = 'LIMPEZA' or setor = 'ATENDIMENTO' or setor = 'OPERACAO')
);

create table interno.turno (
    sala_id integer references public.sala (id),
    funcionario_id integer references interno.funcionario (id),
    data_hora_entrada timestamp default current_timestamp,
    data_hora_saida timestamp,
    primary key (sala_id, funcionario_id, data_hora_entrada)
);

-- store procedure de cálculo do salário do funcionário
create function calculaSalario(func_id integer, valor integer) returns real as 
$$
declare
    registro interno.turno%rowtype;
    mes_atual integer;
    ano_atual integer;
    tempo_trabalhado time := '00:00:00';
    resultado real;
begin
    select extract(year from cast(current_timestamp as date)) into ano_atual;
    select extract(month from cast(current_timestamp as date)) into mes_atual;

    for registro in select * from interno.turno 
        where interno.turno.funcionario_id = func_id loop
            if (
                mes_atual = extract(month from cast(current_timestamp as date)) and 
                ano_atual = extract(year from cast(current_timestamp as date))
               ) then
               select tempo_trabalhado + interno.turno.data_hora_saida - interno.turno.data_hora_entrada 
               into tempo_trabalhado;
            end if;
    end loop;

    select valor_ingresso * tempo_trabalhado into resultado;

    return resultado;
end;
$$ language 'plpgsql';

-- inserções de dados nas tabelas
insert into public.sala (nome, capacidade) values 
('Sala IMAX em 4D', 200),
('Sala Comum', 100);


insert into interno.funcionario (nome, setor) values 
('Lucas', 'LIMPEZA'),
('Matheus', 'ATENDIMENTO'),
('Rodrigo', 'OPERACAO');

insert into interno.turno (sala_id, funcionario_id, data_hora_entrada, data_hora_saida) values
(1, 1, '2022-01-03 10:00:00', '2022-01-03 20:00:00'),
(1, 1, '2022-02-03 10:00:00', '2022-02-03 20:00:00'),
(2, 2, '2022-01-03 10:00:00', '2022-01-03 20:00:00'),
(2, 2, '2022-01-05 10:00:00', '2022-01-05 20:00:00'),
(1, 3, '2022-02-03 10:00:00', '2022-02-03 20:00:00'),
(1, 3, '2022-02-04 10:00:00', '2022-02-04 20:00:00');

-- casos de teste do cálculo do salário do funcionário
-- select calculaSalario(1, 10); -- não funcionou :(

-- função acionada pelo trigger para criação de um novo turno para a adição de um novo funcionário
create function cria_turno() returns trigger as
$$
declare
    entrada timestamp;
    saida timestamp;
    func_id integer;
    sala_id integer;
begin
    select id from public.sala order by random() limit 1 into sala_id;
    select id from interno.funcionario where interno.funcionario.nome = new.nome into func_id; 
    select current_date + interval '1 day' + interval '8 hour' into entrada;
    select current_date + interval '1 day' + interval '16 hour' into saida;
    
    insert into interno.turno (sala_id, funcionario_id, data_hora_entrada, data_hora_saida) values
    (sala_id, func_id, entrada, saida);

    return new;
end;
$$ language 'plpgsql';

-- trigger para criação de um novo turno para a adição de um novo funcionário
create trigger t_cria_turno
after insert on interno.funcionario
for each row 
execute procedure cria_turno();

-- ativação do trigger
insert into interno.funcionario (nome, setor) values 
('Luiz', 'LIMPEZA');

select * from interno.funcionario;
select * from interno.turno;

-- construção de view
create view dia_de_cinedunas 
    as select public.sala.nome as sala,
              externo.filme.titulo as filme,
              externo.telespectador.nome as cinefilo,
              externo.sessao.data as dia,
              externo.sessao.hora as horario,
              externo.ingresso.corredor as corredor,
              externo.ingresso.poltrona as poltrona
    from externo.telespectador
    inner join externo.ingresso on (externo.telespectador.id = externo.ingresso.telespectador_id)
    inner join externo.sessao on (externo.sessao.id = externo.ingresso.sessao_id)
    inner join externo.filme on (externo.filme.id = externo.sessao.filme_id)
    inner join public.sala on (public.sala.id = externo.sessao.sala_id);

select * from dia_de_cinedunas;