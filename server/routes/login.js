import bcrypt from "bcryptjs";
import { Router } from "express";
import { gerarToken } from "../auth.js";
import db from "../db.js";

const router = Router();

// POST /api/login: confere e-mail e senha e devolve um token JWT
router.post("/", async (req, res) => {
  const { email, senha } = req.body ?? {};
  if (typeof email !== "string" || typeof senha !== "string" || !email || !senha) {
    return res.status(400).json({ erro: "Informe e-mail e senha" });
  }

  const [linhas] = await db.execute(
    "SELECT id_usuario, nome, perfil, senha_hash FROM usuario WHERE email = ? AND ativo = TRUE",
    [email.trim()],
  );
  const usuario = linhas[0];

  // Mesma mensagem para e-mail inexistente e senha errada: não revela quais e-mails existem
  if (!usuario || !(await bcrypt.compare(senha, usuario.senha_hash))) {
    return res.status(401).json({ erro: "E-mail ou senha incorretos" });
  }

  res.json({
    token: gerarToken(usuario),
    usuario: { id_usuario: usuario.id_usuario, nome: usuario.nome, perfil: usuario.perfil },
  });
});

export default router;
