# Inventário local de skills e plugins

Coleta: **2026-10-03 — America/Bahia**. Estado: **[CAMPO] observado no sistema de arquivos**. Presença de arquivo não comprova ativação, instalação completa, autenticação, dependências disponíveis ou funcionamento. Nenhuma skill/plugin foi instalado ou executado para este inventário.


**Limite da publicação:** este inventário descreve o checkout local de 2026-10-03, que continha
trabalho SDD ainda não commitado. As quatro skills `sdd-lifecycle`, `sdd-audit`, `sdd-project` e
`sdd-learn`, `.specify/{kit,flow}.json` e `tools/labs.ps1` são referências desse snapshot, não
arquivos entregues por este PR. Os caminhos sem link preservam a procedência. Para um clone,
consulte as entradas versionadas no [catálogo](../../skills/README.md) e em
[AGENTS.md](../../AGENTS.md); propostas que dependem da migração exigem sua publicação prévia.

## Método e bases

Cada linha de skill representa um `SKILL.md` real. A enumeração foi recursiva, excluindo diretórios simbólicos/junctions; o frontmatter foi lido para nome e gatilho. Descrições abaixo são resumos, sem copiar os procedimentos de terceiros. A origem indicada é o local observado, não uma atribuição de autoria ou validação remota. Consulte [fontes e cobertura](fontes-e-cobertura.md).

| Base | Caminho local | SKILL.md físicos |
|---|---|---:|
| L | `C:/workspace/labs/skills` | 57 |
| A | `C:/Users/brian/.agents/skills` | 52 |
| C | `C:/Users/brian/.codex/skills` (inclui `.system`) | 16 |
| M | `C:/Users/brian/.codex/memories/skills` | 1 |
| P | `C:/Users/brian/.codex/plugins/cache` | 69 |

Total nestas cinco bases: **195 arquivos**, não 195 capacidades independentes. Há duplicações entre bases e dentro de pacotes. As oito junctions de `.agents/skills` e `.claude/skills` do projeto são aliases das quatro SDD canônicas e não entram no total. A descoberta complementar em Cursor encontrou 26 arquivos adicionais, separados abaixo.

## Resolução canônica e sobreposições

No checkout local inventariado, o router então presente em `AGENTS.md` orientava: `sdd-lifecycle`, `sdd-audit`, `sdd-project`, `sdd-learn` em **L**. Seus aliases locais resolvem para essas mesmas pastas. Os nove comandos/skills SDD antigos continuam presentes como legado; não são nove fontes canônicas adicionais. As skills globais `spec-new`, `spec-plan`, `spec-tasks` e `spec-review` descrevem outra convenção (`.spec/changes`), que não substitui `specs/NNN-slug` do labs.

Comparação SHA-256 dos `SKILL.md` homônimos: dez pares L/A são idênticos (`code-review`, `diagnosing-bugs`, `domain-modeling`, `grill-me`, `grilling`, `implement`, `plan`, `research`, `resolving-merge-conflicts`, `tdd`). `graphify` L/A difere; não escolher por nome sozinho nem sincronizar automaticamente. `visualize` A/P também difere. A comparação só cobre o arquivo principal, não todos os recursos da pasta.

O caminho `~/.codex/skills/graphify/SKILL.md` citado na instrução do usuário não apareceu na base C; foram encontrados L e A. Para invocação futura, resolver o caminho disponível e ler a skill correspondente. O grafo existente em `graphify-out/` não foi atualizado neste levantamento.

## Catálogo por base

Em todas as tabelas abaixo, estado = **arquivo presente; execução não validada**. Caminho relativo + base resolve a localização completa. Dependências só são afirmadas na seção específica ao final.

### L — upstream e acervo do labs

| Skill / localização relativa | Categoria e gatilho resumido |
|---|---|
| [agent-team/SKILL.md](../../skills/agent-team/SKILL.md) | Times: desenho, contratos, guardrails e auditoria de agentes |
| [agent-team-loop/SKILL.md](../../skills/agent-team-loop/SKILL.md) | Times: ciclos maker-checker limitados por aceite |
| [agy-customizations/SKILL.md](../../skills/agy-customizations/SKILL.md) | Antigravity: personalização de extensões |
| [antigravity-guide/SKILL.md](../../skills/antigravity-guide/SKILL.md) | Antigravity: guia e navegação da documentação |
| [ask-matt/SKILL.md](../../skills/ask-matt/SKILL.md) | Roteamento: escolher skill ou fluxo |
| [claude-handoff/SKILL.md](../../skills/claude-handoff/SKILL.md) | Handoff: continuação em agente de background |
| [code-review/SKILL.md](../../skills/code-review/SKILL.md) | Revisão: padrões do projeto e aderência à spec |
| [codebase-design/SKILL.md](../../skills/codebase-design/SKILL.md) | Arquitetura: interfaces e módulos profundos |
| [diagnosing-bugs/SKILL.md](../../skills/diagnosing-bugs/SKILL.md) | Diagnóstico: falha ou regressão antes de editar |
| [domain-modeling/SKILL.md](../../skills/domain-modeling/SKILL.md) | Domínio: vocabulário, modelo e decisões |
| [git-guardrails-claude-code/SKILL.md](../../skills/git-guardrails-claude-code/SKILL.md) | Git: hooks de proteção no Claude Code |
| [graphify/SKILL.md](../../skills/graphify/SKILL.md) | Conhecimento: consulta e construção de grafo |
| [grill-me/SKILL.md](../../skills/grill-me/SKILL.md) | Intenção: entrevista de plano ou desenho |
| [grill-with-docs/SKILL.md](../../skills/grill-with-docs/SKILL.md) | Intenção: entrevista com documentação e ADRs |
| [grilling/SKILL.md](../../skills/grilling/SKILL.md) | Intenção: testar decisões por perguntas |
| [handoff/SKILL.md](../../skills/handoff/SKILL.md) | Handoff: documento de passagem de contexto |
| [implement/SKILL.md](../../skills/implement/SKILL.md) | Execução: implementação a partir de spec/tickets |
| [improve-codebase-architecture/SKILL.md](../../skills/improve-codebase-architecture/SKILL.md) | Arquitetura: oportunidades e relatório visual |
| [loop-engineering/SKILL.md](../../skills/loop-engineering/SKILL.md) | Loops: feedback, limite e parada verificável |
| [loop-me/SKILL.md](../../skills/loop-me/SKILL.md) | Loops: entrevista dos workflows desejados |
| [migrate-to-shoehorn/SKILL.md](../../skills/migrate-to-shoehorn/SKILL.md) | TypeScript: migração de assertions de testes |
| [permissioned-github/SKILL.md](../../skills/permissioned-github/SKILL.md) | GitHub: permissões diante de restrições |
| [plan/SKILL.md](../../skills/plan/SKILL.md) | Planejamento: pesquisa e plano antes do código |
| [planning-mode/SKILL.md](../../skills/planning-mode/SKILL.md) | Planejamento: mudanças complexas antes de editar |
| [prototype/SKILL.md](../../skills/prototype/SKILL.md) | Experimento: protótipo descartável para responder dúvida |
| [research/SKILL.md](../../skills/research/SKILL.md) | Pesquisa: fontes primárias e registro em Markdown |
| [resolving-merge-conflicts/SKILL.md](../../skills/resolving-merge-conflicts/SKILL.md) | Git: resolver conflito de merge/rebase |
| [scaffold-exercises/SKILL.md](../../skills/scaffold-exercises/SKILL.md) | Ensino: estrutura de exercícios e soluções |
| [sdd-analyze/SKILL.md](../../skills/sdd-analyze/SKILL.md) | SDD legado: coerência entre artefatos |
| sdd-audit/SKILL.md (`skills/sdd-audit/SKILL.md`, snapshot local) | SDD canônico: checklist, analyze e converge |
| [sdd-checklist/SKILL.md](../../skills/sdd-checklist/SKILL.md) | SDD legado: qualidade da especificação |
| [sdd-clarify/SKILL.md](../../skills/sdd-clarify/SKILL.md) | SDD legado: resolver ambiguidades |
| [sdd-constitution/SKILL.md](../../skills/sdd-constitution/SKILL.md) | SDD legado: princípios do projeto |
| [sdd-converge/SKILL.md](../../skills/sdd-converge/SKILL.md) | SDD legado: código contra especificação |
| [sdd-implement/SKILL.md](../../skills/sdd-implement/SKILL.md) | SDD legado: executar tarefas |
| sdd-learn/SKILL.md (`skills/sdd-learn/SKILL.md`, snapshot local) | SDD canônico: promover falha comprovada em proteção |
| sdd-lifecycle/SKILL.md (`skills/sdd-lifecycle/SKILL.md`, snapshot local) | SDD canônico: fases, estados e transições |
| [sdd-plan/SKILL.md](../../skills/sdd-plan/SKILL.md) | SDD legado: plano técnico |
| sdd-project/SKILL.md (`skills/sdd-project/SKILL.md`, snapshot local) | SDD canônico: instalação, links e diagnóstico |
| [sdd-specify/SKILL.md](../../skills/sdd-specify/SKILL.md) | SDD legado: especificação funcional |
| [sdd-tasks/SKILL.md](../../skills/sdd-tasks/SKILL.md) | SDD legado: decomposição por história |
| [setup-matt-pocock-skills/SKILL.md](../../skills/setup-matt-pocock-skills/SKILL.md) | Configuração: tracker e convenções do pacote |
| [setup-pre-commit/SKILL.md](../../skills/setup-pre-commit/SKILL.md) | Qualidade: hooks, formatação e verificações |
| [setup-ts-deep-modules/SKILL.md](../../skills/setup-ts-deep-modules/SKILL.md) | Arquitetura TS: fronteiras de módulos |
| [tdd/SKILL.md](../../skills/tdd/SKILL.md) | Testes: ciclos red-green-refactor |
| [teach/SKILL.md](../../skills/teach/SKILL.md) | Ensino: conceito ou habilidade |
| [to-questionnaire/SKILL.md](../../skills/to-questionnaire/SKILL.md) | Handoff: decisão transformada em questionário |
| [to-spec/SKILL.md](../../skills/to-spec/SKILL.md) | Intenção: conversa convertida em spec no tracker |
| [to-tickets/SKILL.md](../../skills/to-tickets/SKILL.md) | Planejamento: plano convertido em tickets |
| [triage/SKILL.md](../../skills/triage/SKILL.md) | Tracker: classificar e preparar issues/PRs |
| [wait-what/SKILL.md](../../skills/wait-what/SKILL.md) | Comunicação: reformular a última explicação |
| [wayfinder/SKILL.md](../../skills/wayfinder/SKILL.md) | Planejamento: mapa de decisões de trabalho extenso |
| [wizard/SKILL.md](../../skills/wizard/SKILL.md) | Operação: assistente interativo para passos humanos |
| [writing-beats/SKILL.md](../../skills/writing-beats/SKILL.md) | Escrita: organizar material em sequência narrativa |
| [writing-for-agents/SKILL.md](../../skills/writing-for-agents/SKILL.md) | Autoria: documentos e instruções para agentes |
| [writing-fragments/SKILL.md](../../skills/writing-fragments/SKILL.md) | Escrita: explorar fragmentos |
| [writing-shape/SKILL.md](../../skills/writing-shape/SKILL.md) | Escrita: estruturar artigo |

### A — skills globais compartilhadas

| Skill / localização relativa | Categoria e gatilho resumido |
|---|---|
| [automate/SKILL.md](C:/Users/brian/.agents/skills/automate/SKILL.md) | Automação: criar recorrências |
| [autopilot/SKILL.md](C:/Users/brian/.agents/skills/autopilot/SKILL.md) | PR: acompanhamento de CI, comentários e conflitos |
| [brainstorming/SKILL.md](C:/Users/brian/.agents/skills/brainstorming/SKILL.md) | Intenção: explorar requisitos antes de criar comportamento |
| [canvas/SKILL.md](C:/Users/brian/.agents/skills/canvas/SKILL.md) | Visualização: aplicativo interativo em Canvas |
| [code-review/SKILL.md](C:/Users/brian/.agents/skills/code-review/SKILL.md) | Revisão: padrões do projeto e aderência à spec |
| [create-hook/SKILL.md](C:/Users/brian/.agents/skills/create-hook/SKILL.md) | Autoria: hooks de eventos |
| [create-rule/SKILL.md](C:/Users/brian/.agents/skills/create-rule/SKILL.md) | Autoria: regras persistentes |
| [create-skill/SKILL.md](C:/Users/brian/.agents/skills/create-skill/SKILL.md) | Autoria: skills |
| [create-subagent/SKILL.md](C:/Users/brian/.agents/skills/create-subagent/SKILL.md) | Autoria: agentes especializados |
| [deploy-with-vercel/SKILL.md](C:/Users/brian/.agents/skills/deploy-with-vercel/SKILL.md) | Publicação: projeto e deploy Vercel |
| [diagnosing-bugs/SKILL.md](C:/Users/brian/.agents/skills/diagnosing-bugs/SKILL.md) | Diagnóstico: falha ou regressão antes de editar |
| [dispatching-parallel-agents/SKILL.md](C:/Users/brian/.agents/skills/dispatching-parallel-agents/SKILL.md) | Times: tarefas independentes em paralelo |
| [domain-modeling/SKILL.md](C:/Users/brian/.agents/skills/domain-modeling/SKILL.md) | Domínio: vocabulário, modelo e decisões |
| [executing-plans/SKILL.md](C:/Users/brian/.agents/skills/executing-plans/SKILL.md) | Execução: plano aprovado com checkpoints |
| [finishing-a-development-branch/SKILL.md](C:/Users/brian/.agents/skills/finishing-a-development-branch/SKILL.md) | Git: integração após verificações |
| [goal/SKILL.md](C:/Users/brian/.agents/skills/goal/SKILL.md) | Execução: objetivo persistente |
| [graphify/SKILL.md](C:/Users/brian/.agents/skills/graphify/SKILL.md) | Conhecimento: consulta e construção de grafo |
| [grill-me/SKILL.md](C:/Users/brian/.agents/skills/grill-me/SKILL.md) | Intenção: entrevista de plano ou desenho |
| [grilling/SKILL.md](C:/Users/brian/.agents/skills/grilling/SKILL.md) | Intenção: testar decisões por perguntas |
| [implement/SKILL.md](C:/Users/brian/.agents/skills/implement/SKILL.md) | Execução: implementação a partir de spec/tickets |
| [loop/SKILL.md](C:/Users/brian/.agents/skills/loop/SKILL.md) | Automação: repetição de prompt na sessão |
| [migrate-to-skills/SKILL.md](C:/Users/brian/.agents/skills/migrate-to-skills/SKILL.md) | Autoria: migração de regras/comandos para skills |
| [new-repo/SKILL.md](C:/Users/brian/.agents/skills/new-repo/SKILL.md) | Git: criar repositório hospedado |
| [onboard/SKILL.md](C:/Users/brian/.agents/skills/onboard/SKILL.md) | Entrada: preferências e primeiro objetivo |
| [origin/SKILL.md](C:/Users/brian/.agents/skills/origin/SKILL.md) | Git: CLI de hospedagem |
| [plan/SKILL.md](C:/Users/brian/.agents/skills/plan/SKILL.md) | Planejamento: pesquisa e plano antes do código |
| [receiving-code-review/SKILL.md](C:/Users/brian/.agents/skills/receiving-code-review/SKILL.md) | Revisão: avaliar feedback antes de alterar |
| [rename-chat/SKILL.md](C:/Users/brian/.agents/skills/rename-chat/SKILL.md) | Conversas: renomear por comando explícito |
| [requesting-code-review/SKILL.md](C:/Users/brian/.agents/skills/requesting-code-review/SKILL.md) | Revisão: solicitar auditoria de alterações |
| [research/SKILL.md](C:/Users/brian/.agents/skills/research/SKILL.md) | Pesquisa: fontes primárias e registro em Markdown |
| [resolving-merge-conflicts/SKILL.md](C:/Users/brian/.agents/skills/resolving-merge-conflicts/SKILL.md) | Git: resolver conflito de merge/rebase |
| [review/SKILL.md](C:/Users/brian/.agents/skills/review/SKILL.md) | Revisão: encaminhar a Bugbot/Security |
| [review-bugbot/SKILL.md](C:/Users/brian/.agents/skills/review-bugbot/SKILL.md) | Revisão: subagente Bugbot |
| [review-security/SKILL.md](C:/Users/brian/.agents/skills/review-security/SKILL.md) | Segurança: subagente de revisão |
| [sdk/SKILL.md](C:/Users/brian/.agents/skills/sdk/SKILL.md) | Integração: aplicativos sobre SDK |
| [share/SKILL.md](C:/Users/brian/.agents/skills/share/SKILL.md) | Git: salvar ou compartilhar projeto |
| [shell/SKILL.md](C:/Users/brian/.agents/skills/shell/SKILL.md) | Terminal: executar pedido /shell literal |
| [split-to-prs/SKILL.md](C:/Users/brian/.agents/skills/split-to-prs/SKILL.md) | Git: dividir trabalho em PRs menores |
| [statusline/SKILL.md](C:/Users/brian/.agents/skills/statusline/SKILL.md) | Terminal: configurar linha de status |
| [subagent-driven-development/SKILL.md](C:/Users/brian/.agents/skills/subagent-driven-development/SKILL.md) | Times: executar plano por tarefas independentes |
| [systematic-debugging/SKILL.md](C:/Users/brian/.agents/skills/systematic-debugging/SKILL.md) | Diagnóstico: identificar causa antes da correção |
| [tdd/SKILL.md](C:/Users/brian/.agents/skills/tdd/SKILL.md) | Testes: ciclos red-green-refactor |
| [test-driven-development/SKILL.md](C:/Users/brian/.agents/skills/test-driven-development/SKILL.md) | Testes: implementação com prova de regressão |
| [update-cli-config/SKILL.md](C:/Users/brian/.agents/skills/update-cli-config/SKILL.md) | Configuração: preferências do CLI |
| [update-cursor-settings/SKILL.md](C:/Users/brian/.agents/skills/update-cursor-settings/SKILL.md) | Configuração: preferências do editor |
| [using-git-worktrees/SKILL.md](C:/Users/brian/.agents/skills/using-git-worktrees/SKILL.md) | Git: checkout isolado para trabalho |
| [using-superpowers/SKILL.md](C:/Users/brian/.agents/skills/using-superpowers/SKILL.md) | Roteamento: seleção e uso de skills |
| [validate-changes-match-specs/SKILL.md](C:/Users/brian/.agents/skills/validate-changes-match-specs/SKILL.md) | Revisão: implementação contra specs |
| [verification-before-completion/SKILL.md](C:/Users/brian/.agents/skills/verification-before-completion/SKILL.md) | Verificação: evidência antes de declarar conclusão |
| [visualize/SKILL.md](C:/Users/brian/.agents/skills/visualize/SKILL.md) | Visualização: diagramas, gráficos e interação |
| [writing-plans/SKILL.md](C:/Users/brian/.agents/skills/writing-plans/SKILL.md) | Planejamento: plano de execução |
| [writing-skills/SKILL.md](C:/Users/brian/.agents/skills/writing-skills/SKILL.md) | Autoria: validar skills |

### C — skills globais Codex

| Skill / localização relativa | Categoria e gatilho resumido |
|---|---|
| [.system/imagegen/SKILL.md](C:/Users/brian/.codex/skills/.system/imagegen/SKILL.md) | Mídia: gerar e editar imagens |
| [.system/openai-docs/SKILL.md](C:/Users/brian/.codex/skills/.system/openai-docs/SKILL.md) | Documentação: produtos OpenAI/Codex |
| [.system/review-agent/SKILL.md](C:/Users/brian/.codex/skills/.system/review-agent/SKILL.md) | Revisão: leitura de diff delegado |
| [.system/skill-creator/SKILL.md](C:/Users/brian/.codex/skills/.system/skill-creator/SKILL.md) | Autoria: criação e atualização de skills |
| [.system/skill-installer/SKILL.md](C:/Users/brian/.codex/skills/.system/skill-installer/SKILL.md) | Instalação: skills selecionadas |
| [angular-developer/SKILL.md](C:/Users/brian/.codex/skills/angular-developer/SKILL.md) | Implementação: Angular |
| [find-skills/SKILL.md](C:/Users/brian/.codex/skills/find-skills/SKILL.md) | Descoberta: localizar skills |
| [microsoft-docs/SKILL.md](C:/Users/brian/.codex/skills/microsoft-docs/SKILL.md) | Documentação: tecnologias Microsoft |
| [project-onboard/SKILL.md](C:/Users/brian/.codex/skills/project-onboard/SKILL.md) | Contexto: engenharia reversa de projeto existente |
| [sanitizar-task-spec/SKILL.md](C:/Users/brian/.codex/skills/sanitizar-task-spec/SKILL.md) | Auditoria: escopo delimitado e scan local |
| [spec-new/SKILL.md](C:/Users/brian/.codex/skills/spec-new/SKILL.md) | Spec alternativa: nova mudança em .spec/changes |
| [spec-plan/SKILL.md](C:/Users/brian/.codex/skills/spec-plan/SKILL.md) | Spec alternativa: plano técnico |
| [spec-review/SKILL.md](C:/Users/brian/.codex/skills/spec-review/SKILL.md) | Spec alternativa: qualidade e consistência |
| [spec-tasks/SKILL.md](C:/Users/brian/.codex/skills/spec-tasks/SKILL.md) | Spec alternativa: decomposição de tarefas |
| [spec-to-code-compliance/SKILL.md](C:/Users/brian/.codex/skills/spec-to-code-compliance/SKILL.md) | Auditoria: conformidade código/especificação |
| [spring-boot-engineer/SKILL.md](C:/Users/brian/.codex/skills/spring-boot-engineer/SKILL.md) | Implementação: Spring Boot |

### M — skill derivada de memória

| Skill / localização relativa | Categoria e gatilho resumido |
|---|---|
| [petjus-spec-homologation/SKILL.md](C:/Users/brian/.codex/memories/skills/petjus-spec-homologation/SKILL.md) | Homologação: PetJus, evidência visual e anexo técnico |

## P — plugins em cache

Enumerados somente nomes de pacote, diretórios de versão e frontmatter das skills. Não foram lidos manifestos de conexão, credenciais ou configurações. `latest` é nome de diretório observado; não representa versão remota verificada. Pacotes sem `SKILL.md` podem oferecer ferramentas por outros mecanismos.

| Distribuição / plugin | Diretórios de versão | Skills observadas |
|---|---|---|
| `caveman/caveman` | `2.7.0` | `cavecrew`, `caveman`, `caveman-commit`, `caveman-compress`, `caveman-discover`, `caveman-evidence-review`, `caveman-explore`, `caveman-help`, `caveman-learn`, `caveman-manage`, `caveman-optimize`, `caveman-review`, `caveman-setup`, `caveman-stats`, `investigate-first`, `lean-build`, `migration`, `safe-refactor`, `surgical-patch`, `verify-and-stop` |
| `claude-plugins-official/playwright` | `local` | Nenhum SKILL.md encontrado |
| `openai-bundled/browser` | `26.930.31730` | Nenhum SKILL.md encontrado |
| `openai-bundled/chrome` | `26.930.31730`, `latest` | Nenhum SKILL.md encontrado |
| `openai-bundled/code-review` | `26.930.31730` | Nenhum SKILL.md encontrado |
| `openai-bundled/codex-app-tools` | `0.1.4`, `0.1.5` | Nenhum SKILL.md encontrado |
| `openai-bundled/computer-use` | `26.930.31730` | `computer-use` |
| `openai-bundled/unified-computer-use` | `26.930.31730` | Nenhum SKILL.md encontrado |
| `openai-bundled/visualize` | `1.0.46` | `visualize` |
| `openai-curated-remote/atlassian-rovo` | `1.0.7` | Nenhum SKILL.md encontrado |
| `openai-curated-remote/github` | `0.1.12-5f7cd798dc99` | Nenhum SKILL.md encontrado |
| `openai-curated-remote/gmail` | `0.1.10` | Nenhum SKILL.md encontrado |
| `openai-curated-remote/google-drive` | `0.1.16` | `google-docs`, `google-drive`, `google-drive-comments`, `google-sheets`, `google-slides` |
| `openai-curated-remote/openai-templates` | `0.1.1` | `artifact-template-analytics-dashboard`, `artifact-template-business-review`, `artifact-template-design-report`, `artifact-template-experiment-analysis`, `artifact-template-financial-budget`, `artifact-template-investment-committee-memo`, `artifact-template-legal-memorandum`, `artifact-template-market-trends-report`, `artifact-template-minimal-letterhead`, `artifact-template-operating-calendar`, `artifact-template-operating-review`, `artifact-template-project-kickoff`, `artifact-template-project-tracker`, `artifact-template-sales-pipeline`, `artifact-template-simple-dark-mode`, `artifact-template-simple-light-mode`, `artifact-template-strategy-memorandum`, `artifact-template-system-design`, `artifact-template-team-alignment`, `artifact-template-three-statement-forecast` |
| `openai-curated-remote/pages` | `0.1.19` | `maintain-space`, `manage-schedules`, `organize-space`, `write-page` |
| `openai-curated-remote/plugin-management` | `0.1.0` | `plugin-management` |
| `openai-curated-remote/sites` | `0.1.75` | `sites-building`, `sites-hosting`, `sites-mcp`, `sites-preview-troubleshooting` |
| `openai-curated-remote/work-pets` | `0.1.6` | `create-pet`, `pets`, `update-pet` |
| `openai-primary-runtime/documents` | `26.905.11957` | `documents` |
| `openai-primary-runtime/pdf` | `26.905.11957` | `pdf` |
| `openai-primary-runtime/presentations` | `26.905.11957` | `Presentations` |
| `openai-primary-runtime/spreadsheets` | `26.905.11957` | `Spreadsheets`, `excel-live-control` |
| `openai-primary-runtime/template-creator` | `26.905.11957` | `template-creator` |

Os 69 arquivos de P correspondem a **65 nomes distintos**. No Caveman 2.7.0 há 20 skills em `skills/` e quatro repetidas em `plugins/caveman/skills/`: `cavecrew`, `caveman`, `caveman-compress` têm `SKILL.md` idêntico; `caveman-stats` difere. A sessão disponibilizou as skills do caminho superior `skills/`; o pacote aninhado não deve ser contado como nova capacidade. A validação não selecionou nem removeu versões do cache.

Categorias observadas no frontmatter: Caveman cobre comunicação, custo e engenharia; browser/computer-use cobre interação; Drive/Pages cobre documentos conectados; Sites cobre criação/hospedagem; work-pets cobre mascotes; runtime cobre documentos, PDFs, apresentações e planilhas. `openai-templates` contém 20 templates de artefato. Essas descrições não comprovam a disponibilidade das ferramentas necessárias.

## Descoberta complementar — Cursor

Em `C:/Users/brian/.cursor/skills-cursor` foram encontrados **26 SKILL.md**. A descoberta foi por nomes e comparação de hashes, sem leitura de conversas ou banco de estado. A tabela lista o nome da pasta; o arquivo é sempre `<pasta>/SKILL.md`. O gatilho deve ser conferido no arquivo do harness antes do uso.

| Relação com a base A | Pastas |
|---|---|
| SKILL.md idêntico | `autopilot`, `loop`, `rename-chat`, `review`, `review-bugbot`, `review-security`, `shell`, `statusline`, `visualize` |
| SKILL.md diferente | `automate`, `canvas`, `create-hook`, `create-rule`, `create-skill`, `create-subagent`, `deploy-with-vercel`, `goal`, `migrate-to-skills`, `new-repo`, `onboard`, `origin`, `sdk`, `share`, `split-to-prs`, `update-cli-config`, `update-cursor-settings` |

## Reaproveitamento e dependências verificadas no texto local

| Recurso | Reaproveitamento e dependência observada | Limite da verificação |
|---|---|---|
| Quatro SDD canônicas (L) | `sdd-lifecycle` referencia `.specify/flow.json` e `references/{phases,transitions,routing}.md`; `sdd-project` aponta `tools/labs.ps1` e `references/operations.md`; `sdd-audit` usa `references/audits.md`; `sdd-learn` usa `references/promotion.md` | Arquivos referenciados principais presentes; CLI/doctor não executados neste inventário |
| `handoff` (L) | Referenciar specs, ADRs e evidências em vez de duplicá-los; produzir passagem de contexto sanitizada em diretório temporário | Instruções lidas; nenhum handoff executado |
| `claude-handoff` (L) | Continuação em agente de background conforme o frontmatter | Dependências operacionais e suporte do harness não testados |
| `graphify` (L/A) | O procedimento local descreve `graphify query`, relatório, JSON e visualização; `graphify-out/graph.json` e `GRAPH_REPORT.md` já existem em labs | Duas versões do SKILL.md; executável, dependências e frescor do grafo não validados |
| `sanitizar-task-spec` (C) | Scanner local `scripts/scan_scope.py`, Python 3.10+, biblioteca padrão; manifesto de escopo e relatórios JSON/Markdown; `references/prompt-universal.md` e `script-local.md` | Contrato lido na skill; testes históricos não foram repetidos |
| `petjus-spec-homologation` (M) | Matriz critério → jornada → evidência; PDF para gestão separado de anexo técnico; verificação por snapshot | Específica para PetJus, não é homologação universal nem aprovação atual |

## Manutenção do catálogo

Manter apenas os pontos de entrada canônicos e links vivos para SDD em consumidores. O `skills/README.md` encontrado antes desta consolidação recomendava cópia recursiva e não listava as quatro canônicas; a revisão do catálogo é tratada no mesmo pacote documental. Não deduzir que todos os diretórios do acervo foram instalados em todos os assistentes. Para escolher uma skill, ler a versão efetivamente selecionada pelo harness e seus recursos; este inventário não substitui o procedimento.
