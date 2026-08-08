# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

<!--
═══════════════════════════════════════════════════════════════════════════════
TEMPLATE — CLAUDE.md · camada específica do Claude Code
Fonte: labs/kb/  ·  Companheiro obrigatório: AGENTS.template.md
═══════════════════════════════════════════════════════════════════════════════

PRINCÍPIO DE PROJETO DESTE PAR DE ARQUIVOS
  AGENTS.md  = regras de engenharia PORTÁVEIS (valem em qualquer agente)
  CLAUDE.md  = importa AGENTS.md + acrescenta só o que é do Claude Code
  Uma regra mora em UM lugar. Se você se pegar copiando, parou de usar o template.

  Isto resolve o problema mais caro observado em campo: dois arquivos de norma
  vigentes definindo os MESMOS identificadores com significados DIFERENTES
  (AP-14 · Namespace Colidido). Todo identificador citável precisa ser único no repo.

O TESTE DE INCLUSÃO, de novo: "remover esta linha faria o Claude errar?"
META DE TAMANHO: 40–80 linhas próprias, além do import.

CAMADAS DISPONÍVEIS — use, em vez de inchar este arquivo:
  ~/.claude/CLAUDE.md    todas as sessões, todos os projetos (suas preferências)
  ./CLAUDE.md            este arquivo — projeto, versionado
  ./CLAUDE.local.md      pessoal, no .gitignore
  ./<subdir>/CLAUDE.md   carregado SOB DEMANDA ao tocar aquele diretório ← subutilizado
  .claude/skills/        carregado SOB DEMANDA quando relevante

Apague todos estes comentários ao instanciar.
-->

Regras de engenharia deste projeto: @AGENTS.md

## Verificação — rode e mostre a saída

<!-- Primeira seção de propósito: é a que mais muda o resultado. O Claude para quando
     o trabalho "parece pronto"; uma checagem que ele mesmo roda fecha o laço sozinho. -->

Ao terminar uma mudança de comportamento, rode `<comando de teste>` e `<comando de build>` e
**mostre a saída real**. Não relate "os testes passam" — cole o resultado.

Se a verificação não puder rodar neste ambiente, diga **não verificado**. Nunca marque como feito.

## Fluxo por porte da mudança

<!-- Calibração. Sem isto o Claude aplica o mesmo cerimonial a um typo e a um módulo novo —
     e a documentação oficial é explícita: "se você descreve o diff em uma frase, pule o plano". -->

- **Uma frase de diff** (typo, log, renomear local) → faça direto, verifique, pronto.
- **Mudança estrutural ou feature** → **DISPARO AUTOMÁTICO DE WORKTREE E SDD**:
  1. `claude --worktree <task>` (isola arquivos preventivamente - `EXE-05`).
  2. `/sdd-specify` + invocação obrigatória da skill `grill-me` (`INT-08`) para entrevistar o usuário.
  3. `/sdd-plan` + `/sdd-tasks` (decomposição por história).
  4. Execução por subagentes e auditoria em sessão limpa `/sdd-converge` (`I-09`) antes do merge.

## Contexto

<!-- As três regras que mais economizam contexto. -->

- Investigação que exige ler muitos arquivos: **use subagente** — a exploração não deve consumir esta sessão.
- Ao compactar, preserve sempre: arquivos modificados, comandos de teste e decisões de contrato.
- `<arquivo grande e caro que quase nunca vale ler inteiro>` — leia só a seção relevante.

## Paralelismo

<!-- Worktree isola ARQUIVOS; subagente isola CONTEXTO. Confundir os dois produz worktree para
     tarefa de leitura (caro e inútil) e edição concorrente sem isolamento (conflito silencioso).
     O item de setup abaixo é o que todo mundo esquece: worktree é checkout novo — sem deps, sem .env.
     Detalhe: labs/kb/worktrees.md -->

- **Só leitura ou investigação** → subagente. Worktree não resolve contexto, e custa setup.
- **Uma por frente de trabalho (nunca por task)** → `claude --worktree <tipo>/<assunto>` (impede sujeira na branch `main`, `EXE-05`, `RGIT-11`).
- **Setup obrigatório num worktree novo:** `<comando de install>` `<+ subir serviços/portas próprias>`.
- `<.worktreeinclude do projeto, se houver — os gitignorados que precisam ir junto>`
- `<worktree.baseRef: "fresh" (default) ou "head" — e por quê neste projeto>`


## Comandos e skills deste projeto

<!-- Ponteiros. Uma linha cada. Se precisar explicar o que a skill faz, a description dela está ruim. -->

| Comando | Para quê |
|---|---|
| `/<comando>` | `<uma linha>` |

Skills em `.claude/skills/` são carregadas sozinhas quando relevantes — não precisa invocá-las.

## Peculiaridades do ambiente

<!-- Só o que já quebrou a sessão de alguém. Isto é ouro e não está em lugar nenhum do código. -->

- `<serviço que precisa estar de pé antes de rodar>`
- `<variável obrigatória sem default>`
- `<comportamento surpreendente da toolchain>`
- `<arquivo gerado que não deve ser editado à mão>`

## Git

- Branch: `<padrão>`. Commit por unidade concluída, **nunca** um commit único no fim.
- `<política de PR, se houver>`

<!--
═══════════════════════════════════════════════════════════════════════════════
MANUTENÇÃO — trate este arquivo como código

  Sintoma                                        Diagnóstico              Ação
  ─────────────────────────────────────────────  ───────────────────────  ─────────────────────
  Claude ignora uma regra que está escrita aqui  arquivo longo demais     podar; a regra se perdeu
  Claude pergunta algo que está escrito aqui     redação ambígua          reescrever a linha
  Regra precisa valer SEM exceção                instrução é advisory     converter em hook/CI
  Regra vale só às vezes                         custa contexto sempre    mover para skill
  Regra vale só num diretório                    escopo errado            mover para <dir>/CLAUDE.md
  A informação envelheceu sem ninguém editar     estado volátil aqui      mover para STATUS.md

  Teste de eficácia: mude uma linha e observe se o comportamento do Claude muda de fato.
  Se não muda, a linha não está fazendo nada — apague.

  Revise quando algo der errado. Pode regularmente. Versione junto com o código.
═══════════════════════════════════════════════════════════════════════════════
-->
