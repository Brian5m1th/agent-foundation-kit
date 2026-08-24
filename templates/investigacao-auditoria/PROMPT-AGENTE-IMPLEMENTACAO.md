# Prompt — Implementar o próximo item do plano de auditoria

Protocolo auto-contido para **implementar** achados da auditoria pré-produção já investigados, respeitando a separação em **Dupla Trilha**.

---

## Papel e Visão Geral

Sua responsabilidade nesta tarefa é pegar **uma única unidade de trabalho** da fila de implementação (`docs/investigacao/ESTADO-IMPLEMENTACAO.md`), respeitar a trilha designada e executá-la com sucesso.

Antes de começar, leia estes arquivos nesta ordem:

1. `CLAUDE.md` — arquitetura, convenções de código e princípios.
2. `docs/investigacao/PLANO-IMPLEMENTACAO.md` — agrupamentos, ordem de prioridade e clusters.
3. `docs/investigacao/ESTADO-IMPLEMENTACAO.md` — tabela viva de implementação.
4. Os relatórios `docs/investigacao/<ID>.md` dos achados da unidade a ser implementada — são seu insumo primário; **não reinvestigue do zero**.

---

## As Duas Trilhas de Execução

| Trilha | Descrição | Modo de Execução Obrigatório | Usa Spec Kit (SDD)? |
|---|---|---|---|
| **Trilha A** | `ajuste_simples` — correção pontual | **Plan Mode** (alinhar escopo/arquivos) → Execução direta | **NÃO** |
| **Trilha B** | Cluster `merece_spec` | `/sdd-specify` → `clarify` → `plan` → `tasks` → `analyze` → `implement` | **SIM (Ciclo Completo)** |

- **Regra**: Nunca use Spec Kit na Trilha A (evitar burocracia de 1 linha). Nunca pule Spec Kit na Trilha B (garantir rigor arquitetural).

---

## Passo 1 — Escolher e Reivindicar Unidade

1. Abra `docs/investigacao/ESTADO-IMPLEMENTACAO.md`.
2. Escolha **uma unidade elegível** `pendente` de menor prioridade numérica.
   - Na Trilha A: escolha um item cujas dependências já estejam concluídas.
   - Na Trilha B: escolha o cluster da vez respeitando a ordem do plano, reivindicando também seus itens satélites associados.
3. **Reivindique a linha**:
   - Gere `sess-<4 chars aleatórios>`.
   - Marque `Status` → `em_andamento` com seu ID de agente e timestamp.
   - Salve e **releia imediatamente** para garantir que seu lock markdown não colidiu.

---

## Passo 2 — Execução

### Se Trilha A (Fix Direto)
1. Use **Plan Mode** (ou raciocínio estruturado no chat): declare escopo, arquivos afetados e mitigação de risco.
2. Aplique a alteração mínima necessária respeitando as regras do projeto (type hints, sem código muerto, testes unitários sem I/O).
3. Verifique com linters e testes unitários.

### Se Trilha B (Cluster de Spec)
1. Execute o ciclo completo SDD (`/sdd-specify` → `/sdd-clarify` → `/sdd-plan` → `/sdd-tasks` → `/sdd-analyze` → `/sdd-implement`).
2. Utilize os relatórios `docs/investigacao/<ID>.md` como insumos do `specify`.
3. Garanta que todas as tarefas e critérios de aceite foram cumpridos.

---

## Passo 3 — Finalizar e Persistir

1. Atualize `docs/investigacao/ESTADO-IMPLEMENTACAO.md`:
   - `Status` → `concluido`
   - Preencha `Nota` (hash do commit ou arquivos tocados / caminho da spec gerada).
2. Releia a linha salva.
3. Encerre. Não pegue a próxima unidade nesta mesma sessão.
