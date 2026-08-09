---
name: sdd-converge
description: Audita o código entregue contra spec, plan e constitution
disable-model-invocation: true
argument-hint: [NNN-slug opcional]
allowed-tools: Read, Glob, Grep, Bash
---

Fase 5 do fluxo SDD. Equivale ao `/speckit.converge` do GitHub Spec Kit.

**Postura: cética, não confirmatória.** Seu trabalho é achar a lacuna, não declarar sucesso.

> **Pré-requisito estrutural:** rode isto em **sessão/contexto separado** de quem implementou. Auditor
> que compartilha o contexto do executor herda as premissas dele e converge para confirmação
> (anti-padrão AP-11). Se você acabou de implementar nesta mesma sessão, diga isso no relatório —
> a auditoria vale menos e o leitor precisa saber.

**Spec alvo (opcional):** $ARGUMENTS

## Procedimento

1. Leia `.specify/memory/constitution.md`, `spec.md`, `plan.md`, `tasks.md`.
2. **Critério a critério**, vá ao código e prove ou refute, citando `arquivo:linha`. Task marcada como
   feita **não é evidência** — é a alegação sob auditoria.
3. Rode a verificação declarada em cada task e reporte a **saída real**. Comando que não roda no
   ambiente é "não verificado", jamais "ok".
4. Confira os **contratos** do plan contra a implementação real: assinatura, schema, formato de erro.
5. Constitution, artigo a artigo.
6. **Busque o inverso:** código sem requisito correspondente — escopo ampliado (Artigo IV). É o achado
   mais frequentemente esquecido.
7. Confira a **matriz de rastreabilidade** contra o código. Matriz completa e errada é pior que
   ausente, porque produz confiança falsa.

## Relatório

| Critério | Veredito | Evidência |
|---|---|---|
| SC-001 | atendido / parcial / não atendido / **não verificável** | `arquivo:linha` ou saída do comando |

Depois:

- **Lacunas** — requisito sem implementação.
- **Excedentes** — implementação sem requisito.
- **Divergências de contrato** — plan × código.
- **Desvios de constitution** — artigo, e se estavam declarados no plan.
- **Rastreabilidade** — entradas da matriz que não conferem.
- **Veredito final** — pronto, ou a lista objetiva do que falta.

Não amenize. Se falhou, diga que falhou e mostre a saída.

