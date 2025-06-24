--1
SELECT * FROM ambulatorios
WHERE capacidade > 30;

--2
SELECT * FROM medicos
WHERE idade < 40 OR especialidade = 'traumatologia';

--3
SELECT codm, codp FROM consultas
WHERE hora >= '13:00:00' AND data > '2018-10-15';

--4
SELECT nome, idade FROM pacientes
WHERE cidade <> 'Florianópolis';

--5
SELECT nome, idade * 12 AS idade_em_meses FROM pacientes;

--6
SELECT 
    MIN(salario) AS menor_salario,
    MAX(salario) AS maior_salario
FROM funcionarios
WHERE cidade = 'Florianópolis';

--7
SELECT 
    AVG(idade) AS media_idade,
    COUNT(DISTINCT nroa) AS total_ambulatorios
FROM medicos;

--8
SELECT 
    codf,
    nome,
    salario - (salario * 0.20) AS salario_liquido
FROM funcionarios;

--9
SELECT nome, especialidade FROM medicos
WHERE SUBSTRING(nome, 2, 1) = 'o'
  AND RIGHT(nome, 1) = 'o';

--10
SELECT CPF, nome, idade FROM medicos
WHERE cidade = 'Florianópolis'
UNION
SELECT CPF, nome, idade FROM pacientes
WHERE cidade = 'Florianópolis'
UNION
SELECT CPF, nome, idade FROM funcionarios
WHERE cidade = 'Florianópolis';
