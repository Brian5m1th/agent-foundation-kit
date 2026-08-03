# mattpocock/skills — disciplinas de engenharia empacotadas como skills

> Fonte: [github.com/mattpocock/skills](https://github.com/mattpocock/skills), README + 14 `SKILL.md`.
> Lida em 2026-08-02.
> Selos: `[INDÚSTRIA]` prática de um praticante reconhecido, sem validação controlada ·
> `[CONSOLIDADO]` o que ele herda de literatura revisada · `[OFICIAL]` mecanismo documentado pela
> Anthropic · `[HIPÓTESE]` conclusão desta KB, com condição de falsificação.

Esta é a **primeira destilação de fonte não-oficial** desta KB. Ela entra porque cobre cinco lacunas
reais do corpus daqui (§5) e porque é a crítica mais direta que existe ao fluxo `sdd-*` (§1).
Decisão de absorver em vez de instalar: [ADR-011](11-adrs.md).

---

## 1. A tese, e por que ela mira neste repositório

`[INDÚSTRIA]` O argumento de abertura é explícito: *"Approaches like GSD, BMAD, and Spec-Kit try to
help by owning the process. But while doing so, they take away your control and make bugs in the
process hard to resolve."* A proposta oposta é um conjunto de skills **pequenas, adaptáveis e
componíveis**, sem framework que sequencie o trabalho.

O fluxo `sdd-*` deste repositório é modelado sobre o Spec Kit — ou seja, é exatamente o alvo. Vale
levar a crítica a sério em vez de arquivá-la:

- **Onde ela acerta.** Um processo que sempre roda inteiro é AP-03 (Marreta na Noz). O `labs` já
  responde com H-16 (peso do processo proporcional ao porte) e ADR-002 (calibração por custo de
  reversão) — mas a resposta só vale se o roteamento realmente barrar o caminho pesado nas mudanças
  pequenas, e isso é comportamento, não texto.
- **Onde ela cobra um preço.** Sem sequência imposta, não há portão determinístico, e ADR-003 diz que
  portão é o que separa fluxo com garantia de fluxo com aparência de garantia. O conjunto de skills
  compensa com **cadência humana** — o usuário decide o próximo passo a cada vez.
- `[HIPÓTESE]` As duas abordagens não competem no mesmo eixo: o Spec Kit resolve **sequência**, este
  conjunto resolve **disciplina dentro do passo**. Um passo do `sdd-*` executado com a disciplina de
  `codebase-design` e `diagnosing-bugs` é estritamente melhor que sem. *Falsificação:* se a adoção
  dos padrões desta destilação não reduzir retrabalho dentro das fases do fluxo, a hipótese cai.

## 2. Os dois eixos de invocação

`[INDÚSTRIA]` A taxonomia mais reusável do repositório, e a que o `labs` não tinha nomeado:

| | **User-invoked** | **Model-invoked** |
|---|---|---|
| Quem dispara | só o humano, digitando `/nome` | o humano **ou** o agente, quando a tarefa encaixa |
| Papel | **orquestrar** um fluxo | guardar a **disciplina reutilizável** |
| Custo | carga cognitiva — você tem de lembrar que existe | carga de contexto — a `description` ocupa token em todo turno |
| Mecanismo | `[OFICIAL]` `disable-model-invocation: true` no frontmatter | default do formato SKILL.md |

**A regra de composição:** uma skill user-invoked pode invocar skills model-invoked, **nunca outra
user-invoked**. Isso mantém o grafo de orquestração raso e impede que dois orquestradores disputem o
mesmo fluxo.

`[HIPÓTESE]` Mapeado para este repositório: os comandos `sdd-*` são todos user-invoked e nenhum invoca
outro — o fluxo é sequenciado pelo humano, o que está de acordo com a regra. O que falta aqui é a
camada model-invoked: disciplinas que o agente alcança sozinho no meio de uma task.

## 3. Os quatro modos de falha que motivam o conjunto

`[INDÚSTRIA]` A organização é por sintoma, não por fase — e cada sintoma tem um remédio nomeado.

| # | Falha | Diagnóstico | Remédio no repo externo | Correspondente aqui |
|---|---|---|---|---|
| 1 | *"O agente não fez o que eu quis"* | desalinhamento — *"no-one knows exactly what they want"* `[CONSOLIDADO]` (Hunt & Thomas) | `grilling` antes de qualquer código | INT-06, INT-07 e **INT-08**, `/sdd-clarify` |
| 2 | *"O agente é verboso demais"* | falta de linguagem ubíqua `[CONSOLIDADO]` (Evans) | `CONTEXT.md` como glossário do projeto | **lacuna** → CTX-06 |
| 3 | *"O código não funciona"* | loop de feedback ausente | `tdd` + `diagnosing-bugs` | AP-23, VER-04; loop → **lacuna** → VER-06 |
| 4 | *"Construímos uma bola de lama"* | entropia acelerada pelo agente `[CONSOLIDADO]` (Beck, Ousterhout) | `codebase-design` + varredura periódica | **lacuna** → PLN-05 |

`[INDÚSTRIA]` O ponto do modo 4 que vale reter: agentes não criam a entropia, **aceleram** a que já
existia. O custo do design ruim passa a ser cobrado por sessão, não por trimestre.

## 4. Catálogo — as 21 skills e onde cada uma encosta no fluxo daqui

`[INDÚSTRIA]` Descrições conforme o README da fonte. A última coluna é leitura desta KB.

### Engenharia — user-invoked

| Skill | O que faz | Onde encosta aqui |
|---|---|---|
| `ask-matt` | roteador sobre as demais skills | a tabela de gatilho do [CLAUDE.md](../CLAUDE.md) e `AD-01` |
| `grill-with-docs` | entrevista que também constrói `CONTEXT.md` e ADRs | `/sdd-clarify` + INT-08 + CTX-06 |
| `triage` | move issues por uma máquina de estados de triagem | `ME-01` (ciclo de vida da spec) |
| `improve-codebase-architecture` | varre o codebase por oportunidades de aprofundamento e apresenta em relatório HTML | PLN-05 |
| `setup-matt-pocock-skills` | configura tracker, rótulos e destino de docs, uma vez por repo | `/sdd-constitution` |
| `to-spec` | converte a conversa atual em spec, **sem entrevista** | `/sdd-specify` |
| `to-tickets` | quebra plano/spec em tickets *tracer bullet* com arestas de bloqueio declaradas | `/sdd-tasks`, PLN-02, PLN-03 |
| `implement` | executa a partir de spec/tickets, dirigindo `tdd` e fechando com `code-review` | `/sdd-implement` |
| `wayfinder` | mapeia trabalho grande demais para uma sessão como tickets de decisão | **lacuna** → PLN-06 |

### Engenharia — model-invoked

| Skill | O que faz | Onde encosta aqui |
|---|---|---|
| `prototype` | protótipo descartável para responder a uma pergunta de design | `experiments/` |
| `diagnosing-bugs` | loop disciplinado para bug difícil e regressão de performance | **lacuna** → VER-06 |
| `research` | investiga contra fonte primária e grava markdown citado, como agente em background | CTX-03 |
| `tdd` | red-green-refactor em fatia vertical | VER-04, AP-23 |
| `domain-modeling` | constrói e afia o modelo de domínio, atualizando `CONTEXT.md` e ADRs | **lacuna** → CTX-06 |
| `codebase-design` | vocabulário compartilhado para desenhar módulos profundos | **lacuna** → PLN-05 |
| `code-review` | revisão em dois eixos (Standards × Spec) em subagentes paralelos | VER-01, VER-02, ADR-004 |
| `resolving-merge-conflicts` | resolve hunk a hunk pela intenção de cada lado; **nunca `--abort`** | `resolve-merge-conflicts` da [prompt-library](prompt-library.md) |

### Produtividade

| Skill | Tipo | O que faz | Onde encosta aqui |
|---|---|---|---|
| `grill-me` | user | entrevista sem rastro documental, para quando não há codebase | INT-06, INT-08 |
| `handoff` | user | compacta a conversa num documento de passagem | **lacuna** → CTX-07 |
| `teach` | user | ensina um conceito ao longo de várias sessões, usando o diretório como workspace | — |
| `writing-great-skills` | user | referência de como escrever skill previsível | ADR-005, AP-02, AP-35–37 |
| `grilling` | modelo | o laço de entrevista por trás de `grill-me` e `grill-with-docs` | **INT-08**, INT-07, H-17 |

## 5. As técnicas que valem importar

Cinco lacunas e duas afinações. Cada uma vira identificador citável — é isso que separa absorver de
arquivar.

### 5.1 `grill-me` / `grilling` — a entrevista conduzida → `INT-08`, `H-17`

`[INDÚSTRIA]` É a skill mais popular do conjunto e a que o autor manda usar **toda vez** que se vai
fazer uma mudança. O diagnóstico que a motiva é o modo de falha nº 1: *"a falha mais comum no
desenvolvimento de software é o desalinhamento. Você acha que o dev entendeu o que você quer. Aí você
vê o que ele construiu — e percebe que ele não te entendeu de jeito nenhum."* `[CONSOLIDADO]` Com a
epígrafe de Hunt & Thomas: *"ninguém sabe exatamente o que quer."*

**O achado estrutural, e é o mais instrutivo do repositório inteiro.** `grill-me` tem **duas linhas**:

```
---
name: grill-me
description: A relentless interview to sharpen a plan or design.
disable-model-invocation: true
---
Run a `/grilling` session.
```

Toda a substância mora em `grilling`, que é model-invoked e cabe em oito regras. É o eixo §2 aplicado
em estado puro: o user-invoked **só orquestra**, o model-invoked **guarda a disciplina** — e por isso a
mesma disciplina é reusada por `grill-with-docs`, por `improve-codebase-architecture` e por `wayfinder`
sem nenhuma duplicação.

`[HIPÓTESE]` A lição para este repositório é desconfortável e vale registrar: a skill mais valiosa do
conjunto tem duas linhas de corpo e oito regras de disciplina. Valor de skill não correlaciona com
tamanho — correlaciona com **quantas decisões ela remove**. É AP-27 e ADR-005 vistos pelo lado positivo.

**As oito regras**, na íntegra do que a fonte declara — reproduzidas como padrão em `INT-08`:

| # | Regra | O que ela impede |
|---|---|---|
| 1 | entrevistar implacavelmente até **entendimento compartilhado** | entrevista que para na primeira resposta plausível |
| 2 | descer a árvore de decisão **resolvendo dependências uma a uma** | decidir a folha antes da raiz, e refazer tudo |
| 3 | toda pergunta traz **a resposta recomendada** | transferir ao humano o custo de decidir do zero |
| 4 | **uma pergunta por vez**, esperando a resposta | resposta rasa por sobrecarga |
| 5 | *"perguntar várias coisas de uma vez é desnorteante"* | — a justificativa de 4, declarada |
| 6 | **fato** descobrível no ambiente é buscado, **nunca** perguntado | gastar o humano com o que o grep responde |
| 7 | **decisão é do humano**: apresente e espere | o agente decidir por conta e chamar isso de premissa |
| 8 | **não agir** antes da confirmação de entendimento | implementar o plano errado com eficiência |

**O eixo é a separação fato × decisão** (6 e 7): o agente carrega todo o custo de *descobrir*, o humano
carrega só o de *escolher*. E o término não é do agente — regra 8 exige confirmação explícita.

`[HIPÓTESE]` **Isto parece contradizer AP-09 (Interrogatório) e não contradiz.** O defeito de AP-09
sempre foi a rajada **sem recomendação**, que devolve ao humano o trabalho que o agente deveria ter
feito. Uma pergunta com recomendação embutida custa um "sim". A tensão real é com INT-07, que manda
inferir o inferível — e as duas compõem exatamente na regra 6: infira e busque o que der, pergunte o
resto uma de cada vez, sempre com recomendação.

**As três variantes, e quando usar cada uma** `[INDÚSTRIA]`:

| Variante | Quando | Rastro que deixa |
|---|---|---|
| `grill-me` | não há codebase, ou a decisão não é de código | nenhum — é conversa |
| `grill-with-docs` | há codebase; roda `grilling` **mais** `domain-modeling` | `CONTEXT.md` e ADRs atualizados **durante** a entrevista |
| `grilling` | dentro de outra skill que precisa da disciplina | o que a skill hospedeira decidir |

`[INDÚSTRIA]` O autor chama `grill-with-docs` de *"possivelmente a técnica mais legal deste
repositório"*, pelo efeito composto: a entrevista não só alinha, ela **destila o vocabulário** enquanto
alinha (§5.2) — cada sessão seguinte começa mais barata que a anterior.

`[HIPÓTESE]` Encaixe no fluxo daqui: `INT-08` é o **como** de `/sdd-clarify`, e o comando não descreve
condução hoje — resolve ambiguidade, sem dizer em que ordem nem com que postura. Vale também antes de
`/sdd-specify` quando o pedido chegou em duas frases (INT-06). O que **não** transfere é a variante sem
rastro: aqui toda decisão de entrevista tem de aterrissar em `spec.md` ou em Premissas, senão vira
AP-19 (Ambiguidade Silenciosa) com aparência de alinhamento.

### 5.2 Linguagem ubíqua do projeto → `CTX-06`

`[CONSOLIDADO]` Evans: com linguagem ubíqua, conversa e código derivam do mesmo modelo. `[INDÚSTRIA]`
A implementação é um `CONTEXT.md` versionado, **só glossário, zero detalhe de implementação**, atualizado
no momento em que um termo se resolve — nunca em lote. O exemplo da fonte: *"há um problema quando uma
lição dentro de uma seção de um curso é tornada real (ganha um lugar no sistema de arquivos)"* vira
*"há um problema na cascata de materialização"*.

`[INDÚSTRIA]` Os ganhos declarados vão além da concisão: variáveis, funções e arquivos passam a ser
nomeados de forma consistente; o codebase fica mais navegável para o agente; e o raciocínio gasta menos
token porque existe uma palavra onde havia uma frase. ADR só quando a decisão é **difícil de reverter,
surpreendente e resultado de trade-off real** — os três critérios juntos.

`[HIPÓTESE]` A fronteira que impede o `CONTEXT.md` de virar AP-02: ele é glossário, não spec nem
rascunho. No instante em que ganha "como fazemos X", virou enciclopédia.

### 5.3 Vocabulário de módulo profundo → `PLN-05`

`[CONSOLIDADO]` Ousterhout: *"os melhores módulos são profundos — muita funcionalidade acessível por
uma interface simples"*. Feathers: *seam* é o lugar onde se pode alterar comportamento sem editar
naquele lugar.

`[INDÚSTRIA]` As definições operacionais, que são a contribuição real:

- **Módulo** — qualquer coisa com interface e implementação. Deliberadamente agnóstico de escala.
- **Interface** — *"tudo o que quem chama precisa saber para usar o módulo corretamente"*: assinatura,
  mas também invariantes, ordem de chamada, modos de erro, configuração exigida e características de
  desempenho.
- **Profundidade** — comportamento exercitável por unidade de interface que o chamador precisa aprender.
  **Propriedade da interface, não da implementação.**
- **Adaptador** — coisa concreta que satisfaz uma interface num seam. Descreve **papel**, não substância.
- **Alavancagem** e **localidade** — capacidade por unidade de interface aprendida, e concentração de
  mudança/bug/conhecimento num lugar só.

E três regras de decisão:

1. **Teste da deleção** — apague o módulo mentalmente. Se a complexidade some, ele era passa-fio. Se
   reaparece espalhada por N chamadores, ele pagava o próprio preço.
2. **A interface é a superfície de teste** — chamadores e testes cruzam o mesmo seam. Interface ruim é
   teste ruim, sempre.
3. **Um adaptador é seam hipotético; dois adaptadores é seam real.** O antídoto contra AP-24
   (over-engineering) e contra a *speculative generality* de Fowler.

### 5.4 Mapa de decisões sob névoa → `PLN-06`

`[INDÚSTRIA]` `wayfinder` resolve o caso que o SDD daqui não cobre: a ideia é grande e **envolta em
incerteza**, e não cabe numa sessão. A forma:

- Um artefato-mapa com **Destino · Decisões até aqui · Ainda não especificado · Fora de escopo**.
- O mapa é **índice, não armazenamento**: *"a decisão vive em exatamente um lugar"* — o mapa aponta.
- Filhos que se bloqueiam mutuamente. A **fronteira** são os filhos abertos, desbloqueados e não
  reivindicados; é a borda do conhecido.
- Uma sessão resolve **um** ticket (exceto pesquisas em paralelo). Reivindique antes de trabalhar.
- Termina quando *"não sobra nada a decidir antes de alguém ir e fazer a coisa"* — fronteira vazia.

`[HIPÓTESE]` Encaixe aqui: roda **antes** de `/sdd-specify`, não no lugar dele. O sintoma que dispara é
"não sei nem o que especificar"; o de `/sdd-specify` é "sei o que quero, falta escrever".

### 5.5 Loop de feedback antes da hipótese → `VER-06`

`[INDÚSTRIA]` A frase que carrega a skill `diagnosing-bugs`: sobre construir um sinal vermelho/verde que
pegue **este** bug — *"esta é a habilidade; todo o resto é mecânico"*. As seis fases:

1. **Construir o loop.** Dez formas ordenadas por preferência, do teste no seam ao script HITL, passando
   por curl, CLI com fixture diffada, browser headless, replay de trace, harness descartável, laço de
   propriedade/fuzz, `git bisect run` e loop diferencial entre versões.
   Critério de pronto, como checklist: **capaz de ficar vermelho** (pega o sintoma exato do usuário) ·
   **determinístico** · **rápido** (segundos) · **executável por agente sem humano**.
2. **Reproduzir e minimizar** — encolher até que todo elemento restante seja portante: remover qualquer
   um torna verde.
3. **Hipotetizar** — 3 a 5 hipóteses **ranqueadas antes de testar**, no formato falsificável *"se X é a
   causa, então mudar Y faz o bug sumir / mudar Z o piora"*. Mostrar a lista ao humano, que reordena de
   graça com conhecimento de domínio.
4. **Instrumentar** — cada sonda mapeia para uma predição. **Uma variável por vez.** Preferência:
   debugger/REPL → log no limite que distingue hipóteses → **nunca** "logar tudo e grepar". Log de
   depuração leva tag única (`[DEBUG-a4f2]`) para sair depois num grep só.
5. **Corrigir** — teste de regressão escrito **antes** do fix, e só num seam correto. Se não há seam, o
   achado é arquitetural: registre, não force.
6. **Limpar e post-mortem** — repro original não reproduz mais · teste passa (ou a ausência está
   documentada) · nenhuma tag `[DEBUG-…]` sobrou · protótipos apagados · a hipótese correta está na
   mensagem do commit. Fecha perguntando **o que teria evitado este bug**.

`[HIPÓTESE]` Isto não substitui VER-04 (Falha Forçada), que prova que a verificação mede algo. VER-06
é anterior: constrói a verificação que VER-04 vai testar.

### 5.6 Handoff entre sessões → `CTX-07`

`[INDÚSTRIA]` Documento de passagem gravado **no diretório temporário do SO, não no workspace**, que:
referencia spec, ADR, issue, commit e diff por caminho/URL em vez de duplicá-los; **redige segredos e
PII**; e traz uma seção de **skills sugeridas** para a próxima sessão. Recebe como argumento *para que
a próxima sessão vai servir*.

`[HIPÓTESE]` Fecha um buraco operacional daqui: H-02 e H-15 mandam trocar de sessão, I-09 exige contexto
separado para verificar — e nenhum dos três diz **o que atravessa**. Sem artefato, ou se perde contexto
ou se cola a conversa inteira, que reintroduz o problema que o `/clear` resolveu.

### 5.7 Afinações do que já existe

`[INDÚSTRIA]` Três detalhes que refinam padrões existentes sem criar identificador novo:

- **Revisão em dois eixos** (`code-review`): *Standards* (convenções do repo + linha de base dos smells
  de Fowler) e *Spec* (implementa fielmente a issue de origem?), em dois subagentes **paralelos**, cada
  relatório com ~400 palavras, contra um ponto fixo validado por `git rev-parse` e diff de três pontos.
  A regra que vale importar para VER-01/VER-02: **não reordenar achados entre os eixos** — o relatório
  preserva os dois, com um resumo de uma linha por eixo. Misturar as listas esconde o pior achado do
  eixo mais silencioso.
- **Fatia vertical e teste tautológico** (`tdd`): a fatia corta *estreito mas completo* por todas as
  camadas, e cada uma cabe numa janela de contexto. Bom teste *"lê como uma especificação"* e sobrevive
  a refatoração. Tautológico é o que recomputa o esperado do mesmo jeito que o código — reforça AP-23.
  *"Refatorar não faz parte do laço"*: acontece na revisão.
- **Aresta de bloqueio declarada** (`to-tickets`): cada ticket declara explicitamente por quem está
  bloqueado; sem bloqueador, começa já. É AP-28 (Dependência Implícita) resolvido no formato do ticket,
  e é o que o `depends_on` do sdd-kit faz em JSON. Refactor amplo usa **expand–contract**: forma nova ao
  lado da velha, migração em lotes, contração no fim.

## 6. O que não adotamos, e por quê

`[HIPÓTESE]` Registro honesto do que foi lido e recusado — sem ele a destilação vira propaganda:

| Item | Por que fica de fora |
|---|---|
| Instalar o plugin ou `skills.sh` | [ADR-011](11-adrs.md). Duas coleções de comandos concorrendo pelo mesmo gatilho é AP-14 no espaço de nomes de skill; a fonte alerta que instalar os dois modos deixa tudo em duplicata |
| Substituir `sdd-*` pelo conjunto | O fluxo daqui é upstream de quatro projetos reais; trocar a sequência por cadência humana perderia os portões de ADR-003 |
| Rótulo `ready-for-agent` e integração com tracker | Depende de GitHub/Linear configurado; aqui o artefato é `specs/NNN-slug/` em arquivo |
| Relatório HTML de arquitetura | Bonito e caro; o mesmo conteúdo cabe numa tabela. Reavaliar se a varredura virar rotina |
| `teach` | Fora do escopo desta KB |

## 7. Identificadores que esta destilação origina

| Identificador | Tipo | Origem nesta página |
|---|---|---|
| [INT-08](04-padroes.md) · Entrevista Conduzida por Árvore de Decisão | padrão | §5.1 |
| [CTX-06](04-padroes.md) · Linguagem Ubíqua do Projeto | padrão | §5.2 |
| [CTX-07](04-padroes.md) · Handoff Explícito entre Sessões | padrão | §5.6 |
| [PLN-05](04-padroes.md) · Módulo Profundo | padrão | §5.3 |
| [PLN-06](04-padroes.md) · Mapa de Decisões sob Névoa | padrão | §5.4 |
| [VER-06](04-padroes.md) · Loop de Feedback Antes da Hipótese | padrão | §5.5 |
| [AP-35](05-antipadroes.md) · Skill Negativa | anti-padrão | §8 |
| [AP-36](05-antipadroes.md) · Sedimento | anti-padrão | §8 |
| [AP-37](05-antipadroes.md) · Conclusão Prematura | anti-padrão | §8 |
| [H-17](06-heuristicas-e-invariantes.md) · Uma pergunta por vez, com a recomendação junto | heurística | §5.1 |
| [H-18](06-heuristicas-e-invariantes.md) · Loop antes do bug | heurística | §5.5 |
| [ADR-011](11-adrs.md) · Absorver em vez de instalar | ADR | §6 |

## 8. Escrever skill previsível — `writing-great-skills`

`[INDÚSTRIA]` A tese em uma frase: *"uma skill existe para arrancar determinismo de um sistema
estocástico"*. O objetivo não é capacidade, é **previsibilidade** — a mesma entrada leva ao mesmo
processo em execuções diferentes.

Três camadas de informação, e errar a camada é o defeito mais comum:

1. **Passos na skill** — ações ordenadas, cada uma com critério de conclusão checável.
2. **Referência na skill** — definições e regras consultadas quando precisa.
3. **Referência externa** — material atrás de um ponteiro. É ADR-005 (progressive disclosure) com outro
   nome.

**Palavra-líder** (*leading word*): um termo que o modelo já entende comprime um conceito inteiro num
token e ancora tanto a execução quanto a invocação. Escolher a palavra certa no início da `description`
é onde a descrição faz seu trabalho de invocação.

**Granularidade:** separe skills **por invocação** (precisam disparar independentemente) ou **por
sequência** (para impedir que o agente declare pronto antes da hora).

`[INDÚSTRIA]` Seis modos de falha nomeados. Três já têm identificador aqui — *sprawl* é AP-02/AP-27,
*duplicação* é AP-14, *no-op* é AP-33. Os outros três entram como AP-35 (negação), AP-36 (sedimento) e
AP-37 (conclusão prematura).

---

**Ver também:** [04 — Padrões](04-padroes.md) · [05 — Anti-padrões](05-antipadroes.md) ·
[11 — ADRs](11-adrs.md) · [prompt-library.md](prompt-library.md) · [README da KB](README.md)
