-- Limpeza (ordem reversa por causa das FKs)
DROP TABLE IF EXISTS Acao_Promocional CASCADE;
DROP TABLE IF EXISTS Patrocina        CASCADE;
DROP TABLE IF EXISTS Empresa          CASCADE;
DROP TABLE IF EXISTS Recebe           CASCADE;
DROP TABLE IF EXISTS Partida          CASCADE;
DROP TABLE IF EXISTS Rodada           CASCADE;
DROP TABLE IF EXISTS Campeonato       CASCADE;
DROP TABLE IF EXISTS Cartao           CASCADE;
DROP TABLE IF EXISTS Posicoes         CASCADE;
DROP TABLE IF EXISTS Jogador          CASCADE;
DROP TABLE IF EXISTS Rivaliza         CASCADE;
DROP TABLE IF EXISTS Time             CASCADE;
DROP TABLE IF EXISTS Tecnico          CASCADE;
DROP TABLE IF EXISTS Membro_da_Equipe CASCADE;

-- ---------------------------------------------------------------------
-- Membro_da_Equipe(CPF, Nome, Salário, Data_Nascimento, Data_Contratação)
-- ---------------------------------------------------------------------
CREATE TABLE Membro_da_Equipe (
    CPF              VARCHAR(11)   PRIMARY KEY,
    Nome             VARCHAR(100)  NOT NULL,
    Salario          NUMERIC(10,2) NOT NULL,
    Data_Nascimento  DATE          NOT NULL,
    Data_Contratacao DATE          NOT NULL
);

-- ---------------------------------------------------------------------
-- Tecnico(CPF, Especialidade)  -- CPF -> Membro_da_Equipe
-- ---------------------------------------------------------------------
CREATE TABLE Tecnico (
    CPF           VARCHAR(11) PRIMARY KEY,
    Especialidade VARCHAR(60) NOT NULL,
    CONSTRAINT fk_tecnico_membro
        FOREIGN KEY (CPF) REFERENCES Membro_da_Equipe(CPF)
);

-- ---------------------------------------------------------------------
-- Time(COD, Nome, Cidade, Endereço, [CPF]!)
-- CPF UNIQUE e NOT NULL (cada técnico dirige no máximo um time)
-- ---------------------------------------------------------------------
CREATE TABLE Time (
    COD      SERIAL       PRIMARY KEY,
    Nome     VARCHAR(80)  NOT NULL,
    Cidade   VARCHAR(60)  NOT NULL,
    Endereco VARCHAR(150) NOT NULL,
    CPF      VARCHAR(11)  NOT NULL UNIQUE,
    CONSTRAINT fk_time_tecnico
        FOREIGN KEY (CPF) REFERENCES Tecnico(CPF)
);

-- ---------------------------------------------------------------------
-- Rivaliza(COD_1, COD_2, Apelido_Classico)
-- ---------------------------------------------------------------------
CREATE TABLE Rivaliza (
    COD_1            INT NOT NULL,
    COD_2            INT NOT NULL,
    Apelido_Classico VARCHAR(80) NOT NULL,
    PRIMARY KEY (COD_1, COD_2),
    CONSTRAINT fk_riv_time1 FOREIGN KEY (COD_1) REFERENCES Time(COD),
    CONSTRAINT fk_riv_time2 FOREIGN KEY (COD_2) REFERENCES Time(COD),
    CONSTRAINT chk_riv_distintos CHECK (COD_1 <> COD_2)
);

-- ---------------------------------------------------------------------
-- Jogador(CPF, Data_Entrou, Numero_Camisa, COD)
-- ---------------------------------------------------------------------
CREATE TABLE Jogador (
    CPF           VARCHAR(11) PRIMARY KEY,
    Data_Entrou   DATE        NOT NULL,
    Numero_Camisa INT         NOT NULL,
    COD           INT         NOT NULL,
    CONSTRAINT fk_jog_membro FOREIGN KEY (CPF) REFERENCES Membro_da_Equipe(CPF),
    CONSTRAINT fk_jog_time   FOREIGN KEY (COD) REFERENCES Time(COD),
    CONSTRAINT uq_camisa_time UNIQUE (COD, Numero_Camisa)
);

-- ---------------------------------------------------------------------
-- Posicoes(CPF, Posicao)  -- atributo multivalorado
-- ---------------------------------------------------------------------
CREATE TABLE Posicoes (
    CPF     VARCHAR(11) NOT NULL,
    Posicao VARCHAR(30) NOT NULL,
    PRIMARY KEY (CPF, Posicao),
    CONSTRAINT fk_pos_jogador FOREIGN KEY (CPF) REFERENCES Jogador(CPF)
);

-- ---------------------------------------------------------------------
-- Cartao(COD, Jogos_Suspensão)
-- ---------------------------------------------------------------------
CREATE TABLE Cartao (
    COD              SERIAL PRIMARY KEY,
    Jogos_Suspensao  INT    NOT NULL
);

-- ---------------------------------------------------------------------
-- Campeonato(COD, Nome, Tipo, Data_Inicio, Data_Fim)
-- ---------------------------------------------------------------------
CREATE TABLE Campeonato (
    COD         SERIAL       PRIMARY KEY,
    Nome        VARCHAR(100) NOT NULL,
    Tipo        VARCHAR(40)  NOT NULL,
    Data_Inicio DATE         NOT NULL,
    Data_Fim    DATE         NOT NULL
);

-- ---------------------------------------------------------------------
-- Rodada(COD, Numero)  -- entidade fraca de Campeonato
-- ---------------------------------------------------------------------
CREATE TABLE Rodada (
    COD    INT NOT NULL,
    Numero INT NOT NULL,
    PRIMARY KEY (COD, Numero),
    CONSTRAINT fk_rod_camp FOREIGN KEY (COD) REFERENCES Campeonato(COD)
);

-- ---------------------------------------------------------------------
-- Partida(ID, Placar_V, Placar_M, Data, Arbitro, Publico, COD_R, Numero, COD_M, COD_V)
-- ---------------------------------------------------------------------
CREATE TABLE Partida (
    ID       SERIAL       PRIMARY KEY,
    Placar_V INT          NOT NULL,
    Placar_M INT          NOT NULL,
    Data     DATE         NOT NULL,
    Arbitro  VARCHAR(100) NOT NULL,
    Publico  INT          NOT NULL,
    COD_R    INT          NOT NULL,
    Numero   INT          NOT NULL,
    COD_M    INT          NOT NULL,
    COD_V    INT          NOT NULL,
    CONSTRAINT fk_part_rodada  FOREIGN KEY (COD_R, Numero) REFERENCES Rodada(COD, Numero),
    CONSTRAINT fk_part_mandante FOREIGN KEY (COD_M) REFERENCES Time(COD),
    CONSTRAINT fk_part_visitante FOREIGN KEY (COD_V) REFERENCES Time(COD),
    CONSTRAINT chk_part_times_distintos CHECK (COD_M <> COD_V)
);

-- ---------------------------------------------------------------------
-- Recebe(CPF, COD, ID, Minuto, Motivo)
-- ---------------------------------------------------------------------
CREATE TABLE Recebe (
    CPF    VARCHAR(11)  NOT NULL,
    COD    INT          NOT NULL,
    ID     INT          NOT NULL,
    Minuto INT          NOT NULL,
    Motivo VARCHAR(150) NOT NULL,
    PRIMARY KEY (CPF, COD, ID),
    CONSTRAINT fk_rec_jog     FOREIGN KEY (CPF) REFERENCES Jogador(CPF),
    CONSTRAINT fk_rec_cartao  FOREIGN KEY (COD) REFERENCES Cartao(COD),
    CONSTRAINT fk_rec_partida FOREIGN KEY (ID)  REFERENCES Partida(ID)
);

-- ---------------------------------------------------------------------
-- Empresa(CNPJ, Nome)
-- ---------------------------------------------------------------------
CREATE TABLE Empresa (
    CNPJ VARCHAR(14)  PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

-- ---------------------------------------------------------------------
-- Patrocina(COD, CNPJ, DATA, Valor)
-- ---------------------------------------------------------------------
CREATE TABLE Patrocina (
    COD   INT           NOT NULL,
    CNPJ  VARCHAR(14)   NOT NULL,
    DATA  DATE          NOT NULL,
    Valor NUMERIC(12,2) NOT NULL,
    PRIMARY KEY (COD, CNPJ, DATA),
    CONSTRAINT fk_pat_camp    FOREIGN KEY (COD)  REFERENCES Campeonato(COD),
    CONSTRAINT fk_pat_empresa FOREIGN KEY (CNPJ) REFERENCES Empresa(CNPJ)
);

-- ---------------------------------------------------------------------
-- Acao_Promocional(COD, Tipo, Data, Descrição, COD_P, CNPJ, DATA_P)
-- (COD_P, CNPJ, DATA_P) -> Patrocina(COD, CNPJ, DATA)
-- ---------------------------------------------------------------------
CREATE TABLE Acao_Promocional (
    COD       SERIAL       PRIMARY KEY,
    Tipo      VARCHAR(40)  NOT NULL,
    Data      DATE         NOT NULL,
    Descricao VARCHAR(255) NOT NULL,
    COD_P     INT          NOT NULL,
    CNPJ      VARCHAR(14)  NOT NULL,
    DATA_P    DATE         NOT NULL,
    CONSTRAINT fk_acao_patrocina
        FOREIGN KEY (COD_P, CNPJ, DATA_P) REFERENCES Patrocina(COD, CNPJ, DATA)
);
