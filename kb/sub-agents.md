# Subagentes — coordenação de trabalho em contexto isolado

> Fonte: [Create custom subagents](https://code.claude.com/docs/en/sub-agents). Lida em 2026-08-02.
> Complementa [Run agents in parallel](https://code.claude.com/docs/en/agents) e
> [Hooks](https://code.claude.com/docs/en/hooks) (`SubagentStart`/`SubagentStop`).
> Selos: `[OFICIAL]` documentação Anthropic · `[CAMPO]` observado nos projetos do usuário ·
> `[HIPÓTESE]` proposta desta KB.

Complementa [worktrees.md](worktrees.md): subagente coordena **trabalho**; worktree isola
**arquivos**. Um subagente que edita em paralelo com o principal normalmente precisa dos dois.

## 1. O que um subagente é

`[OFICIAL]` Assistente especializado que roda numa **janela de contexto própria**, com prompt de
sistema, ferramentas e permissões independentes. Use um quando uma tarefa lateral inundaria a
conversa principal com resultado de busca, log ou conteúdo de arquivo que você não vai reler — o
subagente faz o trabalho no contexto dele e devolve só o resumo. Vale a pena **definir** um
customizado quando você fica gerando o mesmo tipo de trabalhador com as mesmas instruções.

Quatro ganhos nomeados pela doc: preservar contexto, impor restrição de ferramenta, reusar
configuração entre projetos (subagente de usuário), e **controlar custo** roteando para modelo mais
barato (Haiku).

Claude decide delegar cruzando a `description` do subagente com o pedido e o contexto atual —
escreva a descrição pensando em quando delegar, não no que o subagente faz.

## 2. Subagentes embutidos

`[OFICIAL]`

| Agente | Modelo | Ferramentas | Propósito |
|---|---|---|---|
| **Explore** | herda da conversa principal, teto Opus na Claude API | só leitura; Write/Edit negados | busca e análise de código sem alterar nada |
| **Plan** | herda | só leitura; Write/Edit negados | pesquisa de codebase durante plan mode |
| **general-purpose** | herda | toda ferramenta disponível a subagente | pesquisa complexa, passos múltiplos, modificação |
| statusline-setup | Sonnet | — | configurar status line via `/statusline` |
| claude-code-guide | Haiku | — | perguntas sobre o próprio Claude Code |
| claude | herda | — | sessão em background despachada sem nome de agente |

**Explore e Plan são os únicos que pulam CLAUDE.md e o git status da sessão principal** — mantêm a
pesquisa rápida e barata. Todo outro embutido e todo customizado carrega os dois (§7). Um subagente
de projeto/usuário chamado `Explore` sobrescreve o embutido e mantém seu próprio `model` — defina
`model: haiku` para manter exploração em modelo mais barato.

Para restringir: negar tipo específico via `permissions.deny: ["Agent(Explore)"]`; negar a ferramenta
`Agent` inteira impede toda delegação; `CLAUDE_CODE_DISABLE_EXPLORE_PLAN_AGENTS=1` remove só
Explore/Plan (Claude lê direto); `CLAUDE_AGENT_SDK_DISABLE_BUILTIN_AGENTS=1` remove todos os
embutidos em modo não-interativo/SDK.

## 3. Onde o arquivo mora, e quem ganha quando colide

`[OFICIAL]` Prioridade decrescente quando dois subagentes têm o mesmo `name`:

| Local | Escopo | Prioridade |
|---|---|---|
| Managed settings | organização inteira | 1 (mais alta) |
| flag `--agents` | sessão atual, só JSON, não persiste | 2 |
| `.claude/agents/` | projeto atual | 3 |
| `~/.claude/agents/` | todos os seus projetos | 4 |
| `agents/` de plugin | onde o plugin está ativo | 5 (mais baixa) |

`.claude/agents/` de projeto é descoberto **subindo** do diretório de trabalho até a raiz do repo —
cada nível é escaneado, e o mais próximo do diretório de trabalho vence em caso de nome repetido
entre níveis (v2.1.178+). Dentro do **mesmo** diretório, dois arquivos com o mesmo `name` — a escolha
não é documentada, é ordem de leitura do filesystem; `/doctor` (v2.1.205+) relata a colisão e propõe
renomear. Diretório de plugin, ao contrário de projeto/usuário, incorpora o subdiretório no
identificador com escopo: `agents/review/security.md` do plugin `my-plugin` registra como
`my-plugin:review:security`.

Definição em qualquer um desses escopos também alimenta [agent teams](https://code.claude.com/docs/en/agent-teams):
ao criar um companheiro, você pode referenciar um `agent_type` e o companheiro herda `tools` e
`model`, com o corpo do arquivo anexado ao prompt de sistema dele.

## 4. Campos do frontmatter

`[OFICIAL]` Arquivo markdown com YAML no topo; só `name` e `description` são obrigatórios. O corpo
vira o prompt de sistema — o subagente recebe **só** isso mais detalhes básicos de ambiente, nunca o
prompt de sistema completo do Claude Code.

| Campo | Obrigatório | O que faz |
|---|---|---|
| `name` | sim | identificador único, minúsculas e hífen; não pode conter `:` (v2.1.218+, reservado a plugin) |
| `description` | sim | quando delegar — é o que Claude lê para decidir |
| `tools` | não | lista-permissão; herda tudo disponível a subagente se omitido |
| `disallowedTools` | não | lista-negação sobre o que foi herdado ou listado |
| `model` | não | `sonnet`\|`opus`\|`haiku`\|`fable`\|ID completo\|`inherit` (default) |
| `permissionMode` | não | `default`\|`acceptEdits`\|`auto`\|`dontAsk`\|`bypassPermissions`\|`plan`\|`manual` (alias de `default`, 2.1.200+) |
| `maxTurns` | não | teto de turnos agentic |
| `skills` | não | conteúdo **completo** da skill pré-carregado no contexto — não é a lista do que ele *pode* invocar |
| `mcpServers` | não | servidores MCP só deste subagente; string referencia já-configurado, objeto define inline |
| `hooks` | não | hooks de ciclo de vida escopados a este subagente |
| `memory` | não | `user`\|`project`\|`local` — memória persistente entre sessões |
| `background` | não | `true` força background sempre; sem definir, Claude escolhe (default background desde 2.1.198) |
| `effort` | não | `low`\|`medium`\|`high`\|`xhigh`\|`max`, sobrescreve o esforço da sessão |
| `isolation` | não | `worktree` — ver [worktrees.md §4](worktrees.md#4-isolamento-de-subagentes) |
| `color` | não | cor de exibição: red, blue, green, yellow, purple, orange, pink, cyan |
| `initialPrompt` | não | primeiro turno automático quando este agente roda como sessão principal via `--agent` |

`tools`/`disallowedTools` aceitam padrão de servidor MCP inteiro: `mcp__<server>` ou
`mcp__<server>__*`; em `disallowedTools`, `mcp__*` remove todo MCP. Quando os dois campos são usados
juntos, `disallowedTools` aplica primeiro, `tools` resolve sobre o que sobrou.

**Skill não preloadável:** skill com `disable-model-invocation: true` — incluindo `/verify` e
`/code-review` embutidas (v2.1.215+) — não entra em `skills`, porque preload usa o mesmo conjunto que
Claude pode invocar sozinho.

## 5. Ferramentas — o que chega ao subagente de fato

`[OFICIAL]` Dois filtros, aplicados nessa ordem, além do que `tools`/`disallowedTools` já cortou:

1. **Sempre removidas**, mesmo se listadas explicitamente: `Agent` (no limite de profundidade),
   `AskUserQuestion`, `EndConversation`, `EnterPlanMode`, `ExitPlanMode` (a menos que
   `permissionMode: plan`), `ScheduleWakeup`, `TaskOutput`, `WaitForMcpServers`, `Workflow`.
2. **Só em background** (default desde v2.1.198): mantém todo MCP, mas dos embutidos só
   `Read, Grep, Glob, Bash, PowerShell, Edit, Write, NotebookEdit, WebFetch, WebSearch, TodoWrite,
   Skill, ToolSearch, EnterWorktree, ExitWorktree, Monitor, TaskStop, SendMessage, Artifact`. Um
   subagente em foreground e o mesmo em background podem resolver ferramentas diferentes a partir da
   **mesma** definição.

Fork pula os dois filtros e recebe o pool exato da conversa principal. Companheiro de agent team
mantém adicionalmente as ferramentas de task e cron.

**Zero ferramentas resolvidas = falha ao lançar** (v2.1.208+; antes disso lançava sem ferramenta
nenhuma e podia devolver resultado vazio ou confuso).

### Restringir quem um agente pode spawnar

`Agent(worker, researcher)` no `tools` de um agente rodando como thread principal (`--agent`) é
lista-permissão: só esses tipos podem ser spawnados. Dentro de uma **definição de subagente**, listar
`Agent` habilita spawn de subagentes próprios (respeitando o limite de profundidade), mas qualquer
lista entre parênteses ali é ignorada.

## 6. Permissão

`[OFICIAL]` `permissionMode` do subagente pode ser sobrescrito, **exceto** quando o modo do pai
prevalece: pai em `bypassPermissions` ou `acceptEdits` tem precedência e não pode ser sobrescrito; pai
em `auto` faz o subagente herdar `auto` e ignorar o `permissionMode` do frontmatter — o classificador
avalia com as mesmas regras do pai.

⚠️ `bypassPermissions` pula prompt inclusive para escrita em `.git`, `.claude`, `.vscode`, `.idea`,
`.husky`, `.cargo`, `.devcontainer`, `.yarn`, `.mvn` — mas **não** pula regra `ask` explícita, MCP
`requiresUserInteraction`, nem remoção de raiz/home.

## 7. O que carrega no início — e o que nunca chega

`[OFICIAL]` Subagente não-fork começa com contexto **fresco**: não vê a conversa, as skills já
invocadas, nem os arquivos já lidos pelo principal. Recebe:

- **prompt de sistema** próprio + detalhes de ambiente que o Claude Code acrescenta;
- **mensagem de tarefa** — o prompt de delegação escrito por Claude;
- **toda a hierarquia de CLAUDE.md** que a conversa principal carrega (usuário, projeto,
  `CLAUDE.local.md`, managed) — **exceto Explore e Plan**, que pulam;
- **git status**, snapshot do início da sessão — ausente sem repo git ou com `includeGitInstructions:
  false`; Explore e Plan pulam sempre;
- **skills pré-carregadas**, se listadas em `skills`;
- **roster de irmãos** (v2.1.206+) — quem mais está na sessão, para `SendMessage`; só aparece se o
  subagente tem `SendMessage` nas ferramentas e há outro agente nomeado.

**Nunca chega a um não-fork:** *output style* da sessão (o subagente roda o prompt de sistema dele);
*auto memory* da conversa principal (use o campo `memory` para dar memória própria); a janela de
contexto é dimensionada pelo modelo **do subagente**, não do pai — delegar para modelo menor dá janela
menor.

`[CAMPO]` Consequência prática: uma regra que precisa alcançar o subagente e não é padrão de projeto
("ignore `vendor/`") precisa ser **restated no prompt de delegação** — CLAUDE.md sozinho não basta se
o subagente for Explore/Plan, e mesmo nos outros a regra compete com o prompt de sistema próprio.

## 8. Foreground × background

`[OFICIAL]` Foreground bloqueia a conversa principal até terminar; prompt de permissão passa direto
para você. **Desde v2.1.198, background é o default** — Claude só roda em foreground quando precisa
do resultado na hora. Prompt de permissão de um subagente em background surge na sessão principal
nomeando quem pediu (v2.1.186+); `Esc` nega só aquela chamada sem parar o subagente.

Resultado de background chega como notificação de conclusão num turno **posterior** (v2.1.211+): se
você perguntar o progresso antes, a resposta é "ainda rodando" — nunca um resultado fabricado.

`Ctrl+B` move uma task rodando para background. `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=1` desliga tudo.

## 9. Limites — três, cada um com sua variável

`[OFICIAL]`

| Limite | Default | Variável | Cobre |
|---|---|---|---|
| **Profundidade de aninhamento** | 3 camadas abaixo da principal (v2.1.219+) | `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH` | subagente spawnando subagente |
| **Total por sessão** | 200 | `CLAUDE_CODE_MAX_SUBAGENTS_PER_SESSION` | todo spawn via ferramenta Agent, incl. aninhado, fork, background |
| **Concorrente** | 20 rodando ao mesmo tempo | `CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS` | só o que está rodando agora; sessão com ultracode é isenta |

No limite de profundidade, `Agent` é retirado de todo subagente exceto fork (que mantém a ferramenta
listada, mas ela retorna erro em vez de spawnar). `/clear` reseta o contador de total-por-sessão; se
sobrevive algo que ainda pode spawnar (workflow rodando), a contagem carrega. Agente de workflow
(`agent()` no script) e teammate de agent team não contam para esses limites — têm os próprios.

## 10. Retomar um subagente

`[OFICIAL]` Cada invocação nasce com contexto zerado; para continuar, peça a Claude para retomar —
ele usa `SendMessage` com o ID ou nome do agente como `to`. **Explore e Plan são one-shot e não
retornam ID** — não são retomáveis; use `general-purpose` ou um customizado quando precisar continuar.

Retomada automática ao receber `SendMessage`, sem nova invocação de `Agent` — mesma regra vale para
subagente parado com `TaskStop`. **Exceção (v2.1.191+):** um subagente que **você** parou com `x` em
`/tasks` não retoma automaticamente — `SendMessage` recebe recusa; digitar no transcript dele em
persoa limpa o estado de parado.

`SendMessage` verifica (v2.1.199+) que o nome ainda aponta para o mesmo agente contatado antes; se um
agente mais novo reusou o nome, a mensagem é recusada em vez de entregue ao alvo errado.

Transcript de subagente vive em `~/.claude/projects/{project}/{sessionId}/subagents/agent-{id}.jsonl`,
independente da compactação da conversa principal, e é limpo depois de `cleanupPeriodDays` (30 dias
default).

## 11. Fork — o subagente que herda tudo

`[OFICIAL]` Um fork é subagente que herda a conversa **inteira** até aquele ponto, em vez de começar
do zero — mesmo prompt de sistema, ferramentas, modelo e histórico da sessão principal. Só a
chamada-de-ferramenta do fork fica de fora da sua conversa; o resultado final volta.

```text
/subtask draft unit tests for the parser changes so far
```

(v2.1.117–2.1.160 exigia `CLAUDE_CODE_FORK_SUBAGENT=1`; v2.1.161–2.1.211 o comando era `/fork`;
v2.1.212+ é `/subtask`, e `/fork` passou a significar clonar a sessão inteira num background session
separado.) Fork não pode spawnar outro fork.

| | Fork | Subagente nomeado |
|---|---|---|
| Contexto | histórico completo | fresco, só o prompt de delegação |
| Prompt/ferramentas | igual à sessão principal | da definição, filtrado se em background |
| Modelo | igual à sessão principal | campo `model` da definição |
| Cache de prompt | compartilhado com a principal | cache próprio |

`[OFICIAL]` Use fork quando um subagente nomeado exigiria contexto demais para ser útil, ou para
tentar abordagens em paralelo do mesmo ponto de partida. Ao spawnar um fork, Claude pode passar
`isolation: "worktree"` para que as edições do fork caiam num worktree separado.

## 12. Escaneamento de saída — mitigação de prompt injection

`[OFICIAL]` (v2.1.210+) Antes de Claude ler o relatório final de um subagente, o Claude Code escaneia
por texto que imita a própria saída do harness (`<system-reminder>`, `Human:`, `Assistant:`) ou
menciona configuração de permissão (`bypassPermissions`, `--dangerously-skip-permissions`) —
inserindo uma barra invertida na imitação, ou prefixando uma linha `[harness: subagent output matched
instruction-shaped pattern(s):`. **O escaneamento não julga malícia e não muda o que uma instrução no
relatório pode fazer** — qualquer chamada de ferramenta que ela induza ainda passa pelas checagens de
permissão normais. Não substitui restringir o que o subagente alcança.

## 13. Padrões de uso

`[OFICIAL]`

- **Isolar operação de alto volume**: "use um subagente para rodar a suíte e reportar só os testes
  que falharam com a mensagem de erro" — o output verboso fica no contexto dele.
- **Pesquisa paralela**: várias investigações independentes, um subagente cada, síntese no fim —
  funciona bem quando as investigações não dependem entre si; ⚠️ muitos subagentes devolvendo detalhe
  consomem contexto significativo de volta.
- **Encadear**: um subagente encontra, outro corrige — Claude passa o contexto relevante entre eles.

### Quando usar conversa principal em vez de subagente

Tarefa precisa de ida-e-volta frequente ou refinamento iterativo; fases compartilham muito contexto
(planejar → implementar → testar); é mudança pequena e direta; latência importa (subagente começa do
zero). Para pergunta pontual sobre algo já na conversa, `/btw` é mais barato que subagente: vê o
contexto completo, sem ferramenta, resposta descartada.

## 14. Definir hooks para um subagente

`[OFICIAL]` No frontmatter (só enquanto aquele subagente está ativo) ou em `settings.json` (session-
wide, dispara dentro de subagentes também). `Stop` no frontmatter converte para `SubagentStop` em
runtime. `SubagentStart`/`SubagentStop` em `settings.json` usam o `name` do agente como matcher —
nome com `:` (escopo de plugin) é regex não-ancorada, ancore com `^nome$`.

`[OFICIAL]` (v2.1.218+) Hook de frontmatter de subagente de **projeto** só roda depois que a pasta
recebe workspace trust; até lá, o subagente roda mas os hooks são pulados com erro no log de debug.
Subagente de **usuário** ou passado via `--agents` não precisa desse passo.

## 15. Exemplo mínimo

```markdown
---
name: code-reviewer
description: Expert code review specialist. Proactively reviews code for quality, security, and maintainability. Use immediately after writing or modifying code.
tools: Read, Grep, Glob, Bash
model: inherit
---

You are a senior code reviewer ensuring high standards of code quality and security.
Review checklist: clareza, nomes, duplicação, tratamento de erro, segredo exposto, validação
de entrada, cobertura de teste. Organize o retorno por prioridade: crítico, aviso, sugestão.
```

`[OFICIAL]` Boas práticas nomeadas pela doc: um subagente, uma especialidade; descrição detalhada
(é o que decide a delegação); ferramentas no mínimo necessário; versionar o de projeto.

## 16. Armadilhas

`[OFICIAL]`

- **Regra de CLAUDE.md some para o subagente** se ele for Explore/Plan (pulam CLAUDE.md por design) —
  restate no prompt de delegação o que precisa alcançá-los.
- **`tools` mal escrito falha silenciosamente antes da v2.1.208** — zero ferramenta resolvida podia
  lançar sem nada e devolver resultado confuso; hoje falha explícito.
- **Foreground × background resolvem ferramentas diferentes** a partir da mesma definição — não
  assuma que o que funcionou uma vez funciona sempre.
- **Subagente parado por você não retoma sozinho** (v2.1.191+) — `SendMessage` bate numa recusa até
  você reabrir o transcript.
- **Nome reusado por agente mais novo é bloqueado**, não redirecionado silenciosamente (v2.1.199+).

`[CAMPO]`

- Prompt de subagente genérico ("investigate X") sem escopo produz **Infinite exploration** (ver
  `kb/anthropic-claude-code.md §10`) mesmo dentro do contexto isolado — o isolamento protege a
  conversa principal, não corrige a falta de delimitação.
- Muitos subagentes retornando relatório detalhado em paralelo devolvem o problema de contexto que
  motivou usá-los — a mitigação é pedir resumo, não despejo, na `description`/prompt de delegação.

## 17. Decisão — subagente, fork, ou nada?

```
A tarefa lateral produziria muito ruído no contexto principal (busca, log, leitura que não volta)?
├─ não → faça na conversa principal.
└─ sim
   └─ Precisa do histórico/contexto completo da conversa para ser útil?
      ├─ sim → fork (/subtask) — herda tudo, cache compartilhado.
      └─ não
         └─ É um tipo de trabalho que você repete com a mesma instrução?
            ├─ sim → subagente customizado em .claude/agents/ (versionado) ou ~/.claude/agents/ (pessoal)
            └─ não → deixe Claude delegar a um embutido (Explore/Plan/general-purpose) por descrição
```

## 18. Comportamentos versionados

`[OFICIAL]` Consulte antes de assumir — a versão instalada pode não ter o comportamento:

| Versão | Mudança |
|---|---|
| 2.1.153 | restrições MCP da sessão principal (`--strict-mcp-config`, managed) passam a cobrir `mcpServers` de subagente |
| 2.1.172–2.1.216 | aninhamento default: 5 camadas, sem opção de mudar |
| 2.1.186 | prompt de permissão de background surge na sessão principal, nomeando o subagente |
| 2.1.191 | subagente parado por você (`x`/`stop_task`) deixa de auto-retomar |
| 2.1.196 | `CLAUDE_CODE_SUBAGENT_MODEL=inherit` passa a se comportar como não-definido |
| 2.1.197 (e antes) | `/agents` abria wizard interativo com abas Running/Library |
| 2.1.198 | `/agents` só imprime aviso; Explore herda o modelo da principal em vez de sempre Haiku; subagente roda em background por default; auto-compaction e extended thinking passam a seguir a sessão principal; mensagem do agente que lançou é tratada como direção de tarefa |
| 2.1.199 | erro de API cortando subagente reporta a falha em vez de devolver o texto do erro como achado; `SendMessage` verifica identidade do nome |
| 2.1.200 | erro de API sem texto útil falha explícito com mensagem nomeada; alias `manual` para `permissionMode` |
| 2.1.205 | resumir agente falho/completo mostra "rodando" corretamente; zero-ferramenta falha ao lançar em vez de rodar vazio; `/doctor` reporta nomes duplicados |
| 2.1.206 | roster de irmãos no contexto inicial (exige `SendMessage` nas ferramentas) |
| 2.1.208 | limite de concorrência ativado (20); background completo permanece listado em `/tasks` até limpeza da sessão |
| 2.1.210 | escaneamento de saída contra prompt injection; `isolation: worktree` falha se o comando resolve fora do worktree |
| 2.1.211 | `model` por invocação persiste em retomada; resultado de background chega só como notificação em turno posterior |
| 2.1.212 | comando de fork vira `/subtask`; limite total-por-sessão configurável (200 default) |
| 2.1.215 | `/verify` e `/code-review` embutidas ficam impossíveis de preload |
| 2.1.216 | agente ausente na retomada mostra aviso em vez de silêncio |
| 2.1.217 | limite de profundidade configurável; limite concorrente configurável |
| 2.1.218 | hook de frontmatter de subagente de projeto exige workspace trust; `name` não aceita `:` |
| 2.1.219 | default de profundidade sobe para 3 |

## 19. Contradição registrada

`[HIPÓTESE]` A doc trata "muitos subagentes em paralelo" como o padrão natural para pesquisa
independente, e o aviso sobre contexto consumido no retorno é uma nota de rodapé. Na prática, o
retorno de N subagentes com relatório completo devolve exatamente o problema que motivou delegar —
a economia de contexto só se realiza se a `description`/prompt de delegação **força resumo**, não
despejo. **Resolução proposta:** todo prompt de delegação para subagente paralelo declara o formato
do retorno esperado (achado + evidência mínima), nunca "investigue e relate".

**Condição de falsificação:** se em prática de campo o retorno verboso raramente estourar contexto —
porque o principal já compacta ou porque N é tipicamente pequeno — a hipótese cai.

---

## 20. Interoperação entre Harnesses de IA (`[CAMPO]`)

Em ambientes de produção com ecossistema multi-ferramenta (**Claude Code**, **Google Antigravity**, **OpenCode**), a portabilidade de estado e sessões entre diferentes agentes exige regras estritas:

1. **Portabilidade de Regras via Upstream Único:** `AGENTS.md` e `RULES.md` no repositório `labs` são a única fonte de verdade. Agentes em qualquer harness leem as regras deste repositório e nunca alteram suas cópias locais nos projetos cliente (evitando `AP-15 · Cópia Manual Multi-Harness`).
2. **Isolamento de Worktrees Inter-Agentes:** Quando Claude Code, Antigravity ou OpenCode executam tarefas em paralelo no mesmo repositório, cada sessão DEVE rodar em sua própria Git Worktree descartável. Isso evita colisão de arquivos temporários de sessão (como `.claude/`, `.gemini/`, `.opencode/`).
3. **Contrato de Artefato SDD:** Especificações em `specs/NNN-slug/` usam exclusivamente Markdown neutro e versionável, permitindo que a fase `/sdd-specify` feita em um harness seja consumida na fase `/sdd-plan` ou `/sdd-implement` por outro harness sem perda de contexto.

---

**Volta ao índice:** [README](README.md) · **Relacionado:** [worktrees.md](worktrees.md) ·
[04-padroes.md · CTX-03](04-padroes.md#ctx-03--delegação-para-preservar-contexto) ·
[anthropic-claude-code.md §6](anthropic-claude-code.md)
