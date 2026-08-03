# 04 — Catálogo de padrões

Formato GoF adaptado: **Contexto → Problema → Solução → Trade-offs → Padrões relacionados →
Anti-padrões que combate → Quando NÃO usar**. A última seção é a que separa catálogo de propaganda.

Índice por disciplina: **CTX** contexto · **INT** intenção · **PLN** planejamento ·
**EXE** execução · **VER** verificação · **LRN** aprendizado.

---

## CTX-01 · Camadas de Contexto

**Contexto.** Conhecimento de projeto que não cabe — nem deve caber — num arquivo só.
**Problema.** Arquivo único fica ou incompleto ou inchado; nos dois casos o agente ignora parte.
**Solução.** Hierarquia por especificidade: global (`~/.claude/CLAUDE.md`) → projeto (`./CLAUDE.md`)
→ módulo (`subdir/CLAUDE.md`, carregado **sob demanda** ao tocar aquele diretório) → sob demanda
(skill). Cada camada só contém o que é verdade naquele escopo.
**Trade-offs.** Descobribilidade × concisão. Fragmentar demais e ninguém sabe onde a regra mora.
**Relacionados.** CTX-02, CTX-03. **Combate.** AP-02 (CLAUDE.md Enciclopédia).
**Não usar quando.** Projeto de um módulo só — a hierarquia vira cerimônia.

## CTX-02 · Skill sob Demanda

**Contexto.** Conhecimento que vale às vezes: um domínio, um procedimento, uma convenção de área.
**Problema.** Se entra no CLAUDE.md, custa contexto em toda sessão inclusive quando é irrelevante.
**Solução.** `SKILL.md` com frontmatter (`name`, `description`). No boot só os metadados são
carregados; o corpo entra quando o agente julga relevante; `references/` só depois disso.
`disable-model-invocation: true` para fluxos com efeito colateral que devem ser disparados à mão.
**Trade-offs.** Custo zero quando não usada × acionamento **não garantido** (depende da `description`).
**Relacionados.** CTX-01, CTX-03. **Combate.** AP-02.
**Não usar quando.** A regra precisa valer **sempre** — aí é CLAUDE.md; ou precisa valer **sem
exceção** — aí é hook (EXE-02).

## CTX-03 · Delegação para Preservar Contexto

**Contexto.** Investigação que exige ler muitos arquivos.
**Problema.** A exploração consome a janela do orquestrador, degradando tudo o que vem depois.
**Solução.** Subagente em contexto próprio; volta só o resumo. *"use subagents to investigate X"*.
`[OFICIAL]` Contexto inicial do subagente: prompt próprio, hierarquia de CLAUDE.md e git status
(exceto Explore/Plan, que pulam os dois), sem ver histórico da conversa nem auto memory do principal —
para regra que precisa alcançá-lo mesmo assim, restate no prompt de delegação.
**Trade-offs.** Contexto preservado × o subagente não vê o que o principal viu (perda de coerência).
**Relacionados.** VER-01 (o mesmo mecanismo, outro fim). **Combate.** AP-05 (Exploração Infinita).
**Não usar quando.** Você já sabe qual arquivo ler — delegar uma leitura conhecida é puro overhead.
**Detalhe completo.** [sub-agents.md](sub-agents.md).

## CTX-04 · Orçamento de Contexto por Faixa

**Contexto.** Sessão longa com risco de estourar a janela no meio de trabalho crítico.
**Problema.** A degradação é gradual e silenciosa; quando se percebe, já custou.
**Solução.** `[CAMPO]` Faixas com ação obrigatória: 0–40% normal · 40–60% preferir subagente ·
60–80% **delegação obrigatória** · 80%+ compactar. Com custo estimado por operação.
**Trade-offs.** Disciplina × overhead de monitorar.
**Relacionados.** CTX-03. **Combate.** AP-04 (Sessão Entulhada).
**Não usar quando.** Tarefas curtas.

## CTX-05 · Fonte Única com Geração

**Contexto.** Vários harnesses de agente no mesmo repositório (`.claude/`, `.agents/`, `.opencode/`).
**Problema.** `[CAMPO]` Cópia manual diverge. Observado: *"as versões **não são idênticas**: ao editar
uma skill, propague para as três"* — instrução que garante divergência com o tempo.
**Solução.** Uma fonte canônica + script de instalação/geração para os demais destinos. A cópia é
artefato derivado e nunca é editada.
**Trade-offs.** Um passo de build × correção garantida.
**Relacionados.** LRN-02. **Combate.** AP-15 (Cópia Manual Multi-Harness).
**Não usar quando.** Um harness só.

---

## INT-01 · Constituição Executável

**Contexto.** Vários artefatos de intenção produzidos ao longo do tempo por pessoas e agentes.
**Problema.** Sem regra de precedência, cada conflito é renegociado por quem estiver mais perto.
**Solução.** Documento curto com autoridade declarada sobre os demais. Executor **para e reporta** ao
detectar conflito; nunca resolve.
**Trade-offs.** Estabilidade × capacidade de evoluir.
**Relacionados.** INT-02. **Combate.** AP-01 (Constituição Genérica).
**Teste de saúde.** Para cada artigo: *que decisão plausível e tentadora isto proíbe?* Sem resposta,
apague o artigo.
**Não usar quando.** Projeto curto, uma pessoa, escopo fechado.

## INT-02 · Especificação Hierárquica

**Contexto.** Agente capaz de escolher implementação, mas não autorizado a escolher comportamento.
**Problema.** Spec detalhada demais vira "programar em inglês"; vaga demais vira alucinação.
**Solução.** Nível 1 (intenção + contrato) rígido e inegociável; Nível 2 (algoritmo, tipos internos,
pastas) livre. O agente é avaliado pelo Nível 1.
**Trade-offs.** Aproveita a inteligência do modelo × a fronteira entre níveis é difícil de manter.
**Relacionados.** INT-05, PLN-01. **Combate.** AP-06 (Pseudocódigo em Prosa).
**Não usar quando.** O contrato só é conhecível depois de tentar.

## INT-03 · Requisito EARS

**Contexto.** Requisitos em prosa que admitem mais de uma leitura.
**Problema.** Ambiguidade sintática impede tanto o humano quanto a análise estática.
**Solução.** Classificar cada requisito num dos seis tipos e escrever na sintaxe correspondente. Isso
habilita detecção de conflito lógico **antes** de gerar código.
**Trade-offs.** Precisão × rigidez de redação.
**Relacionados.** INT-04, VER-03. **Combate.** AP-07 (Critério Vago).
**Não usar quando.** Discovery exploratório, antes de existir requisito.

## INT-04 · Derivação Propriedade ↔ Critério

**Contexto.** Spec com requisitos EARS classificados.
**Problema.** Nem todo requisito merece o mesmo tipo de verificação, e escolher por intuição
desperdiça esforço nos dois sentidos.
**Solução.** `[CAMPO]` Regra de derivação: **Ubiquitous** e **State-Driven** → candidatos naturais a
`PROP` (teste por propriedade). **Event-Driven** e **Unwanted** → critério de aceite Given/When/Then.
Se um Ubiquitous **não** virar PROP, registre o motivo na própria spec (depende de serviço externo,
não-determinístico, é sobre UI, espaço não gerável).
**Trade-offs.** Cobertura forte de invariante × custo de gerador.
**Relacionados.** VER-03. **Combate.** AP-08 (Três Exemplos para uma Regra Universal).
**Teste de bolso.** Se o requisito contém *sempre, nunca, qualquer, todo, independente de, em qualquer
ordem* — é propriedade, e provar com três exemplos é fingir.
**Não usar quando.** O requisito é sobre um caso específico.

## INT-05 · Calibração por Porte

**Contexto.** Mudanças de tamanhos radicalmente diferentes no mesmo repositório.
**Problema.** Um workflow único é marreta para uns e frouxo para outros — refutado independentemente
por Böckeler, pelo modo Lite do sdd-kit e pela SDD V5.
**Solução.** Três pesos. `[CAMPO]` Bug/hotfix (<1 dia) → **Lightweight** (contexto, RF em EARS,
critérios). Feature média (1–3 dias) → **Standard** (+ fluxos, regras, fora de escopo). Módulo novo
(>3 dias) → **Full** (todas as seções).
**Trade-offs.** Adequação × necessidade de julgar o porte antes de começar.
**Relacionados.** PLN-03. **Combate.** AP-03 (Marreta na Noz).
**Regra de ouro.** *"O peso do processo deve ser proporcional ao tamanho da mudança."*
**Não usar quando.** Nunca — este é o padrão de maior consenso de todo o corpus.

## INT-06 · Entrevista Antes da Spec

**Contexto.** Feature grande cuja intenção o próprio solicitante ainda não articulou.
**Problema.** Spec escrita a partir de um pedido de duas frases herda todas as lacunas do pedido.
**Solução.** `[OFICIAL]` O agente entrevista com `AskUserQuestion` — implementação, UI/UX, casos de
borda, preocupações e trade-offs, **evitando perguntas óbvias e cavando as partes difíceis** — até
cobrir tudo, e só então escreve a spec. Em seguida, **sessão nova** para executar.
**Trade-offs.** Qualidade da spec × tempo do humano no início.
**Relacionados.** INT-07, CTX-03.
**Não usar quando.** O escopo já está claro (aí é sledgehammer).

## INT-07 · Protocolo de Pergunta Inteligente

**Contexto.** Agente que precisa de informação faltante.
**Problema.** Os dois extremos falham: assumir em silêncio, e bombardear com perguntas triviais.
**Solução.** `[CAMPO]` Árvore de decisão antes de perguntar: *está no prompt do usuário?* → infira ·
*é prática padrão?* → use o default · *está no código?* → busque primeiro · **é específico do
negócio?** → só então pergunte. Com listas explícitas de *nunca perguntar* (nome de branch, estrutura
de pastas, framework de teste) e *sempre perguntar* (protótipo ou produção? critério de aceite de
negócio? SLA?).
**Trade-offs.** Menos atrito × risco de inferir errado.
**Relacionados.** INT-06. **Combate.** AP-09 (Interrogatório).
**Não usar quando.** Domínio onde inferir errado é caro — aí pergunte mesmo o inferível.

---

## PLN-01 · Contrato Antes de Código

**Contexto.** Executor com liberdade de implementação.
**Problema.** Interfaces inventadas durante a execução divergem entre módulos e entre iterações.
**Solução.** Assinaturas, schemas, formatos de erro e eventos fixados no plan **antes** de qualquer
código. Executor que descobre o contrato inviável **para e reporta**.
**Trade-offs.** Estabilidade × descoberta tardia de inadequação.
**Relacionados.** INT-02, PLN-02. **Combate.** AP-10 (Contrato Emergente).
**Extensão.** Em sistemas distribuídos: OpenAPI/AsyncAPI gerados **antes** do backend, e daí SDKs,
mocks e testes de contrato automaticamente.

## PLN-02 · Decomposição por História, não por Camada

**Contexto.** Plano aprovado a ser decomposto em tasks.
**Problema.** Agrupar por camada ("todos os models, depois todos os controllers") impede entregar
qualquer coisa antes do fim.
**Solução.** `[INDÚSTRIA]` Fases: Setup → **Fundação (portão rígido)** → US1 (MVP) → US2 → …
→ Acabamento. Cada história é entregável e testável isoladamente. Só entra na Fundação o que bloqueia
*todas* as histórias.
**Trade-offs.** Entregabilidade incremental × alguma repetição entre histórias.
**Relacionados.** PLN-03, PLN-04. **Combate.** AP-11 (Big Bang de Camadas).

## PLN-03 · Task Verificável e Atômica

**Contexto.** Lista de tasks a executar por agente.
**Problema.** Task sem critério é "pronta" quando alguém decide que é.
**Solução.** Cada task declara: arquivos afetados · como verificar (comando ou checagem de uma linha)
· o que cobre (RF/SC) · dependências. `[CAMPO]` No formato JSON: `depends_on`, `acceptance_criteria`
(mín. 2), `files_affected`, `tests_required`, `phase`, `status`.
**Trade-offs.** Rastreabilidade × verbosidade.
**Relacionados.** VER-02, PLN-04. **Combate.** AP-12 (Task sem Critério), AP-13 (Task Gigante).
**Regra.** Task maior que 1–2 dias é quebrada. Prefira 12 tasks nítidas a 4 vagas.

## PLN-04 · Paralelismo por Disjunção de Arquivos

**Contexto.** Tasks que poderiam rodar ao mesmo tempo.
**Problema.** Paralelizar tasks que tocam o mesmo arquivo produz conflito silencioso.
**Solução.** Marcar `[P]` **apenas** quando os arquivos são disjuntos e não há dependência. Para
sessões humanas paralelas, worktrees isolam os checkouts. `[OFICIAL]` Quando o isolamento **não** está
disponível — agent teams não colocam os companheiros em worktree — a disjunção deixa de ser otimização
e vira pré-condição: particione por arquivo antes de distribuir.
**Trade-offs.** Velocidade × coordenação.
**Relacionados.** EXE-05, [worktrees.md](worktrees.md).

---

## EXE-01 · Explore → Plan → Implement → Commit

**Contexto.** Mudança cuja abordagem não é óbvia.
**Problema.** Ir direto ao código produz código que resolve o problema errado.
**Solução.** `[OFICIAL]` Quatro fases com plan mode separando exploração de execução; `Ctrl+G` abre o
plano no editor para o humano ajustar antes de aprovar.
**Trade-offs.** Qualidade × overhead real.
**Relacionados.** INT-05, EXE-04. **Combate.** AP-16 (Direto ao Código).
**Não usar quando.** *"Se você consegue descrever o diff em uma frase, pule o plano."*

## EXE-02 · Hook em vez de Instrução

**Contexto.** Regra que precisa valer sem exceção.
**Problema.** Instrução em CLAUDE.md é advisory: o agente pode ignorá-la, e ignora.
**Solução.** Script determinístico no evento correspondente. Stop hook bloqueia o fim do turno até a
checagem passar.
**Trade-offs.** Garantia × rigidez (e o Claude Code sobrepõe o Stop hook após 8 bloqueios seguidos).
**Relacionados.** EXE-03. **Combate.** AP-02.
**Regra de conversão.** *"Se o agente já faz certo sem a instrução, apague-a — ou converta-a em hook."*

## EXE-03 · Harness Engineering

**Contexto.** Agente escrevendo código em volume.
**Problema.** Revisão humana não escala com o volume gerado.
**Solução.** Envolver o agente num ambiente que reprova automaticamente: testes, lint, typecheck,
build, CI. `[CAMPO]` Nenhuma task fecha sem passar no harness relevante. Regra de arquitetura vira
**teste** (ex.: falha se o núcleo de domínio importar Spring, AWS ou Lombok).
**Trade-offs.** Cobre o mecânico × não cobre "é isto que o usuário queria".
**Relacionados.** EXE-02, VER-01. **Combate.** AP-17 (Confiança sem Verificação).

## EXE-04 · Envelope de Autonomia

**Contexto.** Delegação de tarefas com riscos heterogêneos.
**Problema.** Autonomia tratada como configuração global do sistema.
**Solução.** Três campos por tarefa: **decide sozinho** / **consulta antes** / **vedado**. Default por
classe de tarefa; declaração explícita só no desvio. `[CAMPO]` Operação destrutiva exige aprovação
humana **mesmo em modo auto-aprovar**, com o diálogo explicando o que será afetado.
**Trade-offs.** Segurança × burocracia.
**Relacionados.** EXE-05. **Combate.** AP-18 (Delegação em Branco).

## EXE-05 · Isolamento por Worktree

**Contexto.** Várias frentes de trabalho simultâneas **que escrevem nos mesmos arquivos**.
**Problema.** Edições concorrentes colidem e o histórico fica ilegível.
**Solução.** `[CAMPO]` Worktree dedicado por sessão, em branch nomeada pelo assunto
(`spec/SPEC-NNN-slug` ou `<tipo>/<tema>`), com **commit por task concluída** — nunca um commit único
no fim. `[OFICIAL]` No Claude Code: `claude --worktree <nome>` cria em `.claude/worktrees/<nome>/` na
branch `worktree-<nome>`; `isolation: worktree` no frontmatter isola um subagente; `.worktreeinclude`
carrega os gitignorados (`.env`) para dentro; um sweep periódico limpa worktrees de subagente, **nunca
os criados por `--worktree`**.
**Trade-offs.** Isolamento de **arquivo** × custo de setup do **ambiente** (deps, `.env`, portas,
banco) — e worktree não isola runtime: duas sessões na mesma porta continuam colidindo.
**Relacionados.** PLN-04, EXE-04, VER-01. **Detalhe completo.** [worktrees.md](worktrees.md).
**Não usar quando.** A tarefa só lê; nenhuma outra frente escreve ao mesmo tempo; os conjuntos de
arquivos já são disjuntos; ou o setup do ambiente custa mais que o conflito que se evita.

## EXE-06 · Registro de Interpretação

**Contexto.** Executor interpretativo preenchendo lacunas inevitáveis.
**Problema.** As interpretações somem dentro do resultado; a divergência só aparece na consequência.
**Solução.** Lista curta junto à entrega, com a lacuna e a escolha. Filtro: *"outro executor competente
poderia ter escolhido diferente?"*
**Trade-offs.** Visibilidade × ruído.
**Relacionados.** INT-04. **Combate.** AP-19 (Ambiguidade Silenciosa).

---

## VER-01 · Verificador Independente (Writer/Critic)

**Contexto.** Entrega produzida por um executor.
**Problema.** Auto-verificação converge para confirmação: quem decidiu sabe racionalizar a falha.
**Solução.** Verificação em contexto separado (subagente ou sessão nova), com postura de refutar e
evidência citável. `[CAMPO]` Com veredito tipado — `APPROVED` / `CAN_PROCEED_WITH_WARNINGS` /
`CANNOT_PROCEED` — e proibição explícita de sobrepor um `CANNOT_PROCEED`.
**Trade-offs.** Rigor × custo, e risco de over-engineering (ver VER-05).
**Relacionados.** CTX-03, VER-05. **Combate.** AP-20 (Auto-validação).

## VER-02 · Análise Cruzada de Artefatos

**Contexto.** Constitution, spec, plan e tasks prontos, código ainda não escrito.
**Problema.** Incoerência entre artefatos vira defeito caro depois de implementada.
**Solução.** Auditoria **artefato contra artefato** antes do código: cobertura descendente (meta →
requisito → task), cobertura ascendente (**task órfã = escopo ampliado**), contradições, conformidade
com a constitution, vazamento de tecnologia para dentro da spec.
**Trade-offs.** Pega defeito na fase mais barata × mais um passo.
**Relacionados.** VER-01. **Combate.** AP-21 (Drift entre Camadas).

## VER-03 · Propriedade Quarentenada

**Contexto.** Propriedade que codifica invariante ainda não implementada.
**Problema.** As duas saídas naturais são ruins: apagar a propriedade, ou afrouxá-la até passar.
**Solução.** `[CAMPO]` Marcar como pendente (`@Tag("pbt-pending")` / `it.skip`) **com link para a task
que a torna verde**. O build padrão exclui as pendentes; um comando roda tudo.
**Trade-offs.** Honestidade × build "verde" que não cobre tudo.
**Relacionados.** INT-04. **Combate.** AP-22 (Propriedade Afrouxada).

## VER-04 · Falha Forçada

**Contexto.** Teste ou propriedade recém-escrita.
**Problema.** Teste mal escrito — gerador vazio, asserção tautológica, pré-condição que descarta tudo
— passa alegremente para sempre.
**Solução.** `[CAMPO]` Inverter deliberadamente uma comparação no código de produção, rodar, exibir o
contra-exemplo mínimo produzido pelo shrinking, e reverter. *"Uma propriedade que nunca foi vista
falhando não foi verificada."*
**Trade-offs.** Um passo a mais × é o **único** passo que prova que a verificação mede algo.
**Relacionados.** VER-03. **Combate.** AP-23 (Teste Decorativo).

## VER-05 · Achado Proporcional

**Contexto.** Revisão adversarial rodando.
**Problema.** `[OFICIAL]` *"Um revisor instruído a achar lacunas normalmente reporta alguma, mesmo
quando o trabalho está correto."* Perseguir tudo produz abstração extra, código defensivo e testes
para casos impossíveis.
**Solução.** Instruir o revisor a sinalizar **só** o que afeta correção ou requisito declarado; o
resto é opcional e marcado como tal.
**Trade-offs.** Evita over-engineering × pode deixar passar melhoria legítima.
**Relacionados.** VER-01. **Combate.** AP-24 (Over-engineering por Revisão).

---

## LRN-01 · Lições Aprendidas Consumíveis

**Contexto.** Erros que se repetem entre execuções e entre features.
**Problema.** O conhecimento fica no PR e morre.
**Solução.** `[INDÚSTRIA]` Arquivo de lições que o agente **escreve e lê**: registre erro e correção;
antes de corrigir qualquer erro, consulte se já sabe como corrigi-lo. Laço fechado dentro da execução.
**Trade-offs.** Compostos ao longo do tempo × problema de Grudin (quem captura não colhe).
**Relacionados.** LRN-02. **Combate.** AP-25 (Erro Recorrente).

## LRN-02 · Promoção Falha → Padrão → Pergunta de Revisão

**Contexto.** Auditoria ou incidente que expôs uma classe de falha.
**Problema.** A correção pontual não impede a próxima ocorrência em outro lugar.
**Solução.** `[CAMPO]` — o padrão mais bem executado deste corpus. Cada falha real vira um padrão
numerado com evidência arquivada, e o conjunto de padrões vira uma **lista de perguntas de revisão**
reutilizável (18 perguntas cobrindo P_Novo4–P_Novo21). Falha → padrão → pergunta → prevenção.
**Trade-offs.** Alto valor composto × exige disciplina de registro no momento em que dói.
**Relacionados.** LRN-01, VER-01.
**Não usar quando.** A falha foi genuinamente única e não generalizável — registre como nota, não
como padrão.

---

## Índice cruzado

| Padrão | Disciplina | Princípio | Combate |
|---|---|---|---|
| CTX-01 Camadas | D2 | P06 | AP-02 |
| CTX-02 Skill sob demanda | D2 | P07 | AP-02 |
| CTX-03 Delegação | D2 | P05 | AP-05 |
| CTX-04 Orçamento | D2 | P05 | AP-04 |
| CTX-05 Fonte única | D2 | P06 | AP-15 |
| INT-01 Constituição | D1 | — | AP-01 |
| INT-02 Hierárquica | D1 | P02 | AP-06 |
| INT-03 EARS | D1 | P01 | AP-07 |
| INT-04 PROP↔AC | D1/D5 | P01 | AP-08 |
| INT-05 Calibração | D1 | P01/P03 | AP-03 |
| INT-06 Entrevista | D1 | P03 | — |
| INT-07 Pergunta inteligente | D1 | P04 | AP-09 |
| PLN-01 Contrato antes | D3 | P02 | AP-10 |
| PLN-02 Por história | D3 | P08 | AP-11 |
| PLN-03 Task verificável | D3 | P08 | AP-12/13 |
| PLN-04 Disjunção | D3 | P08 | — |
| EXE-01 Explore→Plan | D4 | P01 | AP-16 |
| EXE-02 Hook | D4 | P11 | AP-02 |
| EXE-03 Harness | D4 | P11 | AP-17 |
| EXE-04 Envelope | D4 | P10 | AP-18 |
| EXE-05 Worktree | D4 | P10 | — |
| EXE-06 Interpretação | D4 | P04 | AP-19 |
| VER-01 Independente | D5 | P12 | AP-20 |
| VER-02 Cruzada | D5 | P09 | AP-21 |
| VER-03 Quarentena | D5 | P13 | AP-22 |
| VER-04 Falha forçada | D5 | P13 | AP-23 |
| VER-05 Proporcional | D5 | P13 | AP-24 |
| LRN-01 Lições | D6 | P14 | AP-25 |
| LRN-02 Promoção | D6 | P14 | AP-25 |

---

**Anterior:** [03 — Princípios](03-principios.md) · **Próximo:** [05 — Anti-padrões](05-antipadroes.md)
