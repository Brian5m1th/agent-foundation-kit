# TEAMWORK-PREVIEW — Autonomous Task Execution Workflow (`[CAMPO]`)

> **Selo Epistêmico:** `[CAMPO]` (Origem: Esteira de Execução Serializada de Backlog para AI Agents)  
> **Tipo:** Agent Workflow / Execution Skill  
> **Precedência:** Este workflow rege a ordem e o ciclo de vida de execução autônoma de tasks em `TODO`.

---

## 🎯 Objetivo

Executar automaticamente todas as tasks atualmente em **TODO**, seguindo uma ordem definida pelo agente e processando **exatamente uma task por vez**.

Cada task deve percorrer o ciclo completo:

$$\text{TODO} \longrightarrow \text{Análise/Contexto} \longrightarrow \text{Worktree} \longrightarrow \text{SDD} \longrightarrow \text{Implementação} \longrightarrow \text{Testes} \longrightarrow \text{Git Strategy} \longrightarrow \text{PR} \longrightarrow \text{Push} \longrightarrow \text{Cleanup} \longrightarrow \text{DONE} \longrightarrow \text{Próxima Task}$$

O agente **NUNCA deve trabalhar em mais de uma task simultaneamente**.

---

## 🛑 1. REGRA ABSOLUTA — SERIALIZAÇÃO

A unidade de trabalho é uma única task.

O agente deve:

1. Buscar as tasks em `TODO`.
2. Analisar todas as tasks e criar uma ordem de execução.
3. Selecionar somente a primeira task.
4. Executar o fluxo completo dessa task.
5. Só considerar a task concluída após:
   - implementação finalizada;
   - testes executados;
   - Git validado;
   - PR criado;
   - commit/push realizados conforme a Git Strategy do projeto (`RGIT-02`/`RGIT-03`);
   - worktree limpa (`EXE-05`);
   - task atualizada para `DONE`;
   - PR referenciando a task.
6. Somente depois disso selecionar a próxima task.

### 🚫 Proibições Invioláveis

Nunca:
- iniciar duas tasks ao mesmo tempo;
- criar worktrees para múltiplas tasks antecipadamente;
- misturar código de duas tasks;
- criar PRs de múltiplas tasks antes de finalizar a atual;
- deixar uma task parcialmente implementada para começar outra;
- marcar uma task como `DONE` antes do fluxo completo;
- alterar outra task "aproveitando" o contexto da task atual.

> **Uma task entra. Uma task sai completamente finalizada. Só então a próxima começa.**

---

## 🔍 2. BUSCA E PRIORIZAÇÃO DAS TASKS

Primeiro, buscar todas as tasks com status `TODO`. Não alterar nenhuma task ainda.

Para cada task:
1. Ler título.
2. Ler descrição completa.
3. Ler critérios de aceitação.
4. Ler prioridade.
5. Ler dependências.
6. Identificar bloqueios.
7. Identificar relação com outras tasks.
8. Identificar impacto técnico.
9. Identificar dependências entre tasks.

Criar internamente uma ordem de execução baseada na seguinte prioridade:
1. Dependências técnicas obrigatórias.
2. Bloqueios que impedem outras tasks.
3. Prioridade definida na task.
4. Risco técnico.
5. Impacto no sistema.
6. Complexidade.
7. Ordem natural do domínio/feature.

*Não modificar a prioridade original da task.* Apenas criar uma **ordem operacional de execução**.  
Antes de começar, registrar a ordem escolhida.

---

## 📌 3. SELEÇÃO DA TASK

Selecionar somente a primeira task da fila.

Obter:
- ID da task;
- título;
- descrição;
- critérios de aceitação;
- prioridade;
- links;
- comentários relevantes;
- contexto relacionado;
- dependências.

A partir deste momento, o agente deve trabalhar exclusivamente nessa task.

---

## 🧠 4. CONTEXTO ANTES DO CÓDIGO

Antes de alterar qualquer arquivo:
1. Entender completamente a task.
2. Identificar o comportamento esperado.
3. Localizar no projeto as áreas relacionadas.
4. Inspecionar arquitetura existente.
5. Identificar padrões já utilizados.
6. Identificar testes existentes.
7. Identificar possíveis impactos.
8. Verificar se a task já possui implementação parcial.
9. Verificar o estado atual do Git.

Não implementar baseado somente no título da task. A descrição + contexto do projeto + código existente + critérios de aceitação são a fonte de verdade.

Se houver ambiguidade importante, usar o fluxo de **clarification** (`/sdd-clarify`) antes da implementação (`ADR-002`).

---

## 🌿 5. WORKTREE ISOLADO (`EXE-05`, `RGIT-11`)

Criar uma worktree exclusiva para a task atual.

A worktree deve:
- partir da branch correta;
- possuir nome identificável pela task (ex: `task/<TASK-ID>-<short-description>`);
- manter isolamento da branch principal (`main`/`master`);
- evitar qualquer alteração fora do escopo da task.

Nunca reutilizar uma worktree contendo trabalho de outra task.

Antes de começar a implementação:
- verificar branch;
- verificar status;
- confirmar que a worktree está limpa;
- confirmar que a task é a única unidade de trabalho ativa.

---

## 📐 6. SDD PIPELINE

Dentro da worktree, executar obrigatoriamente o pipeline SDD.

$$\text{Specify} \longrightarrow \text{Clarify} \longrightarrow \text{Plan} \longrightarrow \text{Implement} \longrightarrow \text{Verify}$$

### Specify (`/sdd-specify`)
Criar a especificação da task contendo: problema, objetivo, contexto, escopo, fora de escopo, requisitos funcionais/não-funcionais, critérios de aceitação, restrições, impactos e riscos.

### Clarify (`/sdd-clarify` / `INT-08`)
Questionar ambiguidades técnicas, comportamentais ou arquiteturais. Não inventar requisitos. Quando uma decisão puder alterar comportamento, contrato, arquitetura, segurança ou persistência, tratar como ponto crítico bloqueante (`ADR-002`).

### Grill Me (`/sdd-checklist` / Review Agressiva)
Executar uma revisão agressiva da especificação questionando: requisitos ausentes, edge cases, inconsistências, critérios de aceitação incompletos, impactos, segurança, concorrência, persistência, integração, observabilidade, testes, regressões e compatibilidade de contratos.  
*Objetivo:* Encontrar problemas antes de escrever código.

---

## 🛠️ 7. IMPLEMENTAÇÃO

Implementar somente o que estiver definido no escopo da task.

Respeitar:
- arquitetura existente;
- padrões do projeto;
- regras de `AGENTS.md` e `CLAUDE.md`;
- padrões de testes;
- Git Strategy (`RGIT-*`);
- convenções de naming;
- contratos existentes.

Não realizar refatorações não relacionadas. Se encontrar um problema fora do escopo: registrá-lo como possível follow-up e continuar a task.

---

## 🧪 8. TESTES & VALIDAÇÃO (`RTEST-*`)

Após a implementação:
1. Executar os testes unitários e de integração relacionados.
2. Executar linters, formatters e type-checks.
3. Executar o build do projeto.
4. Executar validações adicionais configuradas no repositório.

Se houver falha: **não avançar para o PR.** Investigar $\rightarrow$ corrigir $\rightarrow$ re-executar. Nenhuma task é concluída com testes quebrados.

---

## 👁️ 9. SELF-REVIEW

Revisar o `git diff` completo da task antes de commitar.

Verificar:
- escopo e qualidade do código;
- conformidade com a arquitetura;
- ausência de código morto, logs de debug ou secrets vaziados;
- arquivos alterados sem justificativa;
- tratamento de erros e casos de borda.

---

## 📦 10. GIT STRATEGY (`RGIT-02`, `RGIT-03`)

Somente após implementação + testes + self-review:
1. Inspecionar `git status` e `git diff`.
2. Criar commit seguindo a Git Strategy do projeto (Conventional Commits).
3. Fazer push para a branch remota da task.
4. Criar Pull Request (PR) seguindo o padrão do repositório.

O PR deve conter:
- referência explícita à task (ex: `JIRA: <TASK-ID>`);
- link real da task;
- resumo da implementação e decisões tomadas;
- testes executados e evidências de validação.

---

## 🔗 11. PR E TASK STATE

Após a criação do PR e push concluído, atualizar a task com:
- link e referência ao PR;
- resumo do status de implementação.

A task só transita para `DONE` quando o fluxo completo e os critérios de aceitação forem satisfeitos.

---

## 🧹 12. CLEANUP (`EXE-05`)

Depois do PR/push:
1. Confirmar que os commits estão no remoto.
2. Confirmar a criação e vinculação do PR.
3. Garantir ausência de alterações pendentes locais.
4. Remover a worktree exclusiva da task (`git worktree remove`).
5. Voltar ao estado operacional padrão do repositório.

Não carregar alterações nem contextos da task anterior para a próxima.

---

## ✅ 13. FINALIZAÇÃO DA TASK

Transitar o status da task: `TODO → DONE`.

Registrar log interno:
- Task ID concluída;
- SHA do Commit / Branch / PR Link;
- Resultado da validação de testes.

Somente após este registro, avançar para a próxima task.

---

## 🔄 14. PRÓXIMA TASK

Voltar para a lista de tasks. Buscar novamente as tasks em `TODO` (re-avaliar o estado do repositório).

Recalcular a ordem considerando:
- tasks concluídas;
- novas tasks adicionadas no intermédio;
- mudanças de prioridade ou dependências.

Selecionar **uma única task** e repetir o ciclo completo.

---

## 🛑 15. CONDIÇÕES DE PARADA

### Caso A — Sucesso Total
Não existem mais tasks em `TODO`. Encerrar o workflow e apresentar o relatório final.

### Caso B — Bloqueio Crítico
Se a task não puder ser concluída por ambiguidade crítica, credenciais ausentes, dependência externa ou decisão humana necessária:
- NÃO pular silenciosamente.
- Registrar o motivo do bloqueio e evidências.
- Transitar para a próxima task apenas se o bloqueio não comprometer a dependência das demais.

### Caso C — Falha Técnica
Se testes falharem: investigar e corrigir no contexto da mesma task. Não abandonar a task sem exaurir a correção ou registrar bloqueio formal.

---

## 🛡️ 16. REGRAS DE SEGURANÇA OPERACIONAL (`RSEC-*`)

- Nunca executar comandos destrutivos sem autorização.
- Nunca apagar trabalho não commitado.
- Nunca fazer force push em branches compartilhadas.
- Nunca expor secrets ou alterar ambientes de produção diretamente.
- Se houver trabalho prévio não relacionado no ambiente: **parar e analisar antes de prosseguir.**

---

## 📊 17. RELATÓRIO FINAL

Ao finalizar o ciclo, apresentar uma tabela consolidada:

| Task | Resultado | PR | Commit SHA | Testes | Status Final |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `TASK-001` | Concluída | PR #X | `a1b2c3d` | Passed | `DONE` |
| `TASK-002` | Bloqueada | N/A | N/A | N/A | `BLOCKED` (Motivo X) |

---

## 📌 HIERARQUIA DE ARQUITETURA RECOMENDADA

```text
CLAUDE.md / AGENTS.md (Regras de Engenharia & Invariantes Globais)
│
└── Agent Workflows / Skills (Processos Operacionais Especializados)
    ├── teamwork-preview.md (Orquestrador FIFO Task → PR)
    ├── sdd-workflow.md (Pipeline de Especificação)
    ├── code-review.md (Auditoria de Código & Self-Review)
    └── orc3-sequential-pr-review.md (Orquestrador FIFO PR → Remediation)
```
