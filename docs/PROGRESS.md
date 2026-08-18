# PROGRESS

Status vivo. Atualizar no mesmo commit da entrega.

Última atualização: 18/08/2026

## Fases

| # | fase | status | observação |
|---|---|---|---|
| 0 | Repositório e demonstração interna | em andamento | protótipo pronto; falta publicar |
| 1 | Persistência real | não iniciada | trocar o adaptador `DB` por API |
| 2 | Link tokenizado por respondente | não iniciada | depende da fase 1 |
| 3 | Status do redesign vindo do sistema | não iniciada | precisa de acesso ao dado de ativação |
| 4 | Painel com autenticação de servidor | não iniciada | senha do protótipo é só demonstração |
| 5 | Agrupamento de temas no servidor | não iniciada | chave de API nunca no cliente |
| 6 | Página do embaixador | não iniciada | sustenta a taxa de resposta a partir da 3ª onda |

## Decidido

- Índice **IRD** = 0,35 UMUX-Lite + 0,25 CES + 0,20 nota × 10 + 0,20 preferência vs. anterior.
- Taxa de reversão, tempo até reverter, risco de reversão e atrito entre layouts ficam **fora** do composto.
- Cadência trimestral, janela fixa de 2 semanas, amostragem rotativa, até 10 entrevistas por onda.
- NPS removido do instrumento.
- Comparação com a versão anterior é a pergunta central desta fase e **tem prazo de validade**: sai em 2 ou 3 ondas, quando a memória do layout antigo deixar de ser confiável.
- Recompensa é status e acesso, não brinde — boa parte da base é servidor público.

## Aberto

- Onde roda o backend e qual stack do app de produção.
- Quem é o dono do dado de ativação do redesign no 1Doc (para a fase 3).
- Janela exata da primeira onda oficial, evitando pico dos clientes.
- Quando a criação de processos e o Administrativo entram no redesign — muda o questionário.

## Cuidados conhecidos

- Sem `<!DOCTYPE>` o Chrome entra em quirks mode e tabelas não herdam cor nem fonte do ancestral. O protótipo é servido como arquivo único e já declara charset; se virar app, garantir doctype. Aplicado ao materializar `prototipo/index.html` no repositório: o arquivo abre com `<!DOCTYPE html>` e `<html lang="pt-BR">` para ser servido direto por HTTP sem cair em quirks mode.
- Animar o cartão a cada re-render causa instabilidade de layout e cliques no elemento errado. No protótipo a animação só dispara na troca de tela.
- Classes utilitárias globais (`.up`, `.down`) do painel escuro vazaram uma vez para a pesquisa clara. Manter namespaces separados entre os dois temas.
