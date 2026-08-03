# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Regras de engenharia, mapa da KB e invariantes deste repositório: @AGENTS.md

## Biblioteca de prompts — consulte antes de agir

[kb/prompt-library.md](kb/prompt-library.md) contém os **52 prompts oficiais** da Anthropic, cada um
com o critério de verificação e o formato de saída que a versão informal do pedido perde.

**IMPORTANT — regra de roteamento:** quando um pedido cair numa das intenções abaixo, **abra o arquivo
e leia a entrada correspondente antes de executar**. O prompt não é texto a devolver ao usuário: é o
checklist do que a ação precisa conter. Se o pedido do usuário for mais preciso que a entrada da
biblioteca, o pedido vence.

| Pedido soa como… | Entrada |
|---|---|
| conectar ferramenta externa — **"instala o MCP do GitHub"**, Sentry, Linear, Figma, Notion, banco | `connect-a-tool-with` |
| criar comando/skill, "sempre que eu pedir X" | `turn-a-recurring-task` |
| "toda vez que Y acontecer, faça Z" (determinístico) | `add-a-hook-for` |
| entender repositório, arquivo, ou "onde a gente faz X" | `get-oriented-in-a`, `explain-unfamiliar-code`, `find-where-something-happens` |
| impacto de apagar algo, ou "por que está assim" | `see-what-depends-on`, `trace-how-code-evolved` |
| escrever spec, planejar mudança, mapear bordas | `draft-a-spec-by`, `plan-a-multi-file`, `map-edge-cases-before` |
| testes, cobertura, TDD | `write-tests-run-them`, `fill-gaps-from-a`, `drive-implementation-from-tests` |
| migrar padrão, portar linguagem, otimizar métrica | `migrate-a-pattern-across`, `port-code-between-languages`, `optimize-against-a-measurable` |
| revisar diff, PR, plano de infra, segurança | `review-your-changes-before`, `review-a-pull-request`, `review-infrastructure-changes-before`, `run-a-security-review` |
| commit, merge, PR, changelog, CI | `commit-with-a-generated`, `resolve-merge-conflicts`, `open-a-pull-request`, `draft-release-notes-from`, `write-a-ci-workflow` |
| teste/build quebrado, erro reportado, incidente, logs | `find-and-fix-a`, `fix-a-build-error`, `investigate-a-reported-error`, `investigate-a-production-incident`, `query-logs-in-plain` |
| analisar CSV ou dados | `analyze-a-data-file` |
| "não é isso", "mudou demais", erro que se repete | `course-correct-a-wrong`, `narrow-the-scope-of`, `turn-a-correction-into` |

**Fronteira com o SDD:** a biblioteca é o caminho leve, o fluxo `sdd-*` é o pesado. Vale a calibração
oficial — *se você descreve o diff em uma frase, pule o plano* (H-01). `draft-a-spec-by` e
`plan-a-multi-file` têm equivalentes versionados (`/sdd-specify`, `/sdd-plan`); a §5 do arquivo diz
qual usar quando. A árvore completa de decisão é `AD-01` em
[kb/09](kb/09-decisao-estados-algoritmos.md).

### Disciplinas fora da biblioteca de prompts

Cinco pedidos que nenhum dos 52 prompts atende. O destino é um padrão da KB, não um prompt — leia a
entrada antes de agir. Detalhe em [kb/mattpocock-skills.md](kb/mattpocock-skills.md).

| Pedido soa como… | Vá para |
|---|---|
| "me entrevista sobre isso", "testa meu plano", pedido de duas frases para feature grande | `INT-08` · Grilling — **antes** de `/sdd-specify` |
| "está tudo acoplado", desenhar a interface de um módulo, decidir onde cortar | `PLN-05` · Módulo Profundo |
| escopo nebuloso, "não sei nem o que especificar", grande demais para uma sessão | `PLN-06` **antes** de `/sdd-specify` |
| bug difícil, teste intermitente, regressão de desempenho | `VER-06` (construa o loop primeiro) + `find-and-fix-a` |
| encerrar a sessão passando o bastão para outra | `CTX-07` · Handoff |
| o agente é verboso, o projeto tem jargão que ele não conhece | `CTX-06` · Linguagem Ubíqua |

## Antes de escrever na KB ou nos templates

Estes três arquivos respondem quase toda dúvida de manutenção — leia a entrada, não improvise:

- **Onde este conhecimento deve morar** → `AD-02` em [kb/09](kb/09-decisao-estados-algoritmos.md):
  muda com frequência → `STATUS.md` · vale só num diretório → `<dir>/CLAUDE.md` · vale só às vezes →
  skill · precisa valer sem exceção → hook/CI · portátil → `AGENTS.md` · do Claude Code → `CLAUDE.md`.
- **Que tipo de verificação usar** → `AD-03`, mesmo arquivo.
- **Teste de inclusão, linha a linha** — *"remover isto faria o agente errar?"* Se não, apague
  (AP-02 · CLAUDE.md Enciclopédia).

## Paralelismo

Worktree isola **arquivos**; subagente isola **contexto**. Confundir os dois produz worktree para
tarefa de leitura (caro e inútil) e edição concorrente sem isolamento.

- Investigação que exige varrer muitos arquivos → subagente (`CTX-03`); a exploração não deve
  consumir esta sessão.
- Duas frentes escrevendo nos mesmos arquivos → `claude --worktree <assunto>`, uma por frente, nunca
  uma por task (`EXE-05`, `PLN-04`).
- Detalhe operacional: [kb/worktrees.md](kb/worktrees.md) · [kb/sub-agents.md](kb/sub-agents.md).

## Instalação nos projetos consumidores

```powershell
pwsh C:\workspace\labs\.specify\scripts\install.ps1                                  # commands globais
pwsh C:\workspace\labs\.specify\scripts\install.ps1 -Target C:\workspace\WWMA-Tech   # projeto + .specify/
```

Sobrescreve os `sdd-*.md` (labs é upstream), **preserva** `constitution.md` e templates já existentes
no destino. `-Force` sobrescreve tudo.

O par de contexto tem instalação própria — copiar `templates/AGENTS.template.md` e
`templates/CLAUDE.template.md`, preencher os placeholders e apagar os comentários HTML. Ver
[templates/README.md](templates/README.md).

## Peculiaridades do ambiente

- Windows + PowerShell 7. Scripts do repositório são `.ps1`; invoque com `pwsh`, não `powershell`.
- `labs` **não é um repositório git** — não há histórico para consultar nem `git blame` para atribuir
  decisão. A justificativa de uma escolha mora no `ADR` correspondente, não no commit.
