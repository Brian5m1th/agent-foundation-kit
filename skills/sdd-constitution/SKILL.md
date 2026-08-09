---
name: sdd-constitution
description: Cria ou emenda a constitution do projeto (princípios inegociáveis)
disable-model-invocation: true
argument-hint: [princípios em linguagem livre | vazio para revisar a existente]
allowed-tools: Read, Write, Edit, Glob, Grep
---

Fase 0 do fluxo SDD. Equivale ao `/speckit.constitution` do GitHub Spec Kit.

**Entrada do usuário (pode estar vazia):** $ARGUMENTS

## Passos

1. Leia `.specify/memory/constitution.md`. Se não existir, crie a partir do template do próprio
   arquivo em `labs`.
2. Investigue o projeto para descobrir princípios **já praticados mas não escritos**: convenções de
   stack, padrões de teste, restrições de licença, regras de segurança. Um princípio que a equipe já
   segue é melhor candidato que um aspiracional.
3. Redija ou emende os artigos.

## Regra crítica — o teste de saúde

Para **cada** artigo, responda por escrito: *"que decisão plausível e tentadora este artigo proíbe?"*

- Sem resposta concreta → o artigo é decorativo. **Apague-o.**
- "Buscar a qualidade", "priorizar o usuário", "escrever código limpo" reprovam sempre.
- "Nenhum endpoint público sem rate limit", "zero dependência copyleft", "nenhuma migração sem
  rollback testado" passam.

Uma constitution que nunca barrou nada não governa nada.

## Versionamento

- MAJOR: artigo removido ou redefinido · MINOR: artigo novo · PATCH: redação.
- Atualize versão e data de emenda. Emenda exige justificativa escrita.

## Ao terminar

Liste os artigos com a decisão que cada um proíbe, a versão nova, e **quais artigos você propôs
apagar por reprovarem no teste de saúde**. Se algum artigo já em vigor conflita com specs existentes,
reporte o conflito — não o resolva.

