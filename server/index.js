import "dotenv/config";
import express from "express";
import { autenticar } from "./auth.js";
import db from "./db.js";
import doacoes from "./routes/doacoes.js";
import doadores from "./routes/doadores.js";
import itens from "./routes/itens.js";
import login from "./routes/login.js";

if (!process.env.JWT_SECRET) {
  console.error("Falta a variável JWT_SECRET no arquivo .env (veja o .env.example).");
  process.exit(1);
}

const app = express();
app.use(express.json());

// Rotas públicas
app.get("/api/health", async (req, res) => {
  let banco = "ok";
  try {
    await db.query("SELECT 1");
  } catch {
    banco = "sem conexão";
  }
  res.json({ status: "ok", banco, app: "ONG do Igor", hora: new Date().toISOString() });
});

app.use("/api/login", login);

// Rotas protegidas: sem token válido, respondem 401
app.use("/api/doadores", autenticar, doadores);
app.use("/api/itens", autenticar, itens);
app.use("/api/doacoes", autenticar, doacoes);

// Tratamento final de erros: qualquer erro não tratado nas rotas chega aqui.
app.use((erro, req, res, _next) => {
  if (erro.type === "entity.parse.failed") {
    return res.status(400).json({ erro: "JSON inválido no corpo da requisição" });
  }
  console.error(erro);
  res.status(500).json({ erro: "Erro interno no servidor" });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`API rodando em http://localhost:${PORT}`);
});
