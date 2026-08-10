# Arquitetura de Automação do Fluxo Jira + SDD & Agentes AI

> **Instância Jira:** [wwmatech.atlassian.net](https://wwmatech.atlassian.net)  
> **Cloud ID:** `<JIRA_CLOUD_ID>` (configurado via ambiente / MCP)  
> **Repositório:** Upstream `labs`  
> **Última Atualização:** 2026-08-10

---

## 1. Visão Geral da Automação

O objetivo desta automação é sincronizar **automaticamente** os status das tarefas no Jira à medida que o desenvolvedor ou o agente de IA avança pelas etapas do **Fluxo SDD** (Spec-Driven Development) e Git/GitHub.

```mermaid
sequenceDiagram
    autonumber
    actor Dev as Desenvolvedor / Agente AI
    participant Jira as Jira Cloud (wwmatech)
    participant SDD as Comando SDD / CLI
    participant GH as GitHub Actions / CI

    Note over Dev, Jira: 1. Especificação & Planejamento
    Dev->>SDD: /sdd-specify ou /sdd-plan (IA-148)
    SDD->>Jira: Transição ID 11 (To Do)

    Note over Dev, Jira: 2. Execução / Código
    Dev->>SDD: /sdd-implement (IA-148)
    SDD->>Jira: Transição ID 21 (In Progress)

    Note over Dev, Jira: 3. Auditoria & PR
    Dev->>GH: Abrir PR (feat/IA-148-slug)
    GH->>Jira: Transição ID 31 (In Review) via GitHub Action

    Note over Dev, Jira: 4. Conclusão & Merge
    Dev->>GH: Merge PR em main
    GH->>Jira: Transição ID 41 (Done) via GitHub Action
```

---

## 2. Matriz de Automação por Camada

| Fase SDD / Git | Trigger | Ação Automatizada | Status Alvo no Jira | ID Transição |
|---|---|---|---|---|
| **Especificação / Planejamento** | `/sdd-specify`, `/sdd-plan` | Script local / Agent Hook | `To Do` | `11` |
| **Desenvolvimento Ativo** | `/sdd-implement` | Script local / MCP Tool | `In Progress` | `21` |
| **Abertura de PR / Review** | Abertura do Pull Request | GitHub Action (`jira-sdd-sync.yml`) | `In Review` | `31` |
| **Merge em Main** | Merge do PR / Push `main` | GitHub Action (`jira-sdd-sync.yml`) | `Done` | `41` |

---

## 3. Componentes da Solução Criada

### A. Script PowerShell de Sincronização Local (`.specify/scripts/sync-jira.ps1`)
Script leve invocável via terminal ou automaticamente por agentes de IA:

```powershell
# Exemplos de uso do script:
pwsh .specify/scripts/sync-jira.ps1 -IssueKey "IA-148" -Stage "todo"        # -> To Do (11)
pwsh .specify/scripts/sync-jira.ps1 -IssueKey "IA-148" -Stage "implement"   # -> In Progress (21)
pwsh .specify/scripts/sync-jira.ps1 -IssueKey "IA-148" -Stage "review"      # -> In Review (31)
pwsh .specify/scripts/sync-jira.ps1 -IssueKey "IA-148" -Stage "done"        # -> Done (41)
```

### B. CI/CD no GitHub Actions (`.github/workflows/jira-sdd-sync.yml`)
Disparado automaticamente ao abrir PR ou ao realizar merge na branch `main`. Extrai a chave do ticket (ex: `IA-148`) diretamente do nome da branch ou mensagem de commit.

### C. Hook nos Agentes AI (Atlassian MCP Tool)
Quando o agente executa comandos como `/sdd-implement` ou `/sdd-converge`, ele utiliza a ferramenta `transitionJiraIssue` nativa do MCP Server do Atlassian para transicionar o ticket sem intervenção manual.

---

## 4. Política de Visibilidade no Quadro (Backlog vs. Active Board)

Para garantir que o **Quadro de Trabalho (Active Board)** exiba **apenas as tarefas que estão sendo executadas no momento**, a automação segue a seguinte regra de visibilidade:

```mermaid
graph LR
    Backlog["📦 Backlog (To Do / Rascunho)"] -->|Selecionado / SDD Start| Board["📌 Quadro Ativo (In Progress / In Review)"]
    Board -->|Merge em Main / Done| Archived["✅ Concluído (Removido do Quadro Ativo)"]
```

1. **Entrada no Quadro Ativo (`To Do` / `In Progress`):**
   - Sempre que uma tarefa, bug ou story é selecionada para execução (ao rodar `/sdd-specify`, `/sdd-plan` ou `/sdd-implement`), o item sai do Backlog e entra no **Quadro Ativo**.

2. **Manutenção no Quadro (`In Progress` & `In Review`):**
   - O item permanece visível no Quadro Ativo durante todo o ciclo de desenvolvimento e auditoria de código (PR).

3. **Remoção do Quadro Ativo após Conclusão (`Done`):**
   - Assim que o PR é mesclado e o status muda para `Done`, o item é concluído. O filtro do Quadro Ativo (`status != Done`) remove a tarefa concluída da visualização principal, deixando o quadro **limpo e focado exclusivamente nas tarefas em andamento**.

