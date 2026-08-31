# Catálogo Central de Skills — `labs/skills`

Este diretório contém o acervo centralizado de **Skills** de Engenharia de Sistemas Agênticos do repositório `labs`. 
Ele serve como fonte de verdade para desenvolvedores humanos e agentes de IA (Claude Code, Google Antigravity, OpenCode, Cursor, Codex, Windsurf).

---

## 🤖 Como usar com qualquer IA

Se você é um desenvolvedor ou deseja que a sua IA consuma e execute essas skills:

### Opção 1: Antigravity / Gemini CLI
Copie ou sincronize as pastas de skills para o seu diretório global `~/.gemini/config/skills/` ou mantenha a referência em `.agents/skills/`:
```powershell
Copy-Item -Path "C:\workspace\labs\skills\*" -Destination "$env:USERPROFILE\.gemini\config\skills\" -Recurse -Force
```

### Opção 2: Claude Code / OpenCode / Cursor / Codex
Aponte o agente para ler a instrução da skill desejada antes de executar a tarefa:
> *"Leia as instruções da skill contidas em `skills/<nome-da-skill>/SKILL.md` antes de prosseguir."*

---

## 📚 Catálogo Completo de Skills

### 🔄 Fluxo SDD (Spec-Driven Development)
| Skill | Tipo | Descrição |
|---|---|---|
| [`sdd-constitution`](sdd-constitution/SKILL.md) | User-invoked | Estabelece os princípios e constituição inegociável do repositório. |
| [`sdd-specify`](sdd-specify/SKILL.md) | User-invoked | Cria a especificação funcional (o QUÊ e POR QUÊ) sem detalhes tecnológicos. |
| [`sdd-clarify`](sdd-clarify/SKILL.md) | User-invoked | Resolve ambiguidades e perguntas abertas da especificação com o humano. |
| [`sdd-plan`](sdd-plan/SKILL.md) | User-invoked | Cria o plano de arquitetura técnica (COMO — stack, contratos, riscos). |
| [`sdd-tasks`](sdd-tasks/SKILL.md) | User-invoked | Decompõe o plano em tarefas pequenas agrupadas por histórias de usuário. |
| [`sdd-analyze`](sdd-analyze/SKILL.md) | User-invoked | Audita a coerência interna entre os artefatos (spec vs plan vs tasks). |
| [`sdd-implement`](sdd-implement/SKILL.md) | User-invoked | Executa a implementação do código, uma task por vez. |
| [`sdd-converge`](sdd-converge/SKILL.md) | User-invoked | Audita se o código final satisfaz rigorosamente a especificação. |
| [`sdd-checklist`](sdd-checklist/SKILL.md) | User-invoked | Gera checklists de verificação por dimensão da especificação. |

### 🧠 Alinhamento, Entrevistas & Raciocínio Profundo
| Skill | Tipo | Descrição |
|---|---|---|
| [`grill-me`](grill-me/SKILL.md) | User-invoked | Entrevista de alinhamento para tirar ambiguidade de planos e ideias antes de codificar. |
| [`grilling`](grilling/SKILL.md) | Model-invoked | O motor iterativo de perguntas e respostas com recomendações embutidas. |
| [`grill-with-docs`](grill-with-docs/SKILL.md) | User-invoked | Entrevista *stateful* que consulta o codebase e atualiza `CONTEXT.md` e ADRs. |
| [`planning-mode`](planning-mode/SKILL.md) / [`plan`](plan/SKILL.md) | User-invoked | Força a IA a pesquisar sem alterar código, gerar o `implementation_plan.md` e aguardar aprovação. |

### 🛠️ Engenharia, Arquitetura & Qualidade de Código
| Skill | Tipo | Descrição |
|---|---|---|
| [`codebase-design`](codebase-design/SKILL.md) | Model-invoked | Vocabulário e princípios para desenhar módulos profundos e interfaces limpas. |
| [`diagnosing-bugs`](diagnosing-bugs/SKILL.md) | Model-invoked | Loop rigoroso de diagnóstico de bugs difíceis e regressões antes de alterar o código. |
| [`domain-modeling`](domain-modeling/SKILL.md) | Model-invoked | Construção e refinamento do modelo de domínio do projeto (`CONTEXT.md`). |
| [`wayfinder`](wayfinder/SKILL.md) | User-invoked | Mapeamento de decisões e tarefas para projetos grandes sob alta incerteza. |
| [`tdd`](tdd/SKILL.md) | Model-invoked | Desenvolvimento guiado por testes em fatias verticais (Red-Green-Refactor). |
| [`code-review`](code-review/SKILL.md) | Model-invoked | Revisão de código em dois eixos (Standards x Spec) usando subagentes em paralelo. |
| [`improve-codebase-architecture`](improve-codebase-architecture/SKILL.md) | User-invoked | Varredura do repositório em busca de pontos de aprofundamento arquitetural. |
| [`resolving-merge-conflicts`](resolving-merge-conflicts/SKILL.md) | Model-invoked | Resolução de conflitos de merge analisando a intenção de cada lado. |

### 📈 Produtividade, Handoff & Escrita para Agentes
| Skill | Tipo | Descrição |
|---|---|---|
| [`handoff`](handoff/SKILL.md) / [`claude-handoff`](claude-handoff/SKILL.md) | User-invoked | Compactação de contexto da sessão em um documento de passagem limpo. |
| [`writing-for-agents`](writing-for-agents/SKILL.md) | User-invoked | Guia de boas práticas para criar ou editar novas skills previsíveis. |
| [`research`](research/SKILL.md) | Model-invoked | Pesquisa contra fontes primárias documentadas em Markdown. |
| [`to-spec`](to-spec/SKILL.md) / [`to-tickets`](to-tickets/SKILL.md) | User-invoked | Conversão de conversas e planos em especificações e fatias de tarefas executáveis. |

### 🤝 Times e Loops de Agentes

| Skill | Tipo | Descrição |
|---|---|---|
| [`agent-team`](agent-team/SKILL.md) | Model-invoked | Desenha e audita times com topologia, Boundary Contracts, guardrails e aceite verificável. |
| [`agent-team-loop`](agent-team-loop/SKILL.md) | Model-invoked | Executa times em ciclos maker-checker até sucesso provado ou estado terminal explícito. |
| [`loop-engineering`](loop-engineering/SKILL.md) | Model-invoked | Projeta e executa loops limitados cuja evidência altera a próxima ação. |

### ⚙️ DevOps, Infraestrutura & Ferramentas
| Skill | Tipo | Descrição |
|---|---|---|
| [`git-guardrails-claude-code`](git-guardrails-claude-code/SKILL.md) | Utility | Proteção contra comandos destrutivos do Git (`reset --hard`, `push --force`). |
| [`setup-pre-commit`](setup-pre-commit/SKILL.md) | Utility | Configuração de hooks de pre-commit com Husky e lint-staged. |
| [`wizard`](wizard/SKILL.md) | Utility | Geração de assistentes interativos para etapas que só humanos podem realizar. |
| [`graphify`](graphify/SKILL.md) | Utility | Transformação de código e documentos em um grafo de conhecimento persistente. |
| [`antigravity-guide`](antigravity-guide/SKILL.md) / [`agy-customizations`](agy-customizations/SKILL.md) | System | Guias e documentação completa do Antigravity e seu sistema de extensões. |

---

## 📌 Estrutura de uma Skill
Toda skill neste diretório segue o padrão padronizado em formato Markdown com YAML frontmatter:
```markdown
---
name: nome-da-skill
description: Descrição concisa de quando e como utilizar a skill.
---

# Título da Skill
Instruções detalhadas, passos ordenados e checklists.
```
