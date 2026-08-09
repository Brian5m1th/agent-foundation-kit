---
name: sdd-specify
description: Cria a especificação (o QUÊ e POR QUÊ) de uma nova feature
disable-model-invocation: true
argument-hint: <descrição da feature em uma ou duas frases>
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(ls:*), Bash(dir:*)
---

Fase 1 do fluxo SDD. Equivale ao `/speckit.specify` do GitHub Spec Kit.

**Feature:** $ARGUMENTS

## Passos

1. Leia `.specify/memory/constitution.md`. Se não existir, avise e registre isso na spec.
2. Determine o próximo número sequencial em `specs/`. Crie `specs/NNN-<slug-kebab>/spec.md` a partir de
   `.specify/templates/spec-template.md`.
3. Explore o código **apenas o suficiente** para não especificar o que já existe. Não desenhe solução
   técnica.
4. Preencha a spec.

## Regras obrigatórias

- **Zero tecnologia.** Sem framework, banco, protocolo, endpoint, caminho de arquivo. Vontade de
  escrever "endpoint" → escreva o comportamento observável pelo usuário.
- **Histórias priorizadas e independentemente testáveis.** A US1 sozinha tem de valer alguma coisa —
  ela é o MVP. Para cada história, escreva explicitamente como validá-la sem as outras.
- **Critérios de sucesso com número e unidade**, independentes de tecnologia.
- **Obstáculos gerados sistematicamente**, não por lembrança: para cada requisito, negue-o e pergunte
  de quantas formas ele pode deixar de valer. Percorra a lista: entrada vazia/malformada, duplicidade,
  concorrência, volume, permissão ausente, dependência externa fora do ar, operação repetida.
- **Ambiguidade vira marcador, classificado:**
  - `[PRECISA ESCLARECER: <pergunta>] — bloqueante` quando reverter a decisão errada é caro (schema,
    contrato público, dado, segurança, regra de negócio);
  - `[PRECISA ESCLARECER: <pergunta>] — não-bloqueante (suposição: <qual>)` quando é barato tentar e
    corrigir. Registre a suposição em Premissas.
- Preencha o **envelope de autonomia** padrão da spec e o **modo de interpretação**.
- "Fora de escopo" preenchido de verdade, com as boas ideias adjacentes.

## Ao terminar

Em no máximo 12 linhas: caminho do arquivo, resultado esperado em uma frase, contagem de histórias /
requisitos / critérios / obstáculos, e **a lista dos marcadores bloqueantes como perguntas diretas**.
Sugira `/sdd-clarify` se houver bloqueantes; `/sdd-plan` se não houver.

