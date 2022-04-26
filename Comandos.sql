--Alterando tipos de dados de uma coluna

ALTER TABLE brasileiraotab
ALTER COLUMN rodada INT;

--Lista de campeonatos com datas disponíveis na tabela na ordem crescente

SELECT DISTINCT ano_campeonato
FROM brasileiraotab
ORDER BY ano_campeonato ASC;

--Lista de campeonatos com datas disponíveis na tabela na ordem decrescente

SELECT DISTINCT ano_campeonato
FROM brasileiraotab
ORDER BY ano_campeonato DESC;

--Lista de times que participaram de cada campeonato

SELECT DISTINCT ano_campeonato, time_man
FROM brasileiraotab
ORDER BY ano_campeonato ASC;

--Lista de times que participaram do campeonato no período em ordem alfabética

SELECT DISTINCT time_man
FROM brasileiraotab
ORDER BY time_man ASC;

--Lista de times que participaram de cada um dos campeonatos, em ordem alfabética

SELECT DISTINCT time_man, ano_campeonato
FROM brasileiraotab
ORDER BY ano_campeonato;

--Quantidade de times que participaram de cada um dos campeonatos, em ordem alfabética

SELECT COUNT(DISTINCT time_man), ano_campeonato
FROM brasileiraotab
GROUP BY ano_campeonato
ORDER BY ano_campeonato;

--Lista de estádios diferentes em que cada time jogou

SELECT DISTINCT time_man, estadio, ano_campeonato
FROM brasileiraotab
ORDER BY ano_campeonato;

--Lista de estádios em que o Vasco da gama jogou no período

SELECT DISTINCT time_man, estadio, ano_campeonato
FROM brasileiraotab
WHERE time_man = 'Vasco da Gama'
ORDER BY ano_campeonato;

--Quantidade de estádios diferentes em que o Vasco da Gama jogou no período

SELECT COUNT(DISTINCT estadio)
FROM brasileiraotab
WHERE time_man = 'Vasco da Gama';

--Lista de times que técnicos treinaram times mandantes desde 2008

SELECT DISTINCT tecnico_man, time_man
FROM brasileiraotab
WHERE tecnico_man <> 'Null' AND ano_campeonato > 2007;

--Número de técnicos que treinaram times mandantes desde 2008

SELECT COUNT (DISTINCT tecnico_man)
FROM brasileiraotab
WHERE tecnico_man <> 'Null' AND ano_campeonato > 2007;

--Média de público desde 2007 quando com portões abertos

SELECT ano_campeonato, AVG(publico) AS 'media de publico'
FROM brasileiraotab
WHERE publico >= 0 
GROUP BY ano_campeonato
ORDER BY ano_campeonato ASC;

--Média de público desde 2007 quando com portões abertos do time Corinthians como mandante

SELECT ano_campeonato, time_man, AVG(publico) AS 'media de publico'
FROM brasileiraotab
WHERE publico >= 0 and time_man = 'Corinthians'
GROUP BY ano_campeonato, time_man
ORDER BY ano_campeonato ASC;

-- Lista dos 20 maiores públicos de 2007 a 2020 no Campeonato Brasileiro

SELECT TOP 20 publico, ano_campeonato, data, estadio, time_man, gols_man, time_vis, gols_vis
FROM brasileiraotab
WHERE publico > 0
ORDER BY PUBLICO DESC;

--Média de público de cada time como mandante desde 2007 quando com portões abertos

SELECT DISTINCT(time_man),ano_campeonato, AVG(publico) AS 'media de publico'
FROM brasileiraotab
WHERE publico >= 0 
GROUP BY time_man, ano_campeonato
ORDER BY ano_campeonato ASC;

-- Lista dos 20 maiores públicos de 2014 a 2019 no Campeonato Brasileiro

SELECT TOP 20 publico, ano_campeonato, data, estadio, time_man, gols_man, time_vis, gols_vis
FROM brasileiraotab
WHERE publico > 0 AND ano_campeonato BETWEEN 2014 AND 2019
ORDER BY PUBLICO DESC;

-- Lista dos 50 maiores públicos em que Botafogo e Fluminense figuram como mandantes de 2007 a 2020 no Campeonato Brasileiro

SELECT TOP 50 publico, ano_campeonato, data, estadio, time_man, gols_man, time_vis, gols_vis
FROM brasileiraotab
WHERE publico > 0 AND time_man IN('Botafogo', 'Fluminense')
ORDER BY PUBLICO DESC;

--Lista de jogos DE 2018 que começaram no intervalo entre as 10 e 11 horas no horário da tabela (18 horas no horario local) 

SELECT ano_campeonato, data, horario, time_man, gols_man, time_vis, gols_vis 
FROM brasileiraotab
WHERE ano_campeonato = 2018 AND horario LIKE '10%';

-- Lista do maior público de 2007 a 2020 no Campeonato Brasileiro

SELECT MAX (publico) AS 'maior publico'
FROM brasileiraotab
WHERE publico > 0 ;

-- Lista do menor público de 2007 a 2020 no Campeonato Brasileiro

SELECT TOP 20 MIN (publico) AS 'menor publico'
FROM brasileiraotab
WHERE publico > 0 ;

--Total de público nos campeonatos de 2009 a 2019

SELECT ano_campeonato, SUM (publico) AS 'Publico total no campeonato'
FROM brasileiraotab
WHERE ano_campeonato BETWEEN 2008 AND 2019
GROUP BY ano_campeonato
ORDER BY ano_campeonato ASC;

-- Campeonatos de 2009 a 2019 com publico total maior que 6000000

SELECT ano_campeonato, SUM (publico) AS 'Publico total no campeonato'
FROM brasileiraotab
GROUP BY ano_campeonato
HAVING SUM(publico) > 6000000 
ORDER BY ano_campeonato ASC;

-- Numero de jogos nos meses de novembro

SELECT ano_campeonato, COUNT(*) AS 'Numero de Jogos', DATEPART(month, data) AS 'Mes'
FROM brasileiraotab
WHERE DATEPART(month, data) = 11
GROUP BY ano_campeonato, DATEPART(month, data);

-- Unindo as colunas data e horario

SELECT CONCAT(data, ' ----- ', horario)
FROM brasileiraotab;

-- Deixando as letras dos estadios em maiusculo

SELECT UPPER (estadio)
FROM brasileiraotab;

-- Deixando as letras dos estadios em minusculo

SELECT LOWER(estadio)
FROM brasileiraotab;

-- Verificando o numero de letras de cada estadio contando os espaços entre os nomes

SELECT LEN(estadio)
FROM brasileiraotab;

--Substituindo o '-' por '/' na coluna data

SELECT REPLACE(data, '-', '/')
FROM brasileiraotab;

--Verificando o percentual da ocupação dos estadios com portoes abertos

SELECT (publico * 100) / publico_max AS 'Percentual de ocupação'
FROM brasileiraotab 
WHERE publico > 0 AND publico_max > 0;

--Verificando os jogos em que tivemos lotação acima de 50% em jogos do Flamengo

SELECT ano_campeonato, data, time_man, time_vis ,(publico * 100) / publico_max AS 'Percentual de ocupação'
FROM brasileiraotab 
WHERE ((publico * 100) / publico_max) > 50 AND time_man = 'Flamengo' AND ano_campeonato > 2012
ORDER BY ano_campeonato ASC;