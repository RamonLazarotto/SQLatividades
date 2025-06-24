--Crie Visões para as seguintes questões
--1
CREATE VIEW vw_pacientes_nao_florianopolis AS
SELECT nome, idade
FROM pacientes
WHERE cidade <> 'Florianópolis';

--2
CREATE VIEW vw_media_idade_total_ambulatorios AS
SELECT AVG(idade) AS media_idade,
       COUNT(DISTINCT nroa) AS total_ambulatorios
FROM medicos;

--3
CREATE VIEW vw_media_idade_por_especialidade AS
SELECT especialidade, AVG(idade) AS media_idade
FROM medicos
GROUP BY especialidade;

--4
CREATE VIEW vw_pessoas_florianopolis AS
SELECT CPF, nome, idade FROM medicos WHERE cidade = 'Florianópolis'
UNION
SELECT CPF, nome, idade FROM pacientes WHERE cidade = 'Florianópolis'
UNION
SELECT CPF, nome, idade FROM funcionarios WHERE cidade = 'Florianópolis';

--5
CREATE VIEW vw_medicos_que_sao_pacientes AS
SELECT nome, CPF
FROM medicos
WHERE CPF IN (SELECT CPF FROM pacientes);

--6
CREATE VIEW vw_ambulatorios_sem_medicos AS
SELECT nroa, andar
FROM ambulatorios
WHERE nroa NOT IN (SELECT nroa FROM medicos);

--7
CREATE VIEW vw_medico_mais_velho AS
SELECT nome, idade
FROM medicos
WHERE idade >= ALL (SELECT idade FROM medicos);

--8
CREATE VIEW vw_medicos_1andar AS
SELECT m.nome, m.especialidade
FROM medicos m
JOIN ambulatorios a ON m.nroa = a.nroa
WHERE a.andar = 1;

--9
CREATE VIEW vw_pacientes_consulta_apos_14h AS
SELECT DISTINCT p.codp, p.nome
FROM pacientes p
JOIN consultas c ON p.codp = c.codp
WHERE c.hora > '14:00:00';

--10
CREATE VIEW vw_medicos_e_suas_consultas AS
SELECT m.CPF AS cpf_medico, m.nome AS nome_medico,
       p.CPF AS cpf_paciente, p.nome AS nome_paciente,
       c.data AS data_consulta
FROM medicos m
LEFT JOIN consultas c ON m.codm = c.codm
LEFT JOIN pacientes p ON c.codp = p.codp;

--11
CREATE VIEW vw_medicos_consultam_todos_pacientes AS
SELECT nome, CPF
FROM medicos m
WHERE NOT EXISTS (
    SELECT 1 FROM pacientes p
    WHERE NOT EXISTS (
        SELECT 1 FROM consultas c
        WHERE c.codm = m.codm AND c.codp = p.codp
    )
);
