# labs

> Base de conhecimento e fluxo de trabalho para engenharia de software **com agentes de IA**.
> Repositório *upstream*: o que está aqui é consumido pelos projetos reais em `C:\workspace\`.

Este repositório responde a uma pergunta prática: **como fazer um agente de IA entregar software
correto de forma repetível?** A resposta não é "prompt melhor" — é um conjunto de artefatos com tipos
fixos: princípios, padrões, anti-padrões, invariantes, decisões registradas, um fluxo de
especificação versionado e templates de contexto instaláveis.

Tudo em português. Nenhuma dependência de runtime — é markdown mais dois scripts PowerShell.

---

## Índice

- [Para que serve](#para-que-serve)
- [Resumo geral](#resumo-geral)
- [Resumo por tipo de conteúdo](#resumo-por-tipo-de-conteúdo)
- [Os templates](#os-templates)
- [Como usar](#como-usar)
- [O que o projeto cobre](#o-que-o-projeto-cobre)
- [Convenções e invariantes](#convenções-e-invariantes)

---

## Para que serve

`labs` tem **dois papéis**, e vale saber em qual você está antes de mexer:

| Papel | Onde | Regra |
|---|---|---|
| **Laboratório** | `experiments/` | Protótipos descartáveis. Mudança livre, pode deletar. |
| **Fonte de verdade** | `kb/`, `.specify/`, `.claude/commands/`, `templates/` | Consumido por outros projetos. Trate como biblioteca compartilhada. |

Consequência: **edite sempre aqui, nunca na cópia instalada no projeto consumidor** — cópias que
divergem entre harnesses é um anti-padrão catalogado (`AP-15 · Cópia Manual Multi-Harness`).

## Resumo geral

Três camadas, da teoria à execução:

```
docs/intent-engineering/     fundamentação científica (por que isto funcionaria)
        ↓
kb/                          conhecimento operacional tipado (o que fazer, e por quê)
        ↓
.specify/ + .claude/commands/ + templates/     artefatos executáveis (fluxo e contexto)
```

- **`kb/`** — 14 documentos numerados + 4 destilações de fontes oficiais. Cada item é **citável por
  identificador** (`P05`, `AP-14`, `I-09`, `ADR-002`), e o namespace é global no repositório.
- **`.specify/` + `.claude/commands/`** — o fluxo **SDD** (Spec-Driven Development): 10 slash
  commands que levam de uma frase até código auditado contra a especificação.
- **`templates/`** — o par `AGENTS.md` / `CLAUDE.md` que dá contexto permanente ao agente em qualquer
  projeto novo.
- **`docs/intent-engineering/`** — 9 documentos de fundamentação, com **selo epistêmico** em cada
  afirmação, para separar o que é consolidado do que é hipótese própria.

## Resumo por tipo de conteúdo

### `kb/` — Engineering Knowledge Base

Não é documentação linear: é um **grafo de artefatos**, cada tipo respondendo a uma pergunta
diferente e envelhecendo em ritmo diferente.

| # | Documento | Responde | Identificadores |
|---|---|---|---|
| 00 | [Taxonomia](kb/00-taxonomia.md) | Onde isto se encaixa? | `D0`–`D6` |
| 01 | [Ontologia](kb/01-ontologia.md) | Como os conceitos se relacionam? | — |
| 02 | [Glossário](kb/02-glossario.md) | O que este termo significa aqui? | — |
| 03 | [Princípios](kb/03-principios.md) | **Por que** fazemos assim? | `P01`–`P14` |
| 04 | [Padrões](kb/04-padroes.md) | Como resolvo este problema recorrente? | `CTX-` `INT-` `PLN-` `EXE-` `VER-` `LRN-` |
| 05 | [Anti-padrões](kb/05-antipadroes.md) | O que falha repetidamente? | `AP-01`–`AP-34` |
| 06 | [Heurísticas e invariantes](kb/06-heuristicas-e-invariantes.md) | O que nunca pode ser violado? | `I-01`–`I-18` · `H-01`–`H-16` |
| 07 | [Modelos mentais](kb/07-modelos-mentais.md) | Como raciocinar sobre isto? | — |
| 08 | [Arquiteturas e pipelines](kb/08-arquiteturas-e-pipelines.md) | Que forma o sistema deve ter? | `AR-01`–`AR-03` · `PL-01`–`PL-05` |
| 09 | [Decisão, estados, algoritmos](kb/09-decisao-estados-algoritmos.md) | O que fazer **neste ponto**? | `AD-01`–`AD-03` · `ME-01`–`ME-03` · `AL-01`–`AL-05` |
| 10 | [Métricas](kb/10-metricas.md) | Como sei se está funcionando? | — |
| 11 | [ADRs](kb/11-adrs.md) | Por que **isto** e não aquilo? | `ADR-001`–`ADR-010` |
| 12 | [Rastreabilidade](kb/12-rastreabilidade.md) | Isto cobre aquilo? | — |
| 13 | [Bibliografia](kb/13-bibliografia.md) | De onde vem a afirmação? | — |

Fora da numeração, destilações das fontes oficiais:
[anthropic-claude-code](kb/anthropic-claude-code.md) ·
[worktrees](kb/worktrees.md) ·
[sub-agents](kb/sub-agents.md) ·
[prompt-library](kb/prompt-library.md) — os **52 prompts oficiais** da Anthropic com um índice de
gatilho (intenção → prompt) que transforma a vitrine em tabela de decisão consultável por agente.

As famílias de padrões seguem as disciplinas: `CTX` contexto · `INT` intenção · `PLN` planejamento ·
`EXE` execução · `VER` verificação · `LRN` aprendizado.

Índice completo e critério de cada tipo: [kb/README.md](kb/README.md).

### `.specify/` + `.claude/commands/` — o fluxo SDD

Dez slash commands em markdown. A ordem é rígida: não se planeja antes de especificar, não se
implementa sem tasks.

| # | Comando | Produz | Responde |
|---|---|---|---|
| 0 | `/sdd-constitution` | `.specify/memory/constitution.md` | Princípios inegociáveis do projeto |
| 1 | `/sdd-specify <descrição>` | `specs/NNN-slug/spec.md` | **O QUÊ** e **POR QUÊ** — sem tecnologia |
| 1.5 | `/sdd-clarify` | spec atualizada | Resolve ambiguidades perguntando ao humano |
| 2 | `/sdd-plan` | `specs/NNN-slug/plan.md` | **COMO** — stack, contratos, riscos |
| 3 | `/sdd-tasks` | `specs/NNN-slug/tasks.md` | Passos por história, verificáveis |
| 3.5 | `/sdd-analyze` | relatório | Os artefatos são coerentes **entre si**? |
| 4 | `/sdd-implement` | código | Execução, uma task por vez |
| 5 | `/sdd-converge` | relatório | O **código** satisfaz a spec? |
| — | `/sdd-checklist <dimensão>` | `specs/NNN-slug/checklists/` | A spec está bem escrita? |

Opcionais: `clarify`, `analyze`, `checklist`. O resto é o caminho principal.

**Distinção que costuma confundir:** `/sdd-analyze` audita **artefato contra artefato**, antes de
implementar. `/sdd-converge` audita **código contra artefato**, depois — e roda em **sessão
separada** de quem implementou, porque auditor que compartilha o contexto do executor converge para
confirmação (`I-09`, `P12`).

Em `.specify/` ficam a `constitution.md` e os templates de `spec`, `plan`, `tasks` e `checklist` que
os comandos preenchem. Em `.specify/scripts/install.ps1`, o instalador.

**Origem:** modelado sobre o [GitHub Spec Kit](https://github.github.io/spec-kit/) — mesma sequência,
mesma estrutura de diretórios. Diferenças deliberadas: português com prefixo `sdd-`; sem dependência
do CLI `specify` (são markdown versionáveis); e **cinco extensões** vindas de
`docs/intent-engineering/` — análise de obstáculos (KAOS), envelope de autonomia por task, modo de
interpretação declarado, registro de interpretação, e bloqueio por ambiguidade calibrado pelo custo
de reversão. Migrar para o Spec Kit oficial é direto: a estrutura de pastas é a mesma.

### `templates/` — o par de contexto

Ver a seção [Os templates](#os-templates).

### `docs/intent-engineering/` — fundamentação

Aprofundamento de **uma** das disciplinas da taxonomia (D1 · Intent). Nove documentos:
fundamentação, taxonomia e glossário, árvore de princípios, árvore de responsabilidades, catálogo de
padrões, decisões arquiteturais, agenda de pesquisa, bibliografia e visão integrada.

O aviso metodológico é parte do conteúdo: **não se assume que "Engenharia de Intenção" seja um campo
consolidado**. Toda afirmação carrega um selo, e os selos nunca se misturam:

`[CONSOLIDADO]` revisado por pares e replicado · `[INDÚSTRIA]` consenso de prática sem validação
controlada · `[RECENTE]` últimos ~3 anos, em disputa · `[EXPERIMENTAL]` evidência empírica com escopo
declarado · `[ACADÊMICO]` proposta sem adoção ampla · `[HIPÓTESE]` proposta original, com condição de
falsificação · `[OFICIAL]` documentação de fornecedor · `[CAMPO]` observado nos projetos reais, com o
arquivo citado.

Nenhuma `[HIPÓTESE]` aparece sem (a) a disciplina de onde deriva e (b) como refutá-la.

### `experiments/`, `specs/`, `note/`

- **`experiments/<data-slug>/`** — protótipos autocontidos, ex.: `2026-08-02-streaming-tool-use/`.
  Uma linha explicando a hipótese testada. Sem stack definida, **um arquivo que roda vale mais que
  uma árvore de pastas vazia**. Experimento que amadurece vira projeto próprio em `C:\workspace\`,
  não cresce aqui dentro.
- **`specs/`** — saída do fluxo SDD quando ele roda no próprio `labs` (`NNN-slug/`).
- **`note/`** — atalhos de uma linha para o arquivo canônico da KB. **Nunca conteúdo** — se você está
  escrevendo texto numa nota, ele pertence a `kb/`.

### `AGENTS.md` e `CLAUDE.md` (raiz)

O próprio par de contexto deste repositório, seguindo a mesma regra que os templates ensinam:
`AGENTS.md` tem as regras de engenharia portáveis, `CLAUDE.md` importa com `@AGENTS.md` e acrescenta
só o que é específico do Claude Code (roteamento da biblioteca de prompts, instalação, paralelismo).

## Os templates

Dois arquivos que trabalham **em par**, governados pela
[ADR-001](kb/11-adrs.md):

> **`AGENTS.md`** carrega as regras de engenharia **portáveis** — valem em qualquer agente.
> **`CLAUDE.md`** importa o primeiro com `@AGENTS.md` e acrescenta **só** o que é do Claude Code.
> Uma regra mora em um lugar só.

Isso existe para evitar um problema observado: dois arquivos de norma vigentes definindo os **mesmos
identificadores** com significados **diferentes** (`AP-14 · Namespace Colidido`).

### Instalar num projeto

```powershell
$p = 'C:\workspace\<projeto>'
Copy-Item C:\workspace\labs\templates\AGENTS.template.md "$p\AGENTS.md"
Copy-Item C:\workspace\labs\templates\CLAUDE.template.md "$p\CLAUDE.md"
```

Depois: preencha os `<placeholders>`, **apague todos os comentários HTML** e rode uma sessão real
para observar se o comportamento mudou de fato.

### As quatro regras de manutenção

1. **Teste de inclusão, linha a linha:** *"remover isto faria o agente errar?"* Se não, apague
   (`AP-02`).
2. **Tamanho:** `AGENTS.md` 60–120 linhas · `CLAUDE.md` 40–80 próprias. Passou de 150 somadas, alguma
   regra já está sendo ignorada.
3. **Onde cada coisa mora** — árvore `AD-02`: muda com frequência → `STATUS.md` · vale só num
   diretório → `<dir>/CLAUDE.md` · vale só às vezes → skill · precisa valer sem exceção → hook/CI ·
   portátil → `AGENTS.md` · específico do Claude Code → `CLAUDE.md`.
4. **Teste de eficácia:** mude uma linha e observe se o comportamento muda. Se não muda, a linha não
   está fazendo nada.

### Diagnóstico rápido

| Sintoma | Causa provável | Ação |
|---|---|---|
| O agente ignora uma regra escrita | arquivo longo demais | podar |
| O agente pergunta algo já respondido | redação ambígua | reescrever a linha |
| A informação envelheceu sozinha | estado volátil em arquivo permanente | mover para `STATUS.md` |
| A regra é violada mesmo estando escrita | instrução é *advisory* | converter em hook/CI |
| Duas definições do mesmo identificador | `AP-14` | renumerar uma das fontes |
| Cópias divergindo entre harnesses | `AP-15` | fonte única + geração |

Detalhe: [templates/README.md](templates/README.md).

## Como usar

Ambiente: **Windows + PowerShell 7**. Os scripts são `.ps1` — invoque com `pwsh`, não `powershell`.

### 1. Instalar o fluxo SDD

```powershell
# Só os slash commands, globais (~/.claude/commands)
pwsh C:\workspace\labs\.specify\scripts\install.ps1

# Num projeto: commands + .specify/ (constitution e templates)
pwsh C:\workspace\labs\.specify\scripts\install.ps1 -Target C:\workspace\WWMA-Tech
```

Os `sdd-*.md` são **sobrescritos** (labs é upstream). A `constitution.md` e os templates já
existentes no destino são **preservados** — `-Force` sobrescreve tudo.

### 2. Instalar o par de contexto

Instalação manual, descrita em [Os templates](#os-templates) — não passa pelo `install.ps1`.

### 3. Rodar uma feature ponta a ponta

```
/sdd-constitution           # uma vez por projeto
/sdd-specify "usuário precisa exportar o relatório em PDF"
/sdd-clarify                # se a spec tiver [PRECISA ESCLARECER] bloqueante
/sdd-plan
/sdd-tasks
/sdd-analyze                # opcional, mas barato
/sdd-implement
/sdd-converge               # em sessão separada
```

### 4. Quando *não* usar o SDD

Existe um caminho leve: a [biblioteca de prompts](kb/prompt-library.md). A calibração oficial é
`H-01` — **se você descreve o diff em uma frase, pule o plano**. A árvore de decisão completa é
`AD-01` em [kb/09](kb/09-decisao-estados-algoritmos.md).

### 5. Paralelismo

Worktree isola **arquivos**; subagente isola **contexto**. Confundir os dois produz worktree para
tarefa de leitura (caro e inútil) e edição concorrente sem isolamento.

- Investigação que varre muitos arquivos → subagente (`CTX-03`).
- Duas frentes escrevendo nos mesmos arquivos → `claude --worktree <assunto>`, uma por frente, nunca
  uma por task (`EXE-05`, `PLN-04`).
- Detalhe: [kb/worktrees.md](kb/worktrees.md) · [kb/sub-agents.md](kb/sub-agents.md).

## O que o projeto cobre

**Cobre:**

- Engenharia de contexto — o que entra no `CLAUDE.md`/`AGENTS.md`, o que vira skill, o que vira hook.
- Engenharia de intenção — do pedido informal à especificação verificável, com tratamento explícito
  de ambiguidade e de obstáculos.
- Planejamento e decomposição — tasks agrupadas por história, envelope de autonomia por task.
- Execução com agentes — paralelismo, isolamento, quando delegar.
- Verificação — auditoria artefato↔artefato e código↔artefato, checklists por dimensão,
  rastreabilidade requisito → intenção → plano → execução → verificação.
- Aprendizado — anti-padrões com evidência de campo, ADRs imutáveis, métricas.
- Roteamento de pedido → prompt oficial, para os 52 prompts da Anthropic.

**Não cobre (deliberadamente):**

- Não é framework nem tem runtime — não há código a executar, exceto o instalador.
- Não é agnóstico de ambiente: assume Windows + PowerShell 7 e Claude Code como harness principal
  (as regras portáveis ficam isoladas em `AGENTS.md` justamente por isso).
- Não é tutorial de uma linguagem ou stack — a spec nunca fala de tecnologia; isso é da fase de plan,
  que é do projeto consumidor.
- Não hospeda projetos que amadureceram — esses saem para `C:\workspace\`.

## Convenções e invariantes

- **A constitution vence** (`I-14`). Conflito com ela é reportado ao humano, nunca resolvido em
  silêncio.
- **Spec não fala de tecnologia.** "React", "Postgres" ou "endpoint" numa spec é vazamento da fase de
  plan.
- **Ambiguidade vira `[PRECISA ESCLARECER]`, classificada** (`P04`, `ADR-002`). *Bloqueante* quando
  reverter é caro (schema, contrato, dado, segurança) — trava a fase seguinte. *Não-bloqueante*
  quando é barato tentar — vira suposição registrada em Premissas. Bloquear tudo é modo de falha, não
  rigor.
- **Histórias são independentemente testáveis**, priorizadas, e a US1 é o MVP.
- **Tasks são agrupadas por história, não por camada** (`PLN-02`) — agrupar por camada destrói a
  entregabilidade incremental.
- **Numeração é sequencial e imutável** — specs (`001-`) e identificadores da KB. Item errado é
  corrigido no lugar ou marcado obsoleto; **nunca renumerado**, porque quebra citação externa.
- **Toda afirmação nova na KB entra com selo** e, quando `[CAMPO]`, com o arquivo citado. Ao citar a
  KB, **preserve o selo** — a força da afirmação vem dele, não da redação.
- **Cite por identificador, não por paráfrase.** O namespace é global: dois artefatos nunca reusam um
  prefixo (`AP-14`).

---

Regras completas de engenharia: [AGENTS.md](AGENTS.md) · camada do Claude Code: [CLAUDE.md](CLAUDE.md).
