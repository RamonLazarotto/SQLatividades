--● Responda utilizando subconsultas com EXISTS
--1
SELECT nome, CPF
FROM medicos m
WHERE EXISTS (
    SELECT 1
    FROM pacientes p
    WHERE p.CPF = m.CPF
);

--2
SELECT m.nome, m.CPF, c.data
FROM medicos m
JOIN consultas c ON m.codm = c.codm
WHERE m.especialidade = 'ortopedia'
  AND EXISTS (
    SELECT 1
    FROM pacientes p
    JOIN consultas c2 ON p.codp = c2.codp AND c2.codm = m.codm
    WHERE p.nome = 'Ana'
);

--3
SELECT nome, CPF
FROM medicos m
WHERE EXISTS (
    SELECT 1
    FROM consultas c
    WHERE c.codm = m.codm
);

--4
SELECT nome, CPF
FROM medicos m
WHERE especialidade = 'ortopedia'
  AND NOT EXISTS (
    SELECT 1
    FROM pacientes p
    WHERE p.cidade = 'Florianópolis'
      AND NOT EXISTS (
          SELECT 1
          FROM consultas c
          WHERE c.codm = m.codm AND c.codp = p.codp
      )
);

--Responda utilizando ORDER BY e GROUP BY
--1
SELECT *
FROM funcionarios
ORDER BY salario DESC, idade ASC
LIMIT 3;

--2
SELECT m.nome, a.nroa, a.andar
FROM medicos m
JOIN ambulatorios a ON m.nroa = a.nroa
ORDER BY a.nroa;

--3
SELECT data, COUNT(*) AS total_consultas
FROM consultas
WHERE hora > '12:00:00'
GROUP BY data
ORDER BY data;

--4
SELECT andar, SUM(capacidade) AS capacidade_total
FROM ambulatorios
GROUP BY andar
ORDER BY andar;

--5
SELECT andar
FROM ambulatorios
GROUP BY andar
HAVING AVG(capacidade) >= 40
ORDER BY andar;

--6
SELECT m.nome
FROM medicos m
JOIN consultas c ON m.codm = c.codm
GROUP BY m.codm, m.nome
HAVING COUNT(*) > 1
ORDER BY m.nome;
