# Tasks: <NOME DA FEATURE>

- **Spec:** ./spec.md · **Plan:** ./plan.md

<!-- Formato derivado do tasks-template.md do GitHub Spec Kit, acrescido dos campos
     Verifica / Envelope (fundamentação em docs/intent-engineering/). -->

## Formato

`[ID] [P?] [História] Descrição` — com arquivos, verificação e envelope.

- **[ID]** — sequencial: T001, T002...
- **[P]** — paralelizável: arquivos disjuntos, sem dependência entre si. Duas tasks no mesmo arquivo
  **não** são paralelas.
- **[História]** — US1, US2... para rastreabilidade. Vazio em tasks de infraestrutura.
- **Verifica** — comando ou checagem de uma linha. Sem isto, a task não existe (Artigo III).
- **Envelope** — só quando **restringe** o padrão da spec.

---

## Fase 1 — Setup

Inicialização do projeto e das ferramentas.

- [ ] **T001** — <ação>
  - Arquivos: `caminho`
  - Verifica: `<comando>`

## Fase 2 — Fundação ⚠️ BLOQUEIA TODAS AS HISTÓRIAS

Infraestrutura sem a qual nenhuma história pode começar: schema, config, tipos base, autenticação.
**Nenhuma task de história inicia antes desta fase fechar.**

- [ ] **T002** — <ação>
  - Arquivos:
  - Verifica:

## Fase 3 — US1 `(P1)` 🎯 MVP

Entregável e testável sozinha. Ao fim desta fase deve existir algo demonstrável.

- [ ] **T003 [P] [US1]** — <ação>
  - Arquivos:
  - Verifica:
  - Cobre: FR-001, SC-001
- [ ] **T004 [US1]** — <ação>
  - Envelope: consulta antes de alterar o schema

**Checkpoint US1:** <como provar que a história inteira funciona isoladamente>

## Fase 4 — US2 `(P2)`

- [ ] **T00N [US2]** — ...

**Checkpoint US2:** ...

## Fase 5 — Acabamento

Transversal: tratamento de erro, documentação, observabilidade, limpeza.

- [ ] **T0NN** — ...

---

## Dependências

```
Setup → Fundação → US1 (MVP) → US2 → ... → Acabamento
```

Dentro de cada história, respeitar a ordem declarada. Entre histórias diferentes, só há dependência
se estiver escrita aqui.

## Rastreabilidade

Todo requisito e todo critério de sucesso precisa aparecer em pelo menos uma task.
**Critério sem task é defeito do plano** — reporte, não invente task genérica.

| Requisito / Critério | Tasks |
|---|---|
| FR-001 | T003, T004 |
| SC-001 | T003 |
