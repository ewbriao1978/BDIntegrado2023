
DROP DATABASE IF EXISTS limpezatop;
CREATE DATABASE limpezatop;

 \c limpezatop


CREATE TABLE diarista(
id SERIAL PRIMARY KEY,
cpf VARCHAR(11)NOT NULL,
nome TEXT NOT NULL
);

CREATE TABLE responsavel(
id SERIAL PRIMARY KEY,
cpf VARCHAR (11) NOT NULL,
nome TEXT NOT NULL
);

CREATE TABLE tamanho(
descr TEXT NOT NULL,
id SERIAL PRIMARY KEY
);

CREATE TABLE residencia(
id SERIAL PRIMARY KEY,
cidade TEXT NOT NULL,
bairro TEXT NOT NULL,
rua TEXT NOT NULL ,
complemento TEXT,
numero TEXT NOT NULL,
tamanho_id INTEGER REFERENCES tamanho (id),
responsavel_id INTEGER REFERENCES responsavel(id)
);

CREATE TABLE faxina (
preco REAL,
data date,
realizada BOOLEAN,
avaliacao TEXT,
precopago REAL ,
numerofaxina integer,
variancia integer,
residencia_id INTEGER REFERENCES residencia(id),
diarista_id INTEGER REFERENCES diarista(id),
id SERIAL PRIMARY KEY
);

INSERT INTO tamanho (descr) VALUES
('pequeno'),
('medio'),
('grande');


INSERT INTO diarista (cpf,nome) VALUES('12345678901','Fabiola Cruz');
INSERT INTO diarista (cpf,nome) VALUES('11111111111','Jandira Soares');
INSERT INTO diarista (cpf,nome) VALUES('11122211122','Rita de Cassia');
INSERT INTO diarista (cpf,nome) VALUES('22222222222','Abrilina Matuzo');
INSERT INTO diarista (cpf,nome) VALUES('22233322233','Jussara da Costa');
INSERT INTO diarista (cpf,nome) VALUES('33333333333','Izaura Sampaio');




INSERT INTO responsavel (cpf,nome) VALUES('12345678901','neuza das terra');
INSERT INTO responsavel (cpf,nome) VALUES('33322233311','Abilio das Neves');
INSERT INTO responsavel (cpf,nome) VALUES('33322233322','Joao Mattos da Cruz');
INSERT INTO responsavel (cpf,nome) VALUES('44444444411','Rosaura Santana');
INSERT INTO responsavel (cpf,nome) VALUES('55588855555','Basilio de Lucca');
INSERT INTO responsavel (cpf,nome) VALUES('66666666666','Teresinha Daciolo');

INSERT INTO residencia (cidade,bairro,rua,numero,tamanho_id,responsavel_id) VALUES
('Rio das pedra','Pedregulu','beco da matança','12',2,1);
INSERT INTO residencia (cidade,bairro,rua,complemento,numero,tamanho_id,responsavel_id) VALUES
('Rio Grande','Parque Marinha','Rio Jacuí','Casa','122', 1, 5);
INSERT INTO residencia (cidade,bairro,rua,complemento,numero,tamanho_id,responsavel_id) VALUES
('Rio Grande','Parque São Pedro','Rua J','Casa','33A', 3, 4);
INSERT INTO residencia (cidade,bairro,rua,complemento,numero,tamanho_id,responsavel_id) VALUES
('Rio Grande','Cassino','Rua Valadares','Casa','1225', 1, 3);
INSERT INTO residencia (cidade,bairro,rua,complemento,numero,tamanho_id,responsavel_id) VALUES
('Rio Grande','Centro', 'Rua Duque de Caxias','Casa','4033C', 2, 6);
INSERT INTO residencia (cidade,bairro,rua,complemento,numero,tamanho_id,responsavel_id) VALUES
('Rio Grande','Barra','Rio Mantuá','Casa','03', 2, 2);




CREATE OR REPLACE FUNCTION agendarfaxina(preco real, data DATE, realizada boolean,
numerofaxina integer, variancia integer, residencia_id integer, diarista_id integer ) RETURNS TEXT AS
$$
DECLARE
 contador INTEGER;
 dataaux date;
 limiteaux date; 
 preco alias for $1;
 data alias for $2;
 realizada alias for $3;
 numerofaxina alias for $4;
 variancia alias for $5;
 residensia_id alias for $6;
 diarista_id alias for $7;

BEGIN
if (numerofaxina > 30)THEN 
 RETURN 'NUMERO DE FAXINAS DEVE SER MENOR QUE 30';
ELSIF (variancia < 15 AND variancia <= 30) THEN
 RETURN 'VARIANCIA DEVE SER QUINZENAL(15) OU MENSAL (30)';
  ELSE
  for contador in 1..numerofaxina LOOP
    INSERT INTO faxina (preco,data, realizada,numerofaxina,variancia, residencia_id, diarista_id)
    VALUES($1, $2, $3, $4, $5, $6, $7 );
end LOOP;
end if;
RETURN 'FAXINA MARCADA COM SUCESSO';
END;
$$ LANGUAGE plpgsql;

-- SELECT agendarfaxina(130,'01-07-2022',false,1,15,2,1);

--=====================================================================================================================
CREATE OR REPLACE FUNCTION realizadas(id INTEGER) RETURNS text AS 
$$
DECLARE
	realizadas real;
	faxinas real;
	nome_diarista TEXT;
	id ALIAS FOR $1;
	percentagem real;
BEGIN
	SELECT INTO faxinas count(faxina.realizada) FROM faxina WHERE diarista_id = $1 GROUP BY diarista_id;
	SELECT INTO realizadas count(faxina.realizada) FROM faxina WHERE realizada IS true AND diarista_id = $1 GROUP BY diarista_id;
	SELECT INTO nome_diarista nome FROM diarista WHERE diarista.id = $1;
	percentagem := (realizadas/faxinas)*100;	
	RETURN 'Nome = '||nome_diarista||' Numerofaxinas = '||faxinas ||' '||'Presenças em = '||' '||percentagem || '%';
END;
$$ LANGUAGE 'plpgsql';

-- SELECT realizadas(2);


--======================================================================================================================

CREATE FUNCTION deletardiaristaPorId(integer) RETURNS boolean AS
$$
DECLARE
    aux integer;
    realizadas real;
	  faxinas real;
	  nome_diarista TEXT;
	  id ALIAS FOR $1;
	  percentagem real;
BEGIN   
    BEGIN
        aux := 0;
        SELECT INTO aux diarista_id FROM faxina WHERE faxina.diarista_id = $1;
        IF aux > 0 THEN
		        DELETE FROM faxina WHERE faxina.diarista_id = $1;
		        DELETE FROM diarista WHERE diarista.id = $1;
            RETURN true;
        ELSE
            RETURN false;
        END IF;
    EXCEPTION   
        WHEN OTHERS THEN RAISE NOTICE 'O ERRO ESTA NO SELECT !!!';
        RETURN false;
    END;
END;
$$ LANGUAGE 'plpgsql';

-- SELECT deletardiaristaPorId(2);
--===============================================================================================================




