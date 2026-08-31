# Times de agentes — contratos de fronteira, guardrails, aceitação e loops

> Pesquisa temática em fontes primárias, realizada em 2026-08-31 para fundamentar skills de
> orquestração e loop. Não é uma especificação de produto nem endosso de um framework.
> Selos: `[OFICIAL]` documentação ou código do fornecedor · `[ACADÊMICO]` paper/proposta de pesquisa
> · `[EXPERIMENTAL]` resultado empírico com escopo declarado · `[HIPÓTESE]` síntese normativa desta
> KB. Os selos não se misturam (ADR-010).

## 1. Resultado executivo

`[HIPÓTESE]` Um time de agentes confiável não é “vários prompts conversando”. É um sistema de
execução com cinco artefatos explícitos:

1. **manifesto do time** — meta comum, topologia, papéis e propriedade de estado;
2. **Boundary Contract por delegação** — entrada, saída, escopo, autoridade, evidência e estados;
3. **guardrails executáveis** — bloqueiam entradas, ações e saídas proibidas;
4. **aceitação independente** — decide por evidência se o estado final satisfaz a intenção;
5. **controlador de loop** — escolhe a próxima ação, persiste progresso e encerra por sucesso ou por
   um estado de não-sucesso explícito.

`[OFICIAL]` A Anthropic recomenda começar pela solução mais simples e adicionar agentes apenas quando
o ganho justificar custo e latência; AutoGen faz a mesma ressalva: times exigem mais *scaffolding* e
devem entrar depois de otimizar um agente único com ferramentas e instruções adequadas
([Anthropic, *Building effective agents*](https://www.anthropic.com/engineering/building-effective-agents),
[AutoGen, *Teams*](https://microsoft.github.io/autogen/stable/user-guide/agentchat-user-guide/tutorial/teams.html)).

`[EXPERIMENTAL]` No sistema de pesquisa da Anthropic, o arranjo Opus 4 + subagentes Sonnet 4 superou
o agente único em 90,2% numa avaliação **interna de pesquisa**, mas consumiu cerca de 15 vezes os
tokens de chat e foi considerado inadequado para domínios com muitas dependências ou necessidade de
contexto comum. Isso sustenta times para busca ampla e paralelizável; não prova superioridade geral
([Anthropic, *How we built our multi-agent research system*](https://www.anthropic.com/engineering/multi-agent-research-system)).

`[EXPERIMENTAL]` Em 2026, a Anthropic relatou um protótipo com 16 agentes, quase 2.000 sessões e um
repositório Git compartilhado para construir um compilador C. Cada agente clonava um workspace
isolado, adquiria um lock de tarefa, integrava mudanças e liberava o lock. A própria fonte o chama de
protótipo inicial, sem orquestrador ou protocolo rico, e atribui a utilidade do loop principalmente à
qualidade dos testes e do feedback; o custo ficou próximo de US$ 20 mil. É evidência de capacidade e
de padrões de coordenação, não uma receita de produção
([Anthropic, *Building a C compiler with a team of parallel Claudes*](https://www.anthropic.com/engineering/building-c-compiler)).

`[EXPERIMENTAL]` Outro harness da Anthropic separou planner, generator e evaluator e transformou
qualidade subjetiva em critérios graduáveis. O autor relata que o checker separado foi mais fácil de
tornar cético que a autoavaliação do gerador e que artefatos estruturados sustentaram sessões longas;
o harness completo, porém, foi mais de 20 vezes mais caro que o agente solo no exemplo publicado
([Anthropic, *Harness design for long-running application development*](https://www.anthropic.com/engineering/harness-design-long-running-apps)).

`[ACADÊMICO]` A análise MAST de 1.642 traces de sete sistemas encontrou 14 modos de falha agrupados em
especificação/desenho, desalinhamento entre agentes e verificação/término. Intervenções em prompt e
topologia reduziram falhas, mas não as eliminaram; verificação continuou sendo dificuldade transversal
([Cemri et al., *Why Do Multi-Agent LLM Systems Fail?*](https://arxiv.org/abs/2503.13657)).

## 2. Quando um time é a forma certa

`[HIPÓTESE]` Use time somente quando houver pelo menos um ganho estrutural verificável:

- subtarefas realmente independentes que podem executar em paralelo;
- especialidades, ferramentas ou permissões que devem ficar isoladas;
- contexto grande demais, comprimido por trabalhadores com janelas próprias;
- necessidade de separação entre *maker* e *checker*;
- roteamento entre domínios com responsabilidades distintas.

`[OFICIAL]` Esses critérios refletem a orientação convergente de OpenAI, Anthropic, LangChain e Google:
especialistas como ferramentas mantêm um gerente responsável pela resposta; *handoffs* transferem o
controle; paralelismo só cabe quando ramos não dependem uns dos outros; e fluxos determinísticos são
preferíveis quando a rota já é conhecida
([OpenAI Agents SDK, *Agent orchestration*](https://openai.github.io/openai-agents-js/guides/multi-agent/),
[LangChain, *Multi-agent*](https://docs.langchain.com/oss/python/langchain/multi-agent/index),
[Google ADK, *Parallel workflow*](https://adk.dev/agents/workflow-agents/parallel-agents/)).

`[HIPÓTESE]` Não use time quando um agente com ferramentas/skill resolve, quando todos precisam do
mesmo contexto mutável, quando a decomposição gera mais handoffs que trabalho útil ou quando “mais
agentes” é a única justificativa. O fallback é agente único + workflow determinístico + checks.

## 3. Topologias e critério de escolha

| Topologia | Controle | Melhor uso | Risco dominante | Fonte primária |
|---|---|---|---|---|
| Pipeline sequencial | código/arestas | dependências conhecidas | erro em cascata | `[OFICIAL]` [Anthropic](https://www.anthropic.com/engineering/building-effective-agents) |
| Fan-out/fan-in | orquestrador | ramos independentes, busca/votação | duplicação e conflito de merge | `[OFICIAL]` [Google ADK](https://adk.dev/agents/workflow-agents/parallel-agents/) |
| Router | classificador + sintetizador | verticais claras, uma ou várias rotas | classificação errada | `[OFICIAL]` [LangChain](https://docs.langchain.com/oss/python/langchain/multi-agent/router) |
| Supervisor / orchestrator-workers | agente líder | decomposição dinâmica | gargalo, microgestão, ponto único de falha | `[OFICIAL]` [OpenAI](https://openai.github.io/openai-agents-js/guides/multi-agent/), [Anthropic](https://www.anthropic.com/engineering/multi-agent-research-system) |
| Agentes como ferramentas | gerente retém controle | subtarefa limitada e resposta final única | gerente filtra/perde detalhe | `[OFICIAL]` [OpenAI](https://openai.github.io/openai-agents-js/guides/multi-agent/) |
| Handoff / swarm | especialista assume controle | conversa muda de domínio/estado | perda ou inchaço de contexto | `[OFICIAL]` [OpenAI](https://openai.github.io/openai-agents-js/guides/handoffs/), [LangChain](https://docs.langchain.com/oss/python/langchain/multi-agent/handoffs) |
| Group chat round-robin | turnos fixos | crítica/reflexão pequena | fala inútil, contexto crescente | `[OFICIAL]` [AutoGen](https://microsoft.github.io/autogen/stable/user-guide/agentchat-user-guide/tutorial/teams.html) |
| Group chat selector | modelo/função escolhe falante | colaboração dinâmica | seleção instável ou loop | `[OFICIAL]` [AutoGen source](https://github.com/microsoft/autogen/blob/main/python/packages/autogen-agentchat/src/autogen_agentchat/teams/_group_chat/_selector_group_chat.py) |
| Evaluator-optimizer | gerador ↔ verificador | critério claro e refinamento mensurável | autoaprovação, oscilação | `[OFICIAL]` [Anthropic](https://www.anthropic.com/engineering/building-effective-agents), [OpenAI](https://openai.github.io/openai-agents-js/guides/multi-agent/) |
| SOP / linha de montagem | artefatos e fases fixas | produto com etapas e outputs conhecidos | rigidez, verificação final fraca | `[ACADÊMICO]` [MetaGPT](https://arxiv.org/abs/2308.00352) |

`[HIPÓTESE]` Escolha topologia pelo fluxo de controle e dependências, não pelos cargos imaginados.
Misturas são legítimas: um supervisor pode abrir fan-out independente, consolidar e enviar a um
verificador; um especialista recebido por handoff pode chamar trabalhadores como ferramentas.

## 4. Prompt e escopo de cada papel

`[OFICIAL]` A experiência de produção da Anthropic identifica quatro elementos mínimos na delegação:
**objetivo, formato de saída, orientação sobre ferramentas/fontes e fronteiras claras**. Sem eles,
subagentes duplicaram trabalho, deixaram lacunas ou interpretaram períodos diferentes. A mesma fonte
recomenda calibrar número de agentes/chamadas à complexidade e persistir artefatos diretamente para
evitar o “telefone sem fio” do coordenador
([Anthropic, sistema de pesquisa, §§ prompt e appendix](https://www.anthropic.com/engineering/multi-agent-research-system)).

`[OFICIAL]` CrewAI formaliza parte da configuração como `role`, `goal`, `backstory`, `tools`, limites
de iteração/tempo e permissão de delegação; a task adiciona `description`, `expected_output`, contexto,
schema de saída e guardrail
([CrewAI, *Agents*](https://github.com/crewaiinc/crewai/blob/main/docs/en/concepts/agents.mdx),
[CrewAI, *Tasks*](https://github.com/crewAIInc/crewAI/blob/main/docs/edge/en/concepts/tasks.mdx)).

`[HIPÓTESE]` Para uma skill portável, “backstory” é opcional; contrato operacional é obrigatório. O
prompt de papel deve conter, nesta ordem:

```markdown
## Identidade e responsabilidade
Você é <papel>. Responde exclusivamente por <responsabilidade única>.

## Objetivo desta delegação
Produza <estado/artefato observável> para que <consumidor> possa <uso>.

## Entradas e precondições
- Entradas obrigatórias: <referências imutáveis>
- Se faltar: retorne BLOCKED(missing_inputs=[...]); não invente.

## Escopo
- IN: <ações/superfícies permitidas>
- OUT: <ações/superfícies proibidas>
- Não sobrescreva trabalho de outro agente; não expanda escopo.

## Ferramentas e autoridade
- Pode usar: <allowlist>
- Pode escrever em: <paths/recursos exclusivos>
- Exige aprovação antes de: <efeitos externos/destrutivos/sensíveis>

## Contrato de saída
- Schema/arquivo: <formato e destino>
- Evidência obrigatória: <checks, links, logs, hashes, diffs>
- Nunca declare sucesso sem evidência verificável.

## Aceitação e término
- ACCEPTED somente se: <critérios objetivos>
- Caso contrário: REWORK | BLOCKED | FAILED, com motivo e próximo passo.
- Orçamento: <turnos, tempo, tokens, tentativas>.
```

## 5. Boundary Contract

### 5.1 Status epistemológico do termo

`[HIPÓTESE]` **Boundary Contract não aparece como padrão normativo comum** nas principais docs
consultadas. Aqui ele nomeia a composição prática de elementos já separados em fontes primárias:
schemas e ciclo de task no A2A, inputs/outputs/limites de recursos em *Agent Contracts*, fronteiras de
delegação da Anthropic e guardrails de ferramenta da OpenAI/Google.

`[ACADÊMICO]` O preprint *Agent Contracts* propõe o contrato formal
`C=(I,O,S,R,T,Φ,Ψ)`, reunindo especificações de entrada/saída, recursos, limites temporais e critérios
de sucesso, além de leis de conservação para que delegações não excedam o orçamento do pai. É uma
proposta recente, não um padrão consolidado
([*Agent Contracts: A Formal Framework for Resource-Bounded Autonomous AI Systems*](https://arxiv.org/abs/2601.08815)).

`[OFICIAL]` O protocolo A2A fornece uma analogia interoperável: `AgentCard` anuncia identidade,
capacidades, skills e autenticação; `Task` tem ciclo de vida explícito; `Message` transporta conteúdo;
`Artifact` representa saída persistente; campos obrigatórios devem ser validados e mensagens para
tasks terminais são rejeitadas
([A2A Protocol Specification 1.0](https://github.com/a2aproject/A2A/blob/main/docs/specification.md)).

### 5.2 Contrato mínimo por fronteira

`[HIPÓTESE]` Cada spawn, handoff ou etapa deve materializar estes campos:

| Campo | Pergunta que fecha | Check mecânico preferido |
|---|---|---|
| `task_id`, `parent_id`, `attempt` | qual execução é esta? | IDs únicos e correlação |
| `objective` | qual mudança observável deve existir? | condição de estado |
| `inputs` + `preconditions` | de que parte e o que precisa ser verdade? | schema + existência/versionamento |
| `scope.in` / `scope.out` | o que pertence e não pertence ao papel? | allow/deny por recurso |
| `ownership` | quem pode escrever em cada superfície? | single-writer ou lock |
| `tools` / `authority` | o que pode ler, executar, delegar ou publicar? | allowlist + credencial mínima |
| `output` | qual artefato e schema serão entregues? | parser/schema |
| `evidence` | como provar cada afirmação de conclusão? | comandos, testes, estado externo |
| `acceptance` | quem aceita e por quais critérios? | grader independente |
| `budgets` | quanto pode gastar? | max turns/time/tokens/cost/spawns |
| `failure_policy` | o que retry, bloqueio e erro significam? | estados tipados + backoff |
| `terminal_states` | quando não executar mais? | máquina de estados |

`[HIPÓTESE]` Orçamento delegado nunca amplia autoridade: o filho recebe um subconjunto de ferramentas,
paths, efeitos e recursos do pai. O pai pode reduzir limites, nunca aumentá-los implicitamente.

## 6. Guardrails não são critérios de aceitação

`[OFICIAL]` No OpenAI Agents SDK há guardrails de entrada, saída e ferramenta. Os de entrada rodam só
no primeiro agente da cadeia, os de saída só no agente final e os de ferramenta em cada invocação da
função; portanto, confiar apenas nos guardrails do agente não protege automaticamente cada handoff.
Guardrail paralelo reduz latência, mas o modelo pode já ter gasto tokens ou chamado ferramentas antes
do bloqueio. E bloquear uma saída **não desfaz efeitos externos já realizados**
([OpenAI Agents SDK, *Guardrails*](https://openai.github.io/openai-agents-js/guides/guardrails/)).

`[OFICIAL]` Google recomenda defesa em camadas: identidade/autorização, ferramenta que exponha somente
ações permitidas, validação determinística no contexto da ferramenta, sandbox, avaliação/tracing e
controles de rede. Permissão de leitura no sistema externo impede escrita independentemente do que o
modelo decidir; isso é mais forte que uma proibição textual
([Google ADK, *Safety and Security*](https://adk.dev/safety/)).

`[OFICIAL]` A Anthropic descreve a contenção como limite de capacidade do ambiente, complementar à
supervisão probabilística do comportamento. As camadas incluem modelo, ambiente e conteúdo externo;
permissões granulares, sandbox, isolamento de filesystem/rede e controles de egress reduzem o raio de
impacto mesmo quando o agente interpreta mal a intenção. Em handoffs, a checagem precisa ocorrer na
saída e no retorno, pois o filho pode não enxergar a autorização original e pode ser comprometido por
conteúdo lido durante a tarefa
([Anthropic, *How we contain Claude across products*](https://www.anthropic.com/engineering/how-we-contain-claude),
[Anthropic, *Claude Code auto mode*](https://www.anthropic.com/engineering/claude-code-auto-mode)).

`[OFICIAL]` CrewAI permite guardrail por task, feedback do erro ao agente e número máximo de retries;
schemas Pydantic/JSON estruturam a saída. Esse retry limitado é um mecanismo de correção, não prova de
corretude
([CrewAI task docs/source](https://github.com/crewAIInc/crewAI/blob/main/docs/edge/en/concepts/tasks.mdx)).

`[HIPÓTESE]` Regra operacional:

- **guardrail** responde “esta ação/entrada/saída é admissível?”;
- **aceitação** responde “o resultado satisfaz a intenção e preserva regressões?”;
- **orçamento** responde “a execução ainda pode continuar?”;
- **aprovação humana** responde “esta autoridade pode ser exercida agora?”.

Nenhum substitui os outros. Proibições de alto risco devem existir no runtime/permissão, não só no
prompt.

## 7. Estado compartilhado, concorrência e handoff

`[OFICIAL]` No `ParallelAgent` do Google, os ramos não compartilham automaticamente histórico/estado
durante a execução e a ordem dos resultados pode ser não determinística. Compartilhamento precisa ser
explícito; se houver contexto comum, acesso concorrente deve ser protegido por locks ou movido para
banco/fila e consolidado depois
([Google ADK, *Parallel workflow*](https://adk.dev/agents/workflow-agents/parallel-agents/)).

`[OFICIAL]` LangGraph exige reducer para uma chave que recebe updates paralelos; sem regra de merge, a
atualização concorrente é rejeitada. Checkpoints persistem estado para retomar após interrupção/falha,
mas um nó retomado pode executar novamente desde o início — efeitos anteriores precisam tolerar
reexecução
([LangGraph, `INVALID_CONCURRENT_GRAPH_UPDATE`](https://docs.langchain.com/oss/python/langgraph/errors/INVALID_CONCURRENT_GRAPH_UPDATE),
[LangGraph, *Interrupts*](https://langchain-ai.github.io/langgraph/how-tos/human_in_the_loop/breakpoints/)).

`[OFICIAL]` Handoffs em subgrafos também exigem engenharia de contexto: a origem decide exatamente
quais mensagens passam, e uma chamada de ferramenta deve permanecer pareada com sua resposta para não
malformar o histórico do receptor
([LangChain, *Handoffs*](https://docs.langchain.com/oss/python/langchain/multi-agent/handoffs)).

`[HIPÓTESE]` Política segura para uma skill genérica:

- cada artefato mutável tem **um único escritor**; paralelos produzem artefatos separados;
- evidência é append-only e endereçada por `task_id/attempt`;
- merge ocorre numa etapa explícita, com schema/reducer e detecção de conflito;
- estado durável guarda fatos, decisões, versões e próximos passos, não transcripts inteiros;
- efeitos repetíveis usam chave de idempotência ou reconciliação de estado antes de retry;
- “mensagem não recebida” e timeout são `unknown/blocked`, nunca sucesso implícito.

## 8. O loop do time

`[OFICIAL]` OpenAI documenta o padrão gerador + avaliador num `while` até os critérios passarem;
Anthropic condiciona evaluator-optimizer a critérios claros e ganho mensurável; Google ADK alerta que
um `LoopAgent` não sabe sozinho quando parar e exige `max_iterations` e/ou sinal de término; AutoGen
oferece limites por mensagens, tokens, tempo, handoff, fonte ou sinal externo
([OpenAI](https://openai.github.io/openai-agents-js/guides/multi-agent/),
[Anthropic](https://www.anthropic.com/engineering/building-effective-agents),
[Google ADK](https://adk.dev/agents/workflow-agents/loop-agents/),
[AutoGen](https://microsoft.github.io/autogen/stable/user-guide/agentchat-user-guide/tutorial/termination.html)).

`[HIPÓTESE]` Máquina de estados mínima:

```text
READY -> RUNNING -> VERIFYING -> ACCEPTED
                    |             (único sucesso)
                    +-> REWORK -> RUNNING
                    +-> BLOCKED | STALLED | EXHAUSTED | FAILED
```

`[HIPÓTESE]` Uma volta canônica:

```text
reler contrato + estado durável
→ reconciliar artefatos/efeitos reais
→ medir baseline e critérios ainda falhos
→ escolher UM obstáculo de maior impacto
→ delegar tarefas independentes com Boundary Contracts
→ aguardar/juntar resultados válidos; rejeitar contrato quebrado
→ executar verificador independente + regressões
→ aceitar, pedir rework específico ou registrar não-sucesso
→ persistir evidência, custo, tentativas e próximo candidato
→ testar estado terminal e orçamento antes da próxima volta
```

`[HIPÓTESE]` Terminação robusta usa uma disjunção fechada:

```text
ACCEPTED
or BLOCKED(missing_authority | missing_input | external_dependency)
or STALLED(no_material_progress >= N | repeated_failure >= N | oscillation)
or EXHAUSTED(turns | time | tokens | cost | spawns)
or FAILED(unrecoverable_error | violated_invariant)
```

Somente `ACCEPTED` significa concluído. `max_turns`, timeout, erro de ferramenta, ausência de resposta,
guardrail indisponível e orçamento esgotado são não-sucesso. O OpenAI Agents SDK, por exemplo, levanta
exceções distintas para máximo de turnos, timeout, comportamento inválido e tripwire — não as trata
como resposta final bem-sucedida
([OpenAI Agents SDK, *Running agents*](https://openai.github.io/openai-agents-python/running_agents/)).

### 8.1 Detecção de estagnação

`[HIPÓTESE]` Progresso material precisa ser mensurável: critérios falhos diminuíram, nova evidência
válida surgiu, estado externo mudou ou risco foi removido. Pare como `STALLED` se ocorrer qualquer um:

- mesma causa de rejeição por `N` voltas sem nova evidência;
- hash/score/critério do artefato não melhora por `N` voltas;
- alternância A→B→A sem melhoria global;
- todos os candidatos restantes repetem tentativas já invalidadas;
- verificador e executor discordam sem informação nova disponível.

Ao parar, preserve último estado aceito, trace resumido, tentativas descartadas e a autoridade/entrada
necessária para destravar.

## 9. Aceitação e validação

`[OFICIAL]` A Anthropic define outcome como o estado real do ambiente, distinto da afirmação do agente.
Recomenda combinar graders de código, modelo e humano; preferir determinísticos quando possível;
escrever tarefas em que dois especialistas independentes cheguem ao mesmo veredito; manter solução de
referência que prove que a task e seus graders são válidos; isolar trials; e separar suites de
capacidade das de regressão
([Anthropic, *Demystifying evals for AI agents*](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents)).

`[OFICIAL]` SWE-bench Verified exemplifica aceitação de estado: aplica o patch e só considera resolvido
quando todos os testes `FAIL_TO_PASS` e `PASS_TO_PASS` passam. A própria curadoria classifica se os
testes cobrem soluções válidas, lembrando que um check também precisa ser validado
([OpenAI, *Introducing SWE-bench Verified*](https://openai.com/index/introducing-swe-bench-verified/)).

`[HIPÓTESE]` Ordem de força dos checks:

1. estado externo e teste determinístico;
2. schema, tipo, linter, política e invariantes;
3. teste de regressão e comparação com baseline;
4. rubrica congelada com juiz separado e opção `UNKNOWN`;
5. checkpoint humano para gosto, alto risco ou evidência insuficiente.

`[HIPÓTESE]` Acceptance do time deve exigir simultaneamente:

- todos os critérios do pedido mapeados a evidência;
- outputs dos contratos válidos e consumíveis;
- checks-alvo verdes e regressões protegidas;
- nenhum guardrail/invariante violado;
- nenhum trabalho obrigatório em estado não terminal;
- reconciliação do estado real, não apenas mensagens “done”;
- auditor diferente do executor quando o check não for determinístico.

Para comportamento probabilístico, uma passada isolada não mede confiabilidade. `[OFICIAL]` A
Anthropic distingue `pass@k` (ao menos um sucesso) de `pass^k` (todas as tentativas têm sucesso); use
`pass^k` quando consistência for requisito de produto
([Anthropic, evals, § non-determinism](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents)).

## 10. Falhas a cobrir por design

`[ACADÊMICO]` MAST fornece uma taxonomia empírica útil para testes negativos: especificação de tarefa
ou papel, repetição/perda de memória, conversa improdutiva, desconsideração de contribuições,
coordenação/consenso, terminação prematura, ausência de verificação e verificação incorreta. A
arquitetura altera o perfil de falhas; trocar somente o prompt não é correção universal
([paper](https://arxiv.org/abs/2503.13657),
[dataset/código](https://github.com/multi-agent-systems-failure-taxonomy/MAST)).

`[HIPÓTESE]` Matriz mínima de proteção:

| Falha | Proteção estrutural | Teste de aceitação |
|---|---|---|
| papéis sobrepostos | responsabilidade única + `scope.out` | detectar duplicação/conflito |
| lacuna entre papéis | cobertura requisito→owner | nenhum critério sem owner |
| delegação vaga | Boundary Contract validado antes do spawn | schema obrigatório |
| repetição | ledger de tentativas + stall detector | mesma hipótese não repete sem evidência |
| falsa conclusão | só verificador muda para `ACCEPTED` | claim “done” sem evidência falha |
| verificador enviesado | contexto separado + rubrica congelada | calibrar com referência/humano |
| corrida de escrita | single-writer ou reducer | conflito falha fechado |
| perda no handoff | artefato persistente + referência | receptor valida versão/schema |
| filho excede pai | orçamento/autoridade monotônicos | contrato rejeita ampliação |
| loop infinito | success + stall + hard caps | testar cada estado terminal |
| efeito duplicado no retry | idempotência/reconciliação | reinício não duplica efeito |
| aprovação ignorada | gate no runtime | ação sensível sem token não executa |

Os prompts operacionais, schemas e checklists derivados desta pesquisa vivem nas skills
[`agent-team`](../skills/agent-team/SKILL.md) e
[`agent-team-loop`](../skills/agent-team-loop/SKILL.md), evitando duplicação entre evidência e
procedimento executável.
