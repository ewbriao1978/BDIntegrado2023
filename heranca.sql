DROP DATABASE IF EXISTS heranca;

CREATE DATABASE heranca;

\c heranca;

create table funcionario (
     matricula int,
     nome varchar,
     data_nascimento date,
     primary key(matricula)
);

 
create table gerente (
     percentParticipacaLucro int,
     telCel varchar
) inherits (funcionario);


insert into funcionario values (2000, 'Maria', '02/02/1980'); -- Os dados são inseridos somente na tabela funcionários e não na tabela gerente.


insert into gerente values (1000, 'Hesley', '01/01/1975', 10, '99999999'); -- Ao inserir um gerente, automaticamente os atributos herdados (matricula, nome, dataNascimento) são inseridos também na tabela de funcionários.


-- heranca=# SELECT * FROM funcionario ;
-- heranca=# SELECT * FROM gerente ;
-- heranca=# SELECT * FROM only funcionario;




