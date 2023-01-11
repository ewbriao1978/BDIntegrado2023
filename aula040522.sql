DROP DATABASE IF EXISTS aula040522;

CREATE DATABASE aula040522;

\c aula040522;

-- oi
DROP FUNCTION IF EXISTS mascaraCPF;
DROP FUNCTION IF EXISTS mascaraCNPJ;
DROP FUNCTION IF EXISTS validaCPF;
DROP FUNCTION IF EXISTS validaCNPJ;

CREATE FUNCTION validaCNPJ(character(14)) RETURNS boolean AS
$$
    DECLARE
        resultado BOOLEAN;
        cnpj ALIAS FOR $1;
        peso1 integer;
        peso2 integer;
        peso3 integer;
        peso4 integer;
        peso5 integer;
        peso6 integer;
        peso7 integer;
        peso8 integer;
        peso9 integer;
        peso10 integer;
        peso11 integer; 
        peso12 integer;
        peso13 integer;
        nro1   integer;
        nro2   integer;
        nro3 integer;
        nro4 integer;
        nro5 integer;
        nro6 integer;
        nro7 integer;
        nro8 integer;
        nro9 integer;
        nro10 integer;
        nro11 integer;
        nro12 integer;
        nro13 integer;
        nro14 integer;
        soma INTEGER;
        resto INTEGER;
        primeiroDigito integer;
        segundoDigito integer;
        resultadoPrimeiroDigito boolean;
        resultadoSegundoDigito boolean;
    BEGIN
        resultadoPrimeiroDigito := FALSE;
        resultadoSegundoDigito := FALSE;        
        resultado := FALSE;
--        5,4,3,2,9,8,7,6,5,4,3,2
        peso1 := 5;
        peso2 := 4;
        peso3 := 3;
        peso4 := 2;
        peso5 := 9;
        peso6 := 8;
        peso7 := 7;
        peso8 := 6;
        peso9 := 5;
        peso10 := 4;
        peso11 := 3;
        peso12 := 2;
        nro1 := SUBSTRING(cnpj,1, 1);
        nro2 := SUBSTRING(cnpj,2, 1);
        nro3 := SUBSTRING(cnpj,3, 1);
        nro4 := SUBSTRING(cnpj,4, 1);
        nro5 := SUBSTRING(cnpj,5, 1);
        nro6 := SUBSTRING(cnpj,6, 1);
        nro7 := SUBSTRING(cnpj,7, 1);
        nro8 := SUBSTRING(cnpj,8, 1);
        nro9 := SUBSTRING(cnpj,9, 1);
        nro10 := SUBSTRING(cnpj,10, 1);
        nro11 := SUBSTRING(cnpj,11, 1);
        nro12 := SUBSTRING(cnpj,12, 1);
        nro13 := SUBSTRING(cnpj,13, 1);
        nro14 := SUBSTRING(cnpj,14, 1);
        soma := nro1*peso1 + nro2*peso2 + nro3*peso3 + nro4*peso4 + nro5*peso5 + nro6*peso6 + nro7*peso7 + nro8*peso8 + nro9*peso9 + nro10*peso10 + nro11*peso11 + nro12*peso12;
        resto = soma % 11;
        IF resto < 2 THEN
            primeiroDigito := 0;
        ELSE
            primeiroDigito := 11 - resto;         
        END IF;
--        6,5,4,3,2,9,8,7,6,5,4,3,2
          peso1 := 6;
          peso2 := 5;
          peso3 := 4;
          peso4 := 3;
          peso5 := 2;
          peso6 := 9;
          peso7 := 8;
          peso8 := 7;
          peso9 := 6;
          peso10 := 5;
          peso11 := 4;
          peso12 := 3;
          peso13 := 2;
         soma := nro1*peso1 + nro2*peso2 + nro3*peso3 + nro4*peso4 + nro5*peso5 + nro6*peso6 + nro7*peso7 + nro8*peso8 + nro9*peso9 + nro10*peso10 + nro11*peso11 + nro12*peso12 + nro13*peso13;
        resto = soma % 11;
        IF resto < 2 THEN
            segundoDigito := 0;
        ELSE
            segundoDigito := 11 - resto;         
        END IF;
        IF nro13 = primeiroDigito THEN
            resultadoPrimeiroDigito := TRUE;
        END IF;
        IF nro14 = segundoDigito THEN
            resultadoSegundoDigito := TRUE;
        END IF;
        resultado := resultadoPrimeiroDigito and resultadoSegundoDigito;
        RETURN resultado;
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

CREATE TABLE pessoa (
    id serial primary key,
    nome text not null
);

CREATE TABLE pessoa_fisica (
    cpf character(11) not null CHECK(validaCPF(cpf) IS TRUE),
    unique(cpf)
) inherits (pessoa);

CREATE TABLE pessoa_juridica (
    nome_fantasia text,
    cnpj character(14) not null,
    unique(cnpj)
) inherits (pessoa);

INSERT INTO pessoa_fisica (cpf, nome) VALUES 
('96575932045', 'Doris'),
('17658586072', 'Danielle');

INSERT INTO pessoa_juridica (nome_fantasia, cnpj, nome) VALUES
('Facebook','33333333333333', 'Meta');





