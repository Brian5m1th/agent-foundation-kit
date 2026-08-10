# Spec: <NOME DA FEATURE>

<!--
Estrutura derivada do spec-template.md do GitHub Spec Kit, com duas seções acrescentadas
(Obstáculos e Envelope) fundamentadas em docs/intent-engineering/.

REGRA ABSOLUTA: nenhuma tecnologia nesta página. Sem framework, banco, endpoint, arquivo.
Se você sentir vontade de escrever "endpoint", escreva o comportamento observável.
-->

- **ID:** NNN-slug · **Branch:** `NNN-slug` · **Jira Ticket:** `<CHAVE-TICKET>` (ex: IA-148)
- **Status:** rascunho | esclarecida | planejada | implementada
- **Responsável (humano):** <nome>
- **Criada em:** AAAA-MM-DD

## Problema

Qual dor existe hoje, para quem, e o custo de não resolver. Descreve o estado atual, não a solução.

## Resultado esperado

O estado do mundo depois que isto existir, observável de fora. Uma frase.

---

## Histórias de usuário

Priorizadas. **Cada história deve ser entregável e testável de forma independente** — a P1 sozinha já
tem de valer alguma coisa. É isto que permite fatiar a entrega e ter um MVP real.

### US1 — <título> `(P1)`

**Como** <papel>, **quero** <capacidade>, **para** <benefício>.

**Por que P1:** <o que se perde se esta ficar de fora>

**Testável isoladamente:** <como validar esta história sem as outras estarem prontas>

**Cenários de aceite:**

- **Dado** <contexto>, **quando** <ação>, **então** <resultado observável>.
- **Dado** <contexto de erro>, **quando** <ação>, **então** <resultado>.

### US2 — <título> `(P2)`

...

---

## Requisitos funcionais

Numerados, testáveis, sem tecnologia. Cada um aponta a história que serve.

- **FR-001** — O sistema deve... `(US1)`
- **FR-002** — O sistema deve... `(US1, US2)`

## Critérios de sucesso

Mensuráveis e **independentes de tecnologia**. Um critério que só faz sentido conhecendo a
implementação está no documento errado.

- **SC-001** — <métrica com número>. Ex.: "usuário conclui o cadastro em menos de 60 s na primeira
  tentativa, em 90% dos casos".
- **SC-002** — ...

## Entidades principais

Conceitos do domínio e suas relações — **sem** schema, sem tipos, sem tabela.

- **<Entidade>** — o que é, o que a identifica, com quem se relaciona.

---

## Obstáculos

<!--
Seção acrescentada ao formato do Spec Kit. Origem: análise de obstáculos do KAOS
(van Lamsweerde & Letier, IEEE TSE 2000). Geração SISTEMÁTICA, não brainstorming:
para cada FR, negue-o e pergunte "de que formas isto pode deixar de valer?".
-->

Para cada requisito, as condições que impediriam sua satisfação, e como são tratadas.

| # | Obstáculo | Afeta | Tratamento |
|---|---|---|---|
| OB-1 | <entrada vazia / duplicada / concorrente / grande demais / sem permissão / serviço fora> | FR-001 | <requisito ou decisão que resolve> |

## Fora de escopo

Lista explícita do que **não** será feito, incluindo as boas ideias adiadas.

## Premissas e dependências

O que se está assumindo como verdadeiro e do que esta feature depende.

## Envelope de autonomia (padrão da spec)

<!--
Seção acrescentada. Origem: níveis de automação (Parasuraman, Sheridan & Wickens, 2000);
padrão PA-07. Tasks individuais podem restringir, nunca ampliar.
-->

- **Modo de interpretação:** `literal` (executa o pedido, para se inviável) | `interpretativo`
  (persegue a intenção, reporta o que interpretou)
- **O agente decide sozinho:** <ex.: nomes internos, organização de arquivos, ordem de implementação>
- **O agente consulta antes:** <ex.: schema, contrato público, dependência nova>
- **Vedado ao agente:** <ex.: migração destrutiva, mudança de constitution, alterar `auth/`>

## Perguntas em aberto

- `[PRECISA ESCLARECER: <pergunta>]` — **bloqueante** | **não-bloqueante (suposição: <qual>)**
