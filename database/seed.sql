-- ONG do Igor · seed.sql
-- Dados de exemplo. Rode depois do schema.sql.

SET NAMES utf8mb4;
USE ongdoigor;

-- Usuário de demonstração: voluntario@exemplo.com / ongdoigor123
-- A senha fica guardada só como hash bcrypt, nunca em texto puro.
INSERT INTO usuario (nome, email, senha_hash, perfil) VALUES
  ('Voluntário Demonstração', 'voluntario@exemplo.com',
   '$2b$10$gxHEhTKuKpSDrBVaVNHzvuzdCgbictiM/f5i2avUERQ0lHkAP5Pqe', 'voluntario');

INSERT INTO categoria (nome) VALUES
  ('Alimento'),
  ('Higiene'),
  ('Vestuário');

INSERT INTO item (id_categoria, nome, unidade) VALUES
  (1, 'Arroz 5 kg', 'pacote'),
  (1, 'Feijão 1 kg', 'pacote'),
  (1, 'Óleo de soja 900 ml', 'garrafa'),
  (1, 'Leite em pó 400 g', 'lata'),
  (2, 'Sabonete', 'unidade'),
  (2, 'Creme dental', 'unidade'),
  (2, 'Fralda infantil', 'pacote'),
  (3, 'Agasalho', 'peça'),
  (3, 'Cobertor', 'unidade');

INSERT INTO doador (nome, email, telefone, tipo) VALUES
  ('Mercado Bom Preço', 'contato@bompreco.exemplo.com', '(11) 3333-1000', 'empresa'),
  ('Ana Souza', 'ana.souza@exemplo.com', '(11) 98888-1001', 'pessoa'),
  ('Carlos Lima', NULL, '(11) 97777-1002', 'pessoa'),
  ('Paróquia São José', 'secretaria@psaojose.exemplo.com', NULL, 'empresa');

INSERT INTO doacao (id_doador, id_usuario, data_doacao, observacao) VALUES
  (1, 1, '2026-10-05', 'Entrega feita pelo próprio mercado'),
  (2, 1, '2026-10-12', NULL),
  (4, 1, '2026-10-18', 'Campanha do agasalho');

INSERT INTO doacao_item (id_doacao, id_item, quantidade) VALUES
  (1, 1, 10),
  (1, 2, 15),
  (1, 3, 8),
  (2, 5, 12),
  (2, 6, 12),
  (3, 8, 20),
  (3, 9, 6);

INSERT INTO familia (nome_responsavel, telefone, bairro, qtd_pessoas) VALUES
  ('Maria Oliveira', '(11) 95555-2001', 'Jardim das Flores', 4),
  ('José Santos', NULL, 'Vila Nova', 2);

INSERT INTO entrega (id_familia, id_usuario, data_entrega, observacao) VALUES
  (1, 1, '2026-10-20', 'Cesta básica do mês');

INSERT INTO entrega_item (id_entrega, id_item, quantidade) VALUES
  (1, 1, 1),
  (1, 2, 2);
