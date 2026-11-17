# ONG do Igor

Sistema de gestão de doações para a ONG do Igor. Projeto Integrador Extensionista II · ADS.

Com ele, a equipe da ONG cadastra doadores, registra as doações recebidas (com um ou mais itens) e consulta o histórico de doações. O acesso exige login.

## Requisitos

- Git
- Vite+ (comando `vp`): https://viteplus.dev
- MySQL ou MariaDB rodando localmente (por exemplo, pelo XAMPP)

## Como rodar

1. Clone o repositório e entre na pasta:
   ```bash
   git clone https://github.com/IgordeMelo/minhaong.git
   cd minhaong
   ```
2. Instale as dependências: `vp install`
3. Crie o banco: no cliente do MySQL, rode `SOURCE database/schema.sql;` e depois `SOURCE database/seed.sql;` (no phpMyAdmin, cole o conteúdo de cada arquivo na aba SQL e clique em Executar)
4. Copie `.env.example` para `.env` e preencha `DB_USER`, `DB_PASSWORD` e `JWT_SECRET` (um texto longo e aleatório)
5. Terminal 1, inicie a API: `vp run api`
6. Terminal 2, inicie o frontend: `vp dev`
7. Abra http://localhost:5173

### Usuário de demonstração

| Campo  | Valor                  |
| ------ | ---------------------- |
| E-mail | voluntario@exemplo.com |
| Senha  | ongdoigor123           |

## Telas

| Endereço       | Tela                                              |
| -------------- | ------------------------------------------------- |
| #/login        | Entrada no sistema                                |
| #/doadores     | Listagem, cadastro, edição e exclusão de doadores |
| #/doacoes/nova | Registro de doação com um ou mais itens           |
| #/doacoes      | Listagem de doações com doador, data e itens      |

## API

| Método | Rota              | Faz                       | Login? |
| ------ | ----------------- | ------------------------- | ------ |
| GET    | /api/health       | saúde da API e do banco   | não    |
| POST   | /api/login        | devolve o token JWT       | não    |
| GET    | /api/doadores     | lista doadores            | sim    |
| GET    | /api/doadores/:id | busca um doador           | sim    |
| POST   | /api/doadores     | cadastra doador           | sim    |
| PUT    | /api/doadores/:id | edita doador              | sim    |
| DELETE | /api/doadores/:id | exclui doador sem doações | sim    |
| GET    | /api/itens        | catálogo de itens         | sim    |
| GET    | /api/doacoes      | lista doações com itens   | sim    |
| POST   | /api/doacoes      | registra doação com itens | sim    |

Sem token válido, as rotas protegidas respondem 401. Os testes manuais de todas as rotas estão em `api.http` (extensão REST Client do VS Code).

## Estrutura

```
index.html          página principal: topo, navegação e <main id="app">
src/main.js         escolhe a tela pelo endereço depois do # e controla o login
src/api.js          todas as chamadas fetch para a API (envia o token)
src/sessao.js       guarda o token do usuário logado
src/ui.js           funções de apoio (criar elementos, mensagens, datas)
src/pages/          login.js, doadores.js e doacoes.js
src/style.css       estilos mobile-first
server/             API Express (index.js, db.js, auth.js, validacao.js, routes/)
database/           schema.sql e seed.sql
api.http            testes manuais da API
```
