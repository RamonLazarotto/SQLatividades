--Para as seguintes tabelas, crie as seguintes restrições de checagem:
--1
-- a) Ambulatorios: andar >= 0, capacidade >= 1
ALTER TABLE ambulatorios
ADD CONSTRAINT chk_ambulatorios_andar CHECK (andar >= 0);

ALTER TABLE ambulatorios
ADD CONSTRAINT chk_ambulatorios_capacidade CHECK (capacidade >= 1);

-- b) Medicos: idade >= 16
ALTER TABLE medicos
ADD CONSTRAINT chk_medicos_idade CHECK (idade >= 16);

-- c) Pacientes: idade >= 0
ALTER TABLE pacientes
ADD CONSTRAINT chk_pacientes_idade CHECK (idade >= 0);

-- d) Funcionarios: idade >= 0, salario >= 0
ALTER TABLE funcionarios
ADD CONSTRAINT chk_funcionarios_idade CHECK (idade >= 0);

ALTER TABLE funcionarios
ADD CONSTRAINT chk_funcionarios_salario CHECK (salario >= 0);

--2
ALTER TABLE medicos
ADD CONSTRAINT unq_medicos_cpf UNIQUE (CPF);

ALTER TABLE pacientes
ADD CONSTRAINT unq_pacientes_cpf UNIQUE (CPF);

ALTER TABLE funcionarios
ADD CONSTRAINT unq_funcionarios_cpf UNIQUE (CPF);

--3
CREATE FUNCTION idade_em_meses(codp INT)
RETURNS INT
BEGIN
  DECLARE meses INT;
  SELECT idade * 12 INTO meses FROM pacientes WHERE codp = codp;
  RETURN meses;
END;

--4
DELIMITER //

CREATE FUNCTION fn_inserir_paciente(
    p_nome VARCHAR(40),
    p_idade SMALLINT,
    p_cidade CHAR(30),
    p_cpf NUMERIC(11),
    p_doenca VARCHAR(40)
) RETURNS INT
BEGIN
    INSERT INTO pacientes(nome, idade, cidade, CPF, doenca)
    VALUES (p_nome, p_idade, p_cidade, p_cpf, p_doenca);

    RETURN LAST_INSERT_ID();
END //

DELIMITER ;

--b
DELIMITER //

CREATE FUNCTION fn_atualizar_paciente(
    p_codp INT,
    p_nome VARCHAR(40),
    p_idade SMALLINT,
    p_cidade CHAR(30),
    p_cpf NUMERIC(11),
    p_doenca VARCHAR(40)
) RETURNS VOID
BEGIN
    UPDATE pacientes
    SET nome = p_nome,
        idade = p_idade,
        cidade = p_cidade,
        CPF = p_cpf,
        doenca = p_doenca
    WHERE codp = p_codp;
    
    RETURN NULL;
END //

DELIMITER ;

--c
DELIMITER //

CREATE FUNCTION fn_excluir_paciente(p_codp INT) RETURNS INT
BEGIN
    DELETE FROM pacientes WHERE codp = p_codp;
    RETURN NULL;
END //

DELIMITER ;

--
