# 06 — Heurísticas e invariantes

Dois tipos que a documentação costuma misturar, com consequências ruins:

| | **Heurística** | **Invariante** |
|---|---|---|
| Natureza | boa aposta sob incerteza | regra que nunca pode ser violada |
| Quando falha | tem casos conhecidos de falha | violação é defeito, sempre |
| Onde vive | skill, guia, julgamento | constitution, hook, teste |
| Enforcement | nenhum — é conselho | mecânico, ou não é invariante |

**Regra de conversão:** heurística que nunca falhou em ~10 aplicações **e** pode ser verificada por
máquina é candidata a virar invariante. Invariante que precisa de exceção **não era** invariante —
rebaixe para heurística com o caso registrado.

---

# Parte I — Heurísticas

Formato: enunciado · justificativa · **quando falha** · custo · exemplo.

## H-01 · Se você descreve o diff em uma frase, pule o plano
**Justificativa.** Plan mode adiciona overhead real; para escopo claro e correção pequena ele não paga.
**Quando falha.** A "uma frase" esconde um refactor — renomear um símbolo usado em 40 arquivos.
**Custo.** Zero. **Exemplo.** Typo, linha de log, renomear variável local. `[OFICIAL]`

## H-02 · Duas correções falhas ⇒ `/clear`
**Justificativa.** O contexto ficou poluído com abordagens falhas; a terceira tentativa herda as duas.
**Quando falha.** A correção depende de descoberta acumulada que se perderia — aí `/compact` dirigido.
**Custo.** Recontextualizar. **Regra oficial.** *"Uma sessão limpa com prompt melhor quase sempre vence
uma sessão longa com correções acumuladas."*

## H-03 · Se o agente já faz certo sem a instrução, apague a instrução
**Justificativa.** Cada linha do CLAUDE.md dilui as demais.
**Quando falha.** Modelo novo com comportamento diferente; a instrução volta a ser necessária.
**Custo.** Um teste comportamental. **Alternativa.** Converter em hook.

## H-04 · Peça a evidência, não o veredito
**Justificativa.** Revisar a saída do teste é mais rápido que re-executar a verificação — e funciona
para sessões que você não assistiu.
**Quando falha.** A evidência é volumosa demais para ser lida (log de 10 mil linhas).
**Custo.** Tokens de saída.

## H-05 · Delegue a investigação, não a leitura conhecida
**Justificativa.** Subagente existe para tirar o custo de contexto da exploração, não para paralelizar.
**Quando falha.** Investigação que exige o contexto que só o principal tem.
**Custo.** Uma invocação; perda de coerência.

## H-06 · Ambiguidade barata: assuma e registre. Ambiguidade cara: pergunte
**Justificativa.** Bloquear tudo produz agente insuportável; assumir tudo produz retrabalho.
**Onde está a fronteira.** Custo de reverter — schema, contrato público, dado, segurança são caros.
**Quando falha.** O julgamento do custo está errado, o que é comum em domínio novo.
**Custo.** Um julgamento por marcador.

## H-07 · Está no prompt? Infira. É padrão? Use o default. Está no código? Busque. É do negócio? Pergunte
**Justificativa.** `[CAMPO]` Ordena a decisão de perguntar e elimina a maior parte das perguntas
triviais.
**Nunca perguntar.** Nome de branch, estrutura de pastas, formato de endpoint, framework de teste.
**Sempre perguntar.** Protótipo ou produção? Critério de aceite de negócio? SLA? Padrão arquitetural?
**Quando falha.** O default padrão da stack está errado neste projeto — e é por isso que existe
constitution.

## H-08 · Regra universal ⇒ propriedade; caso específico ⇒ exemplo
**Justificativa.** Exemplo prova exemplo.
**Teste de bolso.** O requisito contém *sempre, nunca, qualquer, todo, independente de, em qualquer
ordem*? Então é propriedade.
**Quando falha.** Espaço de entrada não gerável, dependência externa, não-determinismo, UI. Nesses
casos registre o motivo em vez de forçar.

## H-09 · Comece o PBT pela função mais pura e mais crítica
**Justificativa.** `[CAMPO]` 90% do valor está no nível unitário: rápido, determinístico, shrinking
limpo. Normalmente é um validador, um normalizador de erro ou uma máquina de estados de domínio.
**Quando falha.** O sistema não tem função pura relevante (CRUD fino sobre banco).

## H-10 · Limite de rate/lote reflete o pico de uso real, não "quanto menor mais seguro"
**Justificativa.** `[CAMPO]` — heurística nascida de um incidente real. `login=10/min` copiado de guia
genérico quebrou a suíte E2E e revelou o requisito verdadeiro: numa plataforma de inscrição em eventos,
várias pessoas atrás do mesmo Wi-Fi logando em rajada é **tráfego legítimo esperado**.
**Quando falha.** Endpoint sem padrão de rajada legítima e com custo por chamada (envio de e-mail) —
ali menor é melhor mesmo.
**Generalização.** Todo limite numérico é uma afirmação sobre o domínio, não sobre segurança em
abstrato.

## H-11 · Coluna nova nasce nullable no DDL; a obrigatoriedade vive no construtor de domínio
**Justificativa.** `[CAMPO]` `ddl-auto=update` não adiciona `NOT NULL` a tabela com linhas — loga WARN
e **sobe sem a coluna**, e o erro aparece só no primeiro insert.
**Quando falha.** Com migrations versionadas (Flyway), a restrição pode nascer no DDL.
**Generalização.** Toda ferramenta que "faz o que dá" silenciosamente é uma armadilha; prefira a que
falha alto.

## H-12 · Teste que passa a falhar numa correção de segurança é evidência a favor dela
**Justificativa.** `[CAMPO]` O teste afirmava o comportamento inseguro. Reverter a correção para
"consertar" o teste é inverter causa e efeito.
**Quando falha.** A correção realmente quebrou algo legítimo — por isso a pergunta certa é *"o que ele
afirmava era certo?"*, não *"como faço passar?"*.

## H-13 · Uma spec ativa por vez, numeração imutável
**Justificativa.** Duas specs concorrentes competem por contexto e produzem contratos incompatíveis.
**Quando falha.** Time grande com áreas realmente disjuntas.

## H-14 · Commit por task concluída, nunca um commit no fim
**Justificativa.** `[CAMPO]` Favorece revisão incremental e permite abandonar ou retomar a sessão sem
perder granularidade.
**Quando falha.** Task que só faz sentido junto com a seguinte — aí a unidade coerente é o par.

## H-15 · Sessão nova para executar a spec que você acabou de escrever
**Justificativa.** `[OFICIAL]` Contexto limpo, focado em implementação, com a spec como referência
escrita. O contexto da elaboração (alternativas descartadas, discussão) é ruído na execução.
**Quando falha.** Spec pequena, onde recontextualizar custa mais que o ruído.

## H-16 · Peso do processo proporcional ao porte da mudança
**Justificativa.** O consenso mais forte deste corpus — aparece independentemente em três fontes.
**Quando falha.** Mudança pequena em área crítica (uma linha no cálculo de dinheiro). Aí o critério
não é o tamanho, é o **custo do erro**.

## H-17 · Uma pergunta por vez, com a resposta recomendada junto
**Justificativa.** `[INDÚSTRIA]` Rajada de perguntas transfere ao humano o custo de decidir do zero e
produz respostas rasas; pergunta única com recomendação embutida custa um "sim". Resolve a tensão
aparente com AP-09 (Interrogatório): o defeito de AP-09 nunca foi o **número** de perguntas, foi a
ausência de recomendação. Compõe com INT-07 — infira o inferível, pergunte o resto assim. É a regra
mais acionável de INT-08, isolada aqui porque vale em qualquer diálogo, não só em entrevista formal.
**Quando falha.** O humano já escreveu tudo num documento; aí perguntar em série é atrito puro.
Também falha quando as perguntas são independentes e o humano prefere despachar em lote.
**Custo.** Mais turnos. **Exemplo.** `/sdd-clarify` resolvendo uma ambiguidade bloqueante por vez.

## H-18 · Se o loop de feedback não fecha em segundos, conserte o loop antes do bug
**Justificativa.** `[INDÚSTRIA]` Sem sinal vermelho/verde determinístico e rápido, toda hipótese é
testada no escuro e cada iteração custa o dobro. Construir o loop parece desvio e é o caminho curto —
é a fase 1 de VER-06.
**Quando falha.** Bug de causa óbvia com teste existente que já o cobre; e o caso em que construir o
loop custa mais que o defeito vale (script de uso único, defeito cosmético).
**Custo.** Dez a trinta minutos antes de tocar no bug. **Exemplo.** Regressão de desempenho: medir a
linha de base e automatizar a medição antes de otimizar qualquer coisa.

## H-19 · Se o feedback não muda a próxima ação, não construa um loop
**Justificativa.** `[RECENTE]` O valor do loop é adaptação com verificação. Repetir uma tarefa fixa em
cadência fixa é prompt agendado; embrulhá-la em memória, estados e retries adiciona superfície de
falha sem informação nova.
**Quando falha.** A ação parece fixa, mas o resultado altera prioridade, escopo, retry, escalonamento
ou escolha de skill; então há feedback real e EXE-07 se aplica.
**Custo.** Recusar automação excessiva pode manter intervenção humana onde um check ainda precisa ser
descoberto. **Exemplo.** Gerar o mesmo relatório toda noite é agenda; corrigir o maior desvio revelado
pelo relatório e medir de novo é loop.

## H-20 · Harness só melhora quando o holdout também não piora
**Justificativa.** `[EXPERIMENTAL]` No protocolo Self-Harness, o held-in prova que a mudança trata a
fraqueza observada; o held-out detecta regressão e overfit invisíveis ao proposer. Aceitar ganho apenas
no alvo conhecido premia specification gaming.
**Quando falha.** Não existe corpus repetível/evaluator fixo; nesse caso não há base para afirmar
autoaperfeiçoamento — trate a edição como hipótese humana comum, com revisão e rollout controlado.
**Custo.** Dobra a superfície de avaliação e preserva casos que o proposer não pode inspecionar.
**Exemplo.** Mudança em `AGENTS.md` que melhora SWE-bench visível só é promovida se o conjunto
reservado também não regredir.

---

# Parte II — Invariantes

Regras que nunca podem ser violadas. Cada uma declara **como é imposta** — invariante sem enforcement
é heurística com pretensão.

| # | Invariante | Disciplina | Enforcement |
|---|---|---|---|
| **I-01** | Nunca executar sem objetivo declarado | D1 | Portão: sem spec/task, o comando recusa |
| **I-02** | Nunca executar sem contexto mínimo (constitution lida) | D2 | Primeira ação de todo comando |
| **I-03** | Nunca misturar planejamento com execução no mesmo passo | D3/D4 | Plan mode; comandos separados |
| **I-04** | Nunca assumir informação inexistente — marque `UNKNOWN` | D1 | Revisão + protocolo anti-invenção |
| **I-05** | Nunca modificar estado sem validação | D4 | Harness + hook |
| **I-06** | Nunca perder rastreabilidade (todo artefato sobe e desce) | D5 | Matriz verificada |
| **I-07** | Toda decisão precisa ser justificável | D6 | ADR / rationale com alternativa rejeitada |
| **I-08** | Toda ferramenta invocada precisa de motivo explícito | D4 | Envelope + log de tool call |
| **I-09** | Nunca validar o próprio trabalho no mesmo contexto | D5 | Subagente / sessão separada |
| **I-10** | Nunca desabilitar, pular ou apagar teste para o build passar | D4 | Grep por `@Disabled`/`skip` no diff; CI |
| **I-11** | Operação destrutiva exige aprovação humana explícita | D4 | Permissões; vale **mesmo em modo auto** |
| **I-12** | Nenhum segredo no código; ausência de config derruba o boot em prod | D4 | Fail-fast + scanner |
| **I-13** | Nunca logar senha, token, JWT ou PII | D4 | Sanitizador + teste que falha se vazar |
| **I-14** | Conflito com a constitution é reportado, nunca resolvido em silêncio | D1 | Instrução + revisão |
| **I-15** | Nenhum código de fachada (`return "success"` sem trabalho) | D4 | `NotImplementedError` + revisão |
| **I-16** | Truncar é proibido: 48 campos ⇒ documentar 48 | D5 | Contagem antes de emitir |
| **I-17** | A constitution não muda no meio de uma task | D1 | Processo de emenda próprio |
| **I-18** | Task não fecha sem que a verificação declarada tenha rodado | D5 | Harness obrigatório |

## Os oito do esboço original, auditados

Você propôs oito invariantes. Sete entram como estão (I-01 a I-08). A auditoria de cada uma:

| Proposta | Veredito | Observação |
|---|---|---|
| Nunca executar sem objetivo | ✅ I-01 | Fundamental. É a definição de agente dirigido a objetivo |
| Nunca executar sem contexto mínimo | ✅ I-02 | Precisa definir **qual** é o mínimo, ou é inexequível: constitution + spec ativa |
| Nunca misturar planejamento com execução | ✅ I-03 | Sustentado por plan mode e pelos portões de fase |
| Nunca assumir informação inexistente | ✅ I-04 | Reforçado pelo protocolo anti-invenção com 5 níveis de confiança |
| Nunca modificar estado sem validação | ✅ I-05 | Só é invariante **com harness**; sem ele é aspiração |
| Nunca perder rastreabilidade | ✅ I-06 | Com a ressalva de AP-34: rastreabilidade não verificada é pior que nenhuma |
| Toda decisão deve ser justificável | ✅ I-07 | *Justificável* ≠ *justificada*. Exigir justificativa para toda decisão é AP-33 |
| Toda ferramenta precisa de motivo explícito | ⚠️ I-08 rebaixada | Em espírito sim; ao pé da letra produz ruído em cada `ls`. **Reformulada:** ferramenta com efeito colateral precisa de motivo explícito |

**Acréscimos derivados das fontes** — I-09 a I-18. O mais importante é **I-09**, porque é o único que
não pode ser cumprido por boa vontade: exige arquitetura (contexto separado). E **I-10**, porque é o
mais frequentemente violado sob pressão de prazo.

---

**Anterior:** [05 — Anti-padrões](05-antipadroes.md) · **Próximo:** [07 — Modelos mentais](07-modelos-mentais.md)
