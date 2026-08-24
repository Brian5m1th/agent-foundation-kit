# Graph Report - kb  (2026-08-24)

## Corpus Check
- 22 files · ~52,695 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 163 nodes · 152 edges · 26 communities (13 shown, 13 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 2 edges (avg confidence: 0.84)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- Artefatos de Execucao
- Mapa da Knowledge Base
- Loop Engineering
- Disciplinas de Engenharia
- Decisoes Arquiteturais
- Rigor e Evidencia
- Contexto Permanente
- Economia de Contexto
- Contexto em Camadas
- Verificacao Independente
- Modelos e Metricas
- Isolamento por Worktree
- Entrevista Estruturada
- Ambiguidade Calibrada
- Design sem Excesso
- Orcamento de Contexto
- Fluxo SDD
- Especificar Primeiro
- Especificacao Hierarquica
- Unidade Verificavel
- Portoes de Qualidade
- Envelope de Autonomia
- Linguagem Ubiqua
- Escala Proporcional
- Namespace Global
- Limites Epistemicos

## God Nodes (most connected - your core abstractions)
1. `Engineering Knowledge Base — AI Systems Engineering` - 19 edges
2. `EXE-07 · Especificação de Loop Externo` - 9 edges
3. `Task` - 7 edges
4. `D0 · Cognitive Engineering` - 6 edges
5. `Spec` - 5 edges
6. `Harness` - 5 edges
7. `LRN-03 · Evolução de Harness com Holdout` - 5 edges
8. `ADR-012 · Loop como artefato opcional` - 5 edges
9. `Necessidade → Requisito → Intenção → Plano → Task → Execução → Verificação → Evidência` - 5 edges
10. `D2 · Context Engineering` - 4 edges

## Surprising Connections (you probably didn't know these)
- `Explore → Plan → Implement → Commit` --semantically_similar_to--> `PL-02 · Research → Plan → Implement`  [INFERRED] [semantically similar]
  anthropic-claude-code.md → 08-arquiteturas-e-pipelines.md
- `Convergência entre loops, contexto e intenção` --supports--> `EXE-07 · Especificação de Loop Externo`  [EXTRACTED]
  pesquisa-loops-agenticos-2026.md → 04-padroes.md
- `Engineering Knowledge Base — AI Systems Engineering` --references--> `Taxonomia`  [EXTRACTED]
  README.md → 00-taxonomia.md
- `Engineering Knowledge Base — AI Systems Engineering` --references--> `Ontologia / Knowledge Graph`  [EXTRACTED]
  README.md → 01-ontologia.md
- `Engineering Knowledge Base — AI Systems Engineering` --references--> `Princípios`  [EXTRACTED]
  README.md → 03-principios.md

## Hyperedges (group relationships)
- **Loops, contexto, intenção e evolução de harness** — kb_loop_engineering_anatomia_minima, kb_loop_engineering_escada_verificacao, kb_loop_engineering_memoria_compacta, kb_loop_engineering_self_harness_holdout, kb_pesquisa_loops_convergencia [INFERRED 0.90]
- **Sete disciplinas de AI Systems Engineering** — kb_00_taxonomia_d0_cognitive_engineering, kb_00_taxonomia_d1_intent_engineering, kb_00_taxonomia_d2_context_engineering, kb_00_taxonomia_d3_planning_engineering, kb_00_taxonomia_d4_execution_engineering, kb_00_taxonomia_d5_verification_engineering, kb_00_taxonomia_d6_learning_engineering [EXTRACTED 1.00]
- **Governança, intenção, contexto, execução, verificação e aprendizado** — kb_01_ontologia_constitution, kb_01_ontologia_spec, kb_01_ontologia_contexto_ativo, kb_01_ontologia_task, kb_01_ontologia_harness, kb_01_ontologia_licao_aprendida [EXTRACTED 1.00]
- **Composição do loop externo verificável** — kb_01_ontologia_task, kb_01_ontologia_skill, kb_01_ontologia_harness, kb_01_ontologia_especificacao_de_loop [EXTRACTED 1.00]

## Communities (26 total, 13 thin omitted)

### Community 0 - "Artefatos de Execucao"
Cohesion: 0.10
Nodes (24): Envelope de autonomia, Especificação de loop, Harness, Hook, Plan, Propriedade (PROP), Requisito EARS, Revisão adversarial (+16 more)

### Community 1 - "Mapa da Knowledge Base"
Cohesion: 0.09
Nodes (23): Taxonomia, Ontologia / Knowledge Graph, Glossário, Princípios, Catálogo de padrões, Catálogo de anti-padrões, Heurísticas e invariantes, Modelos mentais (+15 more)

### Community 2 - "Loop Engineering"
Cohesion: 0.12
Nodes (17): P14 · Execução vira conhecimento, EXE-07 · Especificação de Loop Externo, LRN-03 · Evolução de Harness com Holdout, AP-38 · Loop sem Saída, AP-39 · Autoaperfeiçoamento sem Holdout, H-19 · Feedback deve mudar a próxima ação, H-20 · Harness só melhora quando o holdout não piora, AR-04 · Loop Externo Verificável (+9 more)

### Community 3 - "Disciplinas de Engenharia"
Cohesion: 0.22
Nodes (13): D0 · Cognitive Engineering, D1 · Intent Engineering, D2 · Context Engineering, D3 · Planning Engineering, D4 · Execution Engineering, D5 · Verification Engineering, D6 · Learning Engineering, Linhas de contexto permanente (+5 more)

### Community 4 - "Decisoes Arquiteturais"
Cohesion: 0.19
Nodes (13): ADR-001 · Um par CLAUDE.md + AGENTS.md, ADR-002 · Calibração por custo de reversão, ADR-003 · Portão determinístico obrigatório, ADR-004 · Verificação em contexto separado, ADR-005 · Progressive disclosure, ADR-006 · Estado volátil fora do contexto permanente, ADR-007 · Falha vira artefato executável, ADR-008 · Ambiguidade classificada (+5 more)

### Community 5 - "Rigor e Evidencia"
Cohesion: 0.17
Nodes (12): P03 · A intenção é descoberta, P11 · Harness sobre exortação, P13 · Evidência, não veredito, EXE-03 · Harness Engineering, PLN-06 · Mapa de Decisões sob Névoa, VER-06 · Loop de Feedback Antes da Hipótese, AP-17 · Confiança sem Verificação, AP-19 · Ambiguidade Silenciosa (+4 more)

### Community 6 - "Contexto Permanente"
Cohesion: 0.20
Nodes (10): CLAUDE.md, Constitution, Contexto ativo, Lição aprendida, Skill (SKILL.md), Subagente, I-14 · Conflito com a constitution é reportado, AR-01 · Sistema Agêntico em Camadas (+2 more)

### Community 7 - "Economia de Contexto"
Cohesion: 0.20
Nodes (10): P05 · O contexto é o recurso escasso, CTX-03 · Delegação para Preservar Contexto, CTX-07 · Handoff Explícito entre Sessões, AP-04 · Sessão Entulhada, AP-05 · Exploração Infinita, Janela de contexto finita, Memória compacta entre voltas, Convergência entre loops, contexto e intenção (+2 more)

### Community 8 - "Contexto em Camadas"
Cohesion: 0.25
Nodes (8): Progressive disclosure, P06 · Camadas de contexto, não um arquivo, P07 · Progressive disclosure, CTX-01 · Camadas de Contexto, CTX-02 · Skill sob Demanda, CTX-05 · Fonte Única com Geração, AP-02 · CLAUDE.md Enciclopédia, AP-15 · Cópia Manual Multi-Harness

### Community 9 - "Verificacao Independente"
Cohesion: 0.40
Nodes (5): P12 · Independência do verificador, VER-01 · Verificador Independente, AP-20 · Auto-validação, AR-02 · Builder / Critic, Escada de verificação em cinco níveis

### Community 10 - "Modelos e Metricas"
Cohesion: 0.40
Nodes (5): MM-06 · Verificação é epistemologia, MM-10 · Falha vira conhecimento, MM-12 · O gargalo é organizacional, METR — AI and OSS Developer Productivity, Will It Survive? (arXiv 2601.16809)

### Community 11 - "Isolamento por Worktree"
Cohesion: 0.67
Nodes (3): EXE-05 · Isolamento por Worktree, Isolamento de arquivos por worktree, Worktree não isola runtime

### Community 12 - "Entrevista Estruturada"
Cohesion: 0.67
Nodes (3): INT-08 · Entrevista Conduzida por Árvore de Decisão, H-17 · Uma pergunta por vez, com recomendação, grilling

## Knowledge Gaps
- **47 isolated node(s):** `Taxonomia`, `Ontologia / Knowledge Graph`, `Princípios`, `Catálogo de padrões`, `Catálogo de anti-padrões` (+42 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **13 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `EXE-07 · Especificação de Loop Externo` connect `Loop Engineering` to `Economia de Contexto`?**
  _High betweenness centrality (0.020) - this node is a cross-community bridge._
- **What connects `Taxonomia`, `Ontologia / Knowledge Graph`, `Princípios` to the rest of the system?**
  _99 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Artefatos de Execucao` be split into smaller, more focused modules?**
  _Cohesion score 0.09782608695652174 - nodes in this community are weakly interconnected._
- **Should `Mapa da Knowledge Base` be split into smaller, more focused modules?**
  _Cohesion score 0.08695652173913043 - nodes in this community are weakly interconnected._
- **Should `Loop Engineering` be split into smaller, more focused modules?**
  _Cohesion score 0.11764705882352941 - nodes in this community are weakly interconnected._
