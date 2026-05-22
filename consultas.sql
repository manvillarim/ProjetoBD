-- ---------------------------------------------------------------------
-- 1) GROUP BY / HAVING
-- Listar os times que receberam mais de 1 cartão no total,
-- mostrando o nome do time e a quantidade de cartões.
-- ---------------------------------------------------------------------
SELECT  t.Nome              AS time_nome,
        COUNT(r.CPF)        AS total_cartoes
FROM    Time t
JOIN    Jogador j ON j.COD = t.COD
JOIN    Recebe  r ON r.CPF = j.CPF
GROUP BY t.COD, t.Nome
HAVING  COUNT(r.CPF) > 1
ORDER BY total_cartoes DESC;


-- ---------------------------------------------------------------------
-- 2) JUNÇÃO INTERNA (INNER JOIN)
-- Listar todas as partidas com nome do time mandante, visitante,
-- nome do campeonato e número da rodada.
-- ---------------------------------------------------------------------
SELECT  p.ID                AS partida_id,
        tm.Nome             AS mandante,
        tv.Nome             AS visitante,
        p.Placar_M || ' x ' || p.Placar_V  AS placar,
        c.Nome              AS campeonato,
        p.Numero            AS rodada,
        p.Data              AS data_partida
FROM    Partida p
INNER JOIN Time       tm ON tm.COD = p.COD_M
INNER JOIN Time       tv ON tv.COD = p.COD_V
INNER JOIN Rodada     r  ON r.COD = p.COD_R AND r.Numero = p.Numero
INNER JOIN Campeonato c  ON c.COD = r.COD
ORDER BY p.Data;


-- ---------------------------------------------------------------------
-- 3) JUNÇÃO EXTERNA (LEFT OUTER JOIN)
-- Listar TODOS os jogadores e, se houver, os cartões recebidos.
-- Jogadores sem cartão devem aparecer com NULL.
-- ---------------------------------------------------------------------
SELECT  m.Nome              AS jogador,
        t.Nome              AS time_nome,
        r.Minuto            AS minuto_cartao,
        r.Motivo            AS motivo,
        c.Jogos_Suspensao   AS suspensao
FROM    Jogador j
JOIN    Membro_da_Equipe m ON m.CPF = j.CPF
JOIN    Time t             ON t.COD = j.COD
LEFT OUTER JOIN Recebe r   ON r.CPF = j.CPF
LEFT OUTER JOIN Cartao c   ON c.COD = r.COD
ORDER BY m.Nome;


-- ---------------------------------------------------------------------
-- 4) SEMI-JUNÇÃO (EXISTS)
-- Listar os campeonatos que possuem ao menos uma empresa patrocinadora.
-- ---------------------------------------------------------------------
SELECT  c.COD, c.Nome, c.Tipo, c.Data_Inicio, c.Data_Fim
FROM    Campeonato c
WHERE   EXISTS (
            SELECT 1
            FROM   Patrocina p
            WHERE  p.COD = c.COD
        );


-- ---------------------------------------------------------------------
-- 5) ANTI-JUNÇÃO (NOT EXISTS)
-- Listar os jogadores que NUNCA receberam cartão.
-- ---------------------------------------------------------------------
SELECT  m.CPF, m.Nome, t.Nome AS time_nome, j.Numero_Camisa
FROM    Jogador j
JOIN    Membro_da_Equipe m ON m.CPF = j.CPF
JOIN    Time t             ON t.COD = j.COD
WHERE   NOT EXISTS (
            SELECT 1
            FROM   Recebe r
            WHERE  r.CPF = j.CPF
        )
ORDER BY m.Nome;


-- ---------------------------------------------------------------------
-- 6) SUBCONSULTA ESCALAR
-- Listar partidas cujo público foi acima da média geral de público.
-- ---------------------------------------------------------------------
SELECT  p.ID,
        tm.Nome AS mandante,
        tv.Nome AS visitante,
        p.Publico,
        (SELECT AVG(Publico) FROM Partida) AS media_publico
FROM    Partida p
JOIN    Time tm ON tm.COD = p.COD_M
JOIN    Time tv ON tv.COD = p.COD_V
WHERE   p.Publico > (SELECT AVG(Publico) FROM Partida)
ORDER BY p.Publico DESC;


-- ---------------------------------------------------------------------
-- 7) SUBCONSULTA DE LINHA (ROW SUBQUERY)
-- Listar partidas cujo par (placar_mandante, placar_visitante) seja
-- igual ao par da partida com maior público.
-- A subconsulta retorna UMA linha com dois valores — comparada à tupla
-- (Placar_M, Placar_V) da partida externa.
-- ---------------------------------------------------------------------
SELECT  p.ID, p.Data, p.Placar_M, p.Placar_V, p.Publico,
        tm.Nome AS mandante, tv.Nome AS visitante
FROM    Partida p
JOIN    Time tm ON tm.COD = p.COD_M
JOIN    Time tv ON tv.COD = p.COD_V
WHERE   (p.Placar_M, p.Placar_V) = (
            SELECT Placar_M, Placar_V
            FROM   Partida
            ORDER BY Publico DESC
            LIMIT 1
        );


-- ---------------------------------------------------------------------
-- 8) SUBCONSULTA DE TABELA (DERIVED TABLE / IN)
-- Listar os times que tiveram pelo menos um jogador com cartão vermelho
-- (cartões com suspensão >= 1).
-- ---------------------------------------------------------------------
SELECT  t.COD, t.Nome, t.Cidade
FROM    Time t
WHERE   t.COD IN (
            SELECT j.COD
            FROM   Jogador j
            JOIN   Recebe  r ON r.CPF = j.CPF
            JOIN   Cartao  c ON c.COD = r.COD
            WHERE  c.Jogos_Suspensao >= 1
        );


-- Variante: subconsulta de tabela na cláusula FROM (derived table)
-- Para cada time, calcular o total de cartões e ranquear.
SELECT  ranking.time_nome, ranking.total_cartoes
FROM    (
            SELECT  t.Nome AS time_nome,
                    COUNT(r.CPF) AS total_cartoes
            FROM    Time t
            LEFT JOIN Jogador j ON j.COD = t.COD
            LEFT JOIN Recebe  r ON r.CPF = j.CPF
            GROUP BY t.COD, t.Nome
        ) AS ranking
ORDER BY ranking.total_cartoes DESC;


-- ---------------------------------------------------------------------
-- 9) OPERAÇÃO DE CONJUNTO (UNION)
-- Listar TODOS os membros da equipe — diferenciando técnicos e jogadores
-- num único resultado.
-- ---------------------------------------------------------------------
SELECT  m.CPF, m.Nome, 'Técnico' AS funcao
FROM    Membro_da_Equipe m
JOIN    Tecnico tc ON tc.CPF = m.CPF
UNION
SELECT  m.CPF, m.Nome, 'Jogador' AS funcao
FROM    Membro_da_Equipe m
JOIN    Jogador j ON j.CPF = m.CPF
ORDER BY funcao, Nome;


-- Operação de conjunto adicional: INTERSECT
-- Times que são mandantes E visitantes em algum momento (devem aparecer
-- em ambos os papéis).
SELECT COD_M AS COD FROM Partida
INTERSECT
SELECT COD_V AS COD FROM Partida;


-- Operação de conjunto adicional: EXCEPT
-- Times que NUNCA jogaram como mandantes.
SELECT COD FROM Time
EXCEPT
SELECT COD_M FROM Partida;
