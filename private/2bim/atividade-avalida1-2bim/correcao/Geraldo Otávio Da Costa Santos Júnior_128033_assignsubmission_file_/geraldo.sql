DROP DATABASE IF EXISTS prova;
CREATE DATABASE prova;

\c prova;

--LEMBRAR DOS CHECKS PARA ALGUMAS COLUNAS
--CPF UNIQUE E VALIDADO

--MES CORRENTE PARA CALCULO DA QUESTÃO 3

DROP TABLE IF EXISTS  telespectador;
DROP TABLE IF EXISTS  sessao;
DROP TABLE IF EXISTS  ingresso;
DROP TABLE IF EXISTS  filme;
DROP TABLE IF EXISTS  sala;
DROP TABLE IF EXISTS  turno;
DROP TABLE IF EXISTS  funcionario;


CREATE SCHEMA externo;
CREATE SCHEMA interno;


SET search_path TO public, externo, interno;

CREATE OR REPLACE FUNCTION validaCPF(character(11)) RETURNS boolean AS
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
END;
$$ LANGUAGE 'plpgsql';



CREATE TABLE  externo.telespectador
   (    id serial PRIMARY KEY, 
    	cpf VARCHAR(11) unique NOT NULL CHECK(validaCPF(cpf) IS TRUE),
        nome text NOT NULL 
   );

CREATE TABLE  externo.filme 
   (    id serial PRIMARY KEY, 
    	titulo text not null, 
     	duracao integer check (duracao > 0) 
   );  

CREATE TABLE  public.sala 
   (    id serial PRIMARY KEY, 
    	nome text not null, 
     	capacidade integer check (capacidade > 0) 
   );

CREATE TABLE  externo.sessao 
   (    id serial PRIMARY KEY, 
       	filme_id integer,  
     	sala_id integer,  
     	data date not null,
        hora time not null,
        foreign key(filme_id) references filme(id),
        foreign key(sala_id)  references sala(id) 
   );

CREATE TABLE  externo.ingresso 
   (    id serial, 
    	telespectador_id integer,  
        sessao_id integer,  
     	valor_ingresso real, 
     	corredor character(1) not null,
        poltrona integer check (poltrona > 0), 
        foreign key(telespectador_id) references telespectador(id),
        foreign key(sessao_id) references sessao(id)
   );

CREATE TABLE  interno.funcionario
   (    id serial PRIMARY KEY, 
    	nome text NOT NULL,
        setor text check (setor = 'LIMPEZA' OR setor = 'ATENDIMENTO' OR setor = 'OPERAÇÃO' ) 
   );

CREATE TABLE  interno.turno 
   (   	sala_id integer,  
        funcionario_id integer,  
     	data_hora_entrada timestamp default current_timestamp, 
     	data_hora_saida timestamp, 
        foreign key(sala_id) references sala(id),
        foreign key(funcionario_id) references funcionario(id)
   );

insert into externo.telespectador(id, cpf, nome) values (1, '17658586072', 'Igor Pai');
insert into externo.telespectador(id, cpf, nome) values (2, '00852154062', 'gege');
insert into externo.telespectador(id, cpf, nome) values (3, '00429523017', 'tata');       

insert into externo.filme(id, titulo, duracao) values (1, 'Sei eu', 1);
insert into externo.filme(id, titulo, duracao) values (2, 'Sei tu', 2);
insert into externo.filme(id, titulo, duracao) values (3, 'Sei elo XD', 3);   

insert into public.sala(id, nome, capacidade) values(1, 'ruim', 1);   
insert into public.sala(id, nome, capacidade) values(2, 'média', 2);
insert into public.sala(id, nome, capacidade) values(3, 'top', 3);

insert into externo.sessao(id, filme_id, sala_id, data, hora) values
(1, 1, 1, current_date, current_time);
insert into externo.sessao(id, filme_id, sala_id, data, hora) values
(2, 2, 2, current_date, current_time);
insert into externo.sessao(id, filme_id, sala_id, data, hora) values
(3, 3, 3, current_date, current_time);

insert into externo.ingresso(id, telespectador_id, sessao_id, valor_ingresso, corredor, poltrona)
values(1, 1, 1, 3.5, 1, 1);
insert into externo.ingresso(id, telespectador_id, sessao_id, valor_ingresso, corredor, poltrona)
values(2, 2, 2, 4.5, 2, 2);
insert into externo.ingresso(id, telespectador_id, sessao_id, valor_ingresso, corredor, poltrona)
values(3, 3, 3, 5.5, 3, 3);


insert into interno.funcionario(id, nome, setor) values (1, 'João', 'LIMPEZA');
insert into interno.funcionario(id, nome, setor) values (2, 'Maria', 'ATENDIMENTO');
insert into interno.funcionario(id, nome, setor) values (3, 'CanRobert', 'OPERAÇÃO');

insert into interno.turno(sala_id, funcionario_id, data_hora_entrada, data_hora_saida) 
values (1, 1, current_timestamp, current_timestamp);
insert into interno.turno(sala_id, funcionario_id, data_hora_entrada, data_hora_saida) 
values (1, 2, current_timestamp, current_timestamp);
insert into interno.turno(sala_id, funcionario_id, data_hora_entrada, data_hora_saida) 
values (1, 3, current_timestamp, current_timestamp);


create view X as select sala.nome as salanome, filme.titulo, telespectador.nome as telenome, sessao.data, sessao.hora, ingresso.corredor, ingresso.poltrona 
from telespectador 
join ingresso on telespectador.id  = ingresso.telespectador_id  
join sessao on sessao.id = ingresso.sessao_id 
join sala on sala.id = sessao.sala_id
join filme on filme.id = sessao.filme_id
;


CREATE OR REPLACE FUNCTION calculaSalario() RETURNS TRIGGER AS
$$
DECLARE
    id_funcionario integer;
    valorHoraTrabalhadaLIMPEZA := 10 ;
    valorHoraTrabalhadaATENDIMENTO := 15 ;
    valorHoraTrabalhadaOPERACAO := 20 ;
    -- registroLocacao RECORD;
BEGIN  
    SELECT INTO funcionario join turno on funcionario.id = turno.funcionario_id where EXTRACT_MONTH(data_hora_entrada = current_month);
    IF funcionario.setor = 'LIMPEZA' THEN
                                        ;
        RETURN NEW;
    ELSE
        IF funcionario.setor = 'ATENDENTE' THEN
            ;                                     
                RETURN NEW;
            ELSE               
                IF funcionario.setor = 'OPERAÇÃO'                    

                   RETURN NEW;                 
                END IF;                     
            END IF;
                    
        END IF;         
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE 'plpgsql'; 

CREATE TRIGGER NOVOFUNCIONARIO AFTER INSERT ON funcionario FOR EACH ROW EXECUTE PROCEDURE calculoSalario();



    









