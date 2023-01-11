
--exercício 1)

DROP DATABASE IF EXISTS prova;


create DATABASE prova;

DROP SCHEMA IF EXISTS externo;
DROP SCHEMA IF EXISTS interno;

-- criando um schema
CREATE SCHEMA externo;
-- criando um schema
CREATE SCHEMA interno;

-- adicionando o esquema no conjunto de esquemas
SET search_path TO public, externo, interno;


--exercício 2)

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

create table externo.telespectador(
    id serial PRIMARY KEY,
    cpf CHARACTER(11) not null CHECK(validaCPF(cpf) IS TRUE),
    nome text not NULL,
    UNIQUE cpf
);

insert into externo.telespectador(cpf, nome) VALUES
('92113842068', 'Ale'),
('95712842000', 'Gil');


create table externo.ingresso(
    id serial PRIMARY KEY,
    telespectador_id integer REFERENCES externo.telespectador(id),
    sessao_id integer REFERENCES externo.sessao(id),
    valor_ingresso REAL,
    corredor CHARACTER(1) not null,
    poltrona integer CHECK (poltrona > 0)
);

insert into externo.ingresso(telespectador_id, sessao_id, valor_ingresso, corredor, poltrona) VALUES
(1, 1, 10.00, 'a', 1),
(2,1,10.00,'a', 2 );

create table externo.sessao(
    id serial PRIMARY KEY,
    filme_id integer references externo.filme(id),
    sala_id integer REFERENCES public.sala(id),
    data date not null,
    hora TIME not null
    
);

insert into externo.sessao(filme_id, sala_id, data, hora) VALUES
(1, 1, '22/06/06');



create table externo.filme(
    id serial PRIMARY key,
    titulo text not null,
    duracao integer CHECK(duracao >0)
);

insert into externo.filme( titulo, duracao) VALUES
('a cidade perdida', 2),
('batmam', 3);


create table public.sala(
    id serial PRIMARY KEY,
    nome text not null,
    capacidade integer CHECK(capacidade > 0)
);

insert into public.sala(nome, capacidade) values
('direita', 22);


create table interno.funcionario(
    id serial PRIMARY KEY,
    nome text not null,
    setor text check('limpeza', 'atendimento', 'operacao')
);


INSERT INTO interno.funcionario (setor_interno.funcionario) VALUES ('limpeza');  
INSERT INTO interno.funcionario (setor_interno.funcionario) VALUES ('atendimento');  
INSERT INTO interno.funcionario (setor_interno.funcionario) VALUES ('operaçao');    


insert into interno.funcionario(nome, setor) VALUES
('rodrigo', 2),
('bia', 3),
('carla', 1);


create table interno.turno(
    sala_id integer REFERENCES public.sala(id),
    funcionario_id integer REFERENCES interno.funcionario(id),
    data_hora_entrada TIMESTAMP CURRENT_TIMESTAMP,
    data_hora_saida TIMESTAMP,
    primary key (sala_id, funcionario_id, data_hora_entrada) 
);

insert into interno.turno(sala_id, funcionario_id, data_hora_entrada,data_hora_saida)VALUES
(1, 1, '22/06/06 08:00', '22/06/06 17:00' ),
(1, 2, '22/06/06 08:00', '22/06/06 17:00' ),
(1, 3, '22/06/06 08:00', '22/06/06 17:00' );





--exercício 5)


CREATE VIEW_ingresso AS SELECT public.sala.nome as sala_nome, externo.filme.titulo as filme_titulo, externo.telespectador.nome as telespectador_nome,
externo.sessao.data as sessao_data, externo.sessao.hora as sessao_hora, externo.ingresso.corredor as ingresso_corredor, 
externo.ingresso.poltrona as ingresso_poltrona from public.sala INNER JOIN externo.filme on(externo.filme.titulo = esterno.sessao.filme_id) 
INNER JOIN externo.telespectador on(externo.telespectador.nome = externo.ingresso.telespectador_id) 
INNER JOIN externo.sessao ON((externo.sessao.data = externo.ingresso.sessao_id) select to_char(externo.sessao.data, 'DD/MM/YYYY') as dma))
INNER JOIN externo.sessao ON(externo.sessao.hora = externo.ingresso.sessao_id) INNER JOIN externo.ingresso on(externo.ingresso.corredor = externo.sessao.id)
INNER JOIN externo.ingresso on(externo.ingresso.poltrona = externo.sessao.id);  


--exercício 4)


CREATE FUNCTION novoFuncionario() RETURNS TRIGGER AS
$$
DECLARE
      
    resultado text;
    data_entrada := ((now)+1);
    hora_entrada := 8:00;
    
BEGIN

    
    SELECT INTO resultado nome FROM interno.sala.nome ORDER BY RANDOM() LIMIT 1;

    RETURN resultado;
        
    INSERT INTO NEW.funcionario (nome,setor) VALUES (funcionario_nome, setor_nome);
    
    RETURN NEW;

    
    insert into turno(sala_id, funcionario_id, data_hora_entrada) values (resultado, new.funcionario, data_entrada, hora_entrada);

END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER novoFuncionario before INSERT ON interno.novoFuncionario
FOR EACH ROW EXECUTE PROCEDURE novoFuncionario();



--exercício 3)

create or replace function calculaSalario($1, $2, $3) RETURN real AS
$$
DECLARE
    id_funcionario := $1;
    setor := $2;
    valorHora := $3;
    turno := 8;
    totalTurnosTrabalhados := $4;
    salarioFuncionario := NEW;
    

BEGIN

    select interno.funcionario.nome, sum(($3* turno)*$4) as salarioFuncionario from interno.funcionario 
        where interno.funcionario.id = interno.funcionario.salario; 
    RETURN NEW;

END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER calculaSalario before select ON interno.funcionario.salario
FOR EACH ROW EXECUTE PROCEDURE calculaSalario();

         

 