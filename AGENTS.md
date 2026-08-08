# AGENTS.md

Regras de engenharia deste repositório, portáveis para qualquer agente.
A camada específica do Claude Code está em [CLAUDE.md](CLAUDE.md).
As regras de **como o código sai** — estilo, git, segurança e convenções por linguagem/framework —
estão em [RULES.md](RULES.md); este arquivo trata do **processo**.

## O que é este diretório

`labs` tem dois papéis, e é importante saber em qual você está antes de agir:

1. **Laboratório de experimentos** — protótipos descartáveis em `experiments/<data-slug>/`. Cada um é
   autocontido, com uma linha explicando a hipótese testada, e pode ser deletado sem afetar nada.
2. **Fonte de verdade** — `kb/`, `.specify/`, `.claude/commands/` e `templates/` são o **upstream**
   consumido pelos projetos reais em `C:\workspace\` (Back-End, Front-End, Freelancer, WWMA-Tech).

Consequência prática: mudanças em `experiments/` são livres. Mudanças em `.specify/`,
`.claude/commands/` e `templates/` afetam outros projetos — trate-as como mudança de biblioteca
compartilhada, e edite sempre aqui, **nunca na cópia instalada** (AP-15 · Cópia Manual Multi-Harness).

## Base de conhecimento — o mapa dos identificadores

`kb/` é a **Engineering Knowledge Base** de AI Systems Engineering: a fundação de onde o fluxo SDD e
os templates derivam. Não é documentação linear — é um grafo de artefatos com tipos fixos, cada um
respondendo a uma pergunta diferente.

**Todo item é citável por identificador, e o namespace é global no repositório** — dois artefatos
nunca reusam um prefixo (AP-14 · Namespace Colidido). Ao citar, use o identificador, não a paráfrase:

| Procura | Arquivo | Identificadores |
|---|---|---|
| Disciplinas, onde algo se encaixa | [00-taxonomia](kb/00-taxonomia.md) | `D0`–`D6` |
| Relações entre conceitos | [01-ontologia](kb/01-ontologia.md) | — |
| O que um termo significa aqui | [02-glossario](kb/02-glossario.md) | — |
| **Por que** fazemos assim | [03-principios](kb/03-principios.md) | `P01`–`P14` |
| **Padrões** — problema recorrente resolvido | [04-padroes](kb/04-padroes.md) | `CTX-`, `INT-`, `PLN-`, `EXE-`, `VER-`, `LRN-` |
| **Anti-padrões** — o que falha repetidamente | [05-antipadroes](kb/05-antipadroes.md) | `AP-01`–`AP-41` (🔴 grave / 🟡 moderado) |
| **Regras absolutas** e apostas sob incerteza | [06-heuristicas-e-invariantes](kb/06-heuristicas-e-invariantes.md) | `I-01`–`I-19` · `H-01`–`H-20` |
| Como raciocinar sobre algo | [07-modelos-mentais](kb/07-modelos-mentais.md) | — |
| **Arquiteturas** de referência e pipelines | [08-arquiteturas-e-pipelines](kb/08-arquiteturas-e-pipelines.md) | `AR-01`–`AR-04` · `PL-01`–`PL-05` |
| O que fazer **neste ponto** | [09-decisao-estados-algoritmos](kb/09-decisao-estados-algoritmos.md) | `AD-01`–`AD-05` · `ME-01`–`ME-04` · `AL-01`–`AL-05` |
| Como sei se está funcionando | [10-metricas](kb/10-metricas.md) | — |
| **Por que** escolhemos isto e não aquilo | [11-adrs](kb/11-adrs.md) | `ADR-001`–`ADR-012` (imutáveis) |
| Isto cobre aquilo? | [12-rastreabilidade](kb/12-rastreabilidade.md) | — |
| De onde vem a afirmação | [13-bibliografia](kb/13-bibliografia.md) | — |

As cinco famílias de padrões seguem as disciplinas: `CTX` contexto · `INT` intenção · `PLN`
planejamento · `EXE` execução · `VER` verificação · `LRN` aprendizado.

Destilações fora da numeração. **Oficiais** `[OFICIAL]`: [anthropic-claude-code](kb/anthropic-claude-code.md),
[git-strategy](kb/git-strategy.md), [worktrees](kb/worktrees.md), [sub-agents](kb/sub-agents.md), [prompt-library](kb/prompt-library.md).
**De indústria** `[INDÚSTRIA]`: [mattpocock-skills](kb/mattpocock-skills.md) — absorvida, não instalada
(ADR-011); [github-agent-skills](kb/github-agent-skills.md) — matriz de skills por papel (PO, QA, QC, Dev). Toda afirmação vinda delas é `[INDÚSTRIA]`, nunca `[OFICIAL]`.
**De campo, de terceiro** `[CAMPO]`: [kbmain-corpus](kb/kbmain-corpus.md) — acervo agêntico em produção,
absorvido por destilação (ADR-012). Rende padrão **e** anti-padrão: VER-07 e AP-38 saem do mesmo lugar.
Observar não é endossar — a §5 de lá registra o que foi **recusado**, e a §7 o material sensível que
não entrou.

**Selo epistêmico é obrigatório e nunca se mistura** (ADR-010): `[CONSOLIDADO]` `[INDÚSTRIA]`
`[RECENTE]` `[EXPERIMENTAL]` `[ACADÊMICO]` `[HIPÓTESE]` `[OFICIAL]` `[CAMPO]`. Ao citar a KB,
**preserve o selo** — a força da afirmação vem dele, não da redação.

Índice e critério de cada tipo de artefato: [kb/README.md](kb/README.md).
Aprofundamento de **uma** das disciplinas (D1 · Intent): [docs/intent-engineering/](docs/intent-engineering/README.md).

## O fluxo SDD

| # | Comando | Produz | Responde |
|---|---|---|---|
| 0 | `/sdd-constitution` | `.specify/memory/constitution.md` | Princípios inegociáveis |
| 1 | `/sdd-specify <descrição>` | `specs/NNN-slug/spec.md` | O QUÊ e POR QUÊ — sem tecnologia |
| 1.5 | `/sdd-clarify` | spec atualizada | Resolve ambiguidades perguntando ao humano |
| 2 | `/sdd-plan` | `specs/NNN-slug/plan.md` | COMO — stack, contratos, riscos |
| 3 | `/sdd-tasks` | `specs/NNN-slug/tasks.md` | Passos por história, verificáveis |
| 3.5 | `/sdd-analyze` | relatório | Os artefatos são coerentes entre si? |
| 4 | `/sdd-implement` | código | Execução, uma task por vez |
| 5 | `/sdd-converge` | relatório | O código satisfaz a spec? |
| — | `/sdd-checklist <dimensão>` | `specs/NNN-slug/checklists/` | A spec está bem escrita? |

Opcionais: `clarify`, `analyze`, `checklist`. O restante é o caminho principal, e a ordem é rígida —
não se planeja antes de especificar, não se implementa sem tasks.

**Distinção que confunde:** `/sdd-analyze` audita **artefato contra artefato**, antes de implementar.
`/sdd-converge` audita **código contra artefato**, depois.

**Origem:** modelado sobre o [GitHub Spec Kit](https://github.github.io/spec-kit/) — mesma sequência,
mesma estrutura de diretórios, mesmos artefatos. Diferenças deliberadas: **português** com prefixo
`sdd-`; **sem dependência do CLI `specify`** (são markdown versionáveis); e **cinco extensões**
fundamentadas em `docs/intent-engineering/` — análise de obstáculos (KAOS), envelope de autonomia por
task (P10/EXE-04), modo de interpretação declarado, registro de interpretação (EXE-06), e bloqueio por
ambiguidade calibrado por custo de reversão (P04/ADR-002). Migrar para o Spec Kit oficial é direto: a
estrutura de pastas é a mesma.

## Invariantes deste repositório

- **A constitution vence** (I-14). Conflito com ela é reportado ao humano, nunca resolvido em silêncio.
- **Spec não fala de tecnologia.** "React", "Postgres" ou "endpoint" numa spec é vazamento da fase de plan.
- **Ambiguidade vira `[PRECISA ESCLARECER]`, classificada** (P04, ADR-002). *Bloqueante* quando
  reverter é caro (schema, contrato, dado, segurança) — trava a fase seguinte. *Não-bloqueante* quando
  é barato tentar — vira suposição registrada em Premissas. Bloquear tudo é modo de falha, não rigor.
- **Histórias são independentemente testáveis**, priorizadas, e a US1 é o MVP.
- **Tasks são agrupadas por história, não por camada** (PLN-02) — agrupar por camada destrói a
  entregabilidade incremental.
- **`/sdd-converge` roda em sessão separada** de quem implementou (I-09, P12); auditor que compartilha
  o contexto do executor converge para confirmação.
- **Numeração é sequencial e imutável** — specs (`001-`) e identificadores da KB. Item errado é
  corrigido no lugar ou marcado obsoleto; **nunca renumerado**, porque quebra citação externa.
- **Toda afirmação nova na KB entra com selo** e, quando `[CAMPO]`, com o arquivo citado.

## Convenções de experimentos

- `experiments/<data-slug>/` — ex.: `2026-08-02-streaming-tool-use/`
- Experimento sem stack definida: um arquivo único que roda é melhor que uma árvore de pastas vazia.
- Experimento que amadurece vira projeto próprio em `C:\workspace\`, não cresce dentro de `labs`.
- `note/` são apenas atalhos de uma linha para o arquivo canônico da KB — nunca conteúdo.

## Onde está o resto

| Precisa de | Vá para |
|---|---|
| Regra de código, commit, segurança ou convenção de stack | [RULES.md](RULES.md) — `RG`, `RGIT`, `RSEC`, `RTEST`, `RJ`, `RSB`, `RPY`, `RTS`, `RNG`, `RRE`, `RDB`, `RDK`, `RCI`, `RCFG` |
| Roteamento de pedido → prompt oficial | [kb/prompt-library.md](kb/prompt-library.md), com a tabela de gatilho em [CLAUDE.md](CLAUDE.md) |
| Instalar o fluxo ou os templates em outro projeto | [CLAUDE.md](CLAUDE.md) · [templates/README.md](templates/README.md) |
| O par CLAUDE.md/AGENTS.md para um projeto novo | [templates/](templates/README.md) — regra em ADR-001 |
| Uso do próprio Claude Code | `docs/eficiencia-claude-code.md` |
