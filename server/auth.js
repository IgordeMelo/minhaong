import jwt from "jsonwebtoken";

const VALIDADE = "8h"; // depois disso, o usuário precisa entrar de novo

export function gerarToken(usuario) {
  return jwt.sign(
    { id_usuario: usuario.id_usuario, nome: usuario.nome, perfil: usuario.perfil },
    process.env.JWT_SECRET,
    { expiresIn: VALIDADE },
  );
}

// Middleware: só deixa passar quem enviar um token válido no cabeçalho
// Authorization: Bearer <token>. Os dados do token ficam em req.usuario.
export function autenticar(req, res, next) {
  const [tipo, token] = (req.headers.authorization ?? "").split(" ");
  if (tipo !== "Bearer" || !token) {
    return res.status(401).json({ erro: "Faça login para continuar" });
  }
  try {
    req.usuario = jwt.verify(token, process.env.JWT_SECRET);
    next();
  } catch {
    res.status(401).json({ erro: "Sessão inválida ou expirada. Entre novamente" });
  }
}
