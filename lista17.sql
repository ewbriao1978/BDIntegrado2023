DROP DATABASE IF EXISTS lista17;
CREATE DATABASE lista17;

\c lista17;

DROP TABLE IF EXISTS  LOCACAO;
DROP TABLE IF EXISTS  RESERVA;
DROP TABLE IF EXISTS  DVD;
DROP TABLE IF EXISTS  STATUS;
DROP TABLE IF EXISTS  FILME;
DROP TABLE IF EXISTS  CATEGORIA;
DROP TABLE IF EXISTS  CLIENTE;


CREATE TABLE  CLIENTE
   (    CODCLIENTE serial, 
    	NOME_CLIENTE VARCHAR(30) NOT NULL, 
    	ENDERECO VARCHAR(50) NOT NULL, 
    	TELEFONE VARCHAR(12) NOT NULL, 
    	DATA_NASC DATE NOT NULL, 
    	CPF VARCHAR(11) NOT NULL, 
     	CONSTRAINT PK_CLIENTE PRIMARY KEY (CODCLIENTE),
	CONSTRAINT CPF_UNIQUE UNIQUE (CPF)
   );

CREATE TABLE  CATEGORIA 
   (    CODCATEGORIA serial, 
    	NOME_CATEGORIA VARCHAR(100) NOT NULL, 
     	CONSTRAINT CATEGORIA_PK PRIMARY KEY (CODCATEGORIA), 
     	CONSTRAINT CHECK_NOME_CATEGORIA CHECK ( NOME_CATEGORIA in ('drama','terror','ação','aventura','comédia'))
   );

CREATE TABLE  FILME 
   (    CODFILME serial, 
    	CODCATEGORIA int, 
    	NOME_FILME VARCHAR(100) NOT NULL, 
    	DIARIA numeric(10,2) NOT NULL, 
     	CONSTRAINT PK_FILME PRIMARY KEY (CODFILME), 
     	CONSTRAINT FK_FIL_CAT FOREIGN KEY (CODCATEGORIA)
      		REFERENCES  CATEGORIA (CODCATEGORIA)
		ON DELETE NO ACTION ON UPDATE CASCADE
   );

CREATE TABLE  STATUS 
   (    CODSTATUS SERIAL, 
    	NOME_STATUS VARCHAR(30) NOT NULL, 
     	CONSTRAINT PK_STATUS PRIMARY KEY (CODSTATUS),
     	CONSTRAINT CHECK_NOME_STATUS CHECK ( NOME_STATUS in ('reservado','disponível','indisponível','locado'))

   );

CREATE TABLE  DVD 
   (    CODDVD SERIAL, 
    	CODFILME int NOT NULL, 
    	CODSTATUS int NOT NULL, 
     	CONSTRAINT PK_DVD PRIMARY KEY (CODDVD), 
     	CONSTRAINT FK_DVD_FIL FOREIGN KEY (CODFILME)
      		REFERENCES  FILME (CODFILME) ON UPDATE CASCADE, 
     	CONSTRAINT FK_DVD_STA FOREIGN KEY (CODSTATUS)
      		REFERENCES  STATUS (CODSTATUS) ON UPDATE CASCADE
   );

CREATE TABLE log (
    codigo serial primary key,
    coddvd integer,
    codstatus integer,
    comando text,
    descricao text
);

CREATE TABLE  LOCACAO 
   (    CODLOCACAO SERIAL, 
    	CODDVD int NOT NULL, 
    	CODCLIENTE int NOT NULL, 
    	DATA_LOCACAO DATE NOT NULL DEFAULT NOW(), 
    	DATA_DEVOLUCAO DATE, 
     	CONSTRAINT PK_LOCACAO PRIMARY KEY (CODLOCACAO), 
     	CONSTRAINT FK_LOC_DVD FOREIGN KEY (CODDVD)
      		REFERENCES  DVD (CODDVD) ON DELETE SET NULL ON UPDATE CASCADE, 
     	CONSTRAINT FK_LOC_CLI FOREIGN KEY (CODCLIENTE)
      		REFERENCES  CLIENTE (CODCLIENTE) ON DELETE SET NULL ON UPDATE CASCADE
   );

CREATE TABLE  RESERVA 
   (    CODRESERVA SERIAL, 
    	CODDVD int NOT NULL, 
    	CODCLIENTE int NOT NULL, 
 	DATA_RESERVA DATE DEFAULT NOW(), 
    	DATA_VALIDADE DATE NOT NULL, 
     	CONSTRAINT PK_RESERVA PRIMARY KEY (CODRESERVA), 
     	CONSTRAINT FK_RES_DVD FOREIGN KEY (CODDVD)
      		REFERENCES  DVD (CODDVD) ON DELETE SET NULL ON UPDATE CASCADE, 
     	CONSTRAINT FK_RES_CLI FOREIGN KEY (CODCLIENTE)
      		REFERENCES  CLIENTE (CODCLIENTE) ON DELETE SET NULL ON UPDATE CASCADE
   );

--inserts

INSERT INTO STATUS (NOME_STATUS) VALUES ('reservado');
INSERT INTO STATUS (NOME_STATUS) VALUES ('disponível');    
INSERT INTO STATUS (NOME_STATUS) VALUES ('locado');
INSERT INTO STATUS (NOME_STATUS) VALUES ('indisponível');
    
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('comédia');    
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ( 'aventura');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ( 'terror');    
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ( 'ação');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ( 'drama');

INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('João Paulo', 'rua XV de novembro, n:18', '88119922','05-02-1990','09328457398');
INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('Maria', 'rua XV de novembro, n:20', '88225422','07-01-1991','93573923168');
INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('Joana', 'rua XV de novembro, n:10', '99778122','09-07-1980','71398987234');
INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('Jeferson', 'rua XV de novembro, n:118', '84549922','09-12-1982','02128443298');
INSERT INTO CLIENTE (NOME_CLIENTE,ENDERECO,TELEFONE,DATA_NASC,CPF ) VALUES ('Paula', 'rua XV de novembro, n:128', '82324232','11-04-1970','57398093284');

INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (1,'Entrando numa fria', 1.50);    
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (2,'O Hobbit', 3.00);    
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (3,'Sobrenatural 2', 4.50);    
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (5,'Um sonho de liberdade', 1.50);
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (2,'Thor 2', 4.50);
INSERT INTO FILME (CODCATEGORIA, NOME_FILME,DIARIA ) VALUES (4,'Velozes e Furiosos', 1.50);

INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (1,1);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (2,2);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (2,3);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (3,2);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (4,2);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (4,3);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (5,1);
INSERT INTO DVD (CODFILME,CODSTATUS) VALUES (6,3);

INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(1,2,current_date,(current_date+4)); 
INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(5,1,current_date,(current_date+4)); 
INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(6,2,(current_date-30),(current_date-26)); 
INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(6,3,(current_date-4),(current_date-1)); 
INSERT INTO RESERVA (CODDVD,CODCLIENTE,DATA_RESERVA,DATA_VALIDADE) VALUES(6,1,(current_date-20),(current_date-16)); 

INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(1,1,(current_date-30),(current_date-28));
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(2,3,(current_date-25),(current_date-23));
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(1,1,(current_date-1),current_date);
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(3,2,(current_date-1),null); 
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(6,2,current_date,null); 
INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) VALUES(8,2,current_date,null);


/*
CREATE FUNCTION deletarClientePorId(integer) RETURNS boolean AS
$$
DECLARE
    aux integer;
BEGIN   
    BEGIN
        aux := 0;
        SELECT INTO aux codcliente FROM cliente WHERE codcliente = $1;
        IF aux > 0 THEN
            DELETE FROM reserva WHERE codcliente = $1;
            DELETE FROM locacao WHERE codcliente = $1; 
            DELETE FROM cliente WHERE codcliente = $1;
            RETURN true;
        ELSE
            RETURN false;
        END IF;
    EXCEPTION   
        WHEN OTHERS THEN RAISE NOTICE 'DEU RUIM. Esqueci de algo!!';
        RETURN false;
    END;
END;
$$ LANGUAGE 'plpgsql';


CREATE FUNCTION insereCliente(nome_cliente varchar(30), endereco varchar(50), telefone varchar(12), data_nascimento date, cpf varchar(11)) RETURNS boolean AS
$$
BEGIN
    INSERT INTO cliente (nome_cliente, endereco, telefone, data_nasc, cpf) VALUES(nome_cliente, endereco, telefone, data_nascimento, cpf);
    RETURN true;
END;
$$ LANGUAGE 'plpgsql';


CREATE FUNCTION qtdeCategoria(x text) RETURNS VOID AS 
$$
DECLARE
    qtdeFilme integer;
    qtdeDvd integer;
BEGIN    
    SELECT into qtdeFilme count(*) FROM filme INNER JOIN categoria ON (filme.codcategoria = categoria.codcategoria) WHERE categoria.nome_categoria = x;
    
    SELECT INTO qtdeDVD count(*) FROM filme INNER JOIN categoria ON (filme.codcategoria = categoria.codcategoria) inner join dvd on (dvd.codfilme = filme.codfilme) WHERE categoria.nome_categoria = x;

    RAISE NOTICE 'QTDE filme %', qtdeFilme;
    RAISE NOTICE 'QTDE dvd %', qtdeDvd;
END;
$$ LANGUAGE 'plpgsql';


CREATE FUNCTION maisLocados() RETURNS VOID AS 
$$
DECLARE
    qtdeMaxima integer;
    registro RECORD;
BEGIN
    SELECT INTO qtdeMaxima count(*) FROM filme INNER JOIN dvd ON (filme.codfilme = dvd.codfilme) INNER JOIN locacao ON (locacao.coddvd = dvd.coddvd) GROUP BY filme.nome_filme LIMIT 1;

    FOR registro IN SELECT filme.nome_filme, count(*) FROM filme INNER JOIN dvd ON (filme.codfilme = dvd.codfilme) INNER JOIN locacao ON (locacao.coddvd = dvd.coddvd) GROUP BY filme.nome_filme HAVING count(*) = qtdeMaxima LOOP
        RAISE NOTICE 'filme %', registro.nome_filme;
    END LOOP;
END;
$$ LANGUAGE 'plpgsql';


CREATE FUNCTION locacaoPorCliente(nome varchar(30)) RETURNS VOID AS 
$$
DECLARE
    registro RECORD;
BEGIN
    FOR registro IN SELECT cliente.codcliente, cliente.nome_cliente, count(*) as qtde FROM cliente INNER JOIN locacao ON (cliente.codcliente = locacao.codcliente) WHERE cliente.nome_cliente = 'Maria' group by cliente.codcliente, cliente.nome_cliente LOOP
        RAISE NOTICE 'A % de codigo % locou % vezes', registro.nome_cliente, registro.codcliente, registro.qtde;
    END LOOP;    
END;
$$ LANGUAGE 'plpgsql';

-- 6
CREATE FUNCTION realizarlocacao(nome_filmeAux varchar(100), nome_clienteAux varchar(100)) RETURNS boolean AS 
$$
DECLARE
    cod_dvdAux integer;
    cod_clienteAux integer;
--    data_locacaoAux date;
--    data_devolucaoAux date;
BEGIN
--    codstatus == 2 (Disponivel)
      SELECT INTO cod_dvdAux dvd.coddvd FROM filme INNER JOIN dvd ON (filme.codfilme = dvd.codfilme)
WHERE codstatus = 2 and filme.nome_filme = nome_filmeAux;

      SELECT INTO cod_clienteAux cliente.codcliente FROM cliente WHERE nome_cliente = nome_clienteAux;  

    INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) 
        VALUES(cod_dvdAux,cod_clienteAux,CURRENT_DATE, CURRENT_DATE+7);

--    codstatus == 3 (Locado)
    UPDATE dvd SET codstatus = 3 WHERE coddvd = cod_dvdAux; 

    RETURN true;
      
END;
$$ LANGUAGE 'plpgsql';

-- 7
CREATE FUNCTION realizarlocacaoComExcecao(nome_filmeAux varchar(100), nome_clienteAux varchar(100)) RETURNS boolean AS 
$$
DECLARE
    cod_dvdAux integer;
    cod_clienteAux integer;
--    data_locacaoAux date;
--    data_devolucaoAux date;
BEGIN
--    codstatus == 2 (Disponivel)
      SELECT INTO cod_dvdAux dvd.coddvd FROM filme INNER JOIN dvd ON (filme.codfilme = dvd.codfilme)
WHERE codstatus = 2 and filme.nome_filme = nome_filmeAux;
        
      IF cod_dvdAux is NULL THEN
        RAISE EXCEPTION 'NOME DE FILME INCORRETO E/OU DVDs INDISPONIVEIS';
        RETURN FALSE;   
      END IF;
    
      SELECT INTO cod_clienteAux cliente.codcliente FROM cliente WHERE nome_cliente = nome_clienteAux;  

     IF cod_clienteAux is NULL THEN
        RAISE EXCEPTION 'NOME DO CLIENTE INCORRETO';
        RETURN FALSE;   
      END IF;

    IF cod_clienteAux IS NOT NULL AND cod_dvdAux IS NOT NULL THEN    

    INSERT INTO LOCACAO (CODDVD,CODCLIENTE,DATA_LOCACAO, DATA_DEVOLUCAO) 
        VALUES(cod_dvdAux,cod_clienteAux,CURRENT_DATE, CURRENT_DATE+7);

--    codstatus == 3 (Locado)
    UPDATE dvd SET codstatus = 3 WHERE coddvd = cod_dvdAux; 
            
        RETURN TRUE;
    END IF;
    
    
    RETURN FALSE;  
END;
$$ LANGUAGE 'plpgsql';


-- 8
CREATE FUNCTION trocaStatus() RETURNS VOID AS 
$$
DECLARE
    cod_dvdAux integer;
BEGIN
    FOR cod_dvdAux IN SELECT DISTINCT coddvd FROM reserva WHERE data_validade < CURRENT_DATE LOOP
--        RAISE NOTICE '%', cod_dvdAux;       
          UPDATE dvd SET codstatus = 2 WHERE dvd.coddvd = cod_dvdAux; 
    END LOOP;
END;
$$ LANGUAGE 'plpgsql';
*/


CREATE OR REPLACE FUNCTION gera_log() RETURNS TRIGGER AS
$$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO log (coddvd, codstatus, comando, descricao)
        VALUES (OLD.coddvd, OLD.codstatus, 'DELETE', 'acabou de deletar o dvd ' || OLD.coddvd);
        RETURN OLD;    
    ELSIF (TG_OP = 'UPDATE') THEN
         INSERT INTO log (coddvd, codstatus, comando, descricao)
        VALUES (NEW.coddvd, NEW.codstatus, 'UPDATE', 'acabou de ATUALIZAR o dvd ' || NEW.coddvd);
        RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO log (coddvd, codstatus, comando, descricao)
        VALUES (NEW.coddvd, NEW.codstatus, 'INSERT', 'acabou de INSERIR o dvd ' || NEW.coddvd);
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE 'plpgsql'; 

CREATE TRIGGER gera_log AFTER INSERT OR UPDATE OR DELETE ON dvd FOR EACH ROW EXECUTE PROCEDURE gera_log();


CREATE OR REPLACE FUNCTION modifica_status() RETURNS TRIGGER AS
$$
BEGIN  
    -- 
    IF (NEW.data_devolucao IS NOT NULL) THEN
        UPDATE dvd SET codstatus = 2 WHERE coddvd = NEW.coddvd;
        RETURN NEW;
    END IF;
    RETURN NULL;    
END;
$$ LANGUAGE 'plpgsql'; 

CREATE TRIGGER modifica_status AFTER UPDATE ON locacao FOR EACH ROW EXECUTE PROCEDURE modifica_status();

CREATE OR REPLACE FUNCTION modifica_status_reserva() RETURNS TRIGGER AS
$$
DECLARE
    registro RECORD;
BEGIN 
    SELECT INTO registro * FROM dvd WHERE coddvd = NEW.coddvd;
    -- se esta disponivel    
    IF registro.codstatus = 2 THEN
        -- pode ser reservado
        UPDATE dvd SET codstatus = 1 WHERE coddvd = NEW.coddvd;
        RETURN NEW;
    ELSE
        -- para outros casos (jah reservado ou indisponivel), exclui a reserva recem criada.    
        DELETE FROM reserva WHERE codreserva = NEW.codreserva;
        RETURN NULL;    
    END IF;
    RETURN NULL;  
END;
$$ LANGUAGE 'plpgsql'; 

CREATE TRIGGER modifica_status_reserva AFTER INSERT ON reserva FOR EACH ROW EXECUTE PROCEDURE modifica_status_reserva();


CREATE OR REPLACE FUNCTION modifica_locacao() RETURNS TRIGGER AS
$$
DECLARE
    registro RECORD;
    registroReserva RECORD;
    -- registroLocacao RECORD;
BEGIN  
    SELECT INTO registro * FROM dvd WHERE coddvd = NEW.coddvd;
    IF registro.codstatus = 2 THEN
        UPDATE dvd SET codstatus = 3 WHERE coddvd = NEW.coddvd;
        RETURN NEW;
    ELSE
        IF registro.codstatus = 1 THEN
            SELECT INTO registroRESERVA * FROM RESERVA WHERE coddvd = NEW.coddvd;
            IF registroRESERVA.codcliente = NEW.codcliente THEN
                UPDATE dvd SET codstatus = 3 WHERE coddvd = NEW.coddvd;
                DELETE FROM reserva WHERE codcliente = NEW.codcliente AND coddvd = NEW.coddvd;                                     
                RETURN NEW;
            ELSE               
                IF registroRESERVA.codcliente is not null THEN                    
                    DELETE FROM locacao WHERE codlocacao = NEW.codlocacao;
                    RAISE EXCEPTION 'reserva para outro cliente!!';
                ELSE
                    DELETE FROM locacao WHERE codlocacao = NEW.codlocacao;
                    RAISE EXCEPTION 'reserva INEXISTENTE!!';                
                END IF;                     
            END IF;
        ELSE
            SELECT INTO registro * FROM dvd WHERE coddvd = NEW.coddvd;
            IF registro.codstatus = 3 THEN
                DELETE FROM locacao WHERE codlocacao = NEW.codlocacao;
                RAISE EXCEPTION 'dvd ja esta locado';
            END IF;
        END IF;         
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE 'plpgsql'; 

CREATE TRIGGER modifica_locacao AFTER INSERT ON locacao FOR EACH ROW EXECUTE PROCEDURE modifica_locacao();



    










