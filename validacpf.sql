CREATE OR REPLACE FUNCTION validaCPF(cpf text) RETURNS boolean AS
$$
DECLARE
num1 INTEGER;
num2 INTEGER;
num3 INTEGER;
num4 INTEGER;
num5 INTEGER;
num6 INTEGER;
num7 INTEGER;
num8 INTEGER;
num9 INTEGER;
num10 INTEGER;
num11 INTEGER;
soma1 INTEGER;
soma2 INTEGER;
resto1 REAL;
resto2 REAL;
BEGIN
num1 := CAST(substring(cpf from 1 for 1) AS INTEGER);
num2 := CAST(substring(cpf from 2 for 1) AS INTEGER);
num3 := CAST(substring(cpf from 3 for 1) AS INTEGER);
num4 := CAST(substring(cpf from 4 for 1) AS INTEGER);
num5 := CAST(substring(cpf from 5 for 1) AS INTEGER);
num6 := CAST(substring(cpf from 6 for 1) AS INTEGER);
num7 := CAST(substring(cpf from 7 for 1) AS INTEGER);
num8 := CAST(substring(cpf from 8 for 1) AS INTEGER);
num9 := CAST(substring(cpf from 9 for 1) AS INTEGER);
num10 := CAST(substring(cpf from 10 for 1) AS INTEGER);
num11 := CAST(substring(cpf from 11 for 1) AS INTEGER);
soma1 := num1 * 10 + num2 * 9 + num3 * 8 + num4 * 7 + num5 * 6 + num6 * 5 +
num7 * 4 + num8 * 3 + num9 * 2;
resto1 := (soma1 * 10) % 11;
IF resto1 = 10 THEN
resto1 := 0;
END IF;
soma2 := num1 * 11 + num2 * 10 + num3 * 9 + num4 * 8 + num5 * 7 + num6 * 6
+ num7 * 5 + num8 * 4 + num9 * 3 + num10 * 2;resto2 := (soma2 * 10) % 11;
IF (resto2 = 10) THEN
resto2 := 0;
END IF;
IF ((resto1 = num10) AND (resto2 = num11)) THEN
RETURN TRUE;
ELSE
RETURN FALSE;
END IF;
END
$$ LANGUAGE 'plpgsql';