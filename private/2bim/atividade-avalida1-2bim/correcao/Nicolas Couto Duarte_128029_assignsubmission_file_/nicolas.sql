
\c postgres
drop database if exists cinema;

CREATE DATABASE cinema;

\c cinema;

DROP SCHEMA IF EXISTS externo;
DROP SCHEMA IF EXISTS interno;

Create Schema externo;
create Schema interno;

SET search_path TO public, externo, interno;

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
    BEGIN
        -- 66167566020
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
    --    RAISE NOTICE '%', nro1;
        nro2 := SUBSTRING(cpf,2, 1);
    --    RAISE NOTICE '%', nro2;    
        nro3 := SUBSTRING(cpf,3, 1);
    --    RAISE NOTICE '%', nro3;
        nro4 := SUBSTRING(cpf,4, 1);
    --    RAISE NOTICE '%', nro4;
        nro5 := SUBSTRING(cpf,5, 1);
    --    RAISE NOTICE '%', nro5;
        nro6 := SUBSTRING(cpf,6, 1);
    --    RAISE NOTICE '%', nro6;
        nro7 := SUBSTRING(cpf,7, 1);
    --    RAISE NOTICE '%', nro7;
        nro8 := SUBSTRING(cpf,8, 1);
    --    RAISE NOTICE '%', nro8;
        nro9 := SUBSTRING(cpf,9, 1);
    --    RAISE NOTICE '%', nro9;
        nro10 := SUBSTRING(cpf,10, 1);
    --    RAISE NOTICE '%', nro10;
        nro11 := SUBSTRING(cpf,11, 1);
    --    RAISE NOTICE '%', nro11;
    --    DIGITO 1
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
        IF resto = 10 THEN
            resto := 0;
        END IF;    
        IF resto = nro11 THEN
            resultadoDigito2 := TRUE;
        END IF;
        resultado := resultadoDigito1 AND resultadoDigito2;
        return resultado;
    EXCEPTION
        WHEN OTHERS THEN RAISE NOTICE 'DEU RUIM';
        RETURN FALSE;
    END;    
END;
$$ LANGUAGE 'plpgsql';


Create table externo.telespectador (
    id serial primary key,
    cpf varchar(11) UNIQUE,--CHECK(validaCPF(cpf) IS TRUE)
    nome text NOT NULL
);

create table externo.filme (
    id serial primary key,
    titulo text NOT NULL,
    duracao integer check (duracao > 0)
);

create table sala (
id serial primary key,
nome_sala text NOT NULL,
capacidade integer check (capacidade > 0)
);

create table externo.sessao(
    id serial primary key,
    filme_id integer references externo.filme (id),
    sala_id integer references sala (id),
    data date not null,
    hora time not null
);

Create table externo.ingresso (
    id serial primary key,
    telespectador_id integer references telespectador (id),
    sessao_id integer references sessao (id),
    valor_ingresso real,
    corredor varchar(1) not null,
    poltrona integer check (poltrona  > 0)
);
 
create table interno.funcionario (
    id serial primary key,
    nome text not null,
    setor text 
);
 create table interno.turno (
     sala_id integer references sala (id),
     funcionario_id integer references funcionario (id),
     data_hora_entrada timestamp default current_timestamp,
     data_hora_saida timestamp 
 );


--teste 
insert into externo.telespectador (cpf , nome) values
('2345213123', 'juninho'),
('2345218123', 'ciclano'),
('2345219123', 'beltrano'),
('2345212123', 'juvenal');

insert into externo.filme (titulo,duracao) values 
('era uma vez', 2),
('uma vez era', 1),
('já foi', 3),
('tá sendo', 4);

insert into sala (nome_sala,capacidade) values 
('salaterro', 100),
('sala acçãoa', 123),
('sala com pipoca no chão', 900),
('sala infinita', 10000);
 
 insert into sessao (filme_id,sala_id,data,hora) values
(1, 4,current_date,current_time),
(2, 3,current_date,current_time),
(3, 2,current_date,current_time),
(4, 1,current_date,current_time);

insert into ingresso (telespectador_id,sessao_id,valor_ingresso,corredor,poltrona) values
(1,2,50,1,1),
(2,2,50,2,2),
(3,3,50,1,1),
(4,4,50,1,1);


 
 create view exercicio5 as select sala.nome_sala, filme.titulo, externo.telespectador.nome ,sessao.data, sessao.hora, corredor, poltrona  
  from externo.ingresso  inner join externo.telespectador on (externo.ingresso.telespectador_id = telespectador.id) 
  inner join externo.sessao on (externo.ingresso.sessao_id = externo.sessao.id) 
  inner join externo.filme on (externo.sessao.filme_id = externo.filme.id )
  inner join sala on (externo.sessao.sala_id = sala.id );

  CREATE OR REPLACE FUNCTION inserirturno() RETURNS TRIGGER AS
$$
DECLARE
    salaAlea integer;
BEGIN
 SELECT INTO salaalea id FROM sala ORDER BY RANDOM() LIMIT 1;
   insert into interno.turno (sala_id,funcionario_id,data_hora_entrada,data_hora_saida) values
   (salaAlea,NEW.id,current_date +cast('1 day' as interval)+cast('08:00:00'as time),current_date+cast('1 day' as interval)+cast('16:00:00'as time));
   return new;
END;
$$ LANGUAGE 'plpgsql'; 

CREATE TRIGGER exercicio4
AFTER  insert on funcionario
FOR EACH ROW 
EXECUTE PROCEDURE inserirturno();

insert into funcionario (nome ,setor) values
('teste','limpeza');

select * from turno;