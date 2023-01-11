DROP DATABASE IF EXISTS faxina;
CREATE DATABASE faxina;

\c faxina;

CREATE TABLE diarista (
	id SERIAL PRIMARY KEY,
	nome TEXT,
	cpf char ( 11 )
);

CREATE TABLE responsavel (
	id SERIAL PRIMARY KEY,
	nome TEXT,
	cpf char ( 11 )
);

CREATE TABLE tamanho (
	id SERIAL PRIMARY KEY,
	nome TEXT CHECK ( ( nome = 'PEQUENA' ) OR ( nome = 'MEDIA' ) OR ( nome = 'GRANDE' ) ),
	valor REAL
);

CREATE TABLE residencia (
	id SERIAL PRIMARY KEY,
	cidade TEXT,
	bairro TEXT,
	rua TEXT,
	complemento TEXT,
	numero TEXT,
	tamanho_id INTEGER REFERENCES tamanho ( id ),
	responsavel_id INTEGER REFERENCES responsavel ( id )
);

CREATE TABLE faxina (
	id SERIAL PRIMARY KEY,
	data DATE,
	presenca BOOLEAN,
	valor_final REAL,
	feedback TEXT,
	diarista_id INTEGER REFERENCES diarista ( id ),
	residencia_id INTEGER REFERENCES residencia ( id )
);

INSERT INTO tamanho ( nome, valor ) VALUES ( 'PEQUENA', 50 ), ( 'MEDIA', 100), ( 'GRANDE', 150 );

INSERT INTO diarista ( nome, cpf ) VALUES ( 'MARINETE', '12345678910' ), ( 'CLAUDIA', '24681357901' );

INSERT INTO responsavel ( nome, cpf ) VALUES ( 'SOLINEUSA', '10987654321' );

INSERT INTO residencia ( cidade, bairro, rua, complemento, numero, tamanho_id, responsavel_id ) VALUES ( 'PELOTAS', 'LINDÓIA', 'TRAVESSA CINCO', 'BLOCO 603', '7', 1, 1 );

INSERT INTO faxina ( data, presenca, valor_final, feedback, diarista_id, residencia_id ) VALUES ( '2022-01-10', 'TRUE', 50, 'EXCELENTE PROFICIONAL', 1, 1 ), ( '2022-01-25', 'TRUE', 50, 'SERVIÇO BEM EXECUTADO', 1, 1 ), ( '2022-02-15', 'FALSE', 50, 'DIARISTA NÃO COMPARECEU', 1, 1 ), ( '2022-04-21', 'TRUE', 50, 'ÓTIMO SERVIÇO', 1, 1 ), ( '2022-05-21', 'TRUE', 50, 'NÃO TIROU O PÓ DOS MÓVEIS', 1, 1 ), ( '2022-06-21', 'TRUE', 50, 'LOREM INPSUM', 1, 1 ), ( '2021-06-21', 'FALSE', 50, 'DIARISTA NÃO APARECEU', 2, 1 );

CREATE FUNCTION agendar_faxina ( id_diarista INTEGER, id_residencia INTEGER, periodo_agendamento INTEGER ) RETURNS text AS 
$$
DECLARE
	ultima_faxina_agendada DATE;
	countt INTEGER;
	id_diarista ALIAS FOR $1;
	id_residencia ALIAS FOR $2;
	periodo_agendamento ALIAS FOR $3;
BEGIN
	IF periodo_agendamento != 15 AND periodo_agendamento != 30 THEN
		RAISE EXCEPTION 'Periodo de agendamento, indisponível! Somente 15 ou 30 dias.';
	ELSE
		countt := 0;
		
		WHILE countt < 30 LOOP
			SELECT INTO ultima_faxina_agendada data FROM faxina WHERE diarista_id = $1 AND residencia_id = $2 ORDER BY data DESC LIMIT 1;
			IF ultima_faxina_agendada IS NOT NULL AND ultima_faxina_agendada::DATE >= CURRENT_DATE THEN		
				IF EXTRACT ( YEAR FROM ultima_faxina_agendada + ( ($3 || 'DAY')::INTERVAL ) ) = EXTRACT( YEAR FROM CURRENT_DATE ) THEN
					INSERT INTO faxina ( data, diarista_id, residencia_id ) VALUES ( ultima_faxina_agendada + ( ($3 || 'DAY')::INTERVAL ), $1, $2 );
				ELSE
					RETURN 'Foram agendadas ' || countt || ' faxinas, como período de ' || $3 || ' dias!';
				END IF;
			ELSE
				INSERT INTO faxina ( data, diarista_id, residencia_id ) VALUES ( CURRENT_DATE + INTERVAL '1 Day', $1, $2 );
			END IF;
			countt := countt + 1;
		END LOOP;
		RETURN 'Foram agendadas ' || countt || ' faxinas, como período de ' || $3 || ' dias!';
	END IF;
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION presencas (  id_diarista INTEGER ) RETURNS text AS 
$$
DECLARE
	qtd_presencas FLOAT;
	qtd_faltas FLOAT;
	qtd_faxinas FLOAT;
	porcentagem FLOAT;
	nome_diarista TEXT;
	id_diarista ALIAS FOR $1;
BEGIN
	SELECT INTO qtd_faxinas COUNT ( * ) FROM faxina WHERE presenca IS NOT NULL AND diarista_id = $1 GROUP BY diarista_id;
	SELECT INTO qtd_presencas COUNT ( * ) FROM faxina WHERE presenca IS TRUE AND diarista_id = $1 GROUP BY diarista_id;
	SELECT INTO qtd_faltas COUNT ( * ) FROM faxina WHERE presenca IS FALSE AND id = $1 GROUP BY diarista_id;
	SELECT INTO nome_diarista nome FROM diarista WHERE id = $1;
	
	porcentagem := qtd_presencas / qtd_faxinas;	
	porcentagem := cast ( ( porcentagem * 100 ) AS NUMERIC(15, 0));
	RETURN 'A diarista ' || nome_diarista || ' tem ' || porcentagem || '% de presenças.';
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION exclui_diarista() RETURNS TRIGGER AS
$$
DECLARE
	qtd_presencas FLOAT;
	qtd_faltas FLOAT;
	qtd_faxinas FLOAT;
	porcentagem FLOAT;
	id_diarista INTEGER;
BEGIN
	id_diarista := NEW.diarista_id;
	SELECT INTO qtd_faxinas COUNT ( * ) FROM faxina WHERE presenca IS NOT NULL AND diarista_id = id_diarista GROUP BY diarista_id;
	SELECT INTO qtd_presencas COUNT ( * ) FROM faxina WHERE presenca IS TRUE AND diarista_id = id_diarista GROUP BY diarista_id;
	SELECT INTO qtd_faltas COUNT ( * ) FROM faxina WHERE presenca IS FALSE AND id = id_diarista GROUP BY diarista_id;
	
	porcentagem := qtd_presencas / qtd_faxinas;	
	porcentagem := cast ( ( porcentagem * 100 ) AS NUMERIC(15, 0));
	
	IF qtd_faxinas >=5 AND porcentagem < 75 THEN
		DELETE FROM faxina WHERE diarista_id = id_diarista;
		DELETE FROM diarista WHERE id = id_diarista;
	END IF;
	
	RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER exclui_diarista AFTER UPDATE ON faxina
FOR EACH ROW EXECUTE PROCEDURE exclui_diarista();
