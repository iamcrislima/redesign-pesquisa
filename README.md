# IRD 1Doc — pesquisa do redesign

Sistema de pesquisa recorrente sobre o redesign do 1Doc. Mede se o redesign entregou o que prometeu e, principalmente, entende quem o desativou e voltou para o layout anterior.

## Por que existe

Os clientes migraram para o redesign há pouco tempo e **podem desativar e voltar**. Isso torna a reversão o sinal mais forte disponível: nota de satisfação é opinião, desativar é comportamento. O sistema trata reversão como métrica de primeira classe e nunca a dilui em índice composto.

## O que já está pronto

`prototipo/index.html` — protótipo funcional completo, arquivo único, sem build e sem dependências. Abra no navegador.

- **Pesquisa** com dois caminhos: 14 telas para quem tem o redesign ativo, 10 para quem voltou ao layout anterior.
- **Busca entre os 272 órgãos** que receberam o redesign, com o tipo de organização deduzido do nome (prefeitura, câmara, saneamento, consórcio).
- **Painel** em `#/painel` (senha de demonstração `produto2026`) com série histórica, comparação item por item com a versão anterior, motivos de reversão, esforço por jornada, atrito entre os dois layouts e fila de entrevistas ordenada pelo dado.
- **Agrupamento de temas por IA** por cima da taxonomia fixa.
- Três ondas de dados de demonstração, com botão para apagar.

## Como rodar

```bash
cp prototipo/config.example.js prototipo/config.js   # preencha URL e chave publicável
python3 -m http.server 8000 --directory prototipo
# http://localhost:8000
```

O schema fica em `supabase/schema.sql` — rode o arquivo **inteiro** no SQL Editor do Supabase. Tabela e RLS estão na mesma transação de propósito: uma tabela criada sem política fica legível por qualquer anônimo até a segunda metade rodar.

Sem `config.js` o adaptador cai para memória e a barra de aviso aparece: **as respostas somem ao recarregar.** Serve para demonstrar, não para coletar.

O painel exige sessão. As contas da equipe são criadas por convite em Authentication → Users no painel do Supabase; não há cadastro na tela de login.

## Documentação

| arquivo | conteúdo |
|---|---|
| `CLAUDE.md` | regras de execução e invariantes de domínio — leia antes de alterar |
| `docs/instrumento.md` | questionário completo, cálculo do IRD, cadência, programa de embaixadores |
| `docs/plano.md` | fases de execução com critério de aceite |
| `docs/PROGRESS.md` | status vivo |

## Índice

```
IRD = 0,35 × UMUX-Lite(SUS) + 0,25 × CES + 0,20 × (nota × 10) + 0,20 × Preferência vs. anterior
```

Fora do composto, sempre ao lado: taxa de reversão, tempo até reverter, risco de reversão e atrito entre os dois layouts.

## Antes de coletar dado real

1. ~~Autenticação do painel no servidor~~ — **resolvido.** Supabase Auth, sem cadastro aberto. A leitura de respostas é barrada por RLS, não por checagem de interface: adulterar o JavaScript no navegador não devolve nenhuma linha.
2. **Pendente.** Chave da API da Anthropic atrás de endpoint próprio — nunca no bundle do cliente. É a fase 5.
3. ~~Nome e e-mail em tabela separada das respostas~~ — **resolvido.** Tabela `contatos`, ligada só pelo código de acompanhamento, sem leitura para anônimo.
