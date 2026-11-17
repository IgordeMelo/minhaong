// Guarda o token e o usuário logado no navegador.
// Na Aula 4, o token é o que prova para a API quem está usando o sistema.

const CHAVE = "ongdoigor:sessao";

export function sessaoAtual() {
  try {
    return JSON.parse(localStorage.getItem(CHAVE));
  } catch {
    return null;
  }
}

export function salvarSessao(sessao) {
  localStorage.setItem(CHAVE, JSON.stringify(sessao));
}

export function encerrarSessao() {
  localStorage.removeItem(CHAVE);
}
