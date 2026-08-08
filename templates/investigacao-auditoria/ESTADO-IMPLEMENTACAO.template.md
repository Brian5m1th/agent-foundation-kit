# Fila de Implementação Pós-Auditoria (Dupla Trilha)

Ordem e agrupamento de execução das correções investigadas.

## Trilha A — Ajustes Simples (`ajuste_simples`)
*Execução direta via Plan Mode / 1 a 1 / sem ciclo Spec Kit.*

| Prior. | ID | Descrição | Ligação / Dependência | Status | Agente | Nota / Commit |
|---|---|---|---|---|---|---|
| F0.1 | B1 | Fix de tipo no validador de entrada | independente | pendente | — | — |
| F0.2 | B2 | Log com tag faltante no fallback | independente | pendente | — | — |

---

## Trilha B — Clusters com Spec (`merece_spec`)
*Execução obrigatória via ciclo SDD (`specify` → `clarify` → `plan` → `tasks` → `implement`).*

| Ordem | Cluster | Achados Cobertos | Satélites Trilha A | Status | Agente | Caminho Spec / PR |
|---|---|---|---|---|---|---|
| 1 | Cluster Core-01 | G1, G2, M4 | B3 | pendente | — | `specs/001-core-01/` |
| 2 | Cluster UI-02 | G5, G6, H2 | — | pendente | — | `specs/002-ui-02/` |

---
*Legenda de Status*: `pendente` · `em_andamento` · `bloqueado_usuario` · `concluido` · `cancelado`
