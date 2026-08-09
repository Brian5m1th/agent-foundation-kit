---
name: sdd-tasks
description: Quebra spec e plano em tasks ordenadas, agrupadas por história
disable-model-invocation: true
argument-hint: [NNN-slug opcional]
allowed-tools: Read, Write, Edit, Glob, Grep
---

Fase 3 do fluxo SDD. Equivale ao `/speckit.tasks` do GitHub Spec Kit.

**Spec alvo (opcional):** $ARGUMENTS

## Passos

1. Localize a spec. Leia `spec.md` e `plan.md`.
2. **Bloqueio:** marcador bloqueante em aberto em qualquer um dos dois → pare e reporte.
3. Crie `specs/NNN-slug/tasks.md` a partir de `.specify/templates/tasks-template.md`.

## Regras obrigatórias

- **Organize por história, não por camada.** Fases: Setup → Fundação → US1 → US2 → ... → Acabamento.
  Agrupar por camada ("todos os models", "todos os controllers") destrói a entregabilidade
  independente das histórias.
- **A fase Fundação é um portão rígido**: nenhuma task de história começa antes dela fechar. Só entra
  nela o que realmente bloqueia *todas* as histórias.
- **US1 é o MVP.** Ao fim da fase da US1 tem de existir algo demonstrável.
- Cada task declara: **arquivos**, **como verificar** (comando ou checagem de uma linha) e **o que
  cobre** (FR/SC). Sem verificação, a task não entra (Artigo III).
- `[P]` só com arquivos disjuntos. Mesmo arquivo ≠ paralelo.
- **Envelope**: preencha apenas quando a task **restringe** o padrão da spec (ex.: "consulta antes de
  alterar o schema"). Não repita o padrão em toda task.
- Prefira 12 tasks nítidas a 4 tasks vagas. Task grande demais para uma execução é quebrada.
- Escreva o **Checkpoint** de cada história: como provar que ela funciona isoladamente.
- Preencha a rastreabilidade. **Requisito ou critério sem task é defeito do plano** — reporte, não
  invente task genérica.

## Ao terminar

Contagem por fase, quantas `[P]`, qual o conteúdo do MVP (fase US1), e qualquer FR/SC sem cobertura.
Sugira `/sdd-analyze` antes de implementar.

