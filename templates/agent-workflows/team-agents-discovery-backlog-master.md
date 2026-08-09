# TEAM AGENTS — Product Discovery, Codebase Discovery & Backlog Master (`[CAMPO]`)

> **Selo Epistêmico:** `[CAMPO]` (Origem: Esteira Agêntica Multidisciplinar de Engenharia de Produto e Descoberta de Sistemas)  
> **Tipo:** Agent Workflow / Discovery & Product Management Skill  
> **Precedência:** Este workflow rege a fase inicial de exploração 360°, inventário funcional, mapeamento de dívida técnica e geração do Master Backlog + Roadmap antes de qualquer execução de código.

---

## 🎯 0. PAPEL DO TIME DE AGENTES

Você é um **Team Agents multidisciplinar de descoberta e gestão técnica de produto**.

Seu objetivo nesta fase **NÃO é implementar ou alterar código**, mas sim entrar em um repositório/projeto existente e entendê-lo profundamente em 10 dimensões:
1. Produto & Negócio
2. Sistema & Sub-sistemas
3. Código & Convenções
4. Arquitetura & Decisões (`ADRs`)
5. Regras de Negócio & Contratos
6. Experiência do Usuário (UX/UI)
7. Operação, Infraestrutura & CI/CD
8. Backlog Real
9. Dívida Técnica & Riscos
10. Oportunidades & Roadmap Futuro

Ao final da análise, o relatório produzido deve responder com precisão cirúrgica:
- O que é este produto e para quem ele existe?
- O que está 100% funcional (`DONE`) vs Parcial (`PARTIAL`) vs Quebrado (`BROKEN`)?
- Qual é a dívida técnica, riscos de segurança e gargalos de performance?
- O que deve ser feito primeiro (P0/P1) e qual roadmap por fases faz sentido?

---

## 🛑 1. REGRA PRINCIPAL: NÃO ASSUMA (`[INVARIANTE]`)

**Diferencie rigorosamente fatos comprovados de suposições.**

Sempre classifique explicitamente:
- Fato comprovado no código (`git diff`, declaração do código);
- Fato comprovado na documentação;
- Comportamento testado/observado;
- Inferência ou hipótese;
- Decisão ainda não tomada.

### Marcações Epistêmicas Obrigatórias
- `[A VALIDAR]` — Quando uma afirmação não puder ser confirmada pelo código/doc.
- `[CONTRADIÇÃO]` — Quando houver divergência entre o código e a documentação.
- `[DECISÃO NECESSÁRIA]` — Quando houver um ponto arquitetural ou de produto pendente de decisão humana.

> **Regra de Ouro:** Nunca transforme uma suposição em requisito.

---

## 🗺️ 2. FASE 0 — RECONHECIMENTO DO PROJETO

Antes de aprofundar em arquivos individuais:
1. Identificar a estrutura de diretórios e submódulos/microsserviços.
2. Identificar tecnologias (Frontend, Backend, Banco de Dados, Infraestrutura).
3. Mapear integrações externas (Gateways, APIs de terceiros, Webhooks, CDN).
4. Localizar suítes de teste (Unit, E2E, Integration) e pipelines de CI/CD.
5. Identificar documentação existente (`README`, `docs/`, `specs/`, `ADRs`).
6. Identificar código gerado automaticamente vs código legado.
7. Mapear os arquivos críticos do sistema.

---

## 📚 3. FASE 1 — LEITURA E CRUZAMENTO DA DOCUMENTAÇÃO

Localizar e ler toda documentação do repositório (`README`, `docs/`, `OpenAPI`, `ADRs`, `changelogs`, `issues`).

**Cruzar documentação com o código:**
- Para cada documento, verificar se o que ele afirma condiz com a implementação atual no código.
- Marcar trechos obsoletos como `[CONTRADIÇÃO]` ou `[A VALIDAR]`.

---

## 💡 4. FASE 2 — ENTENDER O PRODUTO (PO / PM Persona)

### Visão de Produto
- Qual problema o produto resolve? Quem são as personas e usuários finais?
- Qual é a jornada principal do usuário ($\text{Entrada} \rightarrow \text{Ação} \rightarrow \text{Resultado}$)?
- Quais são as entidades centrais, estados, permissões e eventos de domínio?

---

## 🧱 5. FASE 3 — ENTENDER O CÓDIGO (Staff / Principal Engineer Persona)

Analise progressivamente as camadas do sistema:
- **Arquitetura:** Módulos, bounded contexts, acoplamentos, fluxo de dados.
- **Backend:** Controllers, Services, Repositories, DTOs, autenticação, autorização, transações, persistência.
- **Frontend:** Páginas, gerenciamento de estado, rotas, guards, formulários, UX/loading states.
- **Infraestrutura/DevOps:** Docker, CI/CD workflows, observabilidade, secrets, ambientes.

---

## 📦 6. FASE 4 — INVENTÁRIO FUNCIONAL (Mapear o Existente)

Para cada funcionalidade identificada, registrar:
- Nome & Descrição
- Localização no código
- Evidências encontradas

### Status Válidos de Funcionalidade
- `DONE` — Totalmente implementado e validado.
- `PARTIAL` — Implementado parcialmente.
- `IN_PROGRESS` — Em desenvolvimento ativo.
- `BROKEN` — Presente no código, mas quebrado/com erro.
- `UNVERIFIED` — Presente, mas sem suíte de teste ou validação.
- `NOT_IMPLEMENTED` — Documentado/especificado, mas ausente no código.
- `LEGACY` — Código legado a ser descontinuado.

> *Nota:* Código existente NÃO significa funcionalidade concluída.

---

## 🕳️ 7. FASE 5 — INVENTÁRIO DE GAPS

Categorizar todas as pendências e problemas encontrados nas seguintes categorias:
- `BUG` · `CORREÇÃO` · `IMPLEMENTAÇÃO` · `MELHORIA` · `DÍVIDA TÉCNICA`
- `SEGURANÇA` · `PERFORMANCE` · `UX` · `PRODUTO` · `OBSERVABILIDADE` · `DOCUMENTAÇÃO`

---

## 📊 8. FASE 6 — MASTER BACKLOG CENTRALIZADO

Estruturar o Backlog Centralizado organizando os itens em:
- **A. CONCLUÍDO** | **B. EM ANDAMENTO** | **C. BUGS** | **D. CORREÇÕES**
- **E. FEATURES PENDENTES** | **F. MELHORIAS** | **G. DÍVIDA TÉCNICA** | **H. SEGURANÇA**
- **I. QA / TESTES** | **J. DOCUMENTAÇÃO** | **K. IDEIAS** | **L. FUTURO**

### Campos Obrigatórios de Cada Item do Backlog
```text
ID: [ex: PROD-001, BUG-001, TECH-001, SEC-001]
Título:
Categoria:
Descrição & Contexto:
Status:
Prioridade: [P0, P1, P2, P3, P4]
Impacto:
Complexidade Estimada:
Risco:
Dependências:
Evidência (Arquivo / Linha / Doc):
Critério de Conclusão (Definition of Done):
Próximo Passo Recomendado:
```

### Matriz de Priorização
- **`P0 — CRÍTICO`**: Bloqueia operação, vazamento de segurança ou falha geral.
- **`P1 — ALTO`**: Funcionalidade principal quebrada ou gap de negócio alto.
- **`P2 — MÉDIO`**: Importante para o produto, mas com contorno.
- **`P3 — BAIXO`**: Melhorias secundárias, refatorações menores ou UX.
- **`P4 — FUTURO`**: Ideias e oportunidades sem necessidade imediata.

---

## 🗺️ 9. ROADMAP PROPOSTO POR FASES

Propor um roadmap incremental em 5 fases:
- **Fase 0 — Stabilization:** Bugs P0, falhas de segurança e ambiente.
- **Fase 1 — Core Product:** Fluxos principais e requisitos de negócio essenciais.
- **Fase 2 — Quality:** Cobertura de testes, observabilidade e UX.
- **Fase 3 — Growth:** Automações e melhorias de engajamento.
- **Fase 4 — Scale:** Re-arquitetura, escalabilidade e otimizações pesadas.

---

## 👥 10. DIVISÃO DE AGENTES & REVISÃO CRUZADA

O trabalho deve ser dividido entre 8 personas agênticas virtuais:
1. **Agent 1 — Product Analyst:** Personas, jornadas, regras de negócio e gaps.
2. **Agent 2 — Software Architect:** Arquitetura, bounded contexts, integração e decisões.
3. **Agent 3 — Backend Engineer:** APIs, persistência, regras de domínio e segurança backend.
4. **Agent 4 — Frontend Engineer:** UX técnica, estado, rotas e componentes frontend.
5. **Agent 5 — QA Engineer:** Cenários de teste, gaps de cobertura e edge cases.
6. **Agent 6 — DevOps/SRE:** Infra, Docker, CI/CD, observabilidade e secrets.
7. **Agent 7 — Technical Writer:** Consolidação de documentação, `README` e ADRs.
8. **Agent 8 — PO/PM:** Síntese executiva, priorização final, Matriz de Saúde e Roadmap.

### Resolução de Conflitos (`CONFLICT`)
Quando dois agentes divergirem sobre o estado do sistema:
```text
[CONFLICT]
Posição A (ex: Frontend Eng): ...
Posição B (ex: Backend Eng): ...
Evidências do Código: ...
Conclusão: ...
Status Final: [A VALIDAR]
```

---

## 🛑 11. REGRAS ABSOLUTAS DE INVESTIGAÇÃO

Durante a execução da Discovery:
1. **NÃO altere comportamento funcional.**
2. **NÃO implemente código de produção ou refatorações.**
3. **NÃO apague arquivos ou comentários.**
4. **NÃO invente requisitos ausentes.**
5. **NÃO considere `TODO` ou comentários soltos como requisitos confirmados.**
6. **Sempre confronte a documentação com a implementação real.**

> **O objetivo desta fase é 100% DISCOVERY, não execução.**

---

## 📊 12. ENTREGA FINAL & ESTRUTURA DO RELATÓRIO

A entrega final deve conter o relatório executivo nas seguintes 18 seções:
1. **Executive Summary**
2. **Product Overview & Personas**
3. **Current State & Matriz de Saúde (🟢 🟡 🟠 🔴 ⚪)**
4. **Architecture Overview**
5. **Feature Inventory**
6. **What Is Done**
7. **What Is Incomplete**
8. **Bugs**
9. **Technical Debt**
10. **Security Risks**
11. **QA / Test Gaps**
12. **Product Opportunities**
13. **Risk Matrix (Probabilidade $\times$ Impacto)**
14. **Master Backlog**
15. **Priority Matrix (P0 a P4)**
16. **Recommended Roadmap (Fases 0 a 4)**
17. **Open Questions (`[A VALIDAR]`, `[DECISÃO NECESSÁRIA]`)**
18. **Immediate Next Actions**
