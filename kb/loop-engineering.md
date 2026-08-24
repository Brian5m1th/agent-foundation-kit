# Loop Engineering — especificações externas, verificação e memória

> Destilação temática das fontes recebidas em 2026-08-24. O objeto central é a **especificação de
> loop**, não um `while` de programação nem o ciclo interno do agente. Selos epistêmicos permanecem
> separados conforme ADR-010.

## 1. A mudança real

`[RECENTE]` O paper [*Stop Hand-Holding Your Coding Agent*](https://arxiv.org/html/2607.00038) define
Loop Engineering como a disciplina de projetar um artefato externo, limitado e reutilizável que faz
um harness perseguir uma meta sem depender de prompting humano passo a passo. A progressão correta é:

```text
prompt → contexto → harness → loop
como pedir   o que sabe   onde age e é limitado   como encontra, executa, verifica, lembra e para
```

`[ACADÊMICO]` A camada nova **não mata prompt engineering**: o prompt continua dentro da volta; a
especificação de loop acrescenta gatilho, feedback, memória, limites e parada ao redor dele.

`[INDÚSTRIA]` Os vídeos fornecidos popularizam a mesma virada de “pedir uma vez” para “projetar o
sistema que itera”: [*O Criador do Claude Code APOSENTOU Prompts*](https://youtu.be/4UWjYd-IUF4) usa
quatro blocos — gatilho, skills, objetivo/verificação e saída/memória — e
[*Loop Engineering: Faça a IA TRABALHAR Enquanto Você DORME!*](https://youtu.be/LIn5X6ObEms)
enfatiza execução longa sem supervisão contínua. São fontes de prática e divulgação, não avaliação
controlada; a promessa “enquanto dorme” só é aceitável dentro dos guardrails da §8.

`[INDÚSTRIA]` O link Substack repetido resolve para
[*Loop Engineering*, Addy Osmani](https://addyo.substack.com/p/loop-engineering). Sua composição
operacional é automação de descoberta/triagem + worktrees + skills + plugins/connectors + subagentes,
unida por memória externa. O valor da formulação é mostrar que isolamento, capacidades e verificação
são peças distintas; a própria fonte ressalva custo de tokens, gargalo de revisão e dívida de
compreensão.

## 2. Três coisas chamadas “loop”

| Objeto | O que é | Quem projeta | É o foco aqui? |
|---|---|---|---|
| Loop de programação | controle de fluxo no código | programador | não |
| Ciclo interno do agente | perceber → agir com ferramenta → observar → decidir | harness/framework | não |
| **Especificação de loop** | artefato externo com gatilho, meta, check, parada e memória | humano + agente | **sim** |

`[RECENTE]` Confundir os três transforma uma disciplina de controle em “repita o prompt”. O harness é
o motor; a especificação de loop é o piloto.

## 3. A regra de triagem

**A evidência de uma volta muda a próxima ação?** `[RECENTE]`

- **Não:** é execução única ou prompt agendado. Não crie loop.
- **Sim:** há feedback real; prossiga.
- **Não existe check reproduzível:** é fluxo assistido por julgamento, não autonomia verificável.

Não usar loop para gosto puro, direção greenfield ainda indefinida, tarefa de uma passada ou quando o
custo da verificação excede o benefício esperado. Esse *off-ramp* combate AP-03 e evita que “loop”
vire sinônimo de processo pesado.

## 4. Anatomia mínima

Uma especificação bem formada declara:

1. **Gatilho** — manual, agenda ou evento.
2. **Meta** — estado final observável; preferencialmente verificável.
3. **Linha de base** — fotografia comparável anterior à mudança.
4. **Execução de uma volta** — skills/ferramentas nomeadas e uma mudança focada.
5. **Verificação** — evidência externa que aceita ou rejeita a mudança.
6. **Regressões protegidas** — o que não pode piorar enquanto a meta local melhora.
7. **Estados terminais** — `success`, `no-op`, `blocked`, `stalled`, `exhausted`, `error`.
8. **Memória** — estado compacto em disco: tentativas, evidência, decisões e próximo candidato.
9. **Guardrails** — teto de voltas/custo, superfícies permitidas e pontos de aprovação.
10. **Acionamento** — como o harness relê a especificação e inicia a próxima volta.

**Erro, verificação indisponível e orçamento esgotado nunca são sucesso.** `[RECENTE]`

## 5. Escada de verificação

`[ACADÊMICO]` O paper de loops propõe cinco níveis. O número precisa dizer o que o verificador
**realmente é**, não a confiança que o autor gostaria de ter:

| Nível | Check | Papel |
|---|---|---|
| 1 | determinístico: exit code, asserção, golden output | zona autônoma |
| 2 | regra: schema, linter, política, constraint | zona autônoma |
| 3 | verdade de campo atrasada: deploy, resposta real, telemetria | objetivo, mas lento |
| 4 | modelo como juiz com rubrica | fluxo assistido |
| 5 | checkpoint humano | supervisão |

`[RECENTE]` Se nível 4 for inevitável, congele a rubrica, separe maker e checker e quebre o contexto
compartilhado. Isso operacionaliza P12/VER-01. `[CAMPO]` VER-04 continua valendo: quando possível,
prove o próprio check com vermelho-antes/verde-depois.

## 6. Uma volta canônica

```text
reler spec + estado
  → medir linha de base
  → escolher o maior obstáculo restante a partir da evidência
  → fazer UMA mudança reversível por skill nomeada
  → rodar check alvo + regressões protegidas
  → aceitar ou rejeitar a mudança
  → registrar evidência, custo e próximo candidato
  → avaliar estado terminal
```

O ponto decisivo é que a evidência escolhe a próxima ação. Uma lista fixa repetida não é loop
adaptativo; é workflow cíclico.

## 7. Prompt, skill, harness e loop

| Artefato | Unidade | Papel |
|---|---|---|
| Prompt | uma invocação | expressa a ação atual |
| Skill | capacidade reutilizável | sabe executar uma classe de ação |
| Harness | ambiente de operação | ferramentas, permissões, verificadores, runtime |
| Loop | política externa ao longo do tempo | escolhe próxima ação, prova, lembra e para |

`[RECENTE]` Loops robustos **chamam skills**; não reimprovisam toda a disciplina em cada volta. Um
loop sem skill e sem check é AP-38, um retry caro ao redor de um agente desconhecido.

## 8. Segurança e autonomia

`[RECENTE]` Loop autônomo também erra autonomamente. Antes de deixar rodar sem acompanhamento:

- isole filesystem/runtime e restrinja rede quando ela não for necessária;
- use credenciais mínimas, preferencialmente de teste/staging;
- imponha teto rígido de voltas, tempo e custo;
- detecte estagnação e oscilação;
- peça aprovação antes de ação destrutiva, produção, finanças, segurança ou efeito externo;
- limite sub-loops pelo produto `voltas_pai × voltas_filho` e proíba ciclos;
- mantenha a variante anterior recuperável.

O envelope EXE-04 governa cada volta. Salvar ou agendar um prompt não concede permissão nova.

## 9. Memória sem context rot

`[OFICIAL]` A Anthropic recomenda contexto informativo e enxuto, recuperação *just in time*,
progressive disclosure, compactação e notas estruturadas persistidas fora da janela em
[*Effective context engineering for AI agents*](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents).

Aplicação ao loop:

- contexto conversacional é working memory, não banco de estado;
- cada volta longa pode começar em contexto fresco relendo `loop.md` + `loop-state.md`;
- estado guarda decisões e evidência compactas, não saídas brutas de ferramentas;
- lição só vira memória durável após sobreviver à verificação; acumular tudo degrada.

## 10. Self-Harness: o loop que modifica o próprio harness

`[EXPERIMENTAL]` [*Self-Harness: Harnesses That Improve Themselves*](https://arxiv.org/html/2606.09498)
fixa modelo, evaluator, ambiente e conjunto de tarefas; somente o harness muda. O ciclo tem três
estágios:

1. **Weakness Mining** — agrupa traces falhos por causa terminal do verificador, contribuição causal
   do comportamento e mecanismo reutilizável.
2. **Harness Proposal** — o mesmo modelo propõe várias edições distintas e mínimas, cada qual ligada
   a uma falha suportada por evidência e a uma superfície editável.
3. **Proposal Validation** — testa cada variante nos mesmos splits *held-in* e *held-out*.

Regra conservadora de promoção:

```text
Δheld_in ≥ 0  ∧  Δheld_out ≥ 0  ∧  max(Δheld_in, Δheld_out) > 0
```

`[EXPERIMENTAL]` No estudo, os nove pares modelo×benchmark melhoraram nos splits held-in e held-out,
com ganho relativo total máximo de 132%; o escopo foi Terminal-Bench-2.0, SWE-bench Verified e
AppWorld com três famílias de modelos. Isso prova ganho **naquele protocolo**, não superioridade
universal nem segurança para autoeditar um harness de produção.

Aplicação local: LRN-03 exige evaluator fixo, holdout invisível ao proposer, lineage auditável,
rollback e aprovação antes de promover uma mudança para o harness compartilhado.

## 11. Engenharia centrada na intenção

`[ACADÊMICO]` [*From Code-Centric to Intent-Centric Software Engineering*](https://arxiv.org/abs/2605.11027)
interpreta a unidade de trabalho como sistema sociotécnico de intenção, contexto, ferramentas, testes
e governança. Produzir código plausível fica mais barato; especificar intenção, verificar, preservar
arquitetura, segurança, proveniência e responsabilidade ficam mais importantes.

O loop é a forma operacional dessa mudança **quando** a intenção já foi especificada: a meta e o
envelope vêm de D1, a próxima ação usa D2/D3, o harness executa em D4, o check decide em D5 e a memória
curada alimenta D6. Loop sem spec acelera ambiguidade; SDD sem feedback iterativo para no primeiro
plano.

## 12. Encaixe no SDD deste repositório

```text
constitution → specify → clarify → plan → tasks → analyze
                                                  ↓ opcional
                                               sdd-loop
                                                  ↓
                                    implement por voltas verificadas
                                                  ↓
                                              converge
```

`/sdd-loop` é a fase opcional 3.75. Ela produz `specs/NNN-slug/loop.md` e não executa nada. O loop
envolve tasks já aprovadas; não substitui `spec.md`, `plan.md`, `tasks.md` nem `/sdd-converge` em
sessão separada.

## 13. Artefatos executáveis desta absorção

- Skill portátil: [`skills/loop-engineering/SKILL.md`](../skills/loop-engineering/SKILL.md)
- Prompt/comando SDD: [`.claude/commands/sdd-loop.md`](../.claude/commands/sdd-loop.md)
- Template: [`.specify/templates/loop-template.md`](../.specify/templates/loop-template.md)
- Pesquisa fonte a fonte: [`pesquisa-loops-agenticos-2026.md`](pesquisa-loops-agenticos-2026.md)

Prompt mínimo para acionar uma volta, já endurecido:

```text
Leia <loop-spec> e <loop-state>. Execute exatamente uma volta. Use a evidência desta volta para
escolher a próxima ação. Faça no máximo uma mudança focada, rode o check alvo e as regressões, e só
mantenha a mudança se o aceite passar. Atualize o estado com evidência, custo, decisão e próximo
candidato. Retorne um estado: success, no-op, continue, blocked, stalled, exhausted ou error. Erro ou
budget esgotado nunca é sucesso. Não ultrapasse as permissões e aprovações da especificação.
```

## 14. Limites epistêmicos

- `[ACADÊMICO]` O paper de Loop Engineering é position paper + codificação descritiva de um catálogo;
  não é RCT e não publica ROI causal.
- `[EXPERIMENTAL]` Self-Harness tem benchmark e holdout, mas sob tasks, modelos e evaluator fixos.
- `[ACADÊMICO]` Intent-Centric SE é análise temática reflexiva de corpus heterogêneo; interpreta a
  transição, não mede produtividade causal.
- `[OFICIAL]` A fonte Anthropic autoriza afirmações sobre suas recomendações e mecanismos, não sobre
  toda classe de modelos.
- `[INDÚSTRIA]` Vídeos e Substack ajudam a operacionalizar e popularizar; não elevam uma alegação a
  evidência experimental.
