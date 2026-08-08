# Worktrees — isolamento de arquivos para trabalho paralelo

> Fontes: [Worktrees](https://code.claude.com/docs/en/worktrees) ·
> [Common workflows](https://code.claude.com/docs/en/common-workflows#run-parallel-sessions-with-worktrees) ·
> [Run agents in parallel](https://code.claude.com/docs/en/agents) ·
> [Hooks](https://code.claude.com/docs/en/hooks#worktreecreate). Lidas em 2026-08-02.
> Prática de campo: gitworktree.org · pnpm.io/git-worktrees · gitcheatsheet.dev.
> Selos: `[OFICIAL]` documentação Anthropic · `[INDÚSTRIA]` consenso de prática sem validação
> controlada · `[CAMPO]` observado nos projetos do usuário · `[HIPÓTESE]` proposta desta KB.

Padrão correspondente: [EXE-05 · Isolamento por Worktree](04-padroes.md#exe-05--isolamento-por-worktree).

## 1. O que um worktree é — e o que ele não resolve

`[OFICIAL]` Um worktree do git é um **diretório de trabalho separado, com seus próprios arquivos e sua
própria branch**, compartilhando o histórico e o remote do checkout principal. Rodar cada sessão do
Claude Code no seu worktree significa que edições de uma sessão nunca tocam os arquivos da outra.

A distinção que evita quase todo erro de projeto aqui:

> **Worktree isola arquivos. Subagente, agent team e workflow coordenam trabalho.** São eixos
> ortogonais, e a doc oficial é explícita ao classificar worktree como *ferramenta de apoio*, não como
> uma das formas de rodar agentes em paralelo.

`[OFICIAL]` A tabela das formas de paralelizar:

| Abordagem | O que dá | Use quando |
|---|---|---|
| **Subagente** | trabalhador delegado dentro de **uma** sessão, com contexto próprio, devolve resumo | uma tarefa lateral inundaria a conversa principal com buscas, logs e leituras que você não vai reler |
| **Agent view** (`claude agents`) | uma tela para despachar e monitorar sessões em background — *research preview* | várias tarefas independentes que você entrega e confere depois, intervindo só quando uma trava |
| **Agent team** | sessões coordenadas com lista de tasks compartilhada e mensagens entre agentes, sob um líder — *experimental, desligado por padrão* | você quer que o Claude fatie o projeto, distribua e mantenha os trabalhadores em sincronia |
| **Dynamic workflow** | script que roda muitos subagentes e cruza os resultados | o trabalho excede um punhado de subagentes ou exige verificação cruzada: auditoria do repo inteiro, migração de 500 arquivos, plano por vários ângulos |
| **Worktree** | *não é uma forma de rodar agentes* — dá a cada sessão um checkout separado | as tarefas **tocam os mesmos arquivos** |

`[OFICIAL]` Consequência prática por combinação: agent view move cada sessão despachada para seu
próprio worktree automaticamente; subagentes podem receber um cada; **agent teams não isolam os
companheiros de equipe** — ali é preciso particionar o trabalho por arquivo na mão. `/batch` é uma
skill que empacota subagentes + worktrees: fatia uma mudança grande em 5 a 30 subagentes isolados, cada
um abrindo um PR.

## 2. Uso mínimo

```bash
claude --worktree feature-auth      # ou: claude -w feature-auth
```

`[OFICIAL]` Por padrão o worktree nasce em `.claude/worktrees/<nome>/` na raiz do repositório, numa
branch nova chamada `worktree-<nome>`. Rode o mesmo comando com outro nome em outro terminal e você
tem duas sessões isoladas. Omitindo o nome, o Claude gera um (`bright-running-fox`) — apropriado para
sessão descartável; nome explícito para sessão que você pretende revisitar.

Três pré-condições que produzem erro se ignoradas:

- **O repositório precisa de ao menos um commit** — o worktree nasce de um commit existente. Sem
  nenhum: `Failed to resolve base branch "HEAD": git rev-parse failed`.
- **Workspace trust em execução interativa** — se você nunca rodou `claude` naquele diretório,
  `--worktree` sai com erro pedindo que você aceite o diálogo de confiança primeiro. Execução
  não-interativa com `-p` pula a checagem.
- **Nada de symlink no caminho** — se `.claude`, `.claude/worktrees` ou o diretório do worktree for um
  symlink, a criação é recusada com o caminho nomeado no erro.

`[OFICIAL]` Recomendação da própria doc: **adicione `.claude/worktrees/` ao `.gitignore`**, senão o
conteúdo dos worktrees aparece como arquivo não rastreado no checkout principal.

### Pedir ao Claude, dentro da sessão

`[OFICIAL]` "trabalhe num worktree" faz o Claude criar um com a ferramenta `EnterWorktree`. Já dentro
de um, ele pode saltar direto para outro sob `.claude/worktrees/` chamando `EnterWorktree` com o
caminho-alvo — o worktree anterior fica intacto no disco.

Quando o caminho está **fora** de `.claude/worktrees/`, o Claude Code pede aprovação, porque a
mudança leva junto o diretório de trabalho da sessão, o acesso de escrita e a configuração de projeto
(`CLAUDE.md`, settings). Regra de permissão para `EnterWorktree` ou "não perguntar de novo" **não
suprimem** esse prompt; só `bypassPermissions`.

### Preparar o ambiente

`[OFICIAL]` Um worktree é um checkout novo: dependências não estão instaladas e arquivos gitignorados
(como `.env`) não vieram junto. Peça ao Claude para instalar, ou rode o setup do projeto você mesmo
dentro do diretório. Para os gitignorados, use [`.worktreeinclude`](#5-configuração).

## 3. Ciclo de vida e limpeza

`[OFICIAL]` Ao sair de uma sessão interativa, o Claude inspeciona o worktree em busca de trabalho que a
remoção destruiria — arquivos alterados ou não rastreados, e commits novos:

| Estado na saída | O que acontece |
|---|---|
| Limpo, sessão **sem nome** | remove worktree e branch automaticamente |
| Limpo, sessão **nomeada** | pergunta antes, para você poder guardá-lo |
| **Com trabalho dentro** | pergunta: manter (preserva diretório e branch) ou remover (apaga tudo junto) |

`[OFICIAL]` **Execução com `-p` não tem prompt de saída, logo não limpa nada.** Remova com
`git worktree remove` — a fonte mais comum de worktree órfão em pipeline.

### O sweep periódico

`[OFICIAL]` Uma varredura periódica remove os worktrees que o Claude criou **para subagentes e sessões
em background** quando ficam mais velhos que o `cleanupPeriodDays` das settings. Três garantias que
importam:

- o sweep **pula** worktree que ainda contém trabalho: arquivos alterados, não rastreados ou commits
  não enviados;
- o sweep **nunca** remove worktree criado por `--worktree` — esses são seus;
- enquanto um agente roda, o Claude aplica `git worktree lock` no worktree dele, de modo que uma
  limpeza concorrente não pode removê-lo; o lock cai quando o agente termina.

`[OFICIAL]` A partir da v2.1.210 o sweep também libera o lock de uma sessão cujo processo morreu, para
que sessão em background morta não deixe worktree travado para sempre. **Lock que você mesmo pôs com
`git worktree lock` nunca é liberado pelo sweep.**

Para forçar a remoção de um worktree que o sweep preserva:

```bash
git worktree remove <caminho> --force    # --force se houver alteração ou arquivo não rastreado
```

### Retomar sessão

`[OFICIAL]` Retomar uma sessão que estava num worktree devolve a sessão àquele worktree — vale para
retomada interativa, para `--continue`/`--resume` com `-p`, e para o Agent SDK. De lá o Claude ainda
pode sair com a ferramenta `ExitWorktree`. Duas exceções: `--fork-session` começa no diretório de onde
você lançou o Claude e deixa o worktree original intocado; e se o diretório do worktree não existe
mais, a sessão retoma no diretório de lançamento.

## 4. Isolamento de subagentes

`[OFICIAL]` Peça "use worktrees para seus agentes", ou torne o isolamento permanente num subagente
customizado com `isolation: worktree` no frontmatter:

```markdown
---
name: refactorer
description: Applies mechanical refactors across many files
isolation: worktree
---

Apply the requested refactor across every affected file, then run the tests
and report the results.
```

`[OFICIAL]` Cada subagente ganha um worktree temporário, removido automaticamente **se ele terminar sem
alterações**; com alterações, o worktree fica no disco até que o sweep possa removê-lo sem perder
trabalho. Subagentes herdam a mesma [base branch](#5-configuração) de `--worktree`.

`[OFICIAL]` O custo é assimétrico e a própria ferramenta o declara caro: ~200–500 ms de setup e o disco
de mais um checkout **por agente**. Use quando os agentes de fato escrevem nos mesmos arquivos em
paralelo; agente de leitura não precisa de worktree nenhum.

## 5. Configuração

### `worktree.baseRef` — de onde a branch nasce

`[OFICIAL]` Duas opções, e só duas — **não aceita nome de branch**:

| Valor | Comportamento | Quando |
|---|---|---|
| `"fresh"` (default) | ramifica da branch padrão **no remote** (normalmente `main`) | o normal: começar de uma árvore limpa igual ao remote |
| `"head"` | ramifica do `HEAD` local | isolar subagente que precisa operar sobre trabalho em andamento — carrega seus commits não enviados e o estado da feature branch |

```json
{ "worktree": { "baseRef": "head" } }
```

`[OFICIAL]` Dentro de um worktree, `"head"` resolve para o `HEAD` **daquele** worktree, não o do
checkout principal. Com base `"fresh"`, o Claude Code mantém `origin/HEAD` atual: se o repo não é
buscado há 24 h, ele busca a branch padrão com teto de cinco segundos e cai no ref cacheado se a busca
falhar. Sem remote configurado — ou com `origin/HEAD` nem cacheado nem buscável — o worktree cai para o
`HEAD` local. Para começar de uma branch existente específica,
[crie o worktree com git direto](#8-manual-com-git).

### Branch a partir de um pull request

```bash
claude --worktree "#1234"      # aspas: o shell trataria # como início de comentário
```

`[OFICIAL]` Aceita o número prefixado por `#` ou a URL completa do PR no GitHub. Busca
`pull/<n>/head` de `origin` e cria o worktree em `.claude/worktrees/pr-<n>`.

### `.worktreeinclude` — levar os gitignorados junto

`[OFICIAL]` Arquivo na raiz do projeto, **sintaxe de `.gitignore`**. Só é copiado o arquivo que casa com
um padrão **e** é gitignorado — arquivo rastreado nunca é duplicado.

```text
.env
.env.local
config/secrets.json
```

Vale para todo worktree que o Claude Code cria com git: `--worktree`, worktrees de subagente e sessões
paralelas do app desktop. **Com um hook `WorktreeCreate`, o `.worktreeinclude` não é processado** —
copie os arquivos dentro do script do hook.

### Reusar um nome

`[OFICIAL]` Passar a `--worktree` um nome cujo diretório já existe **abre o existente** em vez de criar.
Com a base default `"fresh"`, o worktree reaberto **volta para a branch padrão** em vez de continuar na
ponta antiga quando *todas* estas condições valem: não há alteração nem arquivo não rastreado; ele
ainda está na branch que o Claude Code criou; e ele não tem commits próprios, ou o PR dele foi mergeado
e a branch remota apagada. Qualquer outro caso reabre na ponta antiga — inclusive todo reuso quando
`baseRef` é `"head"` ou quando o nome é um número de PR.

## 6. O que o worktree compartilha com o checkout principal

`[OFICIAL]` Arquivos e branch são próprios; três coisas são compartilhadas — e vale para worktree criado
por `--worktree`, por `git worktree add` ou pelo app desktop:

- **O `.git` do repositório.** Comandos git dentro do worktree escrevem no `.git` compartilhado, e o
  sandbox permite essas escritas: `git commit` funciona de dentro do worktree com sandbox ligado.
- **Plugins de escopo de projeto** (v2.1.200+). Instalados no checkout principal, carregam nos
  worktrees do mesmo repositório — não é preciso reinstalar por worktree.
- **Aprovações de permissão** (v2.1.211+). "Sim, não perguntar de novo" num worktree salva a regra no
  `.claude/settings.local.json` do **checkout principal**, então ela vale no principal e em todos os
  outros worktrees, e **sobrevive à remoção** daquele worktree.

## 7. Hooks `WorktreeCreate` e `WorktreeRemove`

`[OFICIAL]` Substituem inteiramente a lógica `git worktree` — é assim que se coloca worktree fora de
`.claude/worktrees/`, ou se dá suporte a SVN, Perforce e Mercurial. Nenhum dos dois tem suporte a
matcher: disparam sempre.

**`WorktreeCreate`** dispara na criação via `--worktree`, via `isolation: "worktree"` ou para sessão em
background. Entrada por stdin:

```json
{
  "session_id": "abc123",
  "transcript_path": "/path/to/transcript.jsonl",
  "cwd": "/current/working/directory",
  "hook_event_name": "WorktreeCreate",
  "base_branch": "main",
  "worktree_name": "feature-xyz",
  "worktree_path": "/path/to/worktree"
}
```

**Contrato de saída: o hook precisa imprimir o caminho do worktree em stdout.** Exit 0 → o caminho
impresso vira o local do worktree; **qualquer código diferente de zero aborta a criação**. Para hook
HTTP, resposta 2xx com `{"hookSpecificOutput": {"worktreePath": "..."}}`.

**`WorktreeRemove`** dispara na saída da sessão, quando um subagente termina, ou quando você apaga uma
sessão em background. Mesmo schema, sem `base_branch` e sem `worktree_name`. É **non-blocking**: falha
só aparece em modo debug, o código de saída é ignorado e a remoção acontece de todo jeito.

Exemplo oficial, SVN:

```json
{
  "hooks": {
    "WorktreeCreate": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'NAME=$(jq -r .name); DIR=\"$HOME/.claude/worktrees/$NAME\"; svn checkout https://svn.example.com/repo/trunk \"$DIR\" >&2 && echo \"$DIR\"'"
          }
        ]
      }
    ]
  }
}
```

`[OFICIAL]` Worktree criado por hook mantém o transcript no diretório de lançamento — ao contrário do
criado com git, cujo transcript segue a sessão (v2.1.198+, mesmo mecanismo do `/cd`).

## 8. Manual, com git

Preferível quando é preciso partir de uma branch existente específica, ou colocar o worktree fora do
repositório.

```bash
git worktree add ../project-feature-a -b feature-a    # branch nova
git worktree add ../project-bugfix fix-issue-456      # branch existente
cd ../project-feature-a && claude
git worktree list
git worktree remove ../project-feature-a
```

`[INDÚSTRIA]` A convenção de layout mais difundida é a de **diretórios irmãos**: cada worktree ao lado
do clone principal, nunca dentro dele — evita `.git` aninhado e mantém os caminhos previsíveis. É
exatamente o oposto do default do Claude Code (`.claude/worktrees/`), que resolve o mesmo risco por
gitignore.

## 9. Armadilhas

`[OFICIAL]`

- **Symlink no caminho aborta a criação.** `.claude`, `.claude/worktrees` ou o próprio diretório sendo
  symlink → recusa com o caminho nomeado. Antes da v2.1.212, um symlink **commitado** num desses
  caminhos era seguido e podia criar arquivos fora do repositório.
- **Windows: a remoção não atravessa link.** Se uma pasta dentro do worktree é na verdade um link
  (junction NTFS ou symlink de diretório), o Claude Code apaga só o link e preserva o destino. Antes da
  v2.1.205, remover um worktree com link aninhado em subdiretório podia apagar a pasta apontada.
- **`--fork-session` não herda o worktree.** Começa no diretório de lançamento.
- **Falha ao entrar no worktree no startup** imprime o caminho e sai com código 1 — tipicamente um hook
  `WorktreeCreate` que imprimiu outra coisa que não o diretório criado, ou diretório apagado após o
  setup.

`[INDÚSTRIA]`

- **Dependências não vêm junto.** Cada worktree precisa do seu `install`. Compartilhar `node_modules`
  entre branches é a origem de conflito de versão e bug sutil, porque branches diferentes têm
  `package.json` diferentes.
- **O disco multiplica.** Um projeto Node de 2 GB de dependências vira ~10 GB em cinco worktrees. `pnpm`
  mitiga: store content-addressable global, cada worktree com seu `node_modules` por hard link.
- **Portas e banco colidem.** Rodar duas sessões que sobem o mesmo serviço na mesma porta anula o
  isolamento que o worktree deu — o isolamento é de **arquivo**, não de runtime.
- **Worktree órfão pós-merge é o lixo mais comum.** Remova assim que a branch entrar.

## 10. Comportamentos versionados

`[OFICIAL]` A superfície mudou bastante entre v2.1.198 e v2.1.212. Consulte antes de assumir
comportamento — a versão instalada pode não o ter:

| Versão | Mudança |
|---|---|
| 2.1.198 | transcript segue o worktree ao entrar/sair (como `/cd`), então `/desktop` e `--resume` o acham lá; `/agents` deixa de abrir painel |
| 2.1.200 | plugins de escopo de projeto carregam nos worktrees do mesmo repo |
| 2.1.205 | falha ao entrar no worktree sai com código 1 em vez de derrubar a sessão; remoção no Windows para de seguir link aninhado |
| 2.1.206 | `EnterWorktree` fora de `.claude/worktrees/` passa a exigir aprovação (antes, qualquer caminho existente entrava direto) |
| 2.1.208 | base `"fresh"` mantém `origin/HEAD` atual por fetch com teto de 5 s; reuso de nome pode resetar para a branch padrão |
| 2.1.210 | o sweep libera lock deixado por sessão em background morta |
| 2.1.211 | aprovação de permissão dada num worktree é salva no checkout principal e sobrevive à remoção |
| 2.1.212 | resume não-interativo volta ao worktree e `ExitWorktree` funciona; symlink commitado deixa de ser seguido |

## 11. Decisão — preciso de worktree?

```
A tarefa ALTERA arquivos?
├─ não  → nenhum worktree. Leitura, exploração e auditoria não precisam.
└─ sim
   └─ Há OUTRA frente escrevendo ao mesmo tempo?
      ├─ não  → nenhum worktree. Branch normal basta.
      └─ sim
         └─ Os conjuntos de arquivos são disjuntos? (PLN-04)
            ├─ sim  → particionar já resolve; worktree é opcional.
            └─ não / não sei
               └─ Quem escreve?
                  ├─ você, em outro terminal      → claude --worktree <assunto>
                  ├─ subagentes seus, em paralelo → isolation: worktree
                  ├─ sessões despachadas          → agent view (worktree automático)
                  └─ agent team                   → NÃO isola: particione por arquivo na mão
```

## 12. Regra Unificada e Consolidação

`[CONSOLIDADO]` A documentação oficial trata o git worktree como um recurso de custo irrisório. Isso é exato para a camada do *git*, porém falso para o custo de *ambiente* (instalação de pacotes, `.env`, banco de dados, portas).

**Resolução Consolidada (`RGIT-11`):** Worktree é dimensionado por **frente de trabalho**, nunca por tarefa individual. Uma frente é uma unidade de mudança relevante que justifica o setup inicial. Tarefas sucessivas da mesma frente reusam o worktree existente. Leituras e investigações usam subagentes na sessão principal sem criar worktree.

**Enforcement:** Definido em `RULES.md` (`RGIT-05`, `RGIT-11`) e automatizado por Git Hooks e pela esteira de templates (`RULE_AUTOMATIC_WORKTREE_SDD_GRILLING.md`).

---

**Volta ao índice:** [README](README.md) ·
**Padrão:** [EXE-05](04-padroes.md#exe-05--isolamento-por-worktree) ·
**Relacionado:** [PLN-04](04-padroes.md#pln-04--paralelismo-por-disjunção-de-arquivos) ·
[anthropic-claude-code.md §9 Escala](anthropic-claude-code.md)
