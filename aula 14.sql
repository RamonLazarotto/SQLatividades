--Resolva o que se pede utilizando subconsultas [NOT] IN
--1
SELECT nome, CPF
FROM medicos
WHERE CPF IN (
    SELECT CPF FROM pacientes
);

--2
SELECT codp, nome
FROM pacientes
WHERE codp IN (
    SELECT codp
    FROM consultas
    WHERE hora > '14:00:00'
);

--3
SELECT nome, idade
FROM medicos
WHERE codm IN (
    SELECT codm
    FROM consultas
    WHERE codp = (
        SELECT codp
        FROM pacientes
        WHERE nome = 'Ana'
    )
);

--4
SELECT nroa, andar
FROM ambulatorios
WHERE nroa NOT IN (
    SELECT nroa
    FROM medicos
);

--Resolva o que se pede utilizando subconsultas ANY e/ou ALL
--1
SELECT nroa, andar
FROM ambulatorios
WHERE capacidade > ALL (
    SELECT capacidade
    FROM ambulatorios
    WHERE capacidade IS NOT NULL
);

--2
SELECT nome, idade
FROM medicos
WHERE idade <= ALL (
    SELECT idade
    FROM medicos
);

--3
SELECT nome, CPF
FROM pacientes
WHERE codp IN (
    SELECT codp
    FROM consultas
    WHERE hora < ALL (
        SELECT hora
        FROM consultas
        WHERE data = '2016-10-14'
    )
);

--4
SELECT nome, CPF
FROM medicos
WHERE nroa NOT IN (
    SELECT nroa
    FROM ambulatorios
    WHERE capacidade > ALL (
        SELECT capacidade
        FROM ambulatorios
        WHERE andar = 2
    )
);
