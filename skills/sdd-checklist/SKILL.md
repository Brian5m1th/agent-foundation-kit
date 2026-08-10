---
name: sdd-checklist
description: Gera um checklist de qualidade da especificação numa dimensão
disable-model-invocation: true
argument-hint: <dimensão: requisitos | segurança | UX | operação | dados | acessibilidade>
allowed-tools: Read, Write, Edit, Glob, Grep
---

Comando opcional. Equivale ao `/speckit.checklist` do GitHub Spec Kit.

**Dimensão pedida:** $ARGUMENTS

## O que este comando NÃO é

Não é plano de teste do código. É um **checklist de qualidade da especificação**: pergunta *"este
requisito está bem escrito, completo e sem ambiguidade?"*, não *"o código passa?"*.

Item que exige rodar o sistema pertence a `tasks.md` ou a `/sdd-converge`. Confundir os dois é o erro
mais comum com este artefato.

## Passos

1. Localize a spec ativa. Leia `spec.md`, `plan.md` e a constitution.
2. Crie `specs/NNN-slug/checklists/<dimensão>.md` a partir de
   `.specify/templates/checklist-template.md`.
3. Gere itens **específicos desta spec**, não genéricos. "Os requisitos estão claros?" é inútil; "O
   FR-003 define o que acontece quando o token expira durante o upload?" é útil.
4. Percorra a spec item a item e responda cada pergunta. Reprovações viram alterações concretas na
   spec.

## Regras

- Toda pergunta é **fechada** e respondível lendo spec + plan.
- Toda pergunta referencia o item que audita (`FR-003`, `US2`, `SC-001`, `OB-2`).
- Entre 10 e 25 itens. Checklist longo demais não é lido; curto demais não cobre.
- Reprovação vira alteração na spec, não anotação no checklist.

## Ao terminar

Aprovados/total, lista dos reprovados com a correção aplicada ou proposta, e se a spec mudou.

