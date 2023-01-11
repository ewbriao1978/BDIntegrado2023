DROP DATABASE IF EXISTS aula020522;

CREATE DATABASE aula020522;

\c aula020522;

-- minhas tabelas
CREATE TABLE pessoa (
    id serial primary key,
    nome text,
    cpf character(11),
    UNIQUE (cpf)
);
-- meus inserts
INSERT INTO pessoa (nome, cpf) VALUES
('Igor', '11111111111'),
('Betito', '22222222222'),
('Luciano', '33333333333');

-- minhas funcoes
DROP FUNCTION IF EXISTS teste;
DROP FUNCTION IF EXISTS soma;
DROP FUNCTION IF EXISTS eh_par;
DROP FUNCTION IF EXISTS fatorial;
DROP FUNCTION IF EXISTS somatorio;
DROP FUNCTION IF EXISTS pegaPorId;
DROP FUNCTION IF EXISTS listarTodos;
DROP FUNCTION IF EXISTS exportarCSV;
DROP FUNCTION IF EXISTS qtde;
DROP FUNCTION IF EXISTS mascaraCPF;
DROP FUNCTION IF EXISTS mascaraCNPJ;
DROP FUNCTION IF EXISTS validaCPF;
DROP FUNCTION IF EXISTS fibo;

CREATE FUNCTION fibo(integer) RETURNS TEXT AS
$$
DECLARE
    resultado TEXT;
    nro1 INTEGER;
    nro2 INTEGER;
    aux INTEGER;
    aux_soma INTEGER;
    indice ALIAS FOR $1;
BEGIN
    nro1 := 1;
    nro2 := 1;
    if indice = 1 THEN
        RETURN nro1;
    END IF; 
    IF indice = 2 THEN
        RETURN nro1 || ',' || nro2;
    END IF;
    resultado := nro1 || ',' || nro2;
    aux := 3;
    WHILE (aux <= indice ) LOOP
        aux_soma = nro1 + nro2;
        resultado := resultado || ',' || aux_soma;
        nro1 := nro2;
        nro2 := aux_soma;
        aux := aux + 1;
    END LOOP;
    return resultado;
END;
$$ LANGUAGE 'plpgsql';


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
    IF resto = nro11 THEN
        resultadoDigito2 := TRUE;
    END IF;
    resultado := resultadoDigito1 AND resultadoDigito2;
    return resultado;
END;
$$ LANGUAGE 'plpgsql';

-- ex: select pessoa.nome, pessoa.cpf, mascaraCPF(pessoa.cpf) from pessoa;     
CREATE FUNCTION mascaraCNPJ(character(14)) RETURNS text AS
$$ 
DECLARE
    cnpj CHARACTER(14);
    cnpj_formatado TEXT;
BEGIN
    cnpj = $1;
    cnpj_formatado := SUBSTRING(cnpj,1, 2) || '.' || SUBSTRING(cnpj,3, 3) || '.' || SUBSTRING(cnpj,6, 3) || '/' || SUBSTRING(cnpj,9, 4) || '-' || SUBSTRING(cnpj,13, 2); 
    return cnpj_formatado;    
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION mascaraCPF(character(11)) RETURNS text AS
$$ 
DECLARE
    cpf CHARACTER(11);
    cpf_formatado TEXT;
BEGIN
    cpf = $1;
    cpf_formatado := SUBSTRING(cpf,0, 4) || '.' || SUBSTRING(cpf,4, 3) || '.' || SUBSTRING(cpf,7, 3) || '-' || SUBSTRING(cpf,10, 3);
    return cpf_formatado;    
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION qtde() RETURNS integer AS
$$
DECLARE
    qtde INTEGER;
BEGIN
    SELECT count(*) INTO qtde FROM pessoa;
    return qtde;    
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION exportarCSV() RETURNS text AS
$$
DECLARE
    registro pessoa%ROWTYPE;
    csv text;
BEGIN   
   csv := '';
   FOR registro IN SELECT * FROM pessoa LOOP
        -- RAISE NOTICE 'Nome: %', UPPER(registro.nome);                  
        csv = csv || registro.id || ';' || UPPER(registro.nome) || ';';                  
   END LOOP;
   return csv;
END;
$$ LANGUAGE 'plpgsql';


CREATE FUNCTION listarTodos() RETURNS VOID AS
$$
DECLARE
    registro pessoa%ROWTYPE;
BEGIN
   FOR registro IN SELECT * FROM pessoa LOOP
        RAISE NOTICE 'Nome: %', UPPER(registro.nome);                  
   END LOOP;
END;
$$ LANGUAGE 'plpgsql';



CREATE FUNCTION pegaPorId(integer) RETURNS text AS
$$
DECLARE
    registro pessoa%ROWTYPE;
BEGIN
    SELECT INTO registro * FROM pessoa WHERE id = $1;
    return registro;    
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION somatorio(vet integer[]) RETURNS integer AS
$$
DECLARE
    resultado INTEGER;
    x INTEGER;
BEGIN
    resultado := 0;
    FOREACH x IN ARRAY vet LOOP
--        RAISE NOTICE 'x %', x;                  
        resultado := resultado + x;
    END LOOP;
    return resultado;
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION fatorial(integer) RETURNS integer AS
$$
DECLARE
   resultado INTEGER;
   numero INTEGER;
BEGIN
    numero := $1;    
    resultado := $1;    
    WHILE (numero > 1) LOOP
        numero := numero - 1;        
        resultado := resultado * numero;  
       -- RAISE NOTICE 'RESULTADO %', resultado;                  
    END LOOP;
    return resultado;
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION eh_par(integer) RETURNS boolean AS
$$
DECLARE
   resultado boolean;
BEGIN
   IF ($1 % 2 = 0) THEN
     resultado := TRUE;
   ELSE
     resultado := FALSE;
   END IF;
   return resultado;
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION teste() RETURNS text AS
$$
DECLARE
    x pessoa.nome%TYPE;
BEGIN
   x := 'Igor';
   return x;
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION soma(text, text) RETURNS char AS
$$
DECLARE
    resultado text;
    nome ALIAS FOR $1;
    sobrenome ALIAS FOR $2;
BEGIN
    resultado := nome || ' ' || sobrenome;
    return resultado;
END;
$$ LANGUAGE 'plpgsql';
