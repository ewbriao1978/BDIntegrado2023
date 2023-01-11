CREATE OR REPLACE FUNCTION fatorial(integer) RETURNS integer AS
$$
	DECLARE
	resultado integer;
BEGIN
	resultado := 1;
	WHILE ($1 > 0) LOOP
		resultado := resultado*$1;
		$1 = $1 - 1;
	END LOOP;
return resultado;
END;
$$ LANGUAGE 'plpgsql';

DROP FUNCTION primo(integer);
CREATE OR REPLACE FUNCTION primo(integer) RETURNS boolean AS
$$
DECLARE
resultado boolean;
divisor integer;
BEGIN
resultado := false;
divisor := 2;

IF ($1 = 1) THEN
	return resultado;	
END IF;
IF ($1 = 2) THEN
	resultado := true;
	return resultado;	
END IF;
IF ($1 % 2 = 0) THEN
	return resultado;	

END IF;
WHILE ($1 % divisor <> 0) LOOP
	RAISE NOTICE 'Conta % % %',$1, divisor, $1 % divisor;
	divisor := divisor + 1;	
END LOOP;
IF (divisor = $1) THEN
	resultado := true;
	return resultado;
END IF;
return resultado;
END;
$$ LANGUAGE 'plpgsql';


DROP FUNCTION fibo(integer);
CREATE OR REPLACE FUNCTION fibo(integer) RETURNS text AS
$$
DECLARE
	sequencia text;
	proximo integer;
	nro1 integer;
	nro2 integer;
BEGIN
	nro1 := 1;
	nro2 := 1;
IF ($1 = 0) THEN
		return '';
END IF;

IF ($1 = 1) THEN
		return nro1;
END IF;
IF ($1 = 2) THEN
		return nro1||'-'||nro2;
END IF;
sequencia := nro1||'-'||nro2;
$1 := $1 - 2; 
WHILE ($1 > 0) LOOP
	proximo = nro1 + nro2;
	nro1 = nro2;
	nro2 = proximo;
	sequencia := sequencia||'-'||proximo;
  	$1 := $1 - 1;		 
END LOOP;
return sequencia;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION csv(integer) RETURNS text AS
$$
DECLARE
	registro RECORD;
	genero RECORD;
BEGIN
 SELECT * INTO registro FROM filme where id = $1;
 IF (registro.genero_id is not null) THEN
	SELECT * INTO genero FROM genero where id = registro.genero_id;	
	return registro.id||';'||registro.nome||';'||registro.valor||';'||genero.nome||';';
 END IF;
 return registro.id||';'||registro.nome||';'||registro.valor||';';
END;
$$ LANGUAGE 'plpgsql';

DROP FUNCTION maior_menor(integer, integer, integer, out maior integer , out menor integer);
CREATE OR REPLACE FUNCTION maior_menor(integer, integer, integer, out maior integer , out menor integer) AS
$$
BEGIN
  IF ($1 > $2 AND $1 > $3) THEN
	maior := $1;
  END IF;
   IF ($2 > $1 AND $2 > $3) THEN
	maior := $2;
  END IF;	
   IF ($3 > $1 AND $3 > $2) THEN
	maior := $3;
  END IF;
   IF ($1 < $2 AND $1 < $3) THEN
	menor := $1;
  END IF;
   IF ($2 < $1 AND $2 < $3) THEN
	menor := $2;
  END IF;
   IF ($3 < $1 AND $3 < $2) THEN
	menor := $3;
  END IF;
    IF (menor is null) THEN
	IF (maior != $1) THEN
		menor := $1;
	END IF;	
	IF (maior != $2) THEN
		menor := $2;
	END IF;	
	IF (maior != $3) THEN
		menor := $3;
	END IF;	
  END IF;
  IF (maior is null) THEN
	IF (menor != $1) THEN
		maior := $1;
	END IF;	
	IF (menor != $2) THEN
		maior := $2;
	END IF;		
	IF (menor != $3) THEN
		maior := $3;
	END IF;
  END IF;
  IF (menor IS NULL AND maior IS NULL) THEN
	menor := $1;	
	maior := $1;
		
  END IF;  			 
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION somatorio(vetor integer[]) RETURNS integer as 
$$
DECLARE 
    i integer;
    resultado integer;
BEGIN
	resultado:= 0;
	FOREACH i IN ARRAY vetor LOOP
	       -- raise notice 't: %', t;
    		resultado := resultado + i;
	END loop;
  return resultado;
END;
$$ language plpgsql;
 

SELECT somatorio( array[1, 2, 3] );

CREATE OR REPLACE FUNCTION maior(vetor integer[]) RETURNS integer as 
$$
DECLARE 
	i integer;
	maior integer;
BEGIN
FOREACH i IN ARRAY vetor LOOP
   IF (maior is null) THEN
	maior := i;
   END IF; 	
   IF (i > maior) THEN
	maior := i;
   END IF; 	    
END loop;
    return maior;
END;
$$ language plpgsql;

select maior(array[2,4,5]);

DROP FUNCTION media(vetor integer[]);
CREATE OR REPLACE FUNCTION media(vetor integer[]) RETURNS real as 
$$
DECLARE 
	i integer;
	somatorio integer;
	tamanho real;
BEGIN
  somatorio := 0;
  tamanho := array_length(vetor, 1);
  FOREACH i IN ARRAY vetor LOOP
  	somatorio := somatorio + i;      
  END loop;
  return somatorio/tamanho;
END;
$$ language plpgsql;

select media(array[2,4]);

-- DROP FUNCTION media_valor_filme();
CREATE OR REPLACE FUNCTION media_valor_filme() RETURNS real as 
$$
DECLARE 
	media real;
BEGIN
	select avg(cast(valor as numeric(8,2))) INTO media from filme;
	return media;
END;
$$ language plpgsql;

select media_valor_filme();
