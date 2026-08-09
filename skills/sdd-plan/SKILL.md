---
description: Cria o plano técnico (COMO) a partir da spec
argument-hint: [NNN-slug | restrições e stack desejadas]
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(ls:*), Bash(dir:*)
---

Fase 2 do fluxo SDD. Equivale ao `/speckit.plan` do GitHub Spec Kit.

**Direcionamento técnico do usuário (pode estar vazio):** $ARGUMENTS

## Passos

1. Identifique a spec alvo. Leia `spec.md` **inteira** e `.specify/memory/constitution.md`.
2. **Bloqueio:** marcador `[PRECISA ESCLARECER]` **bloqueante** em aberto → pare, liste, sugira
   `/sdd-clarify`. Marcadores não-bloqueantes não impedem.
3. Investigue o código real: stack em uso, convenções, onde features análogas moram. O plano encaixa no
   que existe; não propõe um mundo paralelo.
4. Crie `specs/NNN-slug/plan.md` a partir de `.specify/templates/plan-template.md`.

## Regras obrigatórias

- **Verificação de constitution primeiro**, artigo a artigo, antes de detalhar o resto. Desvio é
  permitido com justificativa escrita; desvio silencioso não.
- **Contratos concretos**: assinaturas reais, schemas reais, payloads de exemplo, formatos de erro.
  É esta seção que impede a implementação de improvisar (Artigo II).
- **Pelo menos uma alternativa descartada**, com o motivo **e quando esse motivo deixa de valer**. Se
  não houve alternativa real, diga isso — rationale inventado é pior que ausente.
- Toda dependência nova exige justificativa (Artigo I).
- Todo critério de sucesso da spec aparece na estratégia de verificação. Critério que não é
  automatizável é declarado "julgamento humano" — **não invente proxy numérica**.
- Desvio do Artigo I preenche o Rastreamento de complexidade.
- Dúvida técnica que muda a arquitetura vira `[PRECISA ESCLARECER]` no plan.

## Ao terminar

Abordagem em 3 linhas, arquivos que serão tocados, riscos, e **desvios de constitution em destaque**.
Peça aprovação antes de `/sdd-tasks`.

