--1
CREATE OR REPLACE FUNCTION fn_maiusculo_paciente()
RETURNS TRIGGER AS $$
BEGIN
  NEW.nome := UPPER(NEW.nome);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--2
CREATE TABLE log (
  identificador SERIAL PRIMARY KEY,
  tabela VARCHAR(50),
  operacao VARCHAR(10),
  dadosNovos TEXT,
  dadosAntigos TEXT
);

--3
CREATE OR REPLACE FUNCTION fn_log_geral()
RETURNS TRIGGER AS $$
DECLARE
  novos TEXT;
  antigos TEXT;
BEGIN
  IF TG_OP = 'UPDATE' THEN
    novos := row_to_json(NEW)::TEXT;
    antigos := row_to_json(OLD)::TEXT;

    INSERT INTO log (tabela, operacao, dadosNovos, dadosAntigos)
    VALUES (TG_TABLE_NAME, 'UPDATE', novos, antigos);

    RETURN NEW;

  ELSIF TG_OP = 'DELETE' THEN
    antigos := row_to_json(OLD)::TEXT;

    INSERT INTO log (tabela, operacao, dadosNovos, dadosAntigos)
    VALUES (TG_TABLE_NAME, 'DELETE', NULL, antigos);

    RETURN OLD;
  END IF;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

--4
CREATE TRIGGER trg_update_ambulatorios
AFTER UPDATE ON ambulatorios
FOR EACH ROW
EXECUTE FUNCTION fn_log_geral();

CREATE TRIGGER trg_delete_ambulatorios
AFTER DELETE ON ambulatorios
FOR EACH ROW
EXECUTE FUNCTION fn_log_geral();
