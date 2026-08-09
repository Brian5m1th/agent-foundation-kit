---
description: Audita a coerência entre constitution, spec, plan e tasks — antes de implementar
argument-hint: [NNN-slug opcional]
allowed-tools: Read, Glob, Grep
---

Fase 3.5 do fluxo SDD, **antes** da implementação. Equivale ao `/speckit.analyze` do GitHub Spec Kit.

Não confunda com `/sdd-converge`: aqui você audita os **artefatos entre si**; lá se audita o **código
contra os artefatos**. Nenhum código é lido nesta fase.

**Spec alvo (opcional):** $ARGUMENTS

## Procedimento

Leia `.specify/memory/constitution.md`, `spec.md`, `plan.md`, `tasks.md`. Depois verifique:

### 1. Cobertura descendente
- Toda história tem requisitos? Todo requisito tem task? Todo critério de sucesso tem task e mecanismo
  de verificação? Todo obstáculo tem tratamento?

### 2. Cobertura ascendente
- Toda task sobe para um requisito? **Task órfã é escopo ampliado** (Artigo IV) — é o achado que mais
  escapa.
- Todo contrato do plan serve a algum requisito?

### 3. Consistência
- Requisitos que se contradizem.
- Plan que contradiz a spec (ex.: plan resolve um caso que a spec pôs Fora de escopo).
- Tasks que assumem contrato diferente do declarado no plan.
- Terminologia divergente para a mesma entidade entre os três documentos.

### 4. Constitution
- Artigo a artigo. Todo desvio está declarado **e justificado** no plan? Desvio não declarado é achado
  crítico.

### 5. Vazamentos
- Tecnologia dentro da spec (vazou da fase de plan).
- Ambiguidade bloqueante ainda aberta.
- Adjetivo não quantificado servindo de critério.
- Proxy numérica inventada para um softgoal (AP-05).

## Relatório

| Severidade | Onde | Achado | Correção sugerida |
|---|---|---|---|
| crítico / alto / médio | `arquivo:seção` | | |

**Crítico** = desvio de constitution não declarado, requisito sem cobertura, contradição direta.

Depois: contagem por severidade, e **veredito explícito** — liberado para `/sdd-implement`, ou a lista
objetiva do que corrigir antes. Não amenize; um relatório sem achados numa spec real é suspeito.

