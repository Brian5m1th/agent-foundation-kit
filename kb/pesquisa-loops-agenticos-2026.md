# Pesquisa — loops agênticos, contexto e self-harness (2026)

> Pesquisa realizada em 2026-08-24 a partir das fontes fornecidas. Este arquivo separa o que cada
> fonte sustenta, o que é convergência entre fontes e o que continua sendo inferência. A destilação
> operacional está em [`loop-engineering.md`](loop-engineering.md).

## Pergunta

Como substituir supervisão humana passo a passo por loops agênticos que sejam adaptativos,
verificáveis, limitados e capazes de preservar aprendizado sem degradar o contexto ou o harness?

## Resultado consolidado

`[CONSOLIDADO]` Um loop útil não é “repita este prompt”. É uma especificação externa ao agente com
gatilho, meta observável, linha de base, ação por volta, feedback que muda a próxima ação, verificação,
regressões protegidas, memória compacta, limites e estados de parada. O harness fornece capacidades e
restrições; a skill sabe executar uma classe de ação; o prompt conduz uma volta; o loop governa a
progressão entre voltas.

`[CONSOLIDADO]` A melhor fronteira de autonomia é determinada pelo verificador. Exit codes,
asserções, schemas e regras permitem autonomia mais forte; juiz-LLM e preferência humana exigem fluxo
assistido, rubrica explícita e separação entre maker e checker. Erro, falta de verificador e orçamento
esgotado são estados terminais distintos de sucesso.

`[CONSOLIDADO]` Memória de loop deve viver fora da conversa e registrar apenas evidência, decisões,
tentativas, mudanças aceitas/rejeitadas e próximo candidato. Repassar transcrições acumuladas a cada
volta desperdiça atenção e favorece context rot.

## Evidência por fonte

### Stop Hand-Holding Your Coding Agent

Fonte: [arXiv 2607.00038](https://arxiv.org/html/2607.00038). `[RECENTE]` `[ACADÊMICO]`

- Propõe Loop Engineering como disciplina de especificar loops externos ao harness, em vez de
  conduzir o agente passo a passo.
- A anatomia inclui trigger, goal, skills, verification, stopping e memory.
- Organiza a verificação em cinco níveis: determinística, regra, verdade de campo, juiz-LLM e humano.
- Na codificação descritiva de 50 loops da Loop Library, 70% ficaram nos níveis 1–2 de verificação,
  74% declararam estados terminais, 66% metas verificáveis, 78% gatilho manual, 20% skills nomeadas e
  32% memória persistente.
- Propõe custo por mudança aceita como métrica operacional.

Limite: é position paper com análise descritiva de corpus, não experimento controlado de
produtividade ou ROI. A taxonomia orienta design; não demonstra que todo trabalho de software deve
virar loop.

### Self-Harness: Harnesses That Improve Themselves

Fonte: [arXiv 2606.09498](https://arxiv.org/html/2606.09498). `[EXPERIMENTAL]`

- Mantém modelo, evaluator, ambiente e tarefas fixos e permite que o processo altere somente o
  harness.
- Executa Weakness Mining → Harness Proposal → Proposal Validation.
- Separa casos held-in e held-out; promove uma variante apenas quando nenhum split piora e pelo menos
  um melhora.
- Avalia três famílias de modelos em Terminal-Bench-2.0, SWE-bench Verified e AppWorld. Os nove pares
  modelo×benchmark melhoraram nos dois splits; o maior ganho relativo agregado reportado foi 132%, e
  o maior ganho absoluto destacado foi +40,6 pontos percentuais em AppWorld com GLM.

Limite: os ganhos valem para o protocolo, modelos, benchmarks e evaluator estudados. O resultado não
autoriza autoedição irrestrita de harness de produção. Holdout invisível ao proposer, lineage,
rollback e aprovação continuam necessários.

### From Code-Centric to Intent-Centric Software Engineering

Fonte: [arXiv 2605.11027](https://arxiv.org/abs/2605.11027). `[ACADÊMICO]`

- Interpreta a mudança de engenharia centrada no código para engenharia centrada na intenção como
  uma reorganização sociotécnica do trabalho.
- Intenção, contexto, arquitetura, verificação, segurança, governança, proveniência e
  responsabilidade tornam-se elementos centrais quando gerar código plausível fica barato.
- Sustenta o encaixe conceitual entre SDD e loops: a spec fixa intenção; o loop governa adaptação e
  evidência durante a execução.

Limite: análise temática reflexiva de literatura e discurso, não benchmark causal de produtividade.

### Effective Context Engineering for AI Agents

Fonte: [Anthropic Engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents).
`[OFICIAL]`

- Trata atenção/contexto como recurso finito e recomenda o menor conjunto de tokens de alto sinal.
- Recomenda recuperação just in time, progressive disclosure, compactação, notas estruturadas e
  subagentes com contexto isolado.
- Dá base à arquitetura de voltas com contexto fresco que relê `loop.md` e `loop-state.md`, em vez de
  carregar toda a história conversacional.

Limite: é orientação oficial de engenharia da Anthropic, não comparação experimental universal entre
arquiteturas ou fornecedores.

### Loop Engineering — Addy Osmani

Fonte: [Substack](https://addyo.substack.com/p/loop-engineering). `[INDÚSTRIA]`

- Compõe automações, worktrees, skills, plugins/connectors, subagentes e memória externa em fluxos de
  trabalho persistentes.
- Mantém prompts como componente interno; a novidade é o sistema externo que dispara, observa,
  verifica, registra e repete.
- Explicita custos de tokens, gargalo humano de revisão e dívida de compreensão como limites reais.

Limite: síntese prática e opinião de indústria, não avaliação controlada.

### Vídeos fornecidos

- [O Criador do Claude Code APOSENTOU Prompts](https://www.youtube.com/watch?v=4UWjYd-IUF4),
  Maestros da IA, 2026-06-28, 13:07. `[INDÚSTRIA]`
- [Loop Engineering: Faça a IA TRABALHAR Enquanto Você DORME!](https://www.youtube.com/watch?v=LIn5X6ObEms),
  O Novo Programador, 2026-08-14, 22:49. `[INDÚSTRIA]`

Os metadados e descrições confirmam o enquadramento didático/promocional de Loop Engineering. Não foi
obtida transcrição verificável; por isso, título e descrição não são usados para sustentar resultados
experimentais ou mecanismos não presentes nas fontes primárias. “Aposentou prompts” é hipérbole: os
papers e a prática mantêm prompts dentro das voltas.

## Convergências e tensões

- `[CONSOLIDADO]` Todas as fontes convergem em mover esforço de instrução local para desenho do
  sistema: contexto, capacidades, verificadores, isolamento, memória e parada.
- `[CONSOLIDADO]` Loop Engineering e context engineering são complementares: o primeiro governa o
  tempo; o segundo preserva a qualidade da atenção em cada volta.
- `[CONSOLIDADO]` Intent-centric SE define a camada normativa; Loop Engineering não deve inventar a
  intenção que a spec não resolveu.
- `[HIPÓTESE]` Loops podem aumentar throughput por período, mas não há nestas fontes uma estimativa
  causal generalizável de ROI. Custo por mudança aceita e taxa de regressão devem ser medidos no
  próprio ambiente.
- `[HIPÓTESE]` Self-Harness é uma forma potente de LRN-03, porém sua segurança depende mais da
  independência do evaluator e do holdout do que da qualidade retórica do proposer.

## Consequência operacional para este repositório

O desenho foi incorporado como EXE-07, LRN-03, AP-38, AP-39, H-19, H-20, AR-04, PL-06, AD-04,
ME-04, AL-06 e ADR-012. A skill canônica está em
[`skills/loop-engineering/`](../skills/loop-engineering/), o comando SDD em
[`../.claude/commands/sdd-loop.md`](../.claude/commands/sdd-loop.md) e o template em
[`../.specify/templates/loop-template.md`](../.specify/templates/loop-template.md).
