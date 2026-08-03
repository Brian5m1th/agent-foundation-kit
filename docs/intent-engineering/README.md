# Engenharia de Intenção — Fundamentação Científica

> Base teórica de referência para projetos, artigos e documentação do **K.A.O.S.**
> Documento vivo. Versão 0.1 — 2026-08-02.

## Aviso metodológico (leia primeiro)

Este corpo de documentos **não assume que "Engenharia de Intenção" seja um campo consolidado**. Ele
não é. O que existe é um conjunto grande de conhecimento maduro, espalhado por disciplinas que não
conversam entre si, tratando do mesmo problema com nomes diferentes — e um vazio real no ponto onde
essas disciplinas deveriam se encontrar.

Todo enunciado neste corpus carrega um **selo epistêmico**. Eles nunca se misturam:

| Selo | Significado | Como tratar |
|---|---|---|
| `[CONSOLIDADO]` | Conhecimento estabelecido, revisado por pares, replicado, ensinado | Pode ser usado como fundação |
| `[INDÚSTRIA]` | Consenso ou prática dominante, sem validação experimental controlada | Útil, mas não é evidência |
| `[RECENTE]` | Pesquisa dos últimos ~3 anos, ainda em disputa; preprints marcados como tal | Provisório |
| `[EXPERIMENTAL]` | Evidência empírica específica, com escopo e limitações declarados | Vale pelo que mediu, não além |
| `[ACADÊMICO]` | Proposta acadêmica sem adoção ou validação ampla | Ideia, não fato |
| `[HIPÓTESE]` | **Proposta original deste corpus.** Derivada de disciplinas existentes, ainda não testada | Precisa ser falsificada antes de ser confiada |

Nenhuma `[HIPÓTESE]` é apresentada sem (a) a disciplina de onde é derivada e (b) uma condição de
falsificação explícita.

## Estrutura

| Documento | Conteúdo |
|---|---|
| [01 — Fundamentação](01-fundamentacao.md) | O problema, a definição proposta, o mapa do conhecimento existente, os conflitos entre escolas, as lacunas |
| [02 — Taxonomia e glossário](02-taxonomia-e-glossario.md) | Escala de Intenção, glossário, mapa conceitual, mapa de dependências |
| [03 — Árvore de princípios](03-arvore-de-principios.md) | Princípios derivados, com proveniência e condição de falha |
| [04 — Árvore de responsabilidades](04-arvore-de-responsabilidades.md) | Quem responde pelo quê entre humano, sistema e agente |
| [05 — Catálogo de padrões](05-catalogo-de-padroes.md) | Padrões e anti-padrões, com forças, contexto e cenários de falha |
| [06 — Decisões arquiteturais](06-decisoes-arquiteturais.md) | ADRs da própria disciplina, com alternativas descartadas |
| [07 — Agenda de pesquisa](07-agenda-de-pesquisa.md) | Lacunas, hipóteses próprias e como refutá-las |
| [08 — Bibliografia](08-bibliografia.md) | Fontes classificadas por natureza da evidência |
| [09 — Visão integrada](09-visao-integrada.md) | Síntese, teses centrais, fraquezas declaradas e auditoria do fluxo SDD do `labs` |

## Nota sobre o nome K.A.O.S.

Existe uma metodologia consolidada de Requirements Engineering chamada **KAOS** — *Knowledge
Acquisition in autOmated Specification* — desenvolvida por Axel van Lamsweerde e colaboradores na
Université catholique de Louvain, a partir do início dos anos 1990. `[CONSOLIDADO]`

KAOS é, em substância, engenharia de intenção: modela metas, refina metas em AND/OR até chegar a
requisitos operacionais, analisa **obstáculos** (formas de a meta falhar) e **atribui
responsabilidade** por cada requisito a um agente específico — humano ou sistema.

Duas das entregas que você pediu — *árvore de princípios* e *árvore de responsabilidades* — são,
respectivamente, um refinamento de metas e uma atribuição de responsabilidade no sentido exato de
KAOS. Isso não é coincidência de vocabulário: é sinal de que o problema é o mesmo, e que a literatura
de 1990–2005 já resolveu partes dele.

Este corpus trata o KAOS de van Lamsweerde como **ancestral direto** da disciplina proposta. Se o
nome do seu projeto for homenagem deliberada, o corpus está alinhado; se for coincidência, a
coincidência é informativa e vale ser assumida.
