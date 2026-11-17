import "./style.css";
import { verificarSaude } from "./api.js";
import { telaDoacoes, telaNovaDoacao } from "./pages/doacoes.js";
import { telaDoadores } from "./pages/doadores.js";
import { telaLogin } from "./pages/login.js";
import { encerrarSessao, sessaoAtual } from "./sessao.js";

const app = document.querySelector("#app");
const menu = document.querySelector("#menu");
const areaSessao = document.querySelector("#sessao");
const nomeUsuario = document.querySelector("#nome-usuario");

// Cada endereço depois do # mostra uma tela
const rotas = {
  "#/login": telaLogin,
  "#/doadores": telaDoadores,
  "#/doacoes/nova": telaNovaDoacao,
  "#/doacoes": telaDoacoes,
};

function navegar() {
  const sessao = sessaoAtual();
  let rota = rotas[location.hash] ? location.hash : "#/doadores";

  // Sem login, só a tela de login. Já logado, não faz sentido voltar a ela.
  if (!sessao && rota !== "#/login") rota = "#/login";
  if (sessao && rota === "#/login") rota = "#/doadores";
  if (location.hash !== rota) {
    location.hash = rota; // dispara hashchange, que chama navegar() de novo
    return;
  }

  menu.hidden = !sessao;
  areaSessao.hidden = !sessao;
  nomeUsuario.textContent = sessao?.usuario.nome ?? "";

  for (const link of menu.querySelectorAll("a")) {
    if (link.getAttribute("href") === rota) link.setAttribute("aria-current", "page");
    else link.removeAttribute("aria-current");
  }
  rotas[rota](app);
}

document.querySelector("#sair").addEventListener("click", () => {
  encerrarSessao();
  location.hash = "#/login";
});

window.addEventListener("hashchange", navegar);
navegar();

// Indicador no rodapé, herdado da Aula 1
const statusApi = document.querySelector("#status-api");
verificarSaude()
  .then((saude) => (statusApi.textContent = `${saude.status}, banco: ${saude.banco}`))
  .catch(() => (statusApi.textContent = "fora do ar"));
