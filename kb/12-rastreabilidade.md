# 12 — Matriz de rastreabilidade

## 1. A cadeia

```
Necessidade → Requisito → Intenção → Plano → Task → Execução → Verificação → Evidência
```

**Rastreabilidade bidirecional** significa que, de qualquer elo, você chega ao que o justifica (para
cima) e ao que ele originou (para baixo).

| Direção | Detecta | Frequência com que é feita |
|---|---|---|
| **Descendente** (necessidade → evidência) | Requisito sem implementação — **lacuna** | quase sempre |
| **Ascendente** (evidência → necessidade) | Implementação sem requisito — **escopo ampliado** | quase nunca |

> A checagem ascendente é a mais barata do catálogo e a mais esquecida. É ela que pega o "aproveitei e
> refatorei o módulo vizinho" e a feature que ninguém pediu.

## 2. Formato canônico

Uma linha por requisito, do começo ao fim da cadeia.

| Necessidade | RF | Regra | Contrato | PROP | Critério | Task | Commit | Evidência | Estado |
|---|---|---|---|---|---|---|---|---|---|
| N-01 | RF01 | RN01 | `POST /x` | PROP-01 | AC-RF01 | T-003, T-007 | `a1b2c3d` | `PaymentTest.java:42` + saída | ✅ |
| N-01 | RF02 | — | — | — | AC-RF02 | T-005 | `d4e5f6a` | manual — `qa/casos/12.md` | ⚠️ não automatizado |
| N-02 | RF03 | RN04 | `GET /y` | PROP-03 | AC-RF03 | — | — | — | 🔴 **sem task** |
| — | — | — | — | — | — | T-011 | `f7g8h9b` | — | 🔴 **órfã** |

**As duas últimas linhas são o produto real da matriz.** Uma matriz que só tem linhas verdes não foi
verificada — foi preenchida.

## 3. Regras de integridade

Verificáveis mecanicamente. Cada uma é uma consulta, não um julgamento.

| # | Regra | Violação significa |
|---|---|---|
| R1 | Todo RF tem ≥ 1 critério de aceite | Requisito não verificável (AP-07) |
| R2 | Todo critério tem ≥ 1 task | Defeito do plano — reporte, não invente task |
| R3 | Toda task tem ≥ 1 critério que cobre | **Task órfã** = escopo ampliado |
| R4 | Todo RF universal ("sempre/nunca") tem PROP **ou** motivo registrado | AP-08 |
| R5 | Toda task concluída tem evidência citável | AP-17 |
| R6 | Todo contrato do plan serve a ≥ 1 RF | Contrato especulativo (YAGNI) |
| R7 | Todo desvio de constitution está declarado no plan | Desvio silencioso |
| R8 | Toda PROP que falha está quarentenada **com link para a task** | AP-22 |
| R9 | Nenhum ID de regra/padrão tem duas definições no repo | AP-14 |
| R10 | Toda entrada da matriz confere com o código | AP-34 |

**R9 e R10 são as que a prática de campo mais viola** — e R10 é a que torna a matriz confiável ou
decorativa.

## 4. Rastreabilidade no código

Três mecanismos, do mais barato ao mais forte:

| Mecanismo | Como | Custo | Robustez |
|---|---|---|---|
| **Comentário `@spec`** | `@spec payment-gateway#service-layer` / `@implements US-3, US-4` `[CAMPO]` | trivial | frágil (apodrece) |
| **Nome de teste = enunciado** | `transicaoInvalidaNaoMutaOEstado`, não `testConfirmar` `[CAMPO]` | zero | **alta** — o teste falha se a regra mudar |
| **Commit por task** | mensagem referencia `T-003` | trivial | alta — git não apodrece |

**Nome de teste como enunciado é o melhor custo-benefício de toda esta seção.** O nome documenta a
regra, e diferente de um comentário, **falha quando a regra deixa de valer**.

## 5. Como auditar a matriz

```
auditar_matriz(matriz, codigo, spec, plan, constitution):
    para cada linha em matriz:
        se linha.evidencia aponta para arquivo:linha inexistente:  ERRO(R10)
        se linha.task concluida e linha.evidencia vazia:           ERRO(R5)

    para cada rf em spec.requisitos:
        se rf ∉ matriz:                                            ERRO(R1)
        se rf.universal e rf.prop vazia e rf.motivo vazio:         ERRO(R4)

    para cada task em plan.tasks:
        se task ∉ matriz:                                          ERRO(R3)   # órfã

    para cada unidade em codigo.alterado:
        se unidade não mapeia para nenhuma task:                   ERRO(R3)   # a checagem esquecida

    para cada id em regras_citaveis(repo):
        se contar_definicoes(id) > 1:                              ERRO(R9)
```

A penúltima verificação — varrer o **código alterado** e não a matriz — é a que muda o resultado.
Auditar a matriz contra si mesma sempre dá verde.

## 6. Aplicação ao seu ecossistema

Mapeamento dos artefatos reais para a cadeia:

| Elo | InscreveAI `[CAMPO]` | sdd-kit `[CAMPO]` | Fluxo do `labs` |
|---|---|---|---|
| Necessidade | `.spec/discovery/brief.md` | `PROJECT.md` | mapa de PLN-06, quando há névoa |
| Requisito | `spec.md` §4 (EARS) | `1-functional/spec.md` | `spec.md` FR-NNN |
| Regra | `spec.md` §8 (RN) | — | Obstáculos |
| Contrato | `spec.md` §7 | `2-technical/spec.md` | `plan.md` Contratos |
| PROP | `spec.md` §9 | — | — (lacuna) |
| Critério | `spec.md` §10 | `acceptance_criteria` | SC-NNN |
| Task | `tasks.md` | `tasks.json` `depends_on` | `tasks.md` `[P]` + história |
| Execução | commit por task | commit por task | commit por task |
| Verificação | harness + `/spec-review` | validadores + `sdd-validator-runner` | `/sdd-converge` |
| Matriz | `spec.md` §13 | — | `tasks.md` Rastreabilidade |

**Três achados desta comparação:**
1. **O InscreveAI é o único com PROP na cadeia** (§9 do template V5). É o elo mais raro e o mais forte
   — nenhuma das outras fontes, oficiais inclusive, tem verificação de invariante universal na spec.
2. **O sdd-kit é o único com dependências de task formalizadas** (`depends_on` em JSON, com detecção de
   ciclo no validador). É o elo que o formato markdown não consegue verificar mecanicamente.
3. **O elo "Necessidade" do `labs` é o mais novo e o menos exercitado.** As specs começam no requisito;
   para features pequenas tudo bem, para produto faltava o de onde vem. PLN-06 (Mapa de Decisões sob
   Névoa) preenche o elo — o mapa é o artefato de necessidade, e as decisões que ele fecha viram os
   requisitos de `/sdd-specify`. Ainda sem uso registrado: enquanto não houver, trate como aposta.

**O ideal seria a união:** EARS + PROP do InscreveAI · `depends_on` verificável do sdd-kit ·
histórias independentemente testáveis do Spec Kit · calibração por porte dos três.

---

**Anterior:** [11 — ADRs](11-adrs.md) · **Próximo:** [13 — Bibliografia](13-bibliografia.md)
