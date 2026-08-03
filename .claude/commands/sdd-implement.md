---
description: Executa as tasks pendentes, uma por vez, respeitando o envelope
argument-hint: [T001 | US1 | fase 2 | vazio = todas as pendentes]
---

Fase 4 do fluxo SDD. Equivale ao `/speckit.implement` do GitHub Spec Kit.

**Recorte pedido (vazio = todas as pendentes, em ordem):** $ARGUMENTS

## Antes de qualquer código

Leia nesta ordem: `.specify/memory/constitution.md`, `spec.md`, `plan.md`, `tasks.md`. Marcador
bloqueante em aberto → pare e reporte.

Registre para si o **envelope de autonomia** e o **modo de interpretação** da spec, mais as restrições
por task.

## Ciclo por task

1. Releia a task: arquivos, verificação, FR/SC coberto, envelope.
2. Implemente **apenas** o que a task descreve. Nada de melhoria oportunista em código vizinho —
   escopo é contrato (Artigo IV). Ideia boa fora de escopo: anote no relatório e siga.
3. Siga os contratos do `plan.md` ao pé da letra. Contrato inviável na prática → **pare e reporte**;
   mudar o plan é decisão do humano (Artigo II).
4. **Respeite o envelope.** Item marcado "consulta antes" → pergunte, não decida. Item "vedado" → pare.
5. Rode a verificação declarada. Falhou → corrija antes de avançar; não acumule débito.
6. Marque `- [x]` só depois de a verificação passar.

## Registro de interpretação — obrigatório

Sempre que você preencher uma lacuna que a especificação não cobria, **registre**. Filtro: *"outro
executor competente poderia ter escolhido diferente?"* — se sim, entra na lista.

Formato, junto à entrega:

```
Interpretações feitas:
- T004: a spec não definia o comportamento com lista vazia; assumi retornar 200 com array vazio.
- T007: nome do campo não especificado; usei `created_at` por consistência com o resto do schema.
```

Micro-decisão sem alternativa razoável não entra — a lista precisa continuar curta para ser lida.

## Regras

- Uma task por vez, na ordem. `[P]` podem ser agrupadas se realmente não colidirem.
- **Portão da Fundação:** não inicie tasks de história antes da fase Fundação fechar.
- Modo `literal`: execute o pedido; se for inviável, pare. Modo `interpretativo`: persiga a intenção e
  reporte o que interpretou.
- Código no idioma e no estilo do código vizinho.
- Verificação que não roda no ambiente é reportada como **não verificada**, nunca marcada como feita.

## Ao terminar

Tasks concluídas · tasks restantes · **saída real** dos comandos de verificação · lista de
interpretações · desvios de plan/spec reportados · ideias fora de escopo anotadas.
Sugira `/sdd-converge`.
