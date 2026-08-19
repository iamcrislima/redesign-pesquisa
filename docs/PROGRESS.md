# PROGRESS

Status vivo. Atualizar no mesmo commit da entrega.

Última atualização: 19/08/2026

## Fases

| # | fase | status | observação |
|---|---|---|---|
| 0 | Repositório e demonstração interna | entregue | publicado em github.com/iamcrislima/redesign-pesquisa |
| 1 | Persistência real | entregue | Supabase via REST puro; `DB` mantém o contrato get/set/del/keys/all |
| 2 | Link tokenizado por respondente | não iniciada | depende da fase 1 |
| 3 | Status do redesign vindo do sistema | não iniciada | precisa de acesso ao dado de ativação |
| 4 | Painel com autenticação de servidor | entregue | Supabase Auth; leitura barrada por RLS, não pela interface |
| 5 | Agrupamento de temas no servidor | não iniciada | chave de API nunca no cliente |
| 6 | Página do embaixador | não iniciada | sustenta a taxa de resposta a partir da 3ª onda |

## Decidido

- Índice **IRD** = 0,35 UMUX-Lite + 0,25 CES + 0,20 nota × 10 + 0,20 preferência vs. anterior.
- Taxa de reversão, tempo até reverter, risco de reversão e atrito entre layouts ficam **fora** do composto.
- Cadência trimestral, janela fixa de 2 semanas, amostragem rotativa, até 10 entrevistas por onda.
- NPS removido do instrumento.
- Comparação com a versão anterior é a pergunta central desta fase e **tem prazo de validade**: sai em 2 ou 3 ondas, quando a memória do layout antigo deixar de ser confiável.
- Recompensa é status e acesso, não brinde — boa parte da base é servidor público.
- Persistência no **Supabase por REST puro**, sem `supabase-js`: o protótipo continua
  arquivo único, sem dependência externa. As três camadas de storage são
  Supabase → storage do runtime → memória, nesta ordem.
- Credenciais em `prototipo/config.js`, fora do git. `config.example.js` fica commitado.
  A chave publicável é feita para o navegador; quem protege o dado é a RLS.
- **Apagar resposta exige sessão** e só alcança `seed = true`. Ninguém apaga dado real,
  nem logado, nem por engano.

## Aberto

- Bloco rotativo da **Central de atendimento** ainda não implementado: as colunas
  `atend`, `atend_papel` e `atend_why` existem no banco e no adaptador, mas nenhuma
  tela as alimenta.
- Visão **Comparar ondas** do painel ainda não implementada.

- Onde roda o backend e qual stack do app de produção.
- Quem é o dono do dado de ativação do redesign no 1Doc (para a fase 3).
- Janela exata da primeira onda oficial, evitando pico dos clientes.
- Quando a criação de processos e o Administrativo entram no redesign — muda o questionário.

## Cuidados conhecidos

- Sem `<!DOCTYPE>` o Chrome entra em quirks mode e tabelas não herdam cor nem fonte do ancestral. O protótipo é servido como arquivo único e já declara charset; se virar app, garantir doctype. Aplicado ao materializar `prototipo/index.html` no repositório: o arquivo abre com `<!DOCTYPE html>` e `<html lang="pt-BR">` para ser servido direto por HTTP sem cair em quirks mode.
- Animar o cartão a cada re-render causa instabilidade de layout e cliques no elemento errado. No protótipo a animação só dispara na troca de tela.
- A trilha de etapas não pode ser derivada de `flow()` enquanto o status do redesign não foi escolhido: `flow()` devolve só `FLOW_BASE` e a trilha abre com 2 etapas para depois saltar para 5. `blocosDoFluxo()` presume o caminho principal (`FLOW_BASE + FLOW_USA`) até a pessoa responder, e cai para 4 etapas só quando ela diz que voltou ao layout antigo — "No dia a dia" sai porque `ces`, `areas`, `risco` e `prioridade` não existem no `FLOW_REV`. O contador de telas já seguia essa convenção (presume 14).
- `codigo()` sorteia 4 dígitos — 9.000 valores por ano. Com `codigo` como primary key,
  colisão custaria a resposta inteira: em 200 respostas/ano a chance passa de 89%. O envio
  detecta o `409`, reemite o código e tenta de novo, até 8 vezes. Se o volume por onda
  crescer, aumentar a faixa em vez de confiar no retry.
- **Não semear a base a partir do cliente quando há banco.** A RLS esconde as linhas do
  anônimo, então a checagem `ex.length === 0` do `boot()` é sempre verdadeira para quem não
  está logado — cada visitante inseriria a demonstração outra vez. O seed só roda no
  fallback de memória.
- O painel só lê com sessão válida. `DB.all()` sem token devolve `[]` por RLS, não por
  checagem de interface: mesmo adulterando o JavaScript no navegador não se lê resposta.
- Classes utilitárias globais (`.up`, `.down`) do painel escuro vazaram uma vez para a pesquisa clara. Manter namespaces separados entre os dois temas.
