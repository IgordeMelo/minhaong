-- ONG do Igor · schema.sql
-- Recria o banco do zero. Pode ser executado várias vezes seguidas.
--
-- Relacionamentos do MER:
--   doador    1:N doacao        (um doador faz várias doações)
--   usuario   1:N doacao        (um usuário da ONG registra várias doações)
--   doacao    N:N item          (tabela associativa doacao_item)
--   categoria 1:N item          (cada item pertence a uma categoria)
--   familia   1:N entrega       (uma família recebe várias entregas)
--   usuario   1:N entrega       (um usuário da ONG registra várias entregas)
--   entrega   N:N item          (tabela associativa entrega_item)
--
-- LGPD: não guardamos CPF nem endereço completo de doadores e famílias,
-- porque a ONG não usa esses dados. Da família, basta o bairro para
-- organizar as rotas de entrega.

SET NAMES utf8mb4;

DROP DATABASE IF EXISTS ongdoigor;
CREATE DATABASE ongdoigor CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ongdoigor;

-- Pessoas da ONG que usam o sistema (login na Aula 4)
CREATE TABLE usuario (
  id_usuario    INT AUTO_INCREMENT PRIMARY KEY,
  nome          VARCHAR(150) NOT NULL,
  email         VARCHAR(100) NOT NULL UNIQUE,
  senha_hash    VARCHAR(255) NOT NULL,
  perfil        ENUM('coordenador', 'voluntario') NOT NULL DEFAULT 'voluntario',
  ativo         BOOLEAN NOT NULL DEFAULT TRUE,
  data_cadastro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Pessoas ou empresas que doam para a ONG
CREATE TABLE doador (
  id_doador     INT AUTO_INCREMENT PRIMARY KEY,
  nome          VARCHAR(150) NOT NULL,
  email         VARCHAR(100) UNIQUE,
  telefone      VARCHAR(20),
  tipo          ENUM('pessoa', 'empresa') NOT NULL DEFAULT 'pessoa',
  ativo         BOOLEAN NOT NULL DEFAULT TRUE,
  data_cadastro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Agrupa os itens: Alimento, Higiene, Vestuário...
CREATE TABLE categoria (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nome         VARCHAR(60) NOT NULL UNIQUE
);

-- Catálogo do que a ONG recebe e distribui, com o estoque atual
CREATE TABLE item (
  id_item      INT AUTO_INCREMENT PRIMARY KEY,
  id_categoria INT NOT NULL,
  nome         VARCHAR(150) NOT NULL UNIQUE,
  unidade      VARCHAR(20) NOT NULL DEFAULT 'unidade',
  estoque      INT NOT NULL DEFAULT 0 CHECK (estoque >= 0),
  ativo        BOOLEAN NOT NULL DEFAULT TRUE,
  FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria)
);

-- Cada doação recebida pela ONG
CREATE TABLE doacao (
  id_doacao    INT AUTO_INCREMENT PRIMARY KEY,
  id_doador    INT NOT NULL,
  id_usuario   INT,
  data_doacao  DATE NOT NULL,
  status       ENUM('pendente', 'recebida', 'cancelada') NOT NULL DEFAULT 'recebida',
  observacao   VARCHAR(255),
  data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_doador) REFERENCES doador (id_doador),
  FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON DELETE SET NULL
);

-- Itens de cada doação (N:N entre doacao e item)
CREATE TABLE doacao_item (
  id_doacao  INT NOT NULL,
  id_item    INT NOT NULL,
  quantidade INT NOT NULL CHECK (quantidade > 0),
  PRIMARY KEY (id_doacao, id_item),
  FOREIGN KEY (id_doacao) REFERENCES doacao (id_doacao) ON DELETE CASCADE,
  FOREIGN KEY (id_item) REFERENCES item (id_item)
);

-- Famílias atendidas pela ONG
CREATE TABLE familia (
  id_familia       INT AUTO_INCREMENT PRIMARY KEY,
  nome_responsavel VARCHAR(150) NOT NULL,
  telefone         VARCHAR(20),
  bairro           VARCHAR(100) NOT NULL,
  qtd_pessoas      INT NOT NULL DEFAULT 1 CHECK (qtd_pessoas > 0),
  ativo            BOOLEAN NOT NULL DEFAULT TRUE,
  data_cadastro    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Cada entrega de itens para uma família
CREATE TABLE entrega (
  id_entrega   INT AUTO_INCREMENT PRIMARY KEY,
  id_familia   INT NOT NULL,
  id_usuario   INT,
  data_entrega DATE NOT NULL,
  observacao   VARCHAR(255),
  data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_familia) REFERENCES familia (id_familia),
  FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON DELETE SET NULL
);

-- Itens de cada entrega (N:N entre entrega e item)
CREATE TABLE entrega_item (
  id_entrega INT NOT NULL,
  id_item    INT NOT NULL,
  quantidade INT NOT NULL CHECK (quantidade > 0),
  PRIMARY KEY (id_entrega, id_item),
  FOREIGN KEY (id_entrega) REFERENCES entrega (id_entrega) ON DELETE CASCADE,
  FOREIGN KEY (id_item) REFERENCES item (id_item)
);
