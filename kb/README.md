# Engineering Knowledge Base — AI Systems Engineering

> Base de conhecimento de engenharia para construir e operar sistemas de software com agentes de IA.
> Não é um documento linear: é um grafo de artefatos que se referenciam e evoluem por incremento.
> Versão 0.1 — 2026-08-02. Destino: fundação do **K.A.O.S** e de qualquer projeto que use agentes.

## Por que uma base de conhecimento, e não uma pesquisa

Pesquisa linear responde a uma pergunta e envelhece. Uma KB **organiza conhecimento em tipos com
formato fixo**, o que permite: consultar por tipo, detectar contradição entre itens, versionar por
item, e — o ponto decisivo — ser consumida em fatias por um agente sem carregar tudo.

Cada tipo de artefato responde a uma pergunta diferente. Confundi-los é a origem de CLAUDE.md
inchados e constituições decorativas:

| Artefato | Pergunta que responde | Muda a cada |
|---|---|---|
| **Taxonomia** | Onde isto se encaixa? | anos |
| **Ontologia** | Como isto se relaciona? | anos |
| **Glossário** | O que isto significa aqui? | meses |
| **Princípio** | Por que fazemos assim? | anos |
| **Padrão** | Como resolvo este problema recorrente? | meses |
| **Anti-padrão** | O que falha repetidamente? | meses |
| **Heurística** | Qual é a boa aposta sob incerteza? | semanas |
| **Invariante** | O que nunca pode ser violado? | anos |
| **Modelo mental** | Como devo raciocinar sobre isto? | anos |
| **Arquitetura de referência** | Que forma o sistema deve ter? | trimestres |
| **Pipeline** | Em que ordem as coisas acontecem? | trimestres |
| **Árvore de decisão** | O que fazer neste ponto? | meses |
| **Máquina de estados** | Em que estado estou e para onde posso ir? | meses |
| **Métrica** | Como sei se está funcionando? | trimestres |
| **ADR** | Por que escolhemos isto em vez daquilo? | imutável (só se acrescenta) |
| **Rastreabilidade** | Isto cobre aquilo? | por feature |

## Índice

| # | Documento | Tipo |
|---|---|---|
| — | [Anthropic · Claude Code](anthropic-claude-code.md) | Destilação das fontes oficiais |
| — | [Git Strategy](git-strategy.md) | Destilação das fontes oficiais — convenções de branch, commits, worktree por frente e hooks |
| — | [Worktrees](worktrees.md) | Destilação das fontes oficiais — isolamento de arquivos para trabalho paralelo |
| — | [Subagentes](sub-agents.md) | Destilação das fontes oficiais — coordenação de trabalho em contexto isolado |
| — | [Biblioteca de prompts](prompt-library.md) | Os 52 prompts oficiais + índice de gatilho (intenção → prompt) |
| — | [mattpocock/skills](mattpocock-skills.md) | Destilação `[INDÚSTRIA]` — disciplinas de engenharia empacotadas como skills |
| — | [Agent Skills do GitHub](github-agent-skills.md) | Destilação `[INDÚSTRIA]` / `[OFICIAL]` / `[CAMPO]` — matriz extensiva de skills (PO, QA, QC, Dev) |
| — | [Corpus KbMain](kbmain-corpus.md) | Destilação `[CAMPO]` — acervo agêntico de terceiro em produção, com seus modos de apodrecimento |
| 00 | [Taxonomia](00-taxonomia.md) | Classificação hierárquica das disciplinas |
| 01 | [Ontologia / Knowledge Graph](01-ontologia.md) | Relações semânticas entre conceitos |
| 02 | [Glossário](02-glossario.md) | Definições formais |
| 03 | [Princípios](03-principios.md) | Meta-princípios com origem, limites e classificação |
| 04 | [Padrões](04-padroes.md) | Soluções recorrentes (formato GoF) |
| 05 | [Anti-padrões](05-antipadroes.md) | Falhas recorrentes, com evidência |
| 06 | [Heurísticas e invariantes](06-heuristicas-e-invariantes.md) | Regras práticas e regras absolutas |
| 07 | [Modelos mentais](07-modelos-mentais.md) | Formas de raciocinar |
| 08 | [Arquiteturas de referência e pipelines](08-arquiteturas-e-pipelines.md) | Formas e sequências |
| 09 | [Árvores de decisão, estados e algoritmos](09-decisao-estados-algoritmos.md) | Procedimentos conceituais |
| 10 | [Métricas de qualidade](10-metricas.md) | Sinais observáveis |
| 11 | [ADRs](11-adrs.md) | Decisões arquiteturais com alternativas |
| 12 | [Rastreabilidade](12-rastreabilidade.md) | Requisito → Intenção → Plano → Execução → Verificação |
| 13 | [Bibliografia comentada](13-bibliografia.md) | Fontes classificadas por natureza |
| — | [templates/CLAUDE.template.md](../templates/CLAUDE.template.md) | Artefato executável |
| — | [templates/AGENTS.template.md](../templates/AGENTS.template.md) | Artefato executável |

Aprofundamento de **uma** das disciplinas: [docs/intent-engineering/](../docs/intent-engineering/README.md)
— fundamentação científica de Engenharia de Intenção, com selos epistêmicos.

## Selos epistêmicos

Herdados do corpus de Intent Engineering e usados em toda a KB. **Nunca se misturam.**

`[CONSOLIDADO]` revisado por pares e replicado · `[INDÚSTRIA]` consenso de prática, sem validação
controlada · `[RECENTE]` últimos ~3 anos, em disputa · `[EXPERIMENTAL]` evidência empírica com escopo
declarado · `[ACADÊMICO]` proposta sem adoção ampla · `[HIPÓTESE]` proposta original desta KB, com
condição de falsificação · `[OFICIAL]` documentação de fornecedor (Anthropic/GitHub) — autoritativa
sobre o produto, não sobre o mundo · `[CAMPO]` observado nos projetos do usuário (InscreveAI,
Wakanda, K.A.O.S), com o arquivo citado.

`[CAMPO]` é o selo mais valioso desta KB e o mais fácil de perder: é evidência que ninguém mais tem.

Desde 2026-08-04 (ADR-012) o selo `[CAMPO]` tem **duas origens**: os projetos do titular e acervos de
terceiros observados diretamente. A distinção fica no cabeçalho de cada destilação, não em selo novo —
observar não é endossar, e a mesma fonte pode render um padrão e um anti-padrão.

## Fontes primárias desta versão

**Oficiais** — `code.claude.com/docs`: best-practices, common-workflows, prompt-library, worktrees,
agents, hooks, sub-agents · `github.github.io/spec-kit` · Anthropic Agent Skills.
**De indústria** — `github.com/mattpocock/skills` (21 skills, lidas em 2026-08-02; ver ADR-011).
**Acadêmicas** — arXiv 2508.10146 (Agentic AI Frameworks) · arXiv 2601.16809 (Will It Survive?) ·
METR 2507.09089 · DORA 2024 · GitClear 2025 · Martin Fowler / Thoughtworks (Böckeler).
**De campo** — `WWMA-Tech/inscreveai-new-project` (.spec, CLAUDE.md, AGENTS.md, patterns.md com
P1–P22 e P_Novo1–21, correctness/) · `Back-End/Wakanda/wakanda-ai/sdd-kit` (framework/standards,
WORKFLOW, MODES, 11 agentes, 7 skills, 19 comandos) · `Freelancer/K.A.O.S` (CLAUDE.md, .agents) ·
Metodologia SDD V5 · Comparativo TDD/BDD/SDD · **corpus KbMain** (619 arquivos: 493 de KB em 36
domínios, 58 agentes, dossiê metodológico, kit de verificação por propriedades — lido em 2026-08-04,
ver ADR-012).

Detalhe e comentário: [13-bibliografia.md](13-bibliografia.md).
