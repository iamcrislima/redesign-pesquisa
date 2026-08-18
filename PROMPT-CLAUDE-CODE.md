# Prompt para o Claude Code

## 1. Publicar no GitHub

Cole no Claude Code, na pasta do projeto:

```
Leia CLAUDE.md, README.md e docs/plano.md antes de qualquer coisa.

Inicialize o repositório git nesta pasta, faça o primeiro commit com a mensagem
"feat: pesquisa do redesign 1Doc — protótipo e documentação" e crie o repositório
remoto PRIVADO no GitHub chamado ird-1doc usando o gh CLI. Depois publique o
protótipo: prototipo/index.html é arquivo único sem build, então configure o deploy
mais simples que funcione (GitHub Pages servindo a pasta prototipo, ou Vercel se
já estiver configurado neste ambiente).

Não altere nenhum arquivo do projeto nesta tarefa. Se algo impedir o push, me diga
qual é o bloqueio em vez de tentar contornar.
```

Se preferir fazer à mão:

```bash
git init && git add . && git commit -m "feat: pesquisa do redesign 1Doc — protótipo e documentação"
gh repo create ird-1doc --private --source=. --push
```

## 2. Executar a Fase 1 (persistência)

Só depois de decidir a stack. Prompt sugerido:

```
Leia CLAUDE.md e docs/plano.md.

Implemente a Fase 1 do plano: persistência real. Respeite os invariantes de domínio
do CLAUDE.md — vocabulário, áreas que estão e não estão no redesign, jornadas do CES
e redação do bloco CORE são intocáveis.

Regras de isolamento desta tarefa:
- prototipo/index.html é referência congelada, não altere.
- Trabalhe apenas nos arquivos novos do app de produção e em docs/PROGRESS.md.
- O adaptador DB do protótipo (linhas iniciais do script) é o contrato: reimplemente
  get, set, del e all contra a API, sem mudar as chaves de dados.

Antes de escrever código, me mostre o plano de arquivos e o schema. Ao terminar,
atualize docs/PROGRESS.md no mesmo commit.
```

## 3. Regra permanente

Toda tarefa começa com "leia CLAUDE.md". Os invariantes ali foram levantados em revisão
com a designer responsável e reintroduzi-los é regressão, não melhoria.
