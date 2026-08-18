# Plano de execução

O protótipo já resolve o fluxo, a copy e o cálculo. O que falta é o que transforma isso em sistema: persistência, identificação do respondente e segurança. As fases estão ordenadas por dependência, não por esforço.

---

## Fase 0 — repositório e demonstração interna

Objetivo: colocar no ar o que já existe, para circular internamente e alinhar antes de construir.

- Repositório criado, `CLAUDE.md` e `docs/` no lugar.
- `prototipo/index.html` publicado (Vercel, Netlify ou GitHub Pages — é arquivo único, sem build).

**Atenção:** fora do runtime de artifacts, `window.storage` não existe e o adaptador `DB` cai para memória. As respostas somem ao recarregar. Para a demonstração interna isso basta; não use para coletar nada real.

**Aceite:** link abre em desktop e celular, os dois caminhos (redesign ativo / voltou) completam sem erro, painel abre com os dados de demonstração.

---

## Fase 1 — persistência real

Objetivo: coletar de verdade.

O protótipo foi escrito com um adaptador de storage isolado justamente para isso. Trocar significa reimplementar quatro métodos (`get`, `set`, `del`, `all`) — nada mais no app muda.

```js
const DB = {
  async set(k, v) { /* POST /api/respostas */ },
  async all()     { /* GET  /api/respostas?wave=... */ },
  // ...
};
```

Modelo mínimo:

| tabela | campos |
|---|---|
| `respostas` | `codigo` (PK), `wave`, `criado_em`, `cliente_id`, `tipo_org`, `papel`, `tempo`, `freq`, `status`, `nota`, `nota_why`, `u1`, `u2`, `legado` (json), `legado_worse`, `ces` (json), `sat` (json), `admin`, `admin_why`, `risco`, `risco_why`, `one_thing`, `time_sink`, `rev_*` |
| `contatos` | `codigo` (FK), `nome`, `email` — **tabela separada**, acesso restrito |
| `convites` | `token` (PK), `cliente_id`, `papel`, `wave`, `enviado_em`, `respondido_em` |

**Aceite:** duas respostas enviadas de dispositivos diferentes aparecem no painel; recarregar não perde nada; rascunho sobrevive a fechar a aba.

---

## Fase 2 — link tokenizado por respondente

Objetivo: encurtar a pesquisa e viabilizar a amostragem rotativa.

- Rota `/pesquisa/:token` com órgão e função pré-preenchidos — elimina duas telas.
- Token identifica a pessoa entre ondas, o que faz o *streak* do programa de embaixadores funcionar de verdade.
- Base dividida em 3–4 blocos comparáveis em perfil, rotacionando por onda.

**Aceite:** o convite de uma onda leva a pessoa direto para a tela de status; a mesma pessoa reconhecida na onda seguinte sobe de nível.

---

## Fase 3 — status do redesign vindo do sistema

Objetivo: parar de depender de auto-declaração.

O 1Doc já sabe quem tem o redesign ativo. Usar esse dado e manter a pergunta apenas como conferência:

- Elimina o erro de auto-declaração (hoje há gente que responde "não sei qual versão estou usando").
- Permite **convidar dirigidamente quem desativou o redesign** — exatamente quem nunca responderia por conta própria uma pesquisa sobre o redesign.
- Divergência entre o dado do sistema e a resposta da pessoa vira métrica própria: percepção da virada.

**Aceite:** taxa de reversão calculada a partir do dado do sistema, com a divergência declarada/real reportada ao lado.

---

## Fase 4 — painel com autenticação de servidor

- Login no servidor, com perfil de acesso. A checagem no navegador do protótipo sai.
- Cortes por onda, tipo de organização, órgão, papel e tempo de uso.
- Exportação da onda para análise fora do sistema.

**Aceite:** ninguém acessa o painel sem sessão válida; o corte por tipo de organização recalcula todos os índices.

---

## Fase 5 — agrupamento de temas por IA, no servidor

A chamada à API da Anthropic passa a ser feita por um endpoint próprio. **Chave nunca no cliente.**

- `POST /api/temas` recebe a onda, devolve os grupos.
- Resultado cacheado por onda: o agrupamento não precisa rodar a cada abertura do painel.
- A taxonomia fixa continua valendo em paralelo — ela dá tendência comparável, a IA dá descoberta.

**Aceite:** painel agrupa os temas sem que exista qualquer chave no bundle; segunda abertura da mesma onda não refaz a chamada.

---

## Fase 6 — página do embaixador

`/minha-jornada`: nível, ondas seguidas e o status real de cada sugestão — recebida → em análise → no roadmap → entregue.

Esta é a fase que impede a taxa de resposta de cair na terceira onda. As pessoas respondem pesquisa quando veem que ela importa, e essa página é a prova.

**Aceite:** com o código de acompanhamento, a pessoa vê o andamento das sugestões que ela mesma enviou.

---

## Fora de escopo por decisão

- NPS — mede o produto, não o redesign. Se o CS precisar, é outra pesquisa.
- Nota para `Criar novos processos` e `Administrativo` — ainda não estão no redesign. Quando migrarem, entram no bloco de áreas e saem da pergunta de atrito.
- Jornada de criação e de edição de fluxo — não existem ainda no redesign.
