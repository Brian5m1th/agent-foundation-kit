# 03 — Princípios (meta-princípios)

## Como ler

Nenhum princípio entra aqui sem **origem histórica identificada**. Princípio sem autor e sem problema
original é slogan — e slogan em constitution é o anti-padrão AP-01.

Cada ficha traz: origem · autor · quando · problema que resolve · onde é usado · exemplo ·
contraexemplo · limitações · conflitos · impacto arquitetural · impacto cognitivo · impacto em
sistemas multiagentes · **classificação**.

**Classificação:**

| Classe | Significado | Consequência prática |
|---|---|---|
| **Fundamental** | Violá-lo quebra a disciplina inteira | Vira invariante ([06](06-heuristicas-e-invariantes.md)) |
| **Importante** | Violação custa caro, mas o sistema sobrevive | Vira artigo de constitution |
| **Opcional** | Vale em contextos específicos | Vira heurística ou skill |
| **Experimental** | Plausível, sem validação | Testar antes de adotar |
| **Obsoleto** | Foi verdade; a premissa mudou | Registrar por quê, não apagar |

Índice: **P01–P04** Intent · **P05–P07** Context · **P08–P09** Planning · **P10–P11** Execution ·
**P12–P13** Verification · **P14** Learning.

---

## P01 · Especificar antes de construir

| Campo | Conteúdo |
|---|---|
| **Origem** | Systems Engineering; requisitos de software |
| **Autor** | Daniel McCracken, *Digital Computer Programming* (1957); prática *test-first* no programa Mercury da NASA |
| **Quando** | 1957 — **quase 70 anos**, não é ideia de 2025 |
| **Problema** | O custo de corrigir um defeito cresce com a distância até sua introdução |
| **Onde é usado** | SRS, HLD/LLD, IDL, MDD, OpenAPI, Kiro, Spec Kit, Tessl, sdd-kit |
| **Classificação** | **Fundamental** |

**Exemplo.** Contract-Driven Development num time de serviços financeiros cortou o tempo de ciclo de
integração de API em 75% ao pegar incompatibilidades na revisão da spec em vez de em produção
`[INDÚSTRIA]`.

**Contraexemplo.** Böckeler pediu a Kiro que corrigisse um bug pequeno: o documento de requisitos
transformou o bug em 4 histórias de usuário com 16 critérios de aceite `[EXPERIMENTAL]`. A spec custou
mais que o bug.

**Limitações.** O modo de falha histórico nunca foi ausência de spec — foi **drift**: na Sprint 3 o
documento de design já estava velho. MDD morreu por exigir geradores rígidos e proprietários.

**Conflitos.** Com P03 (a intenção é descoberta) e com X9 (peso × porte). Gojko Adzic alerta que a
estrutura rígida do SDD pode reintroduzir a rigidez que o ágil tentou superar — *"o espectro do
Waterfall em roupagem nova"* `[INDÚSTRIA]`.

**Impacto arquitetural.** A spec vira o artefato durável e o código, derivado. Muda o que se versiona,
o que se revisa e o que se regenera.
**Impacto cognitivo.** Troca dezenas de microdecisões durante a implementação por uma revisão
estruturada no início — elimina *approval fatigue*.
**Impacto multiagente.** É o que torna a delegação paralela possível: sem contrato escrito, dois
agentes trabalhando ao mesmo tempo divergem em silêncio.

---

## P02 · Especificação hierárquica (Nível 1 rígido / Nível 2 flexível)

| Campo | Conteúdo |
|---|---|
| **Origem** | Separação política × mecanismo (sistemas operacionais); design by contract |
| **Autor** | Formulação corrente na literatura de SDD 2025; ancestral em Meyer (1992) |
| **Quando** | Meyer 1992; aplicação a agentes, 2025 |
| **Problema** | *Over-specifying* vira "programar em inglês"; *under-specifying* vira alucinação |
| **Onde é usado** | Metodologia SDD V5 §3, InscreveAI CLAUDE.md, Spec Kit (spec × plan) |
| **Classificação** | **Fundamental** |

**Nível 1 (spec)** — intenção, contrato de interface, regras de negócio, restrições. Inegociável.
**Nível 2 (plan)** — algoritmos, tipos internos, estrutura de pastas, DTOs internos. O agente escolhe
livremente desde que cumpra o Nível 1.

**Exemplo.** "O endpoint devolve `402` com `ProblemDetails` quando o pagamento é recusado" é Nível 1.
"Usa um `Map<String, StatusHandler>` em vez de `switch`" é Nível 2.
**Contraexemplo.** Spec que fixa nome de variável interna: perdeu a inteligência do modelo sem ganhar
garantia.

**Limitações.** A fronteira entre os níveis é notoriamente difícil. Böckeler: *"eu me confundia sobre
quando ficar no nível funcional e quando adicionar detalhe técnico — e como profissão não temos bom
histórico em separar requisito de implementação"* `[EXPERIMENTAL]`.

**Conflitos.** Com P01 quando a completude é confundida com rigidez.
**Impacto arquitetural.** Permite trocar a stack sem reescrever a intenção — a promessa do "código
descartável". **Impacto cognitivo.** Reduz drasticamente o que precisa ser revisado.
**Impacto multiagente.** O Nível 1 é o **protocolo** entre agentes; o Nível 2 é a implementação
privada de cada um.

---

## P03 · A intenção é descoberta, não capturada

| Campo | Conteúdo |
|---|---|
| **Origem** | HCI / elicitação de preferências |
| **Autor** | Shankar, Zamfirescu-Pereira, Hartmann, Parameswaran & Arora, UIST 2024 (Berkeley) — *criteria drift*; ancestral em Keeney & Raiffa (1976) |
| **Quando** | 2024 |
| **Problema** | Exigir critérios completos antes de executar assume uma independência que não existe |
| **Onde é usado** | Refinamento por amostra; modo Lite; `/sdd-clarify` |
| **Classificação** | **Fundamental** |

**Achado.** Usuários precisam de critérios para julgar saídas, mas é julgando saídas que passam a
definir critérios. Alguns critérios **só se tornam formuláveis depois de observar saídas específicas**
`[EXPERIMENTAL]`.

**Exemplo.** `[CAMPO]` O rate limit de login do InscreveAI começou em `10/min`, valor de tutorial. A
suíte E2E em série bateu no teto e revelou o requisito real: numa plataforma de inscrição em eventos,
várias pessoas atrás do mesmo Wi-Fi logando em rajada é **tráfego legítimo**. Ajustado para `30/min`.
O critério correto era inobservável antes da execução.

**Contraexemplo.** Domínio regulado onde a execução exploratória é proibida — aviação, medicina. Ali
a cascata continua racional.

**Limitações.** Escopo do estudo é específico (avaliação de saídas de LLM, N pequeno, laboratório).
Não sobre-generalize.

**Conflitos.** Diretamente com P01. **Arbitragem:** especificar antes continua certo; **fechar** a
especificação antes de executar é que é falso.
**Impacto arquitetural.** Spec versionada e viva, com taxa de revisão como sinal.
**Impacto cognitivo.** Alivia a culpa de "não pensei em tudo" — não pensar em tudo é o estado normal.
**Impacto multiagente.** Exige que o resultado de um agente possa **reabrir** o artefato de outro, o
que a maioria dos pipelines lineares não permite.

---

## P04 · Ambiguidade é explícita e bloqueia conforme o custo

| Campo | Conteúdo |
|---|---|
| **Origem** | Pragmática (implicatura); arquiteturas cognitivas (impasse do SOAR); iniciativa mista |
| **Autor** | Grice (1975); Laird/Newell (SOAR); Horvitz, CHI 1999 (Microsoft Research) |
| **Quando** | 1975 / 1987 / 1999 |
| **Problema** | O executor preenche lacunas e não sinaliza; a divergência aparece na entrega |
| **Onde é usado** | `[NEEDS CLARIFICATION]` (Spec Kit), `[PRECISA ESCLARECER]`, `Q01` em spec V5, `/sdd-clarify` |
| **Classificação** | **Fundamental** |

**Exemplo.** `[CAMPO]` A spec V5 tem seção dedicada: *"Questões em aberto (resolver antes de
implementar) — Q01: [pergunta] — status: aberta/resolvida — decisão:"*. A questão sobrevive com sua
resolução registrada.

**Contraexemplo.** Bloqueio incondicional. O `sdd-kit` reconhece o risco simétrico e o nomeia:
*"Pergunte só o que você não consegue razoavelmente inferir. NUNCA bombardeie com perguntas
triviais"*, com uma árvore de decisão — está no prompt? infira. É prática padrão? use o default. Está
no código? busque. É específico do negócio? **só então pergunte** `[CAMPO]`.

**Limitações.** O limiar de "custo alto de reverter" continua sendo julgamento, não regra.

**Conflitos.** Com velocidade e com a paciência do usuário. Um agente que pergunta demais é desligado.
**Impacto arquitetural.** Exige um campo de estado no artefato (aberta/resolvida) e um portão.
**Impacto cognitivo.** Ambiguidade não é defeito de redação — é a contrapartida da economia da
linguagem. Não se resolve escrevendo melhor, e sim tornando a inferência inspecionável.
**Impacto multiagente.** Sem marcação, a ambiguidade se **multiplica**: cada agente resolve de um
jeito e os resultados não compõem.

---

## P05 · O contexto é o recurso escasso

| Campo | Conteúdo |
|---|---|
| **Origem** | Arquitetura de LLM; teoria da atenção |
| **Autor** | Anthropic, *Best practices* / *Effective context engineering* |
| **Quando** | 2024–2025 |
| **Problema** | A janela enche rápido e o desempenho degrada conforme enche (*context rot*) |
| **Onde é usado** | `/clear`, `/compact`, subagentes, progressive disclosure, context-guardian |
| **Classificação** | **Fundamental** |

**Exemplo.** `[CAMPO]` O `sdd-kit` operacionaliza com um **Context Budget Protocol** de faixas:
0–40% normal · 40–60% preferir subagente · 60–80% **delegação obrigatória** · 80%+ compactar. Com
custos estimados por operação (arquivo grande ≈ 10.000 tokens).

**Contraexemplo.** `[CAMPO]` No mesmo repositório, os comandos `sdd.spec.md` (97 KB), `sdd.fix.md`
(82 KB) e `sdd.start.md` (68 KB) — cada um ≈ 15–25 mil tokens ao ser carregado. O framework declara o
protocolo e o viola na própria distribuição.

**Limitações.** Janela maior não resolve: *"só porque as janelas são maiores não significa que a IA vá
captar tudo que está lá dentro"* (Böckeler) `[EXPERIMENTAL]`.

**Conflitos.** Com P01 e P06 — mais spec e mais regra significam mais contexto consumido.
**Impacto arquitetural.** Justifica progressive disclosure, skills sob demanda e subagentes. É a
razão técnica da existência dos três.
**Impacto cognitivo.** Análogo direto à memória de trabalho humana: capacidade limitada, degradação
graciosa, interferência entre itens.
**Impacto multiagente.** É a **principal justificativa** de arquitetura multiagente. Subagente não
existe para paralelizar — existe para que o custo de contexto da investigação fique em outro lugar.

---

## P06 · Camadas de contexto, não um arquivo

| Campo | Conteúdo |
|---|---|
| **Origem** | Escopo léxico em linguagens de programação; herança de configuração |
| **Autor** | Anthropic (hierarquia de CLAUDE.md); Kiro (*steering*); Böckeler (*memory bank*) |
| **Quando** | 2024–2025 |
| **Problema** | Um arquivo único vira ou incompleto ou inchado; nas duas pontas o agente ignora |
| **Onde é usado** | `~/.claude/CLAUDE.md` → `./CLAUDE.md` → `subdir/CLAUDE.md` → skill |
| **Classificação** | **Importante** |

Ordem de especificidade: **global → projeto → módulo → feature → sob demanda**. Diretório filho é
carregado **quando o agente lê um arquivo dali** — é progressive disclosure nativo do sistema de
arquivos.

**Exemplo.** `[CAMPO]` K.A.O.S mantém `.opencode/rules/*.md` por linguagem (python, typescript, react,
testing, security, docker, mcp, n8n, github-actions) e o CLAUDE.md apenas **aponta**: *"consulte estas
antes de escrever código não-trivial nessa área"*.

**Contraexemplo.** `[CAMPO]` As mesmas skills duplicadas em `.claude/skills/`, `.agents/skills/` e
`.opencode/skills/`, com o CLAUDE.md admitindo: *"as versões **não são idênticas**: ao editar uma
skill, propague para as três"*. Isso é camada virando cópia — anti-padrão AP-15.

**Limitações.** Camada demais fragmenta e ninguém sabe onde uma regra mora.
**Conflitos.** Com descobribilidade.
**Impacto arquitetural.** A estrutura de diretórios vira estrutura de conhecimento.
**Impacto cognitivo.** Reduz carga: você lê só a camada em que está mexendo.
**Impacto multiagente.** Permite que agentes diferentes carreguem fatias diferentes do mesmo corpo.

---

## P07 · Progressive disclosure

| Campo | Conteúdo |
|---|---|
| **Origem** | Design de interface (Nielsen); carregamento tardio em sistemas |
| **Autor** | Anthropic Agent Skills (out/2025; formato aberto em dez/2025, adotado pela OpenAI) |
| **Quando** | 2025 |
| **Problema** | Instalar muito conhecimento sem pagar contexto por conhecimento não usado |
| **Onde é usado** | SKILL.md (só metadados no boot; corpo ao acionar; `references/` sob demanda) |
| **Classificação** | **Fundamental** |

**Exemplo.** Simon Willison chamou Skills de potencialmente *"maior que o MCP"* justamente pela
simplicidade radical: markdown com um pouco de YAML, contra uma especificação de protocolo inteira
`[INDÚSTRIA]`.

**Contraexemplo.** Comando de 97 KB que carrega tudo de uma vez.
**Limitações.** A descoberta depende da qualidade da `description`. Descrição ruim = skill nunca
acionada, e o sintoma é silencioso.
**Conflitos.** Com determinismo: o carregamento é *model-invoked*, ou seja, não garantido.
**Impacto arquitetural.** Conhecimento vira grafo carregável, não documento.
**Impacto multiagente.** Cada agente carrega só a sua fatia — condição para frota de agentes.

---

## P08 · Decompor até a unidade verificável

| Campo | Conteúdo |
|---|---|
| **Origem** | HTN planning; WBS; lote pequeno em Lean |
| **Autor** | Erol, Hendler & Nau (HTN, 1994); DORA (lote pequeno) |
| **Quando** | 1994 / 2024 |
| **Problema** | Task grande esconde bloqueio, estoura contexto e torna o progresso invisível |
| **Onde é usado** | `tasks.json` (`depends_on`, `acceptance_criteria`), `tasks.md` com `[P]` |
| **Classificação** | **Importante** |

**Exemplo.** `[CAMPO]` `sdd-kit`: 15–30 tasks por feature, subtasks de 2–4 horas, e o anti-padrão
AP-06 *Giant Tasks* — *"uma única task que leva mais de 1–2 dias"* — classificado como severidade
alta.

**Contraexemplo.** Fragmentar uma correção de typo em cinco tasks.
**Limitações.** A granularidade ótima depende do executor. O que cabe numa execução de agente muda a
cada geração de modelo.

**Conflitos.** Com P05 — mais tasks significam mais artefato para carregar.
**Impacto arquitetural.** Exige grafo de dependência explícito e detecção de ciclo.
**Impacto cognitivo.** Progresso visível é o que sustenta confiança em execução longa.
**Impacto multiagente.** É a **condição** do paralelismo: `[P]` só existe se os arquivos forem
disjuntos.

**Refinamento importante** `[INDÚSTRIA]` (Spec Kit): decompor **por história de usuário**, não por
camada. Agrupar por camada ("todos os models, depois todos os controllers") destrói a entregabilidade
independente — e com ela o MVP.

---

## P09 · Portões, não corredores

| Campo | Conteúdo |
|---|---|
| **Origem** | Stage-gate (Cooper, 1986); modelo em V |
| **Autor** | Robert Cooper; tradição de Systems Engineering |
| **Quando** | 1986 |
| **Problema** | Trabalho incompleto se propaga e o custo de correção sobe a cada fase |
| **Onde é usado** | `/sdd.finish` bloqueia sem teste; `/sdd-analyze`; gate humano antes do código |
| **Classificação** | **Importante** |

**Exemplo.** `[CAMPO]` `governance.md`: *"Não pode pular validação de fase"* — funcional valida antes
de técnica, técnica antes de tasks, tasks antes de implementação. Com **limites de iteração por
fase** (máx. 5 para clarify, 3 para refinamento) e escalonamento obrigatório ao atingir o máximo.
Esse limite é um achado raro: a maioria dos frameworks define o portão e esquece que iterar
indefinidamente também é modo de falha.

**Contraexemplo.** Portão que ninguém pode reprovar. `[INDÚSTRIA]` Böckeler observa que os checklists
do Spec Kit são *"interpretados por IA, então não há garantia de 100% de que serão respeitados"* —
portão avaliado pelo próprio avaliado.
**Limitações.** Portão custa tempo; portão fraco custa credibilidade.
**Conflitos.** Com P03 — portão pressupõe que a fase anterior pode ser fechada.
**Impacto multiagente.** Portão é o ponto de sincronização de uma frota.

---

## P10 · Envelope de autonomia declarado

| Campo | Conteúdo |
|---|---|
| **Origem** | Níveis de automação; princípio do menor privilégio; contratos incompletos |
| **Autor** | Sheridan & Verplank (1978); Parasuraman, Sheridan & Wickens (2000); Hart & Moore (1990) |
| **Quando** | 1978–2000 |
| **Problema** | Autonomia tratada como configuração global quando o nível certo varia por tarefa |
| **Onde é usado** | `--allowedTools`, permission modes, boundaries de 3 níveis do sdd-kit |
| **Classificação** | **Importante** |

**Exemplo.** `[CAMPO]` `governance.md` Princípio 7 — *Command Safety (não negociável)*: operações
destrutivas exigem aprovação humana explícita **mesmo em modo auto-aprovar**, com tabela de comandos
perigosos (`rm -rf`, `sudo`, `git push --force`, `DROP TABLE`, `chmod 777`) e diálogo de confirmação
que **explica o que será afetado**.

**Contraexemplo.** "Faça o que for necessário."
**Limitações.** Declarar sem enforcement é teatro. O envelope precisa de mecanismo (permissões,
sandbox, hook), não só de texto.
**Conflitos.** Com velocidade e com o volume de prompts de permissão — *"depois da décima aprovação
você não está mais revisando, está clicando"* `[OFICIAL]`.
**Impacto cognitivo.** Ataca diretamente a *approval fatigue*.
**Impacto multiagente.** Cada agente tem envelope próprio; a interseção é a superfície de risco real
do sistema.

---

## P11 · Harness sobre exortação

| Campo | Conteúdo |
|---|---|
| **Origem** | Poka-yoke (Toyota); *fail fast*; CI |
| **Autor** | Shigeo Shingo (poka-yoke, 1960s); formulação para agentes em `patterns.md` P_Novo3 `[CAMPO]` |
| **Quando** | 1960s / 2026 |
| **Problema** | Instrução em documento é advisory; o agente pode ignorá-la e frequentemente ignora |
| **Onde é usado** | Hooks, testes, lint, typecheck, CI, Stop hook, quality gates |
| **Classificação** | **Fundamental** |

**Formulação de campo.** *"O agente é um engenheiro capaz e cego ao contexto; o harness — testes,
linters, type checks, CI/CD — é o ambiente de segurança que restringe seus erros automaticamente."*

**Exemplo.** `[CAMPO]` P_Novo3 do InscreveAI: nenhuma task é concluída sem passar no harness relevante
(`./mvnw test` + `clean compile`; `npm test` + `npm run build`; Playwright em fluxo crítico).
Complementarmente, um teste falha se o núcleo de `shared/email/domain` passar a importar Spring, AWS,
Thymeleaf ou Lombok — **a regra arquitetural virou teste**.

**Contraexemplo.** Regra de arquitetura que só existe em prosa no CLAUDE.md.
**Limitações.** Harness cobre o mecânico. *"Isto é o que o usuário queria"* não é verificável por
linter.
**Conflitos.** Com flexibilidade e com o tempo de setup.
**Impacto arquitetural.** Empurra regra para código executável — a forma mais durável de conhecimento.
**Impacto cognitivo.** Remove do humano o papel de laço de verificação.
**Impacto multiagente.** É o **único** mecanismo que escala para N agentes sem N revisores.

**Aplicação a Loop Engineering.** `[RECENTE]` O loop não torna uma instrução mais forte só por
repeti-la. A autonomia cresce quando cada volta é empurrada por check externo, estados terminais e
runtime que impõe o envelope; sem isso, a repetição amplifica a fragilidade da exortação (AP-38).

> Regra de conversão `[OFICIAL]`: *"se o Claude já faz certo sem a instrução, apague-a — ou
> converta-a em hook."*

---

## P12 · Independência do verificador

| Campo | Conteúdo |
|---|---|
| **Origem** | V&V independente (Systems Engineering); viés de confirmação |
| **Autor** | Wason (1960, viés de confirmação); tradição de IV&V aeroespacial |
| **Quando** | 1960 / prática de IV&V desde os anos 1970 |
| **Problema** | Quem escreveu sabe **por que** decidiu e consegue racionalizar a falha |
| **Onde é usado** | `sdd-validator-runner`, padrão Writer/Reviewer, `/code-review`, `/sdd-converge` |
| **Classificação** | **Fundamental** |

**Formulação de campo.** `[CAMPO]` `mandatory-standards.md`: *"Você NÃO PODE validar seu próprio
código no mesmo contexto"* — com veredito tipado (`APPROVED` / `CAN_PROCEED_WITH_WARNINGS` /
`CANNOT_PROCEED`) e ações **proibidas** listadas: rodar validação no mesmo contexto, interpretar o
resultado ("provavelmente está ok"), sobrepor um `CANNOT_PROCEED`, marcar task completa sem
`APPROVED`.

**Exemplo.** Writer/Reviewer em sessões separadas `[OFICIAL]`: *"contexto novo melhora a revisão porque
o Claude não fica enviesado a favor do código que acabou de escrever"*.
**Contraexemplo.** Mesma sessão implementando e auditando.
**Limitações.** Custa uma execução a mais; e o revisor independente **sempre acha alguma coisa** —
ver P13.
**Conflitos.** Com custo e com coerência (o revisor não viu o raciocínio).
**Impacto multiagente.** É a justificativa mais forte para arquitetura Builder/Critic.

---

## P13 · Evidência, não veredito — e evidência proporcional

| Campo | Conteúdo |
|---|---|
| **Origem** | Epistemologia (falseabilidade); prática de auditoria |
| **Autor** | Popper; Boehm (V&V, 1984); formulação para agentes pela Anthropic |
| **Quando** | 1934 / 1984 / 2025 |
| **Problema** | "Está funcionando" é asserção; a asserção é exatamente o que está sob auditoria |
| **Onde é usado** | Saída real de comando, `arquivo:linha`, screenshot comparado |
| **Classificação** | **Fundamental** |

**Duas metades, e a segunda quase sempre falta:**

1. Exija a evidência: saída do teste, comando e retorno, screenshot. *"Revisar evidência é mais rápido
   que re-rodar a verificação — e funciona para sessões que você não assistiu."*
2. **Calibre o rigor.** *"Um revisor instruído a achar lacunas normalmente reporta alguma, mesmo
   quando o trabalho está correto. Perseguir todo achado leva a over-engineering: camadas extras de
   abstração, código defensivo e testes para casos impossíveis."* `[OFICIAL]`

**Exemplo.** `[CAMPO]` `correctness/06-prompt-para-ia.md` impõe: *"Cite evidência transcrevendo o
trecho real do código — não parafraseie"*, *"Separe SEMPRE o que você OBSERVOU do que você INFERIU"*, e
um passo 6 obrigatório — **force a propriedade a falhar de propósito e mostre o contra-exemplo
mínimo**, porque *"uma propriedade que nunca foi vista falhando não foi verificada"*. Isto é a
verificação da verificação.

**Contraexemplo.** Relatório sem nenhum achado negativo numa entrega real.
**Limitações.** Nem tudo tem evidência barata. Softgoal honesto é declarado como julgamento humano,
não convertido em proxy numérica.
**Conflitos.** Com P12 levado ao extremo → over-engineering.
**Impacto multiagente.** Evidência é o **formato de mensagem** entre agentes. Veredito não compõe;
evidência compõe.

**Aplicação à escada de verificação.** `[ACADÊMICO]` Nível 4 (juiz-LLM) continua sendo opinião por
rubrica; não deve herdar a linguagem de certeza do nível 1. Rotular o nível real é parte da evidência.

---

## P14 · Fechar o laço: execução vira conhecimento

| Campo | Conteúdo |
|---|---|
| **Origem** | Aprendizado organizacional; post-mortem sem culpa (SRE) |
| **Autor** | Argyris & Schön (*double-loop learning*, 1978); Google SRE |
| **Quando** | 1978 / 2016 |
| **Problema** | O mesmo erro é cometido a cada feature porque nada do anterior sobreviveu |
| **Onde é usado** | `LessonsLearned.md`, promoção a padrão, ADR, atualização de constitution |
| **Classificação** | **Importante** |

**Exemplo A** `[INDÚSTRIA]` (Red Hat): o prompt de geração instrui — *"conforme erros forem
corrigidos, registre erro e correção em `LessonsLearned.md`. Sempre que encontrar um erro a corrigir,
consulte o arquivo para ver se já sabe como corrigi-lo."* Laço fechado dentro da própria execução.

**Exemplo B** `[CAMPO]` — o mais forte deste corpus: os padrões `P_Novo4`–`P_Novo21` do InscreveAI
*"nasceram de uma falha real verificada em produção-iminente; a evidência está em `docs/audit/`"*, e
foram promovidos a **18 perguntas de revisão** reutilizáveis. Falha → padrão → pergunta de revisão →
prevenção. É D6 realimentando D1 e D5.

**Contraexemplo.** Retrospectiva cujas ações ninguém executa.
**Limitações.** O **problema de Grudin** (CSCW, 1988): quem paga o custo de capturar não é quem colhe
o benefício. É por isso que a captura de rationale falhou por décadas.
**Conflitos.** Com prazo. É sempre a primeira coisa cortada.
**Impacto arquitetural.** Exige que o conhecimento tenha **onde** ir: constitution, padrão, skill.
Sem destino, a lição vira comentário de PR e morre.
**Aplicação a Self-Harness.** `[EXPERIMENTAL]` Promover uma lição diretamente a prompt/harness não é
aprendizado demonstrado. LRN-03 exige que a edição trate o held-in sem piorar o held-out, com lineage
e rollback; caso contrário, é AP-39.
**Impacto multiagente.** Sem esse laço, N agentes cometem o mesmo erro N vezes — e é por isso que a
disciplina D6 é a menos madura e a mais cara de ignorar.

---

## Princípios classificados como Experimental ou Obsoleto

| Princípio | Classe | Razão |
|---|---|---|
| **Spec-as-source** (só a spec é editada; código é gerado e nunca tocado) | **Experimental** | Tessl em beta. Böckeler: risco de herdar *"as desvantagens do MDD e das LLMs: inflexibilidade **e** não-determinismo"* |
| **Código descartável** (regenerar em vez de refatorar) | **Experimental** | Contradito por evidência: código de agente sobrevive **mais** que o humano — 16% menos risco de modificação (arXiv 2601.16809) `[EXPERIMENTAL]` |
| **Um workflow serve a todos os tamanhos** | **Obsoleto** | Refutado independentemente por Böckeler, pelo modo Lite do sdd-kit e pela calibração da SDD V5 |
| **Contexto maior resolve** | **Obsoleto** | *Context rot*: janela maior ≠ aderência maior |
| **Auto-validação com prompt melhor** | **Obsoleto** | Substituído por P12: o problema é estrutural, não de redação |
| **MDD com gerador proprietário** | **Obsoleto** | A premissa (só um gerador rígido lê a spec) caiu quando o executor virou LLM |

Obsoleto **não é apagado**. Registrar por que uma verdade deixou de valer é o que impede que ela volte
como novidade.

---

**Anterior:** [02 — Glossário](02-glossario.md) · **Próximo:** [04 — Padrões](04-padroes.md)
