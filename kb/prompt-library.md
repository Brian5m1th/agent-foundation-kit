# Biblioteca de prompts — os 52 prompts oficiais, indexados por intenção

> Fonte: [Prompt library](https://code.claude.com/docs/en/prompt-library), lida em 2026-08-02.
> Selo `[OFICIAL]` — os prompts e a justificativa de cada um são da Anthropic. O **índice de gatilho**
> (§2) e a regra de roteamento (§1) são `[HIPÓTESE]` deste repositório: a fonte publica uma vitrine
> navegável por humano; aqui ela vira tabela de decisão consultável por agente.
>
> Os prompts estão em português para uso direto. Os slots (`{path}`, `{behavior}`) mantêm o nome
> original em inglês, porque são identificadores. O texto original em inglês está na fonte.

## 1. Regra de roteamento

**Antes de executar uma tarefa que caia numa das intenções da §2, abra a entrada correspondente e
use aquele prompt como forma da ação** — não como texto a devolver ao usuário, mas como *checklist do
que a ação precisa conter*. Um prompt daqui carrega, tipicamente, três coisas que um pedido informal
perde: o critério de verificação, o formato da saída, e o que **não** mexer.

Três modos de uso, em ordem de frequência:

| Situação | O que fazer |
|---|---|
| O agente recebeu um pedido que casa com uma intenção | Executar seguindo a estrutura do prompt, sem perguntar |
| O usuário pediu "como eu peço X?" | Devolver o prompt preenchido, pronto para colar |
| Nenhuma entrada casa | Aplicar os seis padrões da §4 e escrever o prompt do zero |

**Anti-regra:** isto não é um roteador obrigatório. Se o pedido é preciso e a entrada da biblioteca é
mais genérica que ele, o pedido vence. A biblioteca cobre o caso em que o pedido é *mais raso* que a
tarefa exige.

## 2. Índice de gatilho — intenção → prompt

Leia como: *"se o pedido soa assim, existe prompt para isso."*

| Se o pedido é sobre… | Prompt | Fase |
|---|---|---|
| conhecer um repositório novo, "me explica esse projeto" | [`get-oriented-in-a`](#get-oriented-in-a) | discover |
| entender um arquivo ou fluxo específico | [`explain-unfamiliar-code`](#explain-unfamiliar-code) | discover |
| "onde é que a gente faz X?" | [`find-where-something-happens`](#find-where-something-happens) | discover |
| apagar/remover algo e saber o impacto | [`see-what-depends-on`](#see-what-depends-on) | discover |
| "por que esse código está assim?" | [`trace-how-code-evolved`](#trace-how-code-evolved) | discover |
| dimensionar uma mudança antes de começar | [`scope-a-change-before`](#scope-a-change-before) | discover |
| pergunta de produto respondida pelo código | [`ask-the-codebase-a`](#ask-the-codebase-a) | discover |
| planejar mudança multi-arquivo sem editar | [`plan-a-multi-file`](#plan-a-multi-file) | design |
| escrever spec entrevistando o humano | [`draft-a-spec-by`](#draft-a-spec-by) | design |
| transformar reunião/nota em tickets | [`turn-a-meeting-into`](#turn-a-meeting-into) | design |
| levantar estados de erro e casos de borda | [`map-edge-cases-before`](#map-edge-cases-before) | design |
| mockup → protótipo clicável | [`turn-a-mockup-into`](#turn-a-mockup-into) | design |
| implementar a partir de screenshot de design | [`implement-from-a-screenshot`](#implement-from-a-screenshot) | design |
| construir algo seguindo padrão que já existe | [`follow-an-existing-pattern`](#follow-an-existing-pattern) | build |
| documentar código sem docstring | [`generate-docs-for-code`](#generate-docs-for-code) | build |
| feature pequena e bem definida | [`add-a-small-well`](#add-a-small-well) | build |
| ferramenta interna descartável | [`build-a-small-internal`](#build-a-small-internal) | build |
| resolver uma issue ponta a ponta | [`work-an-issue-end`](#work-an-issue-end) | build |
| trocar copy/texto em todo o codebase | [`find-and-update-copy`](#find-and-update-copy) | build |
| redigir documento imitando exemplos antigos | [`draft-from-past-examples`](#draft-from-past-examples) | build |
| escrever testes e fazer passar | [`write-tests-run-them`](#write-tests-run-them) | build |
| TDD — teste primeiro | [`drive-implementation-from-tests`](#drive-implementation-from-tests) | build |
| aumentar cobertura a partir do relatório | [`fill-gaps-from-a`](#fill-gaps-from-a) | build |
| migrar um padrão em todos os call sites | [`migrate-a-pattern-across`](#migrate-a-pattern-across) | build |
| portar código para outra linguagem | [`port-code-between-languages`](#port-code-between-languages) | build |
| otimizar contra uma métrica | [`optimize-against-a-measurable`](#optimize-against-a-measurable) | build |
| bug visual com medida exata | [`fix-a-precise-visual`](#fix-a-precise-visual) | build |
| revisar o que ainda não foi commitado | [`review-your-changes-before`](#review-your-changes-before) | build |
| revisar um PR | [`review-a-pull-request`](#review-a-pull-request) | build |
| revisar plano de infra (Terraform etc.) | [`review-infrastructure-changes-before`](#review-infrastructure-changes-before) | build |
| revisão de segurança | [`run-a-security-review`](#run-a-security-review) | build |
| revisar conteúdo antes de mandar pra alguém | [`review-content-before-sending`](#review-content-before-sending) | build |
| "não é isso, tenta de novo" | [`course-correct-a-wrong`](#course-correct-a-wrong) | build |
| "você mexeu demais, reduz" | [`narrow-the-scope-of`](#narrow-the-scope-of) | build |
| erro que se repete → virar regra | [`turn-a-correction-into`](#turn-a-correction-into) | build |
| conflito de merge | [`resolve-merge-conflicts`](#resolve-merge-conflicts) | ship |
| commitar com mensagem gerada | [`commit-with-a-generated`](#commit-with-a-generated) | ship |
| abrir PR a partir de um ticket | [`open-a-pull-request`](#open-a-pull-request) | ship |
| release notes / changelog | [`draft-release-notes-from`](#draft-release-notes-from) | ship |
| pipeline de CI | [`write-a-ci-workflow`](#write-a-ci-workflow) | ship |
| teste quebrado | [`find-and-fix-a`](#find-and-fix-a) | operate |
| erro reportado por usuário | [`investigate-a-reported-error`](#investigate-a-reported-error) | operate |
| build quebrado | [`fix-a-build-error`](#fix-a-build-error) | operate |
| incidente em produção | [`investigate-a-production-incident`](#investigate-a-production-incident) | operate |
| screenshot de console cloud (GCP/AWS/k8s) | [`diagnose-from-a-console`](#diagnose-from-a-console) | operate |
| consultar logs em linguagem natural | [`query-logs-in-plain`](#query-logs-in-plain) | operate |
| analisar CSV / arquivo de dados | [`analyze-a-data-file`](#analyze-a-data-file) | operate |
| gerar variações a partir de métricas | [`generate-variations-from-performance`](#generate-variations-from-performance) | operate |
| tarefa repetitiva → skill / slash command | [`turn-a-recurring-task`](#turn-a-recurring-task) | operate |
| comportamento que tem de acontecer sempre → hook | [`add-a-hook-for`](#add-a-hook-for) | operate |
| **conectar ferramenta externa — MCP (GitHub, Sentry, Linear, Figma, Notion, banco)** | [`connect-a-tool-with`](#connect-a-tool-with) | operate |
| encerrar sessão registrando o aprendido | [`capture-what-to-remember`](#capture-what-to-remember) | operate |

### Gatilhos de ferramenta externa

Estes três são os que mais escapam, porque o pedido chega como nome de produto, não como intenção:

- **"instala/configura o MCP do GitHub"**, "conecta o Sentry", "quero que você leia meus tickets do
  Linear", "acessa o Figma" → [`connect-a-tool-with`](#connect-a-tool-with).
- **"cria um comando `/deploy`"**, "sempre que eu pedir X faça Y" → [`turn-a-recurring-task`](#turn-a-recurring-task).
- **"toda vez que editar arquivo, rode o linter"** → [`add-a-hook-for`](#add-a-hook-for) (é hook, não
  skill — determinístico vence advisory).

## 3. Os 52 prompts

Legenda: **Requer** = dependência externa · **Cole** = precisa de anexo no prompt · **Depois** =
como tornar permanente · **Fonte** = de qual guia da Anthropic veio.

---

### Discover · Onboard

#### `get-oriented-in-a`
**Situar-se num repositório novo** ★ *comece por aqui (1)*

```text
me dê uma visão geral deste codebase: arquitetura, diretórios principais, e como as peças se conectam
```

**Por quê:** descreva o que quer saber, não quais arquivos ler. O Claude explora sozinho e devolve
uma síntese de como aquilo se encaixa.
**Depois:** `/init` para gravar isso no `CLAUDE.md` e não repetir toda sessão. · **Fonte:** Common workflows

---

### Discover · Understand

#### `explain-unfamiliar-code`
**Explicar código desconhecido**

```text
explique o que {path} faz e como os dados fluem por ele. escreva o resultado como {format}
```

Slots: `path` = `src/scheduler/queue.ts` · `format` = `uma página HTML com diagrama, e abra no meu navegador`

**Por quê:** nomeie o arquivo e diga o formato da resposta. Troque a página HTML por diagrama, bullets,
ou o que servir ao seu jeito de aprender.
**Depois:** *output style* para o Claude sempre explicar no seu formato. · **Fonte:** Common workflows

#### `find-where-something-happens`
**Achar onde algo acontece** ★ *comece por aqui (2)*

```text
onde é que a gente {behavior}?
```

Slots: `behavior` = `valida o tipo dos arquivos enviados`

**Por quê:** busca por **comportamento**, não por nome de arquivo. Funciona mesmo sem saber como o
arquivo se chama nem em que diretório mora. · **Fonte:** Common workflows

#### `see-what-depends-on`
**Checar o que quebra antes de apagar**

```text
o que quebraria se eu apagasse {target}?
```

Slots: `target` = `o helper retryWithBackoff`

**Por quê:** pergunte antes de remover. A lista de chamadores e efeitos a jusante diz se é limpeza de
uma linha ou mudança que exige coordenação. · **Fonte:** Common workflows

#### `trace-how-code-evolved`
**Rastrear como o código evoluiu**

```text
percorra o histórico de commits de {path} e resuma como ele evoluiu e por quê
```

Slots: `path` = `internal/auth/session.go`

**Por quê:** aponte para o histórico quando a pergunta é *por quê*, não *o quê*. O log e o blame
explicam as decisões por trás da implementação atual. · **Fonte:** Best practices

#### `scope-a-change-before`
**Dimensionar uma mudança antes de começar** · papéis: pm, design

```text
quais arquivos eu precisaria tocar para {change}?
```

Slots: `change` = `adicionar um toggle de dark mode nas configurações`

**Por quê:** dimensione o trabalho antes de colocá-lo num roadmap. A lista de arquivos diz se é um
componente só ou uma mudança transversal. · **Fonte:** How Anthropic teams use Claude Code

#### `ask-the-codebase-a`
**Fazer ao código uma pergunta de produto** · papel: pm

```text
eu sou {role}. me guie pelo que acontece quando um usuário {action}, da UI até o resultado
```

Slots: `role` = `PM` · `action` = `clica em Exportar para PDF`

**Por quê:** declarar o papel calibra o nível da resposta. O Claude explica o que o produto faz a
partir do código-fonte, sem exigir que você o leia.
**Depois:** *output style* fixa esse nível. · **Fonte:** How Anthropic teams use Claude Code

---

### Design · Plan

#### `plan-a-multi-file`
**Planejar mudança multi-arquivo sem tocar em código** · papéis: pm, design

```text
planeje como refatorar {target} para {goal}. liste os arquivos que você mudaria, mas não edite nada ainda
```

Slots: `target` = `o módulo de pagamento` · `goal` = `suportar múltiplas moedas`

**Por quê:** o "não edite ainda" separa exploração de mudança — você vê a abordagem antes de qualquer
código se mover. Para tornar padrão em todo prompt, `Shift+Tab` (plan mode). · **Fonte:** Common workflows

#### `draft-a-spec-by`
**Escrever spec por entrevista** · papel: pm

```text
quero construir {feature}. me entreviste sobre implementação, UX, casos de borda e trade-offs até
cobrirmos tudo, depois escreva a spec em SPEC.md
```

Slots: `feature` = `rate limits por workspace`

**Por quê:** peça para *ser entrevistado* em vez de escrever a spec você mesmo. O Claude faz perguntas
estruturadas até os requisitos fecharem, e só então escreve.
**Depois:** virar skill `/spec` para toda spec começar igual. · **Fonte:** Best practices
**Neste repositório:** é exatamente o que `/sdd-specify` + `/sdd-clarify` fazem, com artefato versionado.

#### `turn-a-meeting-into`
**Transformar reunião em tickets** · papel: pm

```text
leia {input} e liste os action items, depois crie um ticket no {tracker} para cada um, com critérios de aceite
```

Slots: `input` = `@notas-da-reuniao.md` · `tracker` = `Linear`
**Requer:** issue tracker como MCP server ou connector.

**Por quê:** pula a etapa de transcrição. O Claude extrai os action items do input não-estruturado e
escreve direto no tracker — você revisa os tickets, não o transcript.
**Depois:** virar skill `/tickets`. · **Fonte:** How Anthropic teams use Claude Code

#### `map-edge-cases-before`
**Mapear casos de borda antes de construir** · papéis: design, pm

```text
liste os estados de erro, estados vazios e casos de borda de {feature} que o design precisa cobrir
```

Slots: `feature` = `o fluxo de upload de arquivo`

**Por quê:** pergunte pelo que **falta**, não pelo que existe. O Claude lista o que um design de
caminho feliz costuma pular. · **Fonte:** How Anthropic teams use Claude Code

---

### Design · Prototype

#### `turn-a-mockup-into`
**Mockup → protótipo funcional** · papéis: design, pm, marketing
**Cole:** arraste ou `@`-mencione a imagem do mockup antes de enviar.

```text
aqui está um mockup. construa um protótipo clicável, respeitando o layout e os estados mostrados
```

**Por quê:** protótipo clicável responde perguntas que mockup estático não responde. Entregue o código
funcionando para a engenharia em vez de descrever as interações num doc. · **Fonte:** How Anthropic teams use Claude Code

#### `implement-from-a-screenshot`
**Implementar a partir de screenshot, com auto-checagem** · papel: design
**Cole:** a imagem do design. **Requer:** forma de renderizar e screenshottar (app desktop, extensão Chrome, MCP Playwright).

```text
implemente este design, depois tire um screenshot do resultado, compare com o original, e corrija as diferenças
```

**Por quê:** dá ao Claude um **laço de verificação**: ele renderiza, compara com a imagem-fonte e
itera sem você apontar cada lacuna.
**Depois:** `/goal` para ele iterar até os screenshots casarem. · **Fonte:** Best practices

---

### Build · Implement

#### `follow-an-existing-pattern`
**Seguir um padrão que já existe**

```text
veja como {example} está implementado para entender o padrão, e construa {new} do mesmo jeito
```

Slots: `example` = `o handler de webhook do GitHub` · `new` = `um handler de webhook do Stripe`

**Por quê:** aponte para código que você já aprova. Sem referência, o Claude cai em boas práticas
genéricas; com ela, ele usa as convenções que o seu codebase de fato tem.
**Depois:** peça para gravar o padrão no `CLAUDE.md`, e sessões futuras acertam sem a referência. · **Fonte:** Best practices

#### `generate-docs-for-code`
**Documentar código sem documentação** · papel: docs

```text
ache {scope} sem comentários {format} e adicione, seguindo o estilo já usado no arquivo
```

Slots: `scope` = `as funções públicas em src/auth/` · `format` = `JSDoc`

**Por quê:** nomeie escopo e formato. O Claude acha o que falta e imita o estilo de comentário já
presente, então a doc nova lê como o resto. · **Fonte:** Common workflows

#### `add-a-small-well`
**Adicionar feature pequena e bem definida**

```text
adicione um endpoint {endpoint} que retorna {payload}
```

Slots: `endpoint` = `/health` · `payload` = `a versão do app e o uptime`

**Por quê:** declare entradas e saídas, não como construir. O Claude acha onde código parecido mora e
põe o seu ao lado. · **Fonte:** Common workflows

#### `build-a-small-internal`
**Ferramenta interna do zero** · papéis: pm, design, marketing, docs

```text
crie {tool} usando HTML, CSS e JavaScript puro, depois abra no meu navegador
```

Slots: `tool` = `um quadro Kanban com drag-and-drop e três colunas`

**Por quê:** você não precisa de projeto, framework nem build step. Descreva a ferramenta e peça para
abrir — você vê funcionando na hora. · **Fonte:** How Anthropic teams use Claude Code

#### `work-an-issue-end`
**Resolver uma issue ponta a ponta**
**Requer:** `gh` CLI autenticado, ou GitHub como connector/MCP.

```text
leia a issue #{issue}, implemente a correção, e rode os testes
```

Slots: `issue` = `312`

**Por quê:** dê o número, não um resumo. O Claude lê o ticket inteiro — inclusive requisitos que você
esqueceria de mencionar — e valida a mudança antes de reportar. · **Fonte:** Common workflows

#### `find-and-update-copy`
**Trocar copy em todo o codebase** · papéis: design, docs, marketing

```text
ache todo lugar onde dizemos "{copy}" ou variante próxima, me mostre cada um em contexto, e depois
troque todos por "{new}". não mexa nos testes nem no changelog
```

Slots: `copy` = `Cadastre-se grátis` · `new` = `Comece o teste grátis`

**Por quê:** peça por **variantes** e diga o que **pular**. O Claude acha fraseados que busca literal
perderia e deixa fixtures e histórico intactos. · **Fonte:** How Anthropic teams use Claude Code

#### `draft-from-past-examples`
**Redigir documento a partir de exemplos anteriores** · papéis: docs, marketing, pm

```text
leia {examples} em {folder} para aprender a estrutura e a voz, depois escreva um novo sobre {topic}
```

Slots: `examples` = `as avaliações de impacto de privacidade` · `folder` = `legal/pia/` · `topic` = `a nova integração de analytics`

**Por quê:** aponte para uma pasta de trabalho pronto em vez de descrever o seu estilo. O Claude
aprende estrutura e voz do que você já entregou.
**Depois:** virar skill para todo rascunho começar já com a voz certa. · **Fonte:** How Anthropic uses Claude in Legal

---

### Build · Test

#### `write-tests-run-them`
**Escrever testes, rodar, corrigir** ★ *comece por aqui (4)*

```text
escreva testes para {path}, rode, e corrija as falhas
```

Slots: `path` = `app/parsers/feed.py`

**Por quê:** pedir escrever + rodar + corrigir na mesma frase faz o Claude iterar sem parar para pedir
instrução.
**Depois:** `/init` para ele aprender o comando de teste do projeto. · **Fonte:** Common workflows

#### `drive-implementation-from-tests`
**TDD — teste primeiro**

```text
escreva os testes de {feature} primeiro, depois implemente até passarem
```

Slots: `feature` = `o fluxo de reset de senha`

**Por quê:** os testes definem quando o trabalho terminou, e o Claude itera na implementação até
passarem. · **Fonte:** Scaling agentic coding guide

#### `fill-gaps-from-a`
**Preencher lacunas a partir do relatório de cobertura**

```text
leia {report} e adicione testes para os arquivos de menor cobertura até cada um passar de {target}%
```

Slots: `report` = `coverage/coverage-summary.json` · `target` = `80`

**Por quê:** aponte para o relatório em vez de adivinhar o que não está coberto. O Claude lê os
números reais.
**Depois:** virar `/goal` para ele continuar até bater a meta. · **Fonte:** Common workflows

---

### Build · Refactor

#### `migrate-a-pattern-across`
**Migrar um padrão pelo codebase**

```text
migre tudo de {from} para {to}: identifique cada lugar que precisa mudar, depois faça as mudanças
```

Slots: `from` = `a API antiga de logging` · `to` = `o logger estruturado`

**Por quê:** descreva o padrão velho e o novo. Pedir para **identificar primeiro** faz os call sites
aparecerem na resposta, então você confere que nenhum ficou de fora. · **Fonte:** Common workflows

#### `port-code-between-languages`
**Portar código para outra linguagem**

```text
porte {source} para {target}, mantendo {keep}
```

Slots: `source` = `este módulo Python` · `target` = `Rust` · `keep` = `a mesma API pública e o mesmo comportamento nos testes`

**Por quê:** diga o que **preservar**, não só a linguagem-alvo. Nomear a API ou o comportamento que
não pode mudar dá ao Claude um contrato contra o qual checar o port. · **Fonte:** How Anthropic teams use Claude Code

#### `optimize-against-a-measurable`
**Otimizar contra alvo mensurável** · papel: data

```text
otimize {target} para trazer {metric} de {current} para menos de {goal}
```

Slots: `target` = `a query de busca` · `metric` = `latência p95` · `current` = `2s` · `goal` = `500ms`

**Por quê:** declarar métrica e alvo dá uma definição de pronto inequívoca.
**Depois:** virar `/goal` para ele medir e iterar até bater o número. · **Fonte:** Scaling agentic coding guide

#### `fix-a-precise-visual`
**Corrigir bug visual preciso** · papel: design

```text
o {element} passa {amount} além do {container} no {viewport}. corrija.
```

Slots: `element` = `botão de login` · `amount` = `20px` · `container` = `limite do card` · `viewport` = `mobile`

**Por quê:** feedback visual preciso rende correção precisa. Diga elemento, medida e viewport exatos.
**Depois:** dar ao Claude uma ferramenta de preview para ele mesmo screenshottar e verificar. · **Fonte:** Scaling agentic coding guide

---

### Build · Review

#### `review-your-changes-before`
**Revisar antes de commitar** ★ *comece por aqui (5)*

```text
revise minhas mudanças não commitadas e sinalize o que parece arriscado antes de eu commitar
```

**Por quê:** pega problema enquanto ainda é barato. O Claude lê os arquivos alterados **inteiros**,
não só as linhas do diff, e vê coisa que auto-revisão rápida perde.
**Depois:** `/code-review` faz o mesmo em um comando. · **Fonte:** Common workflows

#### `review-a-pull-request`
**Revisar um pull request**
**Requer:** `gh` CLI ou GitHub como connector.

```text
revise o PR #{pr} e resuma o que mudou, depois liste as preocupações
```

Slots: `pr` = `247`

**Por quê:** o Claude revisa com o codebase inteiro em contexto, não só o diff. Ele lê o código
alterado **e o que ele chama**, então pega problema que revisão diff-only não pegaria. · **Fonte:** Common workflows

#### `review-infrastructure-changes-before`
**Revisar mudança de infraestrutura antes de aplicar** · papéis: security, ops
**Cole:** a saída do `terraform plan` no prompt.

```text
aqui está a saída do meu plano Terraform. o que isso vai fazer, e tem algo aqui que vai causar problema?
```

**Por quê:** saída de plano é densa e difícil de escanear. Colar rende um resumo em linguagem clara do
que vai mudar de fato, antes do apply. · **Fonte:** How Anthropic teams use Claude Code

#### `run-a-security-review`
**Revisão de segurança com subagente** · papel: security

```text
use um subagente para revisar {path} em busca de problemas de segurança e reporte o que ele achar
```

Slots: `path` = `src/api/`

**Por quê:** o subagente roda a auditoria na **janela de contexto dele** e devolve só o resumo — uma
revisão longa não entope a sessão principal.
**Depois:** montar um subagente de security-review dedicado, compartilhado com o time. · **Fonte:** Best practices

#### `review-content-before-sending`
**Pegar problemas antes da revisão formal** · papéis: marketing, docs

```text
revise {file} procurando {concerns} e liste o que eu devo corrigir antes de mandar para {reviewer}
```

Slots: `file` = `post-de-lancamento.md` · `concerns` = `afirmações sem lastro, atribuições faltando e problemas de brand guideline` · `reviewer` = `o jurídico`

**Por quê:** um primeiro passe antes de um humano gastar tempo. Nomear as preocupações mantém a
revisão focada.
**Depois:** capturar seu checklist de revisão como skill do time. · **Fonte:** How Anthropic uses Claude in Legal

---

### Build · Steer

#### `course-correct-a-wrong`
**Corrigir o rumo de uma abordagem errada**

```text
não é isso: {feedback}. tente uma abordagem diferente
```

Slots: `feedback` = `a assinatura da função precisa continuar retrocompatível`

**Por quê:** nomeie a **restrição** que o Claude perdeu, não só que está errado. Um motivo concreto dá
uma restrição a satisfazer na retentativa, em vez de outro chute.
**Depois:** `Esc Esc` abre o rewind e restaura código e conversa, para a retentativa começar limpa. · **Fonte:** Best practices

#### `narrow-the-scope-of`
**Reduzir o escopo de uma mudança**

```text
foi mudança demais. mantenha só as alterações em {scope} e desfaça o resto
```

Slots: `scope` = `a lógica de validação em src/forms/`

**Por quê:** quando a direção está certa mas a mudança ficou larga, peça para **manter uma parte** em
vez de rebobinar tudo. Um limite declarado impede que uma correção pequena vire refactor. · **Fonte:** Best practices

#### `turn-a-correction-into`
**Transformar correção em regra**

```text
você fica {mistake}. adicione uma regra no CLAUDE.md para isso parar de acontecer
```

Slots: `mistake` = `usando default export quando este projeto usa named export`

**Por quê:** correção no chat não é compartilhada com o time. Regra no `CLAUDE.md` do projeto é lida
no começo de toda sessão — e commitada, vale para todo mundo.
**Depois:** `/memory` para revisar o que ele escreveu. · **Fonte:** Best practices

---

### Ship · Git

#### `resolve-merge-conflicts`
**Resolver conflitos de merge**

```text
resolva os conflitos de merge nesta branch e explique o que você manteve de cada lado
```

**Por quê:** diga qual estado você quer, não quais marcadores manter. Pedir o raciocínio torna o merge
revisável em vez de caixa-preta. · **Fonte:** Common workflows

#### `commit-with-a-generated`
**Commitar com mensagem gerada**

```text
commite estas mudanças com uma mensagem que resuma o que eu fiz
```

**Por quê:** deixe o Claude derivar a mensagem do diff — ele imita o estilo de commit que o repositório
já tem. · **Fonte:** Common workflows

#### `open-a-pull-request`
**Abrir PR a partir de um ticket**
**Requer:** issue tracker como connector/MCP.

```text
ache o ticket do {tracker} sobre {topic} e abra um PR que o implemente
```

Slots: `tracker` = `Linear` · `topic` = `o timeout de login`

**Por quê:** elimina o troca-troca entre tracker, editor e GitHub. Um prompt lê a spec, faz a mudança
e abre o PR. · **Fonte:** Common workflows

---

### Ship · Release

#### `draft-release-notes-from`
**Release notes a partir do histórico git** · papéis: pm, docs, marketing

```text
compare {from} com {to} e escreva release notes agrupadas em feature, correção e breaking change
```

Slots: `from` = `v2.3.0` · `to` = `v2.4.0`

**Por quê:** dê dois pontos de referência e a estrutura desejada. O Claude lê o log entre eles e
escreve um changelog editável.
**Depois:** virar skill `/changelog`. · **Fonte:** Common workflows

#### `write-a-ci-workflow`
**Escrever um workflow de CI** · papel: ops

```text
escreva um workflow do GitHub Actions que {steps} a cada push na {branch}
```

Slots: `steps` = `roda os testes e faz deploy no staging` · `branch` = `main`

**Por quê:** descreva quando roda e o que faz; o YAML sai pronto, casado com os comandos de build e
teste do seu projeto. · **Fonte:** Common workflows

---

### Operate · Debug

#### `find-and-fix-a`
**Achar e corrigir teste quebrado** ★ *comece por aqui (3)*

```text
o teste {test} está falhando, descubra por quê e corrija
```

Slots: `test` = `UserAuth`

**Por quê:** descreva o sintoma; você não precisa saber qual arquivo quebrou. O Claude roda o teste
para ver a falha, rastreia até o fonte e corrige. · **Fonte:** Common workflows

#### `investigate-a-reported-error`
**Investigar erro reportado** · papel: ops

```text
usuários estão vendo {symptom} em {where}. investigue e me diga o que está acontecendo
```

Slots: `symptom` = `erros 500` · `where` = `/api/settings`

**Por quê:** descreva sintoma e local; o Claude lê o caminho de código relevante e rastreia causas
prováveis. Cole stack traces ou logs se tiver.
**Depois:** deeplink no runbook que abre o Claude com esse prompt pré-preenchido. · **Fonte:** Common workflows

#### `fix-a-build-error`
**Corrigir erro de build na raiz** · papel: ops
**Cole:** a saída do erro no prompt.

```text
aqui está um erro de build. corrija a causa raiz e verifique que o build passa
```

**Por quê:** pedir causa raiz **e** verificação impede remendo superficial que só suprime o erro. · **Fonte:** Best practices

---

### Operate · Incident

#### `investigate-a-production-incident`
**Investigar incidente em produção** · papéis: ops, security

```text
{symptom}. verifique os logs, deploys recentes e mudanças de configuração, e me diga a causa mais provável
```

Slots: `symptom` = `o endpoint de checkout começou a retornar 500 há uma hora`

**Por quê:** liste as **fontes de evidência a correlacionar**, não os passos a seguir. O Claude lê
logs, histórico git e config juntos para estreitar a causa.
**Depois:** conectar Sentry ou o log store via MCP. · **Fonte:** Common workflows

#### `diagnose-from-a-console`
**Diagnosticar a partir de screenshot de console** · papéis: ops, data
**Cole:** o screenshot.

```text
aqui está um screenshot do {console}. me explique por que {resource} está falhando e me dê os
comandos exatos para corrigir
```

Slots: `console` = `dashboard do Kubernetes no GCP` · `resource` = `este pod`

**Por quê:** consoles cloud mostram o problema mas não os comandos. O Claude lê o screenshot e traduz
o dashboard em `kubectl`, `gcloud` ou `aws`. · **Fonte:** How Anthropic teams use Claude Code

#### `query-logs-in-plain`
**Consultar logs em linguagem natural** · papéis: security, ops, data
**Requer:** data warehouse ou log store como connector/MCP.

```text
me mostre todos os {events} de {scope} nas {timeframe}. escreva a query, rode, e me diga o que chama atenção
```

Slots: `events` = `logins que falharam` · `scope` = `o serviço de auth` · `timeframe` = `últimas 24 horas`

**Por quê:** faça a pergunta em vez de escrever o SQL. O Claude monta a query, roda, e mostra **query
e resultado**, para você conferir o que rodou. · **Fonte:** How Anthropic uses Claude in Cybersecurity

---

### Operate · Data

#### `analyze-a-data-file`
**Analisar arquivo de dados** · papéis: data, pm, marketing
**Cole:** arraste o arquivo ou troque o caminho por uma `@`-menção.

```text
leia {file}, resuma os padrões principais, e escreva o resultado em {output}
```

Slots: `file` = `@reports/q1-signups.csv` · `output` = `uma página HTML com gráficos, e abra no meu navegador`

**Por quê:** pergunta pontual não precisa de script pontual. Aponte um arquivo da pasta e o Claude lê
direto, acha os padrões e escreve a saída onde você mandar.
**Depois:** conectar a fonte via MCP em vez de exportar arquivos. · **Fonte:** How Anthropic teams use Claude Code

#### `generate-variations-from-performance`
**Gerar variações a partir de dados de performance** · papéis: marketing, data
**Cole:** o CSV.

```text
leia {file}, ache {items} com baixa performance, e gere {n} novas variações com menos de {limit} caracteres
```

Slots: `file` = `@ads-performance.csv` · `items` = `os títulos` · `n` = `20` · `limit` = `90`

**Por quê:** declare a restrição **no começo** para a geração já sair dentro do limite. · **Fonte:** How Anthropic teams use Claude Code

---

### Operate · Automate

#### `turn-a-recurring-task`
**Transformar tarefa recorrente em skill**

```text
crie uma skill /{name} para este projeto que {steps}
```

Slots: `name` = `ship` · `steps` = `roda o linter e os testes, depois escreve a mensagem de commit`

**Por quê:** nomeie os passos uma vez, reutilize como comando. O Claude escreve uma skill que qualquer
um do time roda. · **Fonte:** Common workflows

#### `add-a-hook-for`
**Adicionar hook para comportamento repetido**

```text
escreva um hook que {action} depois de cada {event}
```

Slots: `action` = `roda o prettier` · `event` = `edição em arquivo .ts ou .tsx`

**Por quê:** hooks tornam o comportamento **automático** em vez de algo que você tem de lembrar de
pedir. Descreva gatilho e ação, e o Claude escreve a configuração. · **Fonte:** Best practices

#### `connect-a-tool-with`
**Conectar uma ferramenta com MCP**

```text
configure o MCP server do {server} para você conseguir ler meus {data} diretamente
```

Slots: `server` = `Sentry` · `data` = `relatórios de erro`

Exemplos prontos:

```text
configure o MCP server do GitHub para você conseguir ler minhas issues e PRs diretamente
configure o MCP server do Sentry para você conseguir ler meus relatórios de erro diretamente
configure o MCP server do Linear para você conseguir ler meus tickets diretamente
configure o MCP server do Figma para você conseguir ler meus arquivos de design diretamente
```

**Por quê:** conecte a fonte **uma vez** em vez de colar dados toda sessão. Depois do setup, o Claude
lê da ferramenta direto quando você pergunta sobre ela.
**Contraponto oficial** (de Best practices): quando existe **CLI** para o serviço — `gh`, `aws`,
`gcloud` —, a CLI é mais econômica em contexto que o MCP. Prefira MCP quando não há CLI, ou quando os
dados são estruturados o bastante para ferramentas tipadas valerem o custo. · **Fonte:** Common workflows

#### `capture-what-to-remember`
**Registrar o que lembrar da próxima vez** · papéis: pm, docs

```text
resuma o que fizemos nesta sessão e sugira o que adicionar ao CLAUDE.md
```

**Por quê:** pergunte antes de esquecer. O Claude sabe o que teve de descobrir na sessão e propõe as
entradas, para a próxima sessão já começar com esse contexto. · **Fonte:** How Anthropic teams use Claude Code

## 4. Os seis padrões por trás dos 52

Quando nenhuma entrada da §2 casa, escreva o prompt aplicando estes — é o que a fonte declara como
denominador comum.

| Padrão | Regra | Exemplo |
|---|---|---|
| **Resultado, não passos** | diga o que quer; deixe o Claude achar os arquivos | `adicione rate limiting na API pública e garanta que os testes existentes passam` |
| **Um jeito de se auto-verificar** | peça rodar/testar/comparar **no mesmo prompt** | `escreva a migração, rode contra o banco de dev, e confirme que o schema bate` |
| **Aponte uma referência** | nomeie arquivo, teste ou padrão a imitar | `adicione uma página de settings com o mesmo layout da página de perfil` |
| **Alvo mensurável** | métrica + limiar, para "pronto" ser inequívoco | `deixe o bundle abaixo de 200KB e me mostre o que você removeu` |
| **Dê o artefato** | cole erro, log, screenshot, plano; ou `@arquivo` | `por que o build está falhando? @build.log` |
| **Diga o formato da resposta** | formato, tamanho, público | `explique a lógica de retry de pagamento como página HTML com diagrama, e abra no navegador` |

**Distribuição observada** (52 prompts): `build` 22 · `operate` 12 · `discover` 7 · `design` 6 ·
`ship` 5. Papéis marcados: `pm`, `design`, `docs`, `marketing`, `ops`, `security`, `data` — **25 dos
52 não têm papel**, ou seja, são de engenharia geral. A existência dos papéis é o sinal: a Anthropic
posiciona o Claude Code como ferramenta de **toda a organização**.

## 5. Onde isto encosta no fluxo SDD deste repositório

Sobreposição declarada, para não haver duas verdades:

| Prompt da biblioteca | Equivalente aqui | Qual usar |
|---|---|---|
| `draft-a-spec-by` | `/sdd-specify` + `/sdd-clarify` | O comando, quando a feature merece artefato versionado; o prompt, para rascunho descartável |
| `plan-a-multi-file` | `/sdd-plan` | O comando produz `plan.md` rastreável; o prompt é plan mode ad hoc |
| `review-your-changes-before` | `/sdd-converge`, `/code-review` | `converge` audita **contra a spec**; o prompt audita o diff em si |
| `map-edge-cases-before` | análise de obstáculos (KAOS) no `/sdd-specify` | O comando, em feature real |
| `turn-a-recurring-task` | como os próprios `sdd-*` nasceram | — |

A calibração oficial vale aqui também: *"se você consegue descrever o diff em uma frase, pule o
plano"* — e, por extensão, pule o SDD. Prompt da biblioteca é o **caminho leve**; o fluxo SDD é o
caminho pesado. Escolher errado nos dois sentidos custa: cerimônia demais para typo, cerimônia de
menos para mudança de schema.

---

**Ver também:** [anthropic-claude-code.md](anthropic-claude-code.md) (destilação de best-practices e
common-workflows) · [09-decisao-estados-algoritmos.md](09-decisao-estados-algoritmos.md) ·
**Volta ao índice:** [README](README.md)
