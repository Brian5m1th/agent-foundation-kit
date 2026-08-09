---
description: Resolve as ambiguidades da spec perguntando ao responsável humano
argument-hint: [NNN-slug opcional]
allowed-tools: Read, Edit, Glob, Grep, AskUserQuestion
---

Fase 1.5 do fluxo SDD, opcional mas recomendada. Equivale ao `/speckit.clarify` do GitHub Spec Kit.

**Spec alvo (opcional):** $ARGUMENTS

## Passos

1. Localize a spec (argumento, ou a de maior número sem plan). Leia `spec.md` e a constitution.
2. Colete **todos** os `[PRECISA ESCLARECER]` e varra a spec por ambiguidade não marcada:
   - adjetivo sem número ("rápido", "grande", "simples");
   - requisito com mais de uma leitura razoável;
   - caso de borda coberto por obstáculo sem tratamento definido;
   - entidade citada sem identificador ou ciclo de vida;
   - critério de sucesso não mensurável.
3. **Pergunte ao usuário** com `AskUserQuestion`, em lotes de até 4, começando pelas bloqueantes.
   Para cada pergunta, ofereça opções concretas e recomende uma — perguntar sem propor obriga o humano
   a fazer o trabalho todo.
4. Aplique as respostas **diretamente na spec**, no lugar certo (requisito, obstáculo, premissa,
   envelope), e remova o marcador resolvido.

## Regras

- Quem responde é o **responsável humano** da spec. Você não responde as suas próprias perguntas —
  isso usurpa uma decisão de nível de meta (Artigo VI).
- Marcador **não-bloqueante** não precisa virar pergunta: promova a suposição a Premissa explícita e
  siga. Perguntar tudo é o modo de falha por excesso.
- Resposta que muda o problema, e não só o detalhe, é sinal de que a spec precisa ser reescrita —
  diga isso em vez de remendar.
- Atualize o Status da spec para `esclarecida` quando não sobrar bloqueante.

## Ao terminar

Liste: perguntas feitas e respostas, seções alteradas, marcadores restantes (com o motivo de
permanecerem), e se a spec está liberada para `/sdd-plan`.

