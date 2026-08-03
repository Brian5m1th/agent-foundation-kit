# 02 — Glossário

Definições formais. Cada verbete traz `[D#]` = disciplina de origem ([00](00-taxonomia.md)) e a fonte.
Termos com ★ são propostos por esta KB.

---

**Agente** `[D4]` — entidade autônoma que percebe, raciocina, usa ferramentas e age sobre um ambiente.
Definição moderna (arXiv 2508.10146): *"entidade autônoma e colaborativa, dotada de capacidades de
raciocínio e comunicação, capaz de interpretar dinamicamente contextos estruturados, orquestrar
ferramentas e adaptar comportamento por memória e interação em sistemas distribuídos"*.

**Agentic AI** `[D4]` — paradigma em que agentes baseados em LLM exibem autonomia dirigida a objetivo,
raciocínio contextual e coordenação multiagente dinâmica. Distingue-se do MAS clássico por usar o LLM
como **motor de raciocínio** em vez de regras ou BDI simbólico.

**AGENTS.md** `[D2]` — arquivo de contexto de projeto, agnóstico de fornecedor. Complementa o
CLAUDE.md: o portátil vive no AGENTS.md; o específico do harness, no CLAUDE.md.

**Ambiguidade marcada** ★ `[D1]` — ambiguidade registrada explicitamente no artefato
(`[PRECISA ESCLARECER]`, `[NEEDS CLARIFICATION]`, `Q01`), que bloqueia a fase seguinte quando reverter
a decisão errada é caro. Oposto de *ambiguidade silenciosa*.

**Anti-invention protocol** `[D5]` — regra que proíbe inventar dados: *"se você não sabe, marque como
UNKNOWN; nunca invente"*. `[CAMPO]` sdd-kit, com sistema de 5 níveis de confiança
(VERIFIED / PARTIAL / CODE_ONLY / DOCS_ONLY / UNKNOWN).

**Approval fatigue** `[D0]` — degradação da qualidade da revisão humana por volume de aprovações.
*"Depois da décima aprovação você não está mais revisando, está clicando"* `[OFICIAL]`.

**Brownfield** `[D1]` — trabalho sobre sistema existente com documentação ausente ou defasada. As
specs descrevem o **delta**, não o sistema inteiro.

**Calibração** `[D1]` — ajuste do peso do processo ao porte da mudança. `[CAMPO]` SDD V5: bug/hotfix
(<1 dia) → Lightweight; feature média (1–3 dias) → Standard; módulo novo (>3 dias) → Full.
*"Não usar marreta pra quebrar noz."*

**CLAUDE.md** `[D2]` — arquivo lido no início de toda sessão do Claude Code. Constituição local e
memória persistente. Regra de inclusão: *"remover esta linha faria o Claude errar?"*

**Constitution** `[D1]` — princípios inegociáveis com autoridade sobre todos os demais artefatos.
Origem no `/speckit.constitution`; papel análogo ao CLAUDE.md; precedente conceitual em Constitutional
AI (Anthropic, 2022).

**Context engineering** `[D2]` — disciplina de curar e manter a informação disponível ao agente
durante a inferência. É o **transporte**; a intenção é a **carga**.

**Context rot** `[D0][D2]` — degradação de atenção e recall conforme a janela de contexto enche.
Janela maior não resolve.

**Contract-Driven Development (CDD)** `[D1]` — variante em que o contrato de interface (OpenAPI,
AsyncAPI) é o artefato central e executável: gera SDK, mock e teste de contrato.

**Criteria drift** `[D1]` — fenômeno em que critérios de avaliação só se tornam formuláveis após
observar saídas concretas, tornando-os dependentes da observação. Shankar et al., UIST 2024.

**Critério discriminante** ★ `[D5]` — critério de aceite falseável: existe pelo menos um resultado
plausível que ele **reprova**. Critério que qualquer entrega satisfaz não é critério.

**EARS / GEARS** `[D1]` — *Easy Approach to Requirements Syntax*. Seis tipos: Ubiquitous ("o sistema
deve…"), Event-Driven ("quando X, o sistema deve…"), State-Driven ("enquanto X…"), Optional ("onde a
feature X…"), Unwanted ("se X, então…"), Complex (combinações). Permite análise estática da spec —
detectar conflito lógico **antes** de gerar código.

**Elegance principle** `[D1]` — *"specs devem ser tão pequenas e elegantes quanto possível, contendo
só o necessário"*. `[CAMPO]` sdd-kit, com benchmarks: functional spec 1–2 páginas, technical 2–3,
tasks 0,5 — **4–6 páginas por feature, não 50**.

**Envelope de autonomia** ★ `[D4]` — declaração por tarefa do que o executor decide sozinho, do que
consulta antes e do que lhe é vedado.

**Fan-out** `[D4]` — distribuição de trabalho por muitas invocações paralelas (`claude -p` em laço,
com `--allowedTools` restrito).

**Greenfield / Brownfield / Reverse engineering** `[D3]` — três modos de projeto. O terceiro documenta
um codebase existente gerando specs retroativas.

**Guardrail** `[D4]` — mecanismo que valida saída, aplica segurança e mantém integridade do fluxo. A
maioria dos frameworks agênticos tem suporte apenas parcial (arXiv 2508.10146).

**Harness** `[D4]` — conjunto de verificações automáticas (teste, lint, typecheck, build, CI) que
restringe os erros do agente sem julgamento de LLM. *"O agente é um engenheiro capaz e cego ao
contexto; o harness é o ambiente de segurança."*

**Hook** `[D4]` — script executado em ponto determinístico do ciclo do agente. Diferença crítica:
instrução em CLAUDE.md é **advisory**; hook é **garantido**.

**MCP (Model Context Protocol)** `[D2]` — protocolo JSON-RPC para chamada de ferramenta e troca de
contexto, modelo cliente-servidor. Comparar com A2A (orientado a agente, Agent Cards), ACP (REST,
IBM), ANP (DIDs + JSON-LD), Agora (meta-camada com Protocol Documents).

**Memory bank** `[D2]` — termo de Böckeler para o contexto geral do codebase (rules, descrição do
produto), relevante em **todas** as sessões — por oposição à spec, relevante só na tarefa que cria ou
altera aquela funcionalidade. Kiro chama de *steering*; Spec Kit, de *constitution*.

**Memória (tipos)** `[D0]` — curto prazo (contexto imediato) · longo prazo (persiste entre sessões) ·
**semântica** (conceitos e fatos) · **procedimental** (fluxos e estratégias) · **episódica**
(instantâneos contextuais de interações passadas).

**Modo de execução** `[D3]` — `[CAMPO]` sdd-kit: **Express** (1 comando, 3–5 perguntas, auto-aprova) ×
**Standard** (4–5 comandos, entrevista, confirmações). Ortogonal ao **modo de template**: Full
(~1.100 linhas) × Lite (~80 linhas).

**Nível 1 / Nível 2** `[D1]` — Nível 1 (spec): intenção e contrato, **rígido**. Nível 2 (plan):
algoritmos, tipos internos, estrutura, **flexível**.

**PBT (property-based testing)** `[D5]` — teste que verifica uma afirmação universal gerando centenas
de entradas, com *shrinking* até o contra-exemplo mínimo. Três engrenagens: gerador, execução,
shrinking.

**Progressive disclosure** `[D2]` — carregar informação em estágios conforme necessário. No boot, só
metadados da skill; ao acionar, o SKILL.md; depois, referências sob demanda.

**Propriedade (PROP)** `[D5]` — invariante universal no formato *"Para qualquer `<espaço>` onde
`<pré-condição>`, então `<invariante>`"*. Se você não consegue preencher as três partes, não é
propriedade.

**Propriedade vermelha (quarentena)** ★ `[D5]` — `[CAMPO]` propriedade que codifica invariante ainda
não implementada: marcada como pendente (`@Tag("pbt-pending")` / `it.skip`) com link para a task que a
torna verde — **nunca afrouxada** até passar.

**Registro de interpretação** ★ `[D4]` — lista das lacunas que o executor precisou preencher e da
escolha feita. Filtro: *"outro executor competente poderia ter escolhido diferente?"*

**Skill (SKILL.md)** `[D2]` — pasta com instruções, scripts e recursos que o agente descobre e carrega
dinamicamente. Formato aberto desde dez/2025 (adotado também pela OpenAI). *Model-invoked* por
padrão; `disable-model-invocation: true` torna manual.

**Spec** `[D1]` — *"artefato estruturado, orientado a comportamento, escrito em linguagem natural, que
expressa funcionalidade de software e serve de guia a agentes"* (Böckeler).

**Spec-first / spec-anchored / spec-as-source** `[D1]` — três níveis de implementação de SDD:
a spec é escrita antes (todos fazem) · é mantida após a tarefa, para evolução (poucos) · é o **único**
arquivo editado pelo humano, que nunca toca o código (Tessl, experimental).

**Spec drift** `[D1]` — código muda, spec não. *"Se o código muda e a spec não, a confiança
colapsa."* Manter a spec atualizada faz parte do Definition of Done.

**Subagente** `[D2][D4]` — agente com janela de contexto e ferramentas próprias, invocado para tarefa
isolada; devolve o resumo sem o custo de contexto da investigação. Coordena **trabalho**; worktree
isola **arquivos** — eixos ortogonais. Detalhe em [sub-agents.md](sub-agents.md).

**TDAD (Test-Driven Agentic Development)** `[D5]` — o agente gera os testes de aceitação a partir da
spec **antes** de implementar; verde = task concluída.

**Validator independence** `[D5]` — *"você não pode validar seu próprio código no mesmo contexto"*.
Exige subagente ou sessão separada.

**Vibe coding** `[D1]` — descrever uma feature, aceitar o que voltar e publicar. O anti-padrão que o
SDD existe para substituir.

**Worktree** `[D4]` — checkout git isolado em branch própria, permitindo sessões paralelas sem
colisão de edições. Isola **arquivos**, não trabalho: coordenação é papel de subagente, agent team ou
workflow. Detalhe em [worktrees.md](worktrees.md).

---

**Anterior:** [01 — Ontologia](01-ontologia.md) · **Próximo:** [03 — Princípios](03-principios.md)
