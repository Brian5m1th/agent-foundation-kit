# 04 — Árvore de responsabilidades

Este documento responde: **quem responde pelo quê**, entre humano, sistema e agente, em cada nível da
Escala de Intenção.

*Proveniência do formato:* a **atribuição de responsabilidade** de KAOS `[CONSOLIDADO]` — em KAOS,
cada requisito-folha é atribuído a um agente único, e uma meta cuja responsabilidade não pode ser
atribuída é sinal de refinamento incompleto. Esse teste é importado literalmente.

## 1. Os quatro papéis

Adaptado da separação entre quem decide, quem executa e quem responde (teoria principal-agente,
Economia `[CONSOLIDADO]`) e dos estágios de automação de Parasuraman, Sheridan & Wickens (2000)
`[CONSOLIDADO]`.

| Papel | Define | Nunca pode ser delegado a | Justificativa |
|---|---|---|---|
| **Titular da intenção** | O que se quer e por quê (N6–N4) | Executor de qualquer tipo | A1: a intenção não é observável; só o titular a tem |
| **Especificador** | Como o querer vira critério verificável (N3–N2) | — pode ser assistido | Trabalho de tradução, auditável por outro |
| **Executor** | Como o critério vira resultado (N1–N0) | — | Pode ser humano ou agente |
| **Verificador** | Se o resultado corresponde ao critério | Ao mesmo agente que executou | P7: independência é condição de validade |

**O único acoplamento proibido é Executor = Verificador.** Todos os outros podem coincidir em equipes
pequenas; este não, porque destrói a função.

## 2. Matriz de responsabilidade por nível

`H` = humano obrigatório · `A` = agente aceitável · `H+A` = agente propõe, humano ratifica ·
`✗` = vedado ao agente

| Nível | Formular | Refinar | Decidir conflito | Verificar |
|---|---|---|---|---|
| **N6 Valores** | H | H | H | H |
| **N5 Propósito** | H | H+A | H | H |
| **N4 Metas** | H+A | H+A | H | H |
| **N3 Requisitos** | H+A | A | H+A | H+A |
| **N2 Restrições** | H+A | A | H+A | A |
| **N1 Instruções** | A | A | A | A |
| **N0 Execução** | A | A | A | A |

`[HIPÓTESE]` — a matriz é uma proposta, derivada de P12 e dos níveis de automação; não há evidência
experimental que a valide. A regra que a gera:

> **Quanto mais alto o nível, menos delegável — porque o erro é menos detectável e menos reversível.**
> Um erro em N1 aparece na execução seguinte. Um erro em N5 aparece em trimestres.

**Decidir conflito é a coluna crítica.** Note que ela é `H` ou `H+A` até N3. Um agente que resolve
sozinho um conflito entre requisitos está tomando decisão de N4 sem autoridade — é o modo de falha
mais comum e mais silencioso da delegação a agentes.

## 3. Árvore de responsabilidades

```
R0 · O resultado corresponde à intenção                          [Titular — indelegável]
│
├── R1 · A intenção existe e está externalizada                   [Titular]
│   ├── R1.1 Valores e limites declarados                         [Titular]
│   ├── R1.2 Propósito articulado                                 [Titular]
│   └── R1.3 Metas priorizadas e em conflito resolvido            [Titular]
│
├── R2 · A intenção foi traduzida sem perda detectável            [Especificador]
│   ├── R2.1 Cada meta gera requisitos que a cobrem               [Especificador]
│   ├── R2.2 Cada requisito tem critério discriminante            [Especificador]     ← P2
│   ├── R2.3 Obstáculos foram gerados e tratados                  [Especificador]     ← KAOS
│   ├── R2.4 Ambiguidades marcadas e resolvidas pelo Titular      [Especificador → Titular]  ← P9
│   └── R2.5 Alternativas rejeitadas registradas                  [Especificador]     ← P6
│
├── R3 · A execução respeitou o envelope                          [Executor]
│   ├── R3.1 Não decidiu fora do envelope declarado               [Executor]          ← P10
│   ├── R3.2 Sinalizou impasse em vez de improvisar               [Executor]          ← P9
│   ├── R3.3 Não ampliou escopo                                   [Executor]
│   └── R3.4 Registrou as interpretações que precisou fazer       [Executor]          ← A1
│
├── R4 · A correspondência foi provada, não presumida             [Verificador]
│   ├── R4.1 Cada critério confrontado com evidência citável      [Verificador]       ← P7
│   ├── R4.2 Buscou implementação sem requisito                   [Verificador]       ← P7
│   ├── R4.3 Não verificou o que executou                         [estrutural]
│   └── R4.4 Reportou não-verificável como não-verificado         [Verificador]
│
└── R5 · A intenção registrada continua sendo a intenção atual    [Titular]
    ├── R5.1 Rationale permite saber quando expira                [Especificador]     ← P6
    ├── R5.2 Deriva detectada e reconciliada                      [Titular]
    └── R5.3 Constituição revisada por processo próprio           [Titular]           ← P8
```

**Teste de completude importado de KAOS:** se um nó desta árvore não pode ser atribuído a um papel
concreto e nomeado, o refinamento está incompleto — e não é o papel que falta, é a decomposição.

## 4. R3.4 — a responsabilidade que não existia antes

`[HIPÓTESE]` — esta é a única linha da árvore sem precedente direto na literatura de RE, e ela decorre
diretamente da tese central: o executor interpreta.

> **R3.4 — Registrar as interpretações realizadas.** Sempre que o executor preenche uma lacuna que a
> especificação não cobria, o preenchimento é registrado como decisão, não absorvido silenciosamente
> no resultado.

Por que não existia: com um compilador, não há interpretação a registrar. Com um agente, cada lacuna
é uma micro-decisão de N3 tomada em N1 — e é a soma dessas micro-decisões que produz um resultado
plausível e errado.

*Precedente parcial:* a *direcionabilidade* e a manutenção de common ground em Klein et al. (2004)
`[CONSOLIDADO]`; a sinalização de estado em automação (Norman, golfo de avaliação).
*Falsificação:* se equipes que exigem registro de interpretação não detectarem mais desvios cedo do
que equipes que não exigem, a responsabilidade não paga seu custo.

## 5. Modos de falha por diluição

Cada linha é um padrão de falha documentado, mapeado para este modelo.

| Falha | Mecanismo | Fonte |
|---|---|---|
| **Operador degradado** | Autonomia alta remove a prática humana; na exceção, o humano é o menos preparado | Bainbridge, 1983 `[CONSOLIDADO]` |
| **Responsabilidade evaporada** | "O agente decidiu" usado como fim de conversa | Deriva de P12 `[HIPÓTESE]` |
| **Verificador capturado** | Verificação feita pelo executor ou com o mesmo contexto; converge para confirmação | P7; viés de confirmação `[CONSOLIDADO]` |
| **Titular ausente** | Ninguém com autoridade para resolver ambiguidade; o executor decide por omissão | KAOS: meta sem agente responsável `[CONSOLIDADO]` |
| **Especificador que também executa** | O critério é ajustado para caber no que foi feito | Goodhart; criteria drift mal governado `[CONSOLIDADO]` / `[EXPERIMENTAL]` |
| **Envelope nominal** | Autonomia declarada mas sem enforcement | Deriva de P10 `[HIPÓTESE]` |

Observe que **quatro dos seis** modos de falha vêm de acoplamento indevido de papéis, não de
incompetência. É argumento a favor de tratar a separação de papéis como propriedade estrutural.

## 6. Aplicação ao fluxo SDD do `labs`

Mapeamento direto entre este modelo e os comandos em `.claude/commands/`:

| Etapa | Papel dominante | Nível | Onde o modelo aponta risco |
|---|---|---|---|
| `/sdd-constitution` | Titular | N6–N5 | Constituição genérica não governa (P8, AP-10) |
| `/sdd-specify` | Especificador (assistido) | N4–N3 | Titular precisa responder os `[PRECISA ESCLARECER]`; se o agente responder, R1.3 foi usurpada |
| `/sdd-clarify` | Titular (agente pergunta) | N4–N3 | É o comando que **implementa** R2.4; o agente não pode responder as próprias perguntas |
| `/sdd-plan` | Especificador | N3–N2 | Alternativas rejeitadas são obrigatórias (R2.5) |
| `/sdd-tasks` | Especificador | N2–N1 | Envelope por task cobre R3.1 (P10) |
| `/sdd-analyze` | Verificador (dos artefatos) | — | Implementa R2.1 e a busca por task órfã; roda antes do código existir |
| `/sdd-implement` | Executor | N1–N0 | R3.4 — registro de interpretação — é obrigatório na saída |
| `/sdd-converge` | Verificador (do código) | — | R4.3 exige contexto separado; rodar na mesma sessão que implementou captura o verificador |

**Cobertura atual:** os nós R1–R5 estão todos atribuídos a um comando concreto. O ponto estrutural que
**nenhum comando pode garantir sozinho** é R4.3 (executor ≠ verificador) — ele depende de quem invoca
rodar `/sdd-converge` em sessão limpa. É uma responsabilidade do humano, não do artefato.

---

**Anterior:** [03 — Árvore de princípios](03-arvore-de-principios.md) · **Próximo:** [05 — Catálogo de padrões](05-catalogo-de-padroes.md)
