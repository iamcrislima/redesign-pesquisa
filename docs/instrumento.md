# IRD 1Doc — pesquisa do redesign

Substitui a versão anterior (PHS). O protótipo funcional é `ird-1doc.html`.

Mudança de premissa: a pesquisa não é sobre o 1Doc, é sobre o **redesign**. E como os clientes migraram há pouco e **podem desativar e voltar ao legado**, a reversão passa a ser o sinal mais importante do sistema.

---

## O que mudou em relação à primeira versão

| antes | agora | por quê |
|---|---|---|
| Órgão em lista fixa | Busca nos 272 órgãos com o redesign, tipo deduzido do nome | a lista não é só prefeitura: tem câmara, SAAE, consórcio. Deduzir o tipo evita uma pergunta e ainda dá o corte |
| Papéis genéricos | 13 funções de prefeitura e câmara + "Outro" com campo livre | protocolo sente a mudança de tela muito mais que quem entra 1x na semana |
| "Comparado com 3 meses atrás" | **Comparação com a versão anterior, em 6 dimensões** | todo mundo migrou agora; a comparação que a pessoa faz com precisão é nova vs. antiga. Esta pergunta tem prazo de validade — em 2 ou 3 ondas ninguém lembra do legado, e aí ela sai |
| NPS no composto | **NPS removido do instrumento** | mede o produto, não o redesign. Se CS quiser NPS, ele pertence a uma pesquisa de relacionamento separada |
| Módulos errados | **Já no redesign:** Inbox, Processos, Assinaturas, Fila de assinatura, Central de ações, Central de atendimento, Minha conta. **Ainda no layout antigo:** Criar novos processos, Administrativo | Painéis → Central de ações · Portal do cidadão → Central de atendimento · Documentos e Ouvidoria não existem. Só as áreas já redesenhadas recebem nota |
| Jornada "montar fluxo" | Removida | não é editável ainda |
| Jornada "criar processo novo" | Trocada por **"analisar um processo"** | criar processo ainda não existe no redesign |
| Vocabulário "versão nova" (meu) | **"o redesign"** | é o termo que o cliente vê no próprio produto, incluindo na opção de desativar |
| Metáfora de protocolo | Removida | nenhum protocolo é aberto de verdade. Sobrou um **código de acompanhamento**, que é o que sustenta a promessa de acompanhar as sugestões |
| — | **Ramo de reversão** (4 telas) | quem voltou tem a informação mais valiosa que existe sobre o redesign |
| — | **Atrito entre os dois layouts** | criação de processos e Administrativo seguem antigos; a pessoa navega metade nova, metade antiga, e esse atrito era invisível |
| — | **Risco de reversão** | intenção aparece antes da ação; é onde ainda dá tempo de agir |

---

## Cálculo

```
UMUX-Lite bruto = ((item1 - 1) + (item2 - 1)) / 12 × 100
UMUX-Lite (SUS) = 0,65 × bruto + 22,9        # 68 = média de mercado, 78 ≈ percentil 85
CES normalizado = (média(1..7) - 1) / 6 × 100
Preferência     = (média das 6 dimensões em -1/0/+1 + 1) / 2 × 100   # 50 = empate com o legado

IRD = 0,35 × UMUX-Lite + 0,25 × CES + 0,20 × (nota × 10) + 0,20 × Preferência
```

**Fora do composto, sempre ao lado:**

- **Taxa de reversão** — % que desativou o redesign. Comportamento, não opinião. Composto dilui, e este número precisa ser visto puro.
- **Tempo de uso antes de voltar** — menos de um dia é problema de adaptação; semanas é lacuna real de capacidade. Mesmo motivo declarado, causa oposta, correção oposta.
- **Risco de reversão** — % de quem continua e já pensou em voltar.
- **Atrito entre os dois layouts** — enquanto a criação de processos e o Administrativo não migrarem, é um piso para o IRD.

Uma leitura que o painel já faz: se o IRD sobe **e** a reversão sobe, é sinal de que um grupo específico está desistindo enquanto o resto avança — vale abrir o corte por tipo de organização.

---

## Instrumento

**Caminho de quem tem o redesign ativo — 14 telas**
abertura · órgão (busca) · perfil · **status da versão** · áreas e tarefas · nota 0-10 + motivo · UMUX-Lite · comparação com a anterior · CES por jornada · nota por área + atrito entre layouts · risco de reversão · prioridade nº1 · convite · confirmação

**Caminho de quem voltou ao legado — 10 telas**
abertura · órgão · perfil · **status** · tempo de uso antes de voltar + quando voltou · motivos (múltipla) + ponto específico · o que traria de volta + recomendaria a outro órgão · nota 0-10 · convite · confirmação

### Bloco CORE — redação imutável

Alterar uma palavra invalida a comparação entre ondas.

- **Status:** *"Você está com o redesign ativo agora?"* → sim / desativei e voltei / não sei dizer
- **Nota:** *"Que nota você dá para o redesign do 1Doc?"* (0–10) + *"Qual o principal motivo da sua nota?"*
- **UMUX-Lite** (1–7): *"O redesign do 1Doc tem as funcionalidades que eu preciso para fazer meu trabalho."* · *"O redesign do 1Doc é fácil de usar."*
- **CES** (1–7): encontrar um processo · analisar um processo · assinar um documento · ver o que está pendente · atender um pedido do cidadão
- **Comparação** (melhor no redesign / igual / melhor na anterior): encontrar o que preciso · número de cliques · velocidade · clareza da informação · aprender e ensinar · aparência
- **Risco:** *"Você já pensou em desativar o redesign e voltar?"*

### Bloco ROTATIVO
Satisfação por área + um tema da onda.

### "Não sei dizer em qual versão estou"
Não é resposta inválida: é um dado sobre a comunicação da virada. O painel conta e reporta. Um redesign que não é percebido informa sobre o rollout, não sobre a interface.

---

## Cadência

Trimestral, janela fixa de 2 semanas, amostragem rotativa em 3–4 blocos. Até 10 entrevistas por onda, com a fila ordenada pelo dado: **quem voltou ao legado primeiro**, depois nota ≤6, depois quem pensou em voltar, e um promotor no fim para dizer o que não mexer.

## Programa Embaixadores

Boa parte da base é servidor público — brinde e sorteio são campo minado. A recompensa é influência, status e acesso: página "suas sugestões" com status real, acesso antecipado, roadmap preview a partir do Ouro, certificado de participação (vale para progressão), selo de órgão parceiro. O que mais move a taxa de resposta é mostrar, no convite seguinte, o que saiu da onda anterior.

## Antes de ir para cliente

1. **Login do painel no servidor** — no protótipo a senha é checada no navegador.
2. **Link tokenizado por respondente** — `/pesquisa/:token` com órgão e função pré-preenchidos; encurta a pesquisa, viabiliza a amostragem rotativa e o streak do programa.
3. **Status da versão vindo do sistema, não da pergunta** — você já sabe quem tem o redesign ativo. Usar o dado real e manter a pergunta apenas como conferência elimina o erro de auto-declaração e permite convidar quem reverteu de forma dirigida.
4. **Identidade separada das respostas** — nome e e-mail em tabela própria, ligados só pelo id do protocolo.
