# Relatório de Auditoria e Convergência SDD (`[TEMPLATE]`)

> **Projeto:** `{NOME_DO_PROJETO}`
> **Spec / Feature:** `{SPEC_SLUG_OU_NUMERO}`
> **Fase:** `[/sdd-analyze | /sdd-converge]`
> **Data:** `{YYYY-MM-DD}`
> **Auditor:** `{AGENTE_OU_HUMANO}`

---

## 1. RESUMO EXECUTIVO

| Métrica | Valor | Meta / Status |
|---|---|---|
| **Conformidade Geral** | `{PERCENTUAL}%` | ≥ 95% |
| **Gaps de Spec vs Código** | `{QTD}` | 0 Bloqueantes |
| **Dívidas Técnicas Criadas** | `{QTD}` | Nenhuma não registrada |
| **Suíte de Testes (Pass/Fail)** | `{PASS}/{TOTAL}` | 100% Verde |

---

## 2. MATRIZ DE RASTREABILIDADE (REQUISITOS VS IMPLEMENTAÇÃO)

| Requisito / US | Critério de Aceite | Status no Código | Evidência / Arquivo |
|---|---|---|---|
| **US-01** | `{CRITERIO_1}` | 🟢 CONFORME | [`File.java`](file:///path/to/File.java#L10) |
| **US-01** | `{CRITERIO_2}` | 🔴 DIVERGENTE | [`File2.java`](file:///path/to/File2.java#L50) |
| **US-02** | `{CRITERIO_3}` | 🟡 PARCIAL | [`File3.ts`](file:///path/to/File3.ts#L30) |

---

## 3. ACHADOS DE AUDITORIA & GAPS IDENTIFICADOS

### 3.1 Divergências Bloqueantes (Must-Fix)
> [!CAUTION]
> - **[GAP-01]** `{Descrição da divergência entre a Spec e o código real}`
>   - **Impacto:** `{Segurança / Corrupção de Dados / Quebra de Contrato}`
>   - **Remediação Recomendada:** `{Passos exatos para correção}`

### 3.2 Melhorias Não-Bloqueantes (Backlog)
> [!NOTE]
> - **[GAP-02]** `{Pequeno desvio de convenção ou refatoração recomendada}`

---

## 4. PARECER FINAL & PRÓXIMOS PASSOS

- [ ] **APROVADO:** O código satisfaz integralmente a Spec. Pronto para Merge.
- [ ] **REPROVADO:** Requer correções nas tasks marcadas com 🔴 antes de prosseguir.
