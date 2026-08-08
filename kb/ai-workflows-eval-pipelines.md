# Destilação de AI Workflows e Pipelines de Avaliação (Evals) `[INDÚSTRIA]` `[RECENTE]`

> Destilação técnica sobre motores/plataformas de workflows de IA e arquitetura de pipelines de avaliação quantitativa offline (*Evals*).
> **Fontes**: 
> - *Top 12 Open-Source AI Workflows Projects* (NocoBase / Dev.to) `[INDÚSTRIA]`
> - *Structured Evaluation Pipelines to Improve Your AI Workflows* (Philip Heltweg) `[RECENTE]`

---

## 1. Visão Geral e Taxonomia de AI Workflows `[INDÚSTRIA]`

A arquitetura de sistemas de software que executam fluxos alimentados por LLMs e Agentes se organiza em 3 camadas funcionais distintas:

```
+-----------------------------------------------------------------------+
| 1. Business System Platforms (Low-Code / Data-Model Driven)           |
|    Ex: NocoBase, Appsmith, OpenProject                                |
+-----------------------------------------------------------------------+
                                  │
                                  ▼
+-----------------------------------------------------------------------+
| 2. Automation Workflow Engines (Node-based / Trigger-Action / Agents) |
|    Ex: n8n, Activepieces, Mastra, Continue, Trigger.dev               |
+-----------------------------------------------------------------------+
                                  │
                                  ▼
+-----------------------------------------------------------------------+
| 3. Workflow Infrastructure & Durable Orchestration                    |
|    Ex: Temporal, Orkes Conductor, Dagger                              |
+-----------------------------------------------------------------------+
```

### Detalhes das Camadas

1. **Plataformas de Negócio com Agentes Nativos (`NocoBase`, `Appsmith`)**:
   - Evolução do Low-Code convencional para sistemas orientados a modelo de dados (*Data-Model-Driven AI Systems*).
   - Conceito de **"AI Employees"**: Agentes virtuais não são meros scripts externos; são entidades do modelo de dados que reagem a eventos no banco de dados e executam tarefas com permissões de negócio internas.

2. **Motores de Automação de Workflows (`n8n`, `Activepieces`, `Mastra`, `Trigger.dev`)**:
   - Automações orientadas a eventos e tarefas de segundo plano (*background jobs*).
   - `n8n` / `Activepieces`: Automação visual por nós com IA integrada como gatilho e ação de primeira classe.
   - `Mastra`: Framework TypeScript/JavaScript para física e orquestração de agentes.
   - `Trigger.dev`: Framework para execução de tarefas de segundo plano duráveis, assíncronas e de longa duração.

3. **Orquestradores Duráveis de Infraestrutura (`Temporal`, `Conductor`)**:
   - Garantia de **Eventual Consistency** e preservação de estado durável.
   - Indispensável para *Agentic Workflows* complexos onde *tool calls* ou *agent loops* duram minutos/horas e precisam resistir a reinicializações ou falhas de infraestrutura.

---

## 2. Arquitetura de Pipelines de Avaliação Offline (*Evals*) `[RECENTE]`

Para evitar o anti-padrão do teste informal (*Vibe Testing*), a engenharia de sistemas de IA exige um **pipeline de avaliação offline quantitativo e automatizado**.

### Princípios Inegociáveis
- **Invariante de Medição**: Não é possível otimizar ou refatorar o que não é medido empiricamente.
- **Testes de Regressão de IA**: Toda alteração de prompt, contexto, engenharia de instrução ou modelo de linguagem deve rodar contra uma suíte estática de testes locais antes da implantação.
- **Offline vs. Online Evaluation**:
  - *Offline Evaluation*: Dataset estático + avaliação local automatizada antes do deploy. É a fundação necessária.
  - *Online Evaluation*: Telemetria em produção + amostragem em tempo real (etapa avançada posterior).

---

## 3. Estrutura de Artefatos de Avaliação Local

```
Dataset de Teste (Markdown + Frontmatter YAML)
          │
          ▼
Sistema sob Teste (Workflow/Prompt/Agente) ──► Resposta Gerada
                                                     │
                                                     ▼
Rubricas de Qualidade (Markdown) ──► LLM-as-a-Judge ──► Nota + Reasoning
                                                     │
                                                     ▼
                                          Relatório de Regressão
```

### 3.1 Traces como Datasets Human-Readable (Markdown + Frontmatter)
Cada *trace* é um histórico de conversa armazenado em arquivos Markdown legíveis com metadados YAML:

```markdown
---
id: account-cancellation-refund
description: Customer requesting a refund outside policy window
scenario-type: policy-edge-case
safety-response: false
---

# Assistant
Hi, I'm here to help with your account. What can I do for you today?

# User
I cancelled my subscription but lost access. Can I get a refund?
```

### 3.2 Rubricas e Anotações (*Annotations*)
Rubricas explicativas em escala Likert (1 a 5) ou Binárias (0 ou 1) que guiam o modelo julgador:

- **Dimensões de Qualidade (Likert 1–5)**: *Helpfulness*, Relevância, Exatidão, Concisão.
- **Dimensões de Segurança e Compliance (Pass/Fail 0 ou 1)**:
  - *Canary Prompts / Adversarial*: Tentativas deliberadas de *prompt injection* ou extração de dados confidenciais.
  - *Honeypot Prompts*: Armadilhas para testar se o agente mantém fronteiras de segurança sem recusas indevidas (*false positives*).

---

## 4. Algoritmo de Execução *LLM-as-a-Judge*

1. **Ingestão**: Carregamento dos traces `.md` e rubricas do diretório local.
2. **Execução**: Envio do histórico de entrada ao backend do workflow sob teste.
3. **Julgamento**: O agente julgador (*LLM-as-a-Judge*) recebe a conversa, a resposta gerada e a rubrica com exemplos âncora.
4. **Output Estruturado**: O juiz retorna um resultado contendo `{ score: number, reasoning: string }`.
5. **Consolidação**: Cálculo de estatísticas (médias/medianas) e sinalização de regressões ou falhas de segurança.

---

## 5. Mapeamento para a Base de Conhecimento `labs`

| Conceito da KB | Aplicação Direta |
|---|---|
| `VER-` (Verificação) | Fundamentação para suítes de teste de regressão e auditoria local em `/sdd-converge`. |
| `P07` (Evidência Empírica) | Substituição de avaliação intuitiva por métricas observáveis e repetíveis. |
| `AR-04` (Agent Pipeline) | Orquestração durável (`Temporal`/`Trigger.dev`) na infraestrutura de agentes. |
| `AP-24` (Avaliador Viciado) | Mitigação pela exigência de *reasoning* explícito e exemplos âncora nas rubricas de avaliação. |
