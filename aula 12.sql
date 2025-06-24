--Responda o que se pede utilizando produto cartesiano
--1
SELECT m.nome, m.cpf
FROM medico m, paciente p
WHERE m.cpf = p.cpf;

--2
SELECT m.nome, m.especialidade
FROM medico m, ambulatorio a
WHERE m.nro_ambulatorio = a.numero
  AND a.andar = 1;

--3
SELECT m.nome, m.idade
FROM medico m, consulta c, paciente p
WHERE c.crm_medico = m.idmedico
  AND c.cod_paciente = p.codigo
  AND p.nome = 'Ana';

--4
SELECT a2.numero
FROM ambulatorio a1, ambulatorio a2
WHERE a1.numero = 5
  AND a2.andar = a1.andar;

--Responda o que se pede utilizando junção (JOIN)
--5
SELECT a.numero, a.andar
FROM medico m
JOIN ambulatorio a ON m.nro_ambulatorio = a.numero
WHERE m.especialidade = 'Ortopedia';

--6
SELECT f.codigo AS cod_funcionario, f.nome AS nome_funcionario,
       m.idmedico AS cod_medico, m.nome AS nome_medico
FROM funcionario f
JOIN medico m ON f.cidade = m.cidade;

--7
SELECT DISTINCT m.idmedico, m.nome
FROM medico m
JOIN consulta c ON m.idmedico = c.crm_medico
WHERE c.hora < '12:00'
  AND m.idade < (
      SELECT idade
      FROM medico
      WHERE nome = 'Maria'
  );


--8
SELECT f.nome, f.salario
FROM funcionario f
JOIN funcionario c ON f.cidade = c.cidade
WHERE c.nome = 'Carlos'
  AND f.salario > c.salario;

--Responda o que se pede utilizando Junção Natural
--1
SELECT codigo, nome
FROM paciente
NATURAL JOIN consulta
WHERE hora > '14:00';

--2
SELECT numero, andar
FROM ambulatorio
NATURAL JOIN medico
NATURAL JOIN consulta
WHERE data = '2018-10-12';

--3
SELECT m.nome, m.cpf, m.especialidade
FROM medico m
NATURAL JOIN consulta
NATURAL JOIN paciente
WHERE paciente.doenca = 'tendinite';

--Responda o que se pede utilizando junção externa
--4
SELECT a.numero, a.andar, m.idmedico, m.nome
FROM ambulatorio a
LEFT JOIN medico m ON a.numero = m.nro_ambulatorio;

--5
SELECT m.cpf AS cpf_medico, m.nome AS nome_medico,
       p.cpf AS cpf_paciente, p.nome AS nome_paciente,
       c.data
FROM medico m
LEFT JOIN consulta c ON m.idmedico = c.crm_medico
LEFT JOIN paciente p ON c.cod_paciente = p.codigo;

--Realizar as seguintes atualizações no BD:
--1
UPDATE pacientes
SET cidade = 'Ilhota'
WHERE nome = 'Paulo';

--2
UPDATE consultas
SET hora = '12:00:00'
WHERE codm = 1 AND codp = 4 AND data = '2018-11-04';

--3
UPDATE pacientes
SET idade = idade + 1,
    doenca = 'câncer'
WHERE nome = 'Ana';

--4
UPDATE consultas
SET hora = hora + INTERVAL '1 hour 30 minutes'
WHERE codm = 3 AND codp = 4;

--5
DELETE FROM funcionarios
WHERE nome = 'Carlos';

--6
DELETE FROM consultas
WHERE hora = '19:00:00';

--7
DELETE FROM pacientes
WHERE doenca = 'câncer' OR idade < 10;

--8
DELETE FROM medicos
WHERE cidade IN ('Biguaçu', 'Palhoça');