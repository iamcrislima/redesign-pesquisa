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
python3 -m http.server 8000 --directory prototipo
# http://localhost:8000
```

Fora do runtime de artifacts o adaptador de storage cai para memória: **as respostas somem ao recarregar.** É suficiente para demonstrar, não para coletar. A troca é a fase 1 do plano.

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

1. Autenticação do painel no servidor — no protótipo a senha é checada no navegador.
2. Chave da API da Anthropic atrás de endpoint próprio — nunca no bundle do cliente.
3. Nome e e-mail em tabela separada das respostas.
