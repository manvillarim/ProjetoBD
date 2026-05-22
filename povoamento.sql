-- ---------------------------------------------------------------------
-- Membro_da_Equipe (técnicos + jogadores)
-- ---------------------------------------------------------------------
INSERT INTO Membro_da_Equipe VALUES ('11111111111', 'Carlos Mendes',    45000.00, DATE '1970-03-12', DATE '2020-01-15');
INSERT INTO Membro_da_Equipe VALUES ('22222222222', 'Roberto Silva',    42000.00, DATE '1968-07-22', DATE '2019-06-10');
INSERT INTO Membro_da_Equipe VALUES ('33333333333', 'Marcos Oliveira',  40000.00, DATE '1972-11-05', DATE '2021-03-20');
INSERT INTO Membro_da_Equipe VALUES ('44444444444', 'Antonio Costa',    38000.00, DATE '1965-02-18', DATE '2018-08-01');
INSERT INTO Membro_da_Equipe VALUES ('55555555555', 'Joao Pereira',     25000.00, DATE '1995-05-10', DATE '2022-01-10');
INSERT INTO Membro_da_Equipe VALUES ('66666666666', 'Pedro Almeida',    30000.00, DATE '1993-08-25', DATE '2021-07-15');
INSERT INTO Membro_da_Equipe VALUES ('77777777777', 'Lucas Santos',     28000.00, DATE '1996-12-03', DATE '2022-06-20');
INSERT INTO Membro_da_Equipe VALUES ('88888888888', 'Rafael Lima',      35000.00, DATE '1992-04-17', DATE '2020-02-10');
INSERT INTO Membro_da_Equipe VALUES ('99999999999', 'Bruno Ferreira',   27000.00, DATE '1997-09-14', DATE '2023-01-05');
INSERT INTO Membro_da_Equipe VALUES ('10101010101', 'Diego Souza',      32000.00, DATE '1994-06-30', DATE '2021-11-12');
INSERT INTO Membro_da_Equipe VALUES ('12121212121', 'Felipe Rocha',     26000.00, DATE '1998-01-22', DATE '2023-03-18');
INSERT INTO Membro_da_Equipe VALUES ('13131313131', 'Gabriel Martins',  29000.00, DATE '1995-10-08', DATE '2022-09-25');

-- ---------------------------------------------------------------------
-- Tecnico
-- ---------------------------------------------------------------------
INSERT INTO Tecnico VALUES ('11111111111', 'Tatico Ofensivo');
INSERT INTO Tecnico VALUES ('22222222222', 'Defensivo');
INSERT INTO Tecnico VALUES ('33333333333', 'Preparacao Fisica');
INSERT INTO Tecnico VALUES ('44444444444', 'Tatico Misto');

-- ---------------------------------------------------------------------
-- Equipe 
-- ---------------------------------------------------------------------
INSERT INTO Equipe (Nome, Cidade, Endereco, CPF) VALUES ('Sport Club Recife',  'Recife',  'Rua do Areal, 50 - Ilha do Retiro',   '11111111111');
INSERT INTO Equipe (Nome, Cidade, Endereco, CPF) VALUES ('Santa Cruz FC',      'Recife',  'Rua do Arraial, 2010 - Arruda',       '22222222222');
INSERT INTO Equipe (Nome, Cidade, Endereco, CPF) VALUES ('Nautico Capibaribe', 'Recife',  'Av. Rosa e Silva, 1086 - Aflitos',    '33333333333');
INSERT INTO Equipe (Nome, Cidade, Endereco, CPF) VALUES ('Central SC',         'Caruaru', 'Rua Lasthenio Ferreira - Lacerdao',   '44444444444');

-- ---------------------------------------------------------------------
-- Rivaliza
-- ---------------------------------------------------------------------
INSERT INTO Rivaliza VALUES (1, 2, 'Classico das Multidoes');
INSERT INTO Rivaliza VALUES (1, 3, 'Classico dos Classicos');
INSERT INTO Rivaliza VALUES (2, 3, 'Classico das Emocoes');

-- ---------------------------------------------------------------------
-- Jogador
-- ---------------------------------------------------------------------
INSERT INTO Jogador VALUES ('55555555555', DATE '2022-01-10', 10, 1);
INSERT INTO Jogador VALUES ('66666666666', DATE '2021-07-15',  9, 1);
INSERT INTO Jogador VALUES ('77777777777', DATE '2022-06-20',  7, 2);
INSERT INTO Jogador VALUES ('88888888888', DATE '2020-02-10',  1, 2);
INSERT INTO Jogador VALUES ('99999999999', DATE '2023-01-05', 11, 3);
INSERT INTO Jogador VALUES ('10101010101', DATE '2021-11-12',  5, 3);
INSERT INTO Jogador VALUES ('12121212121', DATE '2023-03-18',  8, 4);
INSERT INTO Jogador VALUES ('13131313131', DATE '2022-09-25',  4, 4);

-- ---------------------------------------------------------------------
-- Posicoes
-- ---------------------------------------------------------------------
INSERT INTO Posicoes VALUES ('55555555555', 'Meia');
INSERT INTO Posicoes VALUES ('55555555555', 'Atacante');
INSERT INTO Posicoes VALUES ('66666666666', 'Atacante');
INSERT INTO Posicoes VALUES ('77777777777', 'Meia');
INSERT INTO Posicoes VALUES ('88888888888', 'Goleiro');
INSERT INTO Posicoes VALUES ('99999999999', 'Atacante');
INSERT INTO Posicoes VALUES ('99999999999', 'Ponta');
INSERT INTO Posicoes VALUES ('10101010101', 'Zagueiro');
INSERT INTO Posicoes VALUES ('12121212121', 'Volante');
INSERT INTO Posicoes VALUES ('13131313131', 'Lateral');

-- ---------------------------------------------------------------------
-- Cartao  
-- ---------------------------------------------------------------------
INSERT INTO Cartao (Jogos_Suspensao) VALUES (0);  -- COD 1
INSERT INTO Cartao (Jogos_Suspensao) VALUES (1);  -- COD 2
INSERT INTO Cartao (Jogos_Suspensao) VALUES (2);  -- COD 3
INSERT INTO Cartao (Jogos_Suspensao) VALUES (3);  -- COD 4

-- ---------------------------------------------------------------------
-- Campeonato 
-- ---------------------------------------------------------------------
INSERT INTO Campeonato (Nome, Tipo, Data_Inicio, Data_Fim) VALUES ('Campeonato Pernambucano 2025', 'Estadual', DATE '2025-01-15', DATE '2025-04-20');
INSERT INTO Campeonato (Nome, Tipo, Data_Inicio, Data_Fim) VALUES ('Copa do Nordeste 2025',        'Regional', DATE '2025-02-01', DATE '2025-06-15');
INSERT INTO Campeonato (Nome, Tipo, Data_Inicio, Data_Fim) VALUES ('Serie B 2025',                 'Nacional', DATE '2025-04-10', DATE '2025-11-30');

-- ---------------------------------------------------------------------
-- Rodada
-- ---------------------------------------------------------------------
INSERT INTO Rodada VALUES (1, 1);
INSERT INTO Rodada VALUES (1, 2);
INSERT INTO Rodada VALUES (1, 3);
INSERT INTO Rodada VALUES (2, 1);
INSERT INTO Rodada VALUES (2, 2);
INSERT INTO Rodada VALUES (3, 1);
INSERT INTO Rodada VALUES (3, 2);

-- ---------------------------------------------------------------------
-- Partida
-- ---------------------------------------------------------------------
INSERT INTO Partida (Placar_V, Placar_M, Data_Jogo, Arbitro, Publico, COD_R, Numero, COD_M, COD_V) VALUES (1, 2, DATE '2025-01-18', 'Jose Ribeiro',    25000, 1, 1, 1, 2);
INSERT INTO Partida (Placar_V, Placar_M, Data_Jogo, Arbitro, Publico, COD_R, Numero, COD_M, COD_V) VALUES (0, 3, DATE '2025-01-25', 'Marcelo Pereira', 18000, 1, 2, 3, 1);
INSERT INTO Partida (Placar_V, Placar_M, Data_Jogo, Arbitro, Publico, COD_R, Numero, COD_M, COD_V) VALUES (2, 2, DATE '2025-02-01', 'Anderson Lima',   22000, 1, 3, 2, 3);
INSERT INTO Partida (Placar_V, Placar_M, Data_Jogo, Arbitro, Publico, COD_R, Numero, COD_M, COD_V) VALUES (1, 1, DATE '2025-02-08', 'Paulo Henrique',  15000, 2, 1, 1, 4);
INSERT INTO Partida (Placar_V, Placar_M, Data_Jogo, Arbitro, Publico, COD_R, Numero, COD_M, COD_V) VALUES (2, 0, DATE '2025-02-15', 'Ricardo Souza',   12000, 2, 2, 2, 4);
INSERT INTO Partida (Placar_V, Placar_M, Data_Jogo, Arbitro, Publico, COD_R, Numero, COD_M, COD_V) VALUES (3, 1, DATE '2025-04-15', 'Eduardo Costa',   28000, 3, 1, 1, 3);
INSERT INTO Partida (Placar_V, Placar_M, Data_Jogo, Arbitro, Publico, COD_R, Numero, COD_M, COD_V) VALUES (2, 2, DATE '2025-04-22', 'Fernando Alves',  20000, 3, 2, 2, 4);

-- ---------------------------------------------------------------------
-- Recebe
-- ---------------------------------------------------------------------
INSERT INTO Recebe VALUES ('55555555555', 1, 1, 23, 'Falta tatica no meio-campo');
INSERT INTO Recebe VALUES ('66666666666', 2, 2, 78, 'Agressao a adversario');
INSERT INTO Recebe VALUES ('88888888888', 1, 3, 30, 'Atraso na cobranca');
INSERT INTO Recebe VALUES ('99999999999', 3, 3, 88, 'Acumulo de dois amarelos');
INSERT INTO Recebe VALUES ('10101010101', 1, 4, 15, 'Carrinho perigoso');
INSERT INTO Recebe VALUES ('55555555555', 1, 5, 60, 'Falta dura');
INSERT INTO Recebe VALUES ('12121212121', 3, 6, 70, 'Acumulo de dois amarelos');
INSERT INTO Recebe VALUES ('66666666666', 4, 7, 82, 'Agressao fora da disputa de bola');

-- ---------------------------------------------------------------------
-- Empresa
-- ---------------------------------------------------------------------
INSERT INTO Empresa VALUES ('11222333000144', 'Banco Nordeste S.A.');
INSERT INTO Empresa VALUES ('22333444000155', 'Cervejaria Pitu Ltda.');
INSERT INTO Empresa VALUES ('33444555000166', 'Supermercados Bompreco');
INSERT INTO Empresa VALUES ('44555666000177', 'Telecom Pernambuco');

-- ---------------------------------------------------------------------
-- Patrocina 
-- ---------------------------------------------------------------------
INSERT INTO Patrocina VALUES (1, '11222333000144', DATE '2025-01-10',  500000.00);
INSERT INTO Patrocina VALUES (1, '22333444000155', DATE '2025-01-12',  350000.00);
INSERT INTO Patrocina VALUES (2, '33444555000166', DATE '2025-01-28',  450000.00);
INSERT INTO Patrocina VALUES (2, '44555666000177', DATE '2025-02-05',  600000.00);
INSERT INTO Patrocina VALUES (3, '11222333000144', DATE '2025-04-01', 1200000.00);
INSERT INTO Patrocina VALUES (3, '44555666000177', DATE '2025-04-05',  900000.00);

-- ---------------------------------------------------------------------
-- Acao_Promocional
-- ---------------------------------------------------------------------
INSERT INTO Acao_Promocional (Tipo, Data_Acao, Descricao, COD_P, CNPJ, DATA_P) VALUES ('Sorteio',  DATE '2025-02-10', 'Sorteio de camisas autografadas durante o intervalo', 1, '11222333000144', DATE '2025-01-10');
INSERT INTO Acao_Promocional (Tipo, Data_Acao, Descricao, COD_P, CNPJ, DATA_P) VALUES ('Brinde',   DATE '2025-02-20', 'Distribuicao de chaveiros nas entradas do estadio',    1, '22333444000155', DATE '2025-01-12');
INSERT INTO Acao_Promocional (Tipo, Data_Acao, Descricao, COD_P, CNPJ, DATA_P) VALUES ('Promocao', DATE '2025-03-05', 'Desconto de 20% em produtos no supermercado',         2, '33444555000166', DATE '2025-01-28');
INSERT INTO Acao_Promocional (Tipo, Data_Acao, Descricao, COD_P, CNPJ, DATA_P) VALUES ('Sorteio',  DATE '2025-03-15', 'Sorteio de planos de telefonia',                       2, '44555666000177', DATE '2025-02-05');
INSERT INTO Acao_Promocional (Tipo, Data_Acao, Descricao, COD_P, CNPJ, DATA_P) VALUES ('Brinde',   DATE '2025-05-01', 'Brindes para os 1000 primeiros torcedores',            3, '11222333000144', DATE '2025-04-01');
INSERT INTO Acao_Promocional (Tipo, Data_Acao, Descricao, COD_P, CNPJ, DATA_P) VALUES ('Promocao', DATE '2025-06-10', 'Plano de internet com desconto para socios',           3, '44555666000177', DATE '2025-04-05');

COMMIT;