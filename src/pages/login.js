import { entrar } from "../api.js";
import { salvarSessao } from "../sessao.js";
import { esconderMensagem, mostrarMensagem } from "../ui.js";

export function telaLogin(app) {
  app.innerHTML = `
    <form id="form-login" class="cartao formulario-login">
      <h1>Entrar</h1>
      <p class="detalhe">Acesso restrito à equipe da ONG do Igor.</p>
      <label>
        E-mail
        <input name="email" type="email" required autocomplete="username" />
      </label>
      <label>
        Senha
        <input name="senha" type="password" required autocomplete="current-password" />
      </label>
      <div class="acoes">
        <button type="submit">Entrar</button>
      </div>
      <p id="msg" class="mensagem" role="status" hidden></p>
    </form>
  `;

  const form = app.querySelector("#form-login");
  const botao = form.querySelector('button[type="submit"]');
  const msg = app.querySelector("#msg");
  form.elements.email.focus();

  form.addEventListener("submit", async (evento) => {
    evento.preventDefault();
    botao.disabled = true;
    esconderMensagem(msg);
    try {
      const sessao = await entrar(form.elements.email.value.trim(), form.elements.senha.value);
      salvarSessao(sessao);
      location.hash = "#/doadores";
    } catch (erro) {
      mostrarMensagem(msg, erro.message, "erro");
      form.elements.senha.value = "";
    } finally {
      botao.disabled = false;
    }
  });
}
