# 10 — Métricas de qualidade

## Advertência que precede tudo

Toda métrica é uma **proxy da intenção**. Quando vira alvo, deixa de ser boa medida (Goodhart).
Portanto, cada métrica aqui declara **como ela é gamificada** — sem isso, publicar a métrica é
publicar o modo de burlá-la.

Regra de adoção: **nunca use uma métrica isolada como portão**. Use pares que se contrabalançam
(velocidade × estabilidade, cobertura × poder de detecção).

---

## 1. Métricas de intenção (D1)

| Métrica | Definição | Bom sinal | Como é gamificada |
|---|---|---|---|
| **Taxa de revisão da spec** | mudanças na spec após início da execução, por semana | **decrescente** | Congelar a spec por decreto → vira AP-21 (drift) |
| **Densidade de ambiguidade** | marcadores `[PRECISA ESCLARECER]` por requisito na 1ª versão | 0,1–0,3 | Não marcar nada → AP-19 |
| **Taxa de resolução de ambiguidade** | marcadores resolvidos antes do código / total | > 90% para bloqueantes | Reclassificar bloqueante como não-bloqueante |
| **Cobertura de critério** | requisitos com critério discriminante / total | 100% | Critério que nada reprova → AP-07 |
| **Requisitos universais com PROP** | regras "sempre/nunca" com teste de propriedade / total | > 80% | Reescrever a regra para não parecer universal |

**A mais valiosa é a primeira**, e é contraintuitiva: taxa de revisão **zero** durante execução ativa
é sinal de alarme, não de maturidade. Ou o problema era trivial, ou ninguém confrontou a spec com a
realidade.

## 2. Métricas de contexto (D2)

| Métrica | Definição | Bom sinal | Como é gamificada |
|---|---|---|---|
| **Tamanho do contexto permanente** | linhas de CLAUDE.md + AGENTS.md carregadas sempre | < 200 linhas somadas | Mover ruído para skill sem podar |
| **Razão sob demanda** | conteúdo em skills / conteúdo permanente | > 3:1 | Skills que nunca são acionadas |
| **Taxa de acionamento de skill** | sessões em que a skill foi usada / sessões relevantes | > 50% | — (baixo é sintoma de `description` ruim) |
| **Ocupação da janela no fim da tarefa** | % da janela usada quando a task fecha | < 60% | Compactar sem delegar |
| **Divergência entre cópias** | diffs entre `.claude/`, `.agents/`, `.opencode/` | **0** | — (métrica difícil de burlar; use-a) |

**Instrumentação `[CAMPO]` disponível:** o Context Budget Protocol já define as faixas (40/60/80%) —
falta só registrar em que faixa cada task terminou.

## 3. Métricas de planejamento (D3)

| Métrica | Definição | Bom sinal | Como é gamificada |
|---|---|---|---|
| **Granularidade** | tasks com estimativa ≤ 1 dia / total | > 90% | Fatiar artificialmente sem mudar o trabalho |
| **Densidade de dependência** | arestas / tasks | 0,5–1,5 | Omitir dependências reais → AP-28 |
| **Taxa de paralelismo real** | tasks `[P]` que de fato rodaram em paralelo / marcadas `[P]` | > 70% | Marcar `[P]` sem verificar disjunção |
| **Tempo até o primeiro demonstrável** | do início até a US1 fechar | o menor possível | Chamar de US1 algo que não entrega valor |
| **Retrabalho de plano** | tasks reabertas por contrato inviável / total | < 10% | Não reabrir e "consertar" o contrato em silêncio |

## 4. Métricas de execução (D4)

| Métrica | Definição | Bom sinal | Como é gamificada |
|---|---|---|---|
| **Aderência ao envelope** | ações fora do envelope sem aprovação | **0** | Envelope frouxo demais |
| **Densidade de interpretação** | interpretações registradas por task | 0–3 | Não registrar |
| **Granularidade de commit** | commits / task concluída | ≈ 1 | Commits vazios |
| **Aprovações por hora** | prompts de permissão / hora de sessão | < 10 | Auto-aprovar tudo, inclusive destrutivo |
| **Tamanho do lote** | linhas alteradas por PR | pequeno | Fatiar PR sem fatiar risco |
| **Custo por mudança aceita** | tokens/tempo/R$ do loop / mudanças que sobreviveram aos checks | estável ou ↓ | Contar mudança não verificada como aceita |
| **Voltas sem progresso** | voltas sem ganho mensurável / voltas totais | < 20% | Trocar a métrica a cada volta |

**Tamanho do lote é a métrica com melhor lastro externo:** DORA 2024 atribui a queda de ~7,2% em
estabilidade com adoção de IA a um mecanismo mecânico — *a IA facilita produzir mudanças maiores, e
lotes maiores carregam mais risco* `[EXPERIMENTAL]`.

## 5. Métricas de verificação (D5)

| Métrica | Definição | Bom sinal | Como é gamificada |
|---|---|---|---|
| **Cobertura de teste** | linhas/branches cobertas | > 80% | Testes que executam sem asserção |
| **Poder de detecção (mutation score)** | mutantes mortos / gerados | > 60% | — (**difícil de burlar; é a métrica honesta**) |
| **Independência do verificador** | auditorias em contexto separado / total | 100% | Auditar na mesma sessão |
| **Taxa de falha forçada** | propriedades que já foram vistas falhando / total | 100% | Pular o passo |
| **Achados por auditoria** | achados que afetam correção / total de achados | > 50% | Reportar preferência de estilo como achado |
| **Escape de defeito** | defeitos achados em produção / total | decrescente | Não classificar como defeito |
| **Nível real do verifier** | distribuição dos loops nos níveis 1–5 | 1–2 quando unattended | Rotular juiz-LLM como determinístico |
| **Regressão protegida** | mudanças aceitas que mantêm todos os checks protegidos / aceitas | 100% | Proteger só o alvo fácil |

**Cobertura sem mutation score é teatro.** Robert C. Martin, sobre governar qualidade por sinais:
*"meço coisas como cobertura de teste, estrutura de dependências, complexidade ciclomática, tamanho de
módulos, mutation testing… Muito pode ser inferido sobre a qualidade do código a partir dessas
métricas"* `[INDÚSTRIA]` — com a ressalva explícita na fonte de que isso **não substitui revisar o
código gerado**.

## 6. Métricas de aprendizado (D6)

| Métrica | Definição | Bom sinal | Como é gamificada |
|---|---|---|---|
| **Recorrência de classe de defeito** | defeitos da mesma classe em features distintas | → 0 | Reclassificar o defeito |
| **Promoção de lição** | lições que viraram teste/hook/padrão / lições registradas | > 50% | Registrar lições triviais |
| **Idade da constituição** | tempo desde a última emenda com justificativa | 1–6 meses | Emendas cosméticas |
| **Uso efetivo de padrão** | padrões citados em review nos últimos 90 dias / total | > 60% | — (baixo indica catálogo morto) |
| **Meia-vida da documentação** | tempo até um doc ser contrariado pelo código | crescente | — |
| **Promoção de harness** | propostas que passam held-in e held-out / propostas avaliadas | baixa mas positiva | Expor o holdout ao proposer |
| **Regressão held-out** | candidatos promovidos que pioram holdout | **0** | Mudar evaluator/split após ver o resultado |

**A primeira é o melhor indicador único de maturidade de um time com agentes.** Se a mesma classe de
falha reaparece, D6 não está funcionando, independentemente de quantos artefatos existam.

### Painel mínimo de um loop

`[ACADÊMICO]` Até existir ROI controlado, o painel honesto é pequeno: estado terminal · nível real do
verifier · voltas totais/sem progresso · mudanças propostas/aceitas · custo por mudança aceita ·
regressões protegidas. Para Self-Harness, acrescente pass rate held-in/held-out por versão e lineage de
aceite/rejeição. Token gasto sozinho mede atividade, não saúde.

## 7. Métricas de negócio (o que a diretoria pergunta)

| Métrica | O que dizer honestamente |
|---|---|
| **Velocidade** | Cuidado: METR mediu desenvolvedores experientes **19% mais lentos** com IA em codebases maduros, *acreditando* estar ~20% mais rápidos. A percepção é sistematicamente enviesada `[EXPERIMENTAL]` |
| **Estabilidade** | DORA 2024: −7,2% com adoção de IA sem processo. É argumento **a favor** de governar, não contra usar |
| **Dívida técnica** | GitClear (200M+ linhas): churn ~2×, blocos duplicados em alta, refatoração em queda — assinatura de dívida acumulando `[EXPERIMENTAL]` |
| **Sobrevivência do código** | Código de agente sobrevive **mais** que o humano: 15,8 p.p. menos modificação, HR = 0,842, p < 0,001 (201 projetos) `[EXPERIMENTAL]` — refuta "código descartável" |
| **TCO** | Custa mais no início, menos no ciclo. Token é a variável barata; hora de engenheiro caçando bug é a cara |
| **Ganho medido de contrato-primeiro** | −75% no tempo de ciclo de integração de API (caso CDD) `[INDÚSTRIA]` — adjacente ao SDD com IA, mesmo mecanismo: mover o defeito para a esquerda |
| **Precisão de primeira passada** | 95% é **meta declarada** pela Red Hat, não garantia medida. Cite como alvo, nunca como resultado |

**Regra de honestidade:** todos os estudos negativos acima mediram IA usada **sem processo
disciplinado**, e **nenhum deles testou SDD**. Usá-los como prova de que SDD funciona seria desonesto;
usá-los como prova de que *algum* processo é necessário é legítimo.

## 8. Painel mínimo

Se você só puder acompanhar seis, use estes — um por disciplina, escolhidos por serem difíceis de
burlar:

| Disciplina | Métrica | Meta |
|---|---|---|
| D1 Intent | Taxa de revisão da spec | decrescente, ≠ 0 |
| D2 Context | Linhas de contexto permanente | < 200 |
| D3 Planning | Tempo até o primeiro demonstrável | decrescente |
| D4 Execution | Tamanho do lote por PR | pequeno e estável |
| D5 Verification | **Mutation score** | > 60% |
| D6 Learning | **Recorrência de classe de defeito** | → 0 |

---

**Anterior:** [09 — Decisão, estados e algoritmos](09-decisao-estados-algoritmos.md) · **Próximo:** [11 — ADRs](11-adrs.md)
