# MinhaONG

Sistema de gestão para a ONG MinhaONG, desenvolvido no Projeto Integrador Extensionista II.

O projeto tem duas partes: o frontend, servido pelo Vite+ em http://localhost:5173, e a API em Express, que roda em http://localhost:3000. O Vite+ repassa (proxy) toda chamada a `/api` para a API.

## Requisitos

- [Git](https://git-scm.com)
- [Vite+](https://viteplus.dev) (comando `vp`), que já gerencia o Node.js

## Como rodar

```bash
git clone https://github.com/seu-usuario/minhaong.git
cd minhaong
vp install
cp .env.example .env    # no Windows (PowerShell): copy .env.example .env
```

Em um terminal, suba a API:

```bash
vp run api
```

Em outro terminal, suba o frontend:

```bash
vp dev
```

Abra http://localhost:5173. A página deve mostrar **Status da API: ok** com a data e a hora.

## Rotas da API

| Método | Rota          | Resposta                                   |
| ------ | ------------- | ------------------------------------------ |
| GET    | `/api/health` | `{ "status": "ok", "app": "...", "hora": "..." }` |

## Variáveis de ambiente

| Variável | Para que serve          | Exemplo |
| -------- | ----------------------- | ------- |
| `PORT`   | porta em que a API roda | `3000`  |
