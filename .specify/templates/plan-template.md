# Plan: <NOME DA FEATURE>

- **Spec:** ./spec.md · **Status:** rascunho | aprovado

<!-- Estrutura derivada do plan-template.md do GitHub Spec Kit. -->

## Contexto técnico

| Item | Valor |
|---|---|
| Linguagem / versão | |
| Dependências principais | |
| Armazenamento | |
| Testes | |
| Plataforma-alvo | |
| Tipo de projeto | single / web / mobile / cli |
| Metas de desempenho | |
| Restrições | |
| Escala | |

## Verificação de constitution

Artigo a artigo, **antes** de detalhar o plano. Desvio é permitido; desvio não declarado não é.

| Artigo | Cumpre / N/A / Desvio | Justificativa do desvio |
|---|---|---|
| I — Simplicidade | | |
| II — Contratos antes | | |
| III — Verificável | | |
| IV — Escopo | | |
| V — Ambiguidade | | |
| VI — Responsabilidade | | |
| VII — <projeto> | | |

## Abordagem escolhida

Um parágrafo: como será construído e por quê este caminho.

## Alternativas descartadas

<!-- Obrigatório. Decisão sem alternativa rejeitada não é rastreável (QOC; princípio P6). -->

| Alternativa | Por que foi descartada | Quando essa razão deixa de valer |
|---|---|---|
| | | |

## Contratos

Interfaces públicas, **concretas**. Esta seção é o que impede a fase de implementação de improvisar.

```
<assinaturas · schemas · exemplos de payload · formatos de erro>
```

## Modelo de dados

Entidades, campos, tipos, relações, migrações.

## Estrutura do projeto

Arquivos e diretórios que serão criados ou alterados.

```
src/
├── ...
tests/
└── ...
```

## Mudanças por arquivo

| Arquivo | Mudança | Serve a |
|---|---|---|
| | | FR-001 |

## Estratégia de verificação

Como cada critério de sucesso será provado. Softgoal sem métrica honesta é declarado como
"verificação por julgamento humano" — **não** se inventa proxy (evita AP-05 · Proxy Capturada).

| Critério | Mecanismo | Automatizável? |
|---|---|---|
| SC-001 | | sim / não |

## Riscos

| Risco | Impacto | Mitigação |
|---|---|---|
| | | |

## Rastreamento de complexidade

Preencher **somente** se houver desvio do Artigo I. Cada linha é dívida assumida conscientemente.

| Complexidade adicionada | Por que é necessária | Alternativa mais simples rejeitada porque |
|---|---|---|
| | | |
