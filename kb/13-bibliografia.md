# 13 — Bibliografia comentada

Classificada por **natureza da evidência**, não por tema. Cada entrada diz o que ela autoriza a
afirmar — e, quando aplicável, o que ela **não** autoriza.

---

## A. Documentação oficial `[OFICIAL]`

Autoritativa sobre o produto. **Não** é evidência sobre o mundo: descreve como a ferramenta funciona e
o que o fornecedor recomenda, não o que foi medido.

- **Anthropic — [Best practices for Claude Code](https://code.claude.com/docs/en/best-practices)**
  A fonte mais densa deste corpus. Contribuição central: identificar que **quase toda boa prática
  deriva de uma única restrição** — a janela enche e o desempenho degrada. Traz a tabela
  incluir/excluir do CLAUDE.md, o ciclo Explore→Plan→Implement→Commit **com a regra de calibração**
  ("se você descreve o diff em uma frase, pule o plano"), os cinco modos de falha nomeados, e a
  advertência sobre revisor adversarial produzir over-engineering. Destilação:
  [anthropic-claude-code.md](anthropic-claude-code.md).

- **Anthropic — [Common workflows](https://code.claude.com/docs/en/common-workflows)**
  Receitas por tarefa. O que mais rende: a progressão de perguntas para entender codebase novo
  (amplo → estreito), o `@` que também carrega o CLAUDE.md do diretório referenciado, e a tabela de
  opções de agendamento.

- **Anthropic — [Prompt library](https://code.claude.com/docs/en/prompt-library)**
  Valor está na **taxonomia**, não nos prompts: 5 fases de SDLC (discover/design/build/ship/operate),
  15 categorias, 7 papéis, prompts parametrizados por slots nomeados. 25 de 54 prompts sem papel —
  sinal de posicionamento organizacional, não apenas de engenharia.

- **Anthropic — Agent Skills** (out/2025; formato aberto dez/2025, adotado pela OpenAI)
  *Progressive disclosure* como mecanismo. Simon Willison: potencialmente *"maior que o MCP"* pela
  simplicidade radical — markdown + YAML contra uma especificação de protocolo inteira.

- **Anthropic — [Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)**
  Contexto como recurso finito com retorno marginal decrescente; system prompts na “altura” certa,
  recuperação *just in time*, progressive disclosure, compactação, notas estruturadas em disco e
  subagentes. Autoriza o desenho de memória de AR-04: contexto fresco relê estado compacto; não
  autoriza concluir que uma técnica específica sempre melhora qualquer modelo.

- **GitHub — [Spec Kit](https://github.github.io/spec-kit/)** · [repo](https://github.com/github/spec-kit)
  Nove comandos (`constitution`, `specify`, `clarify`, `plan`, `tasks`, `analyze`, `checklist`,
  `implement`, `converge`). O que mais rende: **histórias independentemente testáveis com US1 = MVP**,
  tasks agrupadas por história e não por camada, e a fase Fundação como portão rígido.

## B. Pesquisa acadêmica `[EXPERIMENTAL]` / `[RECENTE]`

- **Macedo — [Stop Hand-Holding Your Coding Agent: Engineering the Loops that Replace Step-by-Step Prompting](https://arxiv.org/html/2607.00038)**,
  arXiv 2607.00038, jun/2026. `[ACADÊMICO]` Position paper + codificação descritiva de 50 loops.
  Define especificação de loop externa (gatilho, meta, verificação, parada, memória), escada de cinco
  níveis, arquiteturas, estados terminais e custo por mudança aceita. O corpus reporta 70% na zona
  autônoma de verificação e 74% com estados terminais nomeados. **Não autoriza causalidade ou ROI**:
  uma única pessoa codificou um único catálogo e o paper não executou experimento controlado.

- **Zhang et al. — [Self-Harness: Harnesses That Improve Themselves](https://arxiv.org/html/2606.09498)**,
  arXiv 2606.09498v3, ago/2026. `[EXPERIMENTAL]` Modelo/evaluator fixos; Weakness Mining → propostas
  mínimas → validação em held-in/held-out. Nos nove pares de três modelos × três benchmarks, os
  harnesses finais melhoraram ambos os splits; ganho relativo total máximo de 132%. **Não autoriza
  autoedição irrestrita de harness de produção** nem generalização fora desses backends/benchmarks.

- **De La Cruz — [From Code-Centric to Intent-Centric Software Engineering](https://arxiv.org/abs/2605.11027)**,
  arXiv 2605.11027, mai/2026. `[ACADÊMICO]` Análise temática reflexiva, dominante, de literatura e
  discurso público: código plausível fica barato enquanto intenção, contexto, arquitetura,
  verificação, segurança, proveniência, governança e julgamento responsável ganham centralidade.
  **Não é estudo de produtividade**; o corpus é heterogêneo e a síntese é interpretativa.

- **Will It Survive? Deciphering the Fate of AI-Generated Code in Open Source** —
  [arXiv 2601.16809](https://arxiv.org/abs/2601.16809), jan/2026. `[EXPERIMENTAL]`
  Análise de sobrevivência, 201 projetos, 200 mil unidades de código. **Refuta a narrativa do "código
  descartável"**: código de agente sobrevive mais (15,8 p.p. menos modificação; HR = 0,842, p < 0,001).
  Perfis de modificação diferem pouco (Cramér's V = 0,116) e a variação **entre agentes** excede a
  diferença agente-humano. Conclusão que fundamenta MM-12: *"o gargalo pode não ser a qualidade da
  geração, mas as práticas organizacionais que governam a evolução de longo prazo"*.
  **Não autoriza dizer** que código de agente é melhor — sobreviver mais também pode significar que
  ninguém o revisita.

- **Agentic AI Frameworks: Architectures, Protocols, and Design Challenges** —
  [arXiv 2508.10146](https://arxiv.org/html/2508.10146v1). `[RECENTE]` *(preprint IEEE)*
  Comparação de CrewAI, LangGraph, AutoGen, Semantic Kernel, Agno, Google ADK, MetaGPT. Contribuições
  úteis aqui: a **taxonomia de memória** (curto/longo prazo, semântica, procedimental, episódica), a
  comparação de protocolos (MCP, A2A, ACP, ANP, Agora), e as **limitações nomeadas** — papéis rígidos,
  ausência de descoberta em runtime, riscos de execução de código gerado, silos de interoperabilidade.

- **METR — Measuring the Impact of Early-2025 AI on Experienced OSS Developer Productivity** —
  [arXiv 2507.09089](https://arxiv.org/abs/2507.09089). `[EXPERIMENTAL]`
  RCT: desenvolvedores experientes **19% mais lentos** em codebases maduros, *acreditando* estar ~20%
  mais rápidos. É a base empírica de MM-11. **Não autoriza dizer** que IA reduz produtividade em geral
  — mediu ferramentas do início de 2025, sem processo estruturado, em codebases maduros.

- **Shankar et al. — Who Validates the Validators?** UIST 2024, Berkeley —
  [arXiv 2404.12272](https://arxiv.org/abs/2404.12272). `[EXPERIMENTAL]`
  Origem de *criteria drift*: critérios dependem da observação das saídas e não são definíveis a
  priori. Base empírica de P03 e MM-05.

- **Zamfirescu-Pereira et al. — Why Johnny Can't Prompt.** CHI 2023, Berkeley. `[EXPERIMENTAL]`
  Não-especialistas generalizam demais a partir de exemplos e não separam "o modelo não entendeu" de
  "eu não especifiquei".

## C. Relatórios de indústria `[EXPERIMENTAL]` com ressalva

Medem populações reais, mas **nenhum deles testou SDD**. Legítimo usá-los para argumentar que *algum*
processo é necessário; desonesto usá-los como prova de que SDD funciona.

- **DORA — [2024 Accelerate State of DevOps](https://cloud.google.com/blog/products/devops-sre/announcing-the-2024-dora-report)**
  Com a adoção de IA: estabilidade −7,2%, throughput −1,5%. Mecanismo proposto: a IA facilita produzir
  **lotes maiores**, e lote maior carrega mais risco. Sustenta a métrica "tamanho do lote".
- **GitClear — [AI Copilot Code Quality 2025](https://www.gitclear.com/ai_assistant_code_quality_2025_research)**
  200M+ linhas: churn ~2× o baseline pré-IA, blocos duplicados em alta, refatoração em queda.
  Assinatura de dívida técnica acumulando.
- **Specmatic — [CDD cortou tempo de ciclo de API em 75%](https://specmatic.io/case-studies/case-study-cdd-cut-api-cycle-time-by-75-percent/)** `[INDÚSTRIA]`
  Caso de Contract-Driven Development — **adjacente** ao SDD com IA, não idêntico. Demonstra o mesmo
  mecanismo: mover o defeito para a esquerda.

## D. Análise crítica `[EXPERIMENTAL]` qualitativa

- **Böckeler, B. (Thoughtworks/Martin Fowler) — [Understanding Spec-Driven Development: Kiro, spec-kit, and Tessl](https://martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html)**, out/2025.
  **A fonte mais valiosa deste corpus para não se enganar.** Contribuições:
  (1) a distinção **spec-first / spec-anchored / spec-as-source** — a única taxonomia clara de níveis
  de SDD; (2) a distinção entre **spec** (relevante à tarefa) e **memory bank** (relevante a todas as
  sessões); (3) as objeções concretas — marreta na noz, revisar markdown pior que revisar código,
  falsa sensação de controle, dificuldade real de separar funcional de técnico, e o paralelo com MDD:
  *"me pergunto se spec-as-source acabaria com as desvantagens dos dois — inflexibilidade **e**
  não-determinismo"*.
  Fecha com *Verschlimmbesserung*: piorar tentando melhorar. Toda proposta de SDD deveria responder a
  este artigo.

## E. Prática de indústria `[INDÚSTRIA]`

- **Addy Osmani — [Loop Engineering](https://addyo.substack.com/p/loop-engineering)**, jun/2026.
  Compõe automações de descoberta/triagem, worktrees, skills, plugins/connectors e subagentes sobre
  memória externa; maker/checker e estado persistido transformam prompts em sistema operável. A
  fonte preserva a ressalva central: loops não eliminam prompting, revisão humana, custo nem dívida de
  compreensão. É experiência/opinião de indústria, não avaliação controlada.

- **Maestros da IA — [O Criador do Claude Code APOSENTOU Prompts (agora ele usa LOOPS)](https://youtu.be/4UWjYd-IUF4)**,
  ago/2026. Divulgação operacional em quatro blocos: gatilho, skills, objetivo/verificação e
  saída/memória; recomenda começar pequeno. Útil como tradução prática, não como evidência empírica.
- **O Novo Programador — [Loop Engineering: Faça a IA TRABALHAR Enquanto Você DORME!](https://youtu.be/LIn5X6ObEms)**,
  ago/2026. Demonstra a proposta de execução longa/unattended. A promessa exige a ressalva que a fonte
  de loops acadêmica explicita: check externo, teto, isolamento, credenciais mínimas e aprovação para
  ações consequenciais.

- **Red Hat — [How spec-driven development improves AI coding quality](https://developers.redhat.com/articles/2025/10/22/how-spec-driven-development-improves-ai-coding-quality)**
  Origem do padrão `LessonsLearned.md` consumido pelo próprio agente (LRN-01) e da estratificação de
  specs "how" (agnóstica de linguagem → específica de linguagem → documentação). Os **95% de precisão
  de primeira passada são meta declarada, não resultado medido** — cite como alvo.
- **Beam — [Spec Driven Development: Build what you mean, not what you guess](https://beam.ai/agentic-insights/spec-driven-development-build-what-you-mean-not-what-you-guess)**
  Introdutório. Útil pela lista honesta de "coisas para observar": tempo inicial, curva de aprendizado,
  spec drift, nível de detalhe, maturidade da ferramenta.
- **DS Academy — Spec-Driven Development, partes 3, 4 e 5.**
  Parte 3: ecossistema (Spec Kit, Tessl + Registry, Claude Code, SKILL.md). Parte 4: a melhor descrição
  em português da **arquitetura de injeção de contexto em três camadas** (system prompt fixo → contexto
  dinâmico → task prompt), do padrão **Builder/Verifier**, e do equilíbrio alucinação × rigidez que
  motiva a especificação hierárquica. Parte 5: o papel do "arquiteto de intenção" e o cenário
  brownfield.
- **Matt Pocock — [github.com/mattpocock/skills](https://github.com/mattpocock/skills)** (lido em
  2026-08-02). 21 skills de engenharia empacotadas, com a tese oposta à do Spec Kit: *"GSD, BMAD e
  Spec-Kit tentam ajudar assumindo o processo — e ao fazê-lo tiram seu controle"*. Origem de INT-08
  (*grilling*, a entrevista conduzida), CTX-06 (linguagem ubíqua), CTX-07 (handoff), PLN-05 (módulo
  profundo), PLN-06 (mapa sob névoa), VER-06 (loop de feedback), AP-35/36/37 e H-17/H-18. Valor da fonte: **operacionaliza** literatura
  consolidada — Ousterhout, Feathers, Fowler, Evans, Beck, Hunt & Thomas — em procedimento executável
  por agente, que é precisamente o que os livros não trazem. Ressalva: é prática de um praticante, sem
  medição publicada; nada aqui é `[CONSOLIDADO]` por vir dele. Destilação:
  [mattpocock-skills.md](mattpocock-skills.md) · decisão de não instalar: ADR-011.
- **Comparativo TDD × BDD × SDD.** Uma tabela que resolve uma confusão frequente: TDD trava correção no
  nível do código, BDD verifica comportamento observável, **SDD opera acima dos dois e os orquestra**.
  Não competem.

## F. Fontes de campo `[CAMPO]`

Observações nos repositórios do usuário. **É a parte que ninguém mais tem**, e por isso a mais
acionável — e a mais fácil de perder se não for registrada.

- **`WWMA-Tech/inscreveai-new-project`** — o mais maduro do ecossistema.
  `CLAUDE.md` (213 linhas, altíssimo sinal, com o defeito de conter estado volátil — AP-26) ·
  `AGENTS.md` · `.spec/` com 4 discovery, ~40 specs arquivadas, 20 de backlog ·
  `.spec/memory/patterns.md` (46 KB, **P1–P22 + P_Novo1–21 + 18 perguntas de revisão**, o melhor
  exemplo de LRN-02 do corpus) · `spec.template.md` V5 com 13 seções, **EARS na §4 e PROP na §9** ·
  `correctness/` (kit portátil de property-based testing com 9 arquétipos, política de propriedade
  vermelha, e prompts de descoberta e implementação com 8 regras de rigor).
  **Também é a fonte dos dois anti-padrões inéditos** AP-14 (P1–P6 colidindo entre três documentos
  vigentes) e AP-15 (skills duplicadas em três harnesses, versões não idênticas).

- **`Back-End/Wakanda/wakanda-ai/sdd-kit`** — o mais completo em processo.
  `framework/standards/`: `core-principles` (protocolo de pergunta inteligente, consistência de stack)
  · `governance` (7 princípios, **limites de iteração por fase**, segurança de comando) ·
  `mandatory-standards` (**anti-invenção com 5 níveis de confiança, anti-truncamento,
  anti-placeholder, independência do validador, orçamento de contexto em faixas**) · `anti-patterns`
  (AP-01 a AP-13 com severidade) · `elegance-principle` (benchmarks de tamanho: 4–6 páginas por
  feature, não 50) · `task-format` (`tasks.json` com `depends_on` e validação de ciclo) ·
  `WORKFLOW`/`MODES` (Express × Standard, Lite × Full, greenfield/brownfield/reverse-eng com 4 fases).
  11 subagentes, 7 skills, 19 comandos — **e os comandos de 60–97 KB que originam AP-27**.

- **`Freelancer/K.A.O.S`** — `CLAUDE.md` exemplar em concisão e em apontar em vez de repetir
  (`.opencode/rules/` por linguagem). Pipeline cognitivo **Observe → Understand → Recall → Reason →
  Plan → Execute → Reflect → Learn → Update** com portas abstratas; `mind/` com identity, goals,
  intent, emotion; memória working/episodic/semantic; runtime com máquina de 10 estados e modos de
  potência Sleeping→Observer→Assistant→Researcher→Autonomous.

- **Metodologia SDD V5** — o documento de apresentação mais honesto do conjunto: reconhece que os
  estudos negativos mediram IA **sem** processo e que nenhum testou SDD; enquadra o custo como TCO;
  lista as limitações citando Böckeler; e afirma explicitamente que não é plano fechado.

---

## Como pesar as fontes

| Pergunta | Peso nas fontes |
|---|---|
| *Como o Claude Code funciona?* | A (oficial) domina |
| *SDD funciona?* | **Ninguém sabe.** Nenhum estudo controlado publicado. B e C medem IA sem processo |
| *IA sem processo tem problema?* | C — evidência razoável (DORA, GitClear, METR) |
| *Como estruturar uma spec?* | E + F — consenso convergente, sem validação |
| *Quais são as armadilhas?* | D + F — Böckeler e os anti-padrões de campo |
| *O que vale a pena medir?* | B + C, com o cuidado de Goodhart |

**A lacuna que define a agenda:** não existe estudo controlado comparando SDD assistido por IA contra
prompting direto, medindo retrabalho, defeito e tempo, **estratificado por porte e custo de reversão**.
Você tem o fluxo instrumentado e os repositórios — é o experimento mais barato e mais informativo
disponível para você, e a predição que a KB faz é específica: **o ganho do SDD deve ser positivo apenas
acima de um limiar de custo de reversão, e possivelmente negativo abaixo dele.** Se o resultado for
ganho uniforme, o modelo de custo desta KB está errado.

---

**Anterior:** [12 — Rastreabilidade](12-rastreabilidade.md) · **Índice:** [README](README.md)
