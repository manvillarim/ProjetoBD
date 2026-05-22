-- ---------------------------------------------------------------------
-- 1) GROUP BY / HAVING
-- ---------------------------------------------------------------------
SELECT  t.Nome              AS time_nome,
        COUNT(r.CPF)        AS total_cartoes
FROM    Equipe t
JOIN    Jogador j ON j.COD = t.COD
JOIN    Recebe  r ON r.CPF = j.CPF
GROUP BY t.COD, t.Nome
HAVING  COUNT(r.CPF) > 1
ORDER BY total_cartoes DESC;


-- ---------------------------------------------------------------------
-- 2) JUNÇÃO INTERNA (INNER JOIN)
-- ---------------------------------------------------------------------
SELECT  p.ID                             AS partida_id,
        tm.Nome                          AS mandante,
        tv.Nome                          AS visitante,
        p.Placar_M || ' x ' || p.Placar_V AS placar,
        c.Nome                           AS campeonato,
        p.Numero                         AS rodada,
        p.Data_Jogo                      AS data_partida
FROM    Partida p
INNER JOIN Equipe       tm ON tm.COD = p.COD_M
INNER JOIN Equipe       tv ON tv.COD = p.COD_V
INNER JOIN Rodada     r  ON r.COD = p.COD_R AND r.Numero = p.Numero
INNER JOIN Campeonato c  ON c.COD = r.COD
ORDER BY p.Data_Jogo;


-- ---------------------------------------------------------------------
-- 3) JUNÇÃO EXTERNA (LEFT OUTER JOIN)
-- ---------------------------------------------------------------------
SELECT  m.Nome              AS jogador,
        t.Nome              AS time_nome,
        r.Minuto            AS minuto_cartao,
        r.Motivo            AS motivo,
        c.Jogos_Suspensao   AS suspensao
FROM    Jogador j
JOIN    Membro_da_Equipe m ON m.CPF = j.CPF
JOIN    Equipe t             ON t.COD = j.COD
LEFT OUTER JOIN Recebe r   ON r.CPF = j.CPF
LEFT OUTER JOIN Cartao c   ON c.COD = r.COD
ORDER BY m.Nome;


-- ---------------------------------------------------------------------
-- 4) SEMI-JUNÇÃO (EXISTS)
-- ---------------------------------------------------------------------
SELECT  c.COD, c.Nome, c.Tipo, c.Data_Inicio, c.Data_Fim
FROM    Campeonato c
WHERE   EXISTS (
            SELECT *
            FROM   Patrocina p
            WHERE  p.COD = c.COD
        );


-- ---------------------------------------------------------------------
-- 5) ANTI-JUNÇÃO (NOT EXISTS)
-- ---------------------------------------------------------------------
SELECT  m.CPF, m.Nome, t.Nome AS time_nome, j.Numero_Camisa
FROM    Jogador j
JOIN    Membro_da_Equipe m ON m.CPF = j.CPF
JOIN    Equipe t             ON t.COD = j.COD
WHERE   NOT EXISTS (
            SELECT *
            FROM   Recebe r
            WHERE  r.CPF = j.CPF
        )
ORDER BY m.Nome;


-- ---------------------------------------------------------------------
-- 6) SUBCONSULTA ESCALAR
-- ---------------------------------------------------------------------
SELECT  p.ID,
        tm.Nome AS mandante,
        tv.Nome AS visitante,
        p.Publico,
        (SELECT AVG(Publico) FROM Partida) AS media_publico
FROM    Partida p
JOIN    Equipe tm ON tm.COD = p.COD_M
JOIN    Equipe tv ON tv.COD = p.COD_V
WHERE   p.Publico > (SELECT AVG(Publico) FROM Partida)
ORDER BY p.Publico DESC;


-- ---------------------------------------------------------------------
-- 7) SUBCONSULTA DE LINHA 
-- ---------------------------------------------------------------------
SELECT  p.ID, p.Data_Jogo, p.Placar_M, p.Placar_V, p.Publico,
        tm.Nome AS mandante, tv.Nome AS visitante
FROM    Partida p
JOIN    Equipe tm ON tm.COD = p.COD_M
JOIN    Equipe tv ON tv.COD = p.COD_V
WHERE   (p.Placar_M, p.Placar_V) IN (
            SELECT Placar_M, Placar_V
            FROM   Partida
            WHERE  Publico = (SELECT MAX(Publico) FROM Partida)
        );

-- ---------------------------------------------------------------------
-- 8) SUBCONSULTA DE TABELA
-- ---------------------------------------------------------------------
SELECT  t.COD, t.Nome, t.Cidade
FROM    Equipe t
WHERE   t.COD IN (
            SELECT j.COD
            FROM   Jogador j
            JOIN   Recebe  r ON r.CPF = j.CPF
            JOIN   Cartao  c ON c.COD = r.COD
            WHERE  c.Jogos_Suspensao >= 1
        );

-- ---------------------------------------------------------------------
-- 9) OPERAÇÃO DE CONJUNTO (UNION)
-- ---------------------------------------------------------------------
SELECT  m.CPF, m.Nome, 'Tecnico' AS funcao
FROM    Membro_da_Equipe m
JOIN    Tecnico tc ON tc.CPF = m.CPF
UNION
SELECT  m.CPF, m.Nome, 'Jogador' AS funcao
FROM    Membro_da_Equipe m
JOIN    Jogador j ON j.CPF = m.CPF
ORDER BY funcao, Nome;
