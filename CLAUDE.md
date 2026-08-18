# CLAUDE.md — regras de execução

Leia este arquivo antes de qualquer alteração. Ele existe para impedir que decisões já fechadas sejam desfeitas.

## O que é este projeto

Sistema de pesquisa recorrente sobre **o redesign do 1Doc** (Softplan). Mede se o redesign entregou o que prometeu, e principalmente entende **quem desativou o redesign e voltou para o layout anterior**.

Não é uma pesquisa de satisfação do 1Doc. É uma pesquisa do redesign. Toda decisão de escopo se resolve por essa frase.

## Invariantes de domínio — não violar

Estes pontos foram corrigidos em revisão com a designer responsável. Reintroduzi-los é regressão.

**Vocabulário**
- O nome é **"o redesign"**. Nunca "versão nova do 1Doc", "1Doc novo", "nova interface".
- O layout anterior é **"a versão anterior"** ou **"o layout antigo"**. Nunca "legado" em texto voltado ao usuário (só em código e documentação interna).
- **Nada é protocolado.** Não existe protocolo, tramitação, despacho ou comprovante. O identificador da resposta é um **código de acompanhamento**. O botão final é "Enviar respostas", não "Protocolar".

**Áreas do produto**
- Já no redesign, recebem nota: `Inbox`, `Processos`, `Assinaturas`, `Fila de assinatura`, `Central de ações`, `Central de atendimento`, `Minha conta`.
- **Ainda no layout antigo, NÃO recebem nota do redesign:** `Criar novos processos`, `Administrativo`. Elas existem no questionário apenas para a pergunta de atrito entre os dois layouts.
- Nomes que **não** existem: Painéis (é Central de ações), Portal do cidadão (é Central de atendimento), Documentos, Ouvidoria.
- Nunca afirmar que "todas as áreas já estão no redesign".

**Jornadas do CES**
- `achar` · `analisar` · `assinar` · `pendencias` · `atender`.
- **Não existe "criar um processo novo"** como jornada do redesign: não é possível ainda.
- **Não existe "montar ou editar um fluxo"**: não é editável ainda.

**Bloco CORE do questionário**
A redação das perguntas CORE é imutável. Alterar uma palavra invalida a comparação entre ondas. São elas: status do redesign, nota 0–10, os dois itens do UMUX-Lite, as 6 dimensões da comparação com a versão anterior, o CES por jornada, e a pergunta de risco de reversão. Ver `docs/instrumento.md`.

Se uma mudança no CORE for realmente necessária: criar a métrica nova **em paralelo** e manter a antiga rodando por 2 ondas.

**Modelo de cálculo**
- `IRD = 0,35 × UMUX-Lite(SUS) + 0,25 × CES + 0,20 × (nota × 10) + 0,20 × Preferência`
- **Taxa de reversão nunca entra no composto.** Composto dilui, e esse número precisa ser lido puro. O mesmo vale para tempo até reverter, risco de reversão e atrito entre layouts.
- NPS foi removido do instrumento de propósito: mede o produto, não o redesign. Não readicionar sem decisão explícita.

## Regras de alteração

- `prototipo/index.html` é **referência funcional congelada**. Ele documenta o comportamento acordado. Só alterar se a mudança for validada com a designer; toda evolução acontece no app de produção.
- Não renomear chaves de dados já persistidas (`status`, `legado`, `ces`, `sat`, `admin`, `risco`, `revMotivos`...). Elas formam a série histórica.
- Toda alteração de escopo entra em `docs/PROGRESS.md` no mesmo commit.
- Commits em português, imperativo, escopo no início: `pesquisa: separa áreas do redesign das legadas`.

## Segurança — dois pontos que não podem passar

1. **A senha do painel no protótipo é checada no navegador.** Isso é aceitável só no protótipo. Em produção, autenticação no servidor, com perfil de acesso.
2. **A chamada à API da Anthropic no protótipo funciona sem chave** porque o runtime de artifacts injeta credencial. Em produção isso **precisa de um proxy no servidor**. Nunca colocar chave de API no bundle do cliente.

Além disso: nome e e-mail do respondente ficam em tabela separada das respostas, ligados apenas pelo código de acompanhamento, com acesso restrito a quem marca as entrevistas.

## Estrutura

```
prototipo/index.html    protótipo funcional completo, arquivo único, sem dependências
docs/instrumento.md     questionário, cálculo, cadência, programa de embaixadores
docs/plano.md           fases de execução com critério de aceite
docs/PROGRESS.md        status vivo — atualizar a cada entrega
```
