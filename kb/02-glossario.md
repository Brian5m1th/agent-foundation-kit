# 02 — Glossário

Definições formais. Cada verbete traz `[D#]` = disciplina de origem ([00](00-taxonomia.md)) e a fonte.
Termos com ★ são propostos por esta KB.

---

**Adaptador** `[D3]` — coisa concreta que satisfaz uma interface num *seam*. Descreve **papel** (que
encaixe preenche), não substância. Um adaptador indica seam hipotético; dois indicam seam real
(PLN-05).

**AAAK Dialect** `[D2]` — formato simbólico estruturado e denso (*Structured Symbolic Summary Format*) para camadas de índice de memória (*closets*), otimizado para varredura ultra-rápida por LLMs com baixíssimo consumo de tokens ([mempalace-memory-system.md](mempalace-memory-system.md)).


**Agente** `[D4]` — entidade autônoma que percebe, raciocina, usa ferramentas e age sobre um ambiente.
Definição moderna (arXiv 2508.10146): *"entidade autônoma e colaborativa, dotada de capacidades de
raciocínio e comunicação, capaz de interpretar dinamicamente contextos estruturados, orquestrar
ferramentas e adaptar comportamento por memória e interação em sistemas distribuídos"*.

**Agentic AI** `[D4]` — paradigma em que agentes baseados em LLM exibem autonomia dirigida a objetivo,
raciocínio contextual e coordenação multiagente dinâmica. Distingue-se do MAS clássico por usar o LLM
como **motor de raciocínio** em vez de regras ou BDI simbólico.

**AGENTS.md** `[D2]` — arquivo de contexto de projeto, agnóstico de fornecedor. Complementa o
CLAUDE.md: o portátil vive no AGENTS.md; o específico do harness, no CLAUDE.md.

**Alavancagem (leverage)** `[D3]` — comportamento que um chamador ou teste consegue exercitar por
unidade de interface que precisou aprender. É a medida operacional de profundidade de módulo (PLN-05).

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

**Fatia vertical / tracer bullet** `[D3]` — recorte **estreito mas completo** que atravessa todas as
camadas (schema, API, UI, teste), demonstrável ou verificável sozinho e que cabe numa janela de
contexto. Oposto do fatiamento horizontal ("todos os models, depois todos os controllers" — AP-11).

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

**Linguagem ubíqua** `[D2]` — vocabulário único compartilhado entre quem conhece o domínio, quem
escreve o código e o agente, de modo que conversa e código derivem do mesmo modelo (Evans). Mora num
glossário versionado do projeto (`CONTEXT.md`), **só termos, zero implementação** — CTX-06.

**Localidade** `[D3]` — grau em que mudança, defeito e conhecimento se concentram num lugar só, em vez
de se espalharem pelos chamadores. Contrapartida da alavancagem no julgamento de PLN-05.

**MCP (Model Context Protocol)** `[D2]` — protocolo JSON-RPC para chamada de ferramenta e troca de
contexto, modelo cliente-servidor. Comparar com A2A (orientado a agente, Agent Cards), ACP (REST,
IBM), ANP (DIDs + JSON-LD), Agora (meta-camada com Protocol Documents).

**Memory bank** `[D2]` — termo de Böckeler para o contexto geral do codebase (rules, descrição do
produto), relevante em **todas** as sessões — por oposição à spec, relevante só na tarefa que cria ou
altera aquela funcionalidade. Kiro chama de *steering*; Spec Kit, de *constitution*.

**Memória (tipos)** `[D0]` — curto prazo (contexto imediato) · longo prazo (persiste entre sessões) ·
**semântica** (conceitos e fatos) · **procedimental** (fluxos e estratégias) · **episódica**
(instantâneos contextuais de interações passadas).

**Method of Loci (Palácio da Memória)** `[D2]` — técnica de organização espacial de dados em *Wings* (alas de entidades/projetos), *Rooms* (quartos temporais) e *Drawers* (gavetas verbatim), utilizada para estruturar o armazenamento local de memória agêntica ([mempalace-memory-system.md](mempalace-memory-system.md)).


**Modo de execução** `[D3]` — `[CAMPO]` sdd-kit: **Express** (1 comando, 3–5 perguntas, auto-aprova) ×
**Standard** (4–5 comandos, entrevista, confirmações). Ortogonal ao **modo de template**: Full
(~1.100 linhas) × Lite (~80 linhas).

**Módulo profundo** `[D3]` — módulo cuja interface é pequena em relação ao comportamento que entrega.
*"Os melhores módulos são profundos: muita funcionalidade acessível por uma interface simples"*
(Ousterhout). Profundidade é propriedade **da interface**, não da implementação — PLN-05.

**Nível 1 / Nível 2** `[D1]` — Nível 1 (spec): intenção e contrato, **rígido**. Nível 2 (plan):
algoritmos, tipos internos, estrutura, **flexível**.

**Palavra-líder (leading word)** `[D2]` — termo que o modelo já compreende e que comprime um conceito
inteiro em um token, ancorando execução e invocação. Escolhê-la bem no início da `description` é onde
uma skill faz seu trabalho de acionamento.

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

**Seam (costura)** `[D3]` — lugar onde se pode alterar o comportamento **sem editar naquele lugar**
(Feathers); é onde a interface de um módulo vive, e por onde chamadores e testes passam igualmente.
Por isso *a interface é a superfície de teste* — PLN-05.

**Skill (SKILL.md)** `[D2]` — pasta com instruções, scripts e recursos que o agente descobre e carrega
dinamicamente. Formato aberto desde dez/2025 (adotado também pela OpenAI). *Model-invoked* por
padrão; `disable-model-invocation: true` torna manual.
Os dois modos têm papéis distintos: **model-invoked** guarda a **disciplina reutilizável** e custa
contexto (a `description` ocupa token em todo turno); **user-invoked** **orquestra** um fluxo e custa
carga cognitiva (você precisa lembrar que existe). Regra de composição: user-invoked pode invocar
model-invoked, **nunca outra user-invoked**.

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

**Teste da deleção** `[D3]` — critério para saber se um módulo se paga: apague-o mentalmente. Se a
complexidade desaparece, ele era passa-fio; se reaparece espalhada por N chamadores, ele concentrava
complexidade real e merece existir.

**Query Sanitization** `[D4]` — algoritmo de pré-processamento de strings de busca para isolar a intenção real e eliminar contaminações causadas por system prompts concatenados antes da geração de embeddings ([AP-47](05-antipadroes.md#ap-47-contaminação-de-query-por-system-prompt)).

**Validator independence** `[D5]` — *"você não pode validar seu próprio código no mesmo contexto"*.
Exige subagente ou sessão separada.

**Verbatim Storage** `[D2]` — armazenamento textual do histórico na sua forma original e exata, rejeitando paráfrases ou resumos destrutivos no nível do banco de dados base ([CTX-11](04-padroes.md#ctx-11-indexação-verbatim-com-camada-simbólica-palace--aaak-dialect)).

**Vibe coding** `[D1]` — descrever uma feature, aceitar o que voltar e publicar. O anti-padrão que o
SDD existe para substituir.

**Wake-up Stack (L0–L3)** `[D2]` — pipeline de inicialização de sessão que pré-carrega apenas as camadas de identidade (L0) e história essencial (L1 ~600–900t), adiando buscas profundas (L3) para quando forem estritamente necessárias ([CTX-10](04-padroes.md#ctx-10-arquitetura-de-memória-l0l3-memory-wake-up-stack)).

**Worktree** `[D4]` — checkout git isolado em branch própria, permitindo sessões paralelas sem
colisão de edições. Isola **arquivos**, não trabalho: coordenação é papel de subagente, agent team ou
workflow. Detalhe em [worktrees.md](worktrees.md).


---

**Anterior:** [01 — Ontologia](01-ontologia.md) · **Próximo:** [03 — Princípios](03-principios.md)
