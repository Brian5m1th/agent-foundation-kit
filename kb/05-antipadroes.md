# 05 — Catálogo de anti-padrões

Formato: **Sintoma → Mecanismo → Evidência → Detecção → Correção**. A coluna que dá valor é
**Evidência**: anti-padrão sem caso observado é opinião com formatação bonita.

Severidade: 🔴 crítico (compromete o resultado) · 🟡 alto (custa caro) · 🟢 médio (atrito).

---

## Contexto

### AP-02 · CLAUDE.md Enciclopédia 🔴

**Sintoma.** Arquivo longo, e o agente ignora metade das regras.
**Mecanismo.** Todo conteúdo é carregado em toda sessão e compete por atenção com o código. Acrescentar
uma regra **enfraquece** as demais.
**Evidência.** `[OFICIAL]` *"CLAUDE.md inchado faz o Claude ignorar suas instruções reais!"* — e o
diagnóstico invertido: *"se o Claude insiste em algo contra o qual existe regra, provavelmente o
arquivo está longo demais e a regra se perdeu no ruído."*
**Detecção.** Para cada linha: *remover isto faria o agente errar?* Se não, é ruído.
**Correção.** CTX-01 (camadas), CTX-02 (skill), EXE-02 (hook). O que o agente já faz certo sem a
instrução: apague.

### AP-26 · Estado Volátil na Constituição 🟡

**Sintoma.** O arquivo permanente contém status de sprint, contagem de testes, o que está em andamento.
**Mecanismo.** *"Informação que muda com frequência"* está explicitamente na lista de **excluir** do
CLAUDE.md `[OFICIAL]`. Ela envelhece entre sessões e o agente age sobre um retrato falso.
**Evidência.** `[CAMPO]` Seção "Estado atual" com contagens (*"48 classes, 251 testes, verificado em
2026-07-30"*) e status de specs em andamento dentro do CLAUDE.md do InscreveAI. O próprio texto admite
a fragilidade: *"contagem de specs de frontend não reconferida nesta rodada — confirme com `npm test`
antes de assumir um número"*.
**Detecção.** Alguma afirmação do arquivo pode estar falsa amanhã sem ninguém editar nada?
**Correção.** Estado vai para arquivo próprio (`STATUS.md`, `tasks.md`) que o agente lê **quando
precisa**; a constituição aponta onde está a verdade, não a repete.

### AP-04 · Sessão Entulhada 🟡

**Sintoma.** Uma tarefa, depois outra sem relação, depois volta à primeira.
**Mecanismo.** Contexto cheio de informação irrelevante degrada e distrai.
**Evidência.** `[OFICIAL]` nomeado como *"kitchen sink session"*.
**Detecção.** A tarefa atual tem relação com o que está no histórico?
**Correção.** `/clear` entre tarefas não relacionadas.

### AP-05 · Exploração Infinita 🟡

**Sintoma.** "Investigue X" sem escopo → centenas de arquivos lidos.
**Mecanismo.** Sem critério de parada, a exploração consome a janela inteira.
**Evidência.** `[OFICIAL]` listado entre os cinco modos de falha comuns.
**Correção.** Delimitar, ou CTX-03 (subagente).

### AP-15 · Cópia Manual Multi-Harness 🔴

**Sintoma.** O mesmo conhecimento em `.claude/`, `.agents/`, `.opencode/`, mantido à mão.
**Mecanismo.** Cópia manual diverge — não é risco, é certeza com o tempo.
**Evidência.** `[CAMPO]` O CLAUDE.md do InscreveAI **documenta a divergência como se fosse
procedimento**: *"as versões **não são idênticas**: ao editar uma skill, propague para as três"*.
**Detecção.** Diff entre as cópias. Se diferem sem intenção, o anti-padrão está ativo.
**Correção.** CTX-05 — fonte única + geração; a cópia é derivada e nunca editada.

### AP-27 · Artefato Grande Demais para o Próprio Protocolo 🟡

**Sintoma.** O framework declara orçamento de contexto e distribui arquivos que o estouram.
**Mecanismo.** Um comando carregado inteiro custa dezenas de milhares de tokens antes de qualquer
trabalho.
**Evidência.** `[CAMPO]` No `sdd-kit`: `sdd.spec.md` **97 KB**, `sdd.fix.md` **82 KB**, `sdd.start.md`
**68 KB** — no mesmo repositório que define o *Context Budget Protocol* com faixa de delegação
obrigatória a partir de 60%.
**Detecção.** Meça os arquivos que são carregados de uma vez. Acima de ~20 KB, questione.
**Correção.** Progressive disclosure: núcleo curto + `references/` sob demanda.

### AP-35 · Skill Negativa 🟡

**Sintoma.** A skill é uma lista de proibições — "não faça X", "nunca Y" — e o agente continua fazendo.
**Mecanismo.** `[INDÚSTRIA]` Dirigir por negação obriga o modelo a representar o comportamento
indesejado para evitá-lo, e não diz qual é o desejado. Sobra ambiguidade exatamente onde a skill
existia para removê-la.
**Evidência.** `[INDÚSTRIA]` *Negation* está entre os seis modos de falha nomeados em
`writing-great-skills` ([mattpocock-skills.md](mattpocock-skills.md) §8).
**Detecção.** Conte as linhas imperativas negativas. Se as proibições superam as instruções positivas,
o anti-padrão está ativo.
**Correção.** Reescrever como ação com critério de conclusão checável. A proibição que sobrar e
precisar valer **sem exceção** não é texto de skill: é hook (EXE-02) ou invariante.

### AP-36 · Sedimento 🟡

**Sintoma.** Camadas acumuladas numa skill, comando ou CLAUDE.md, escritas em momentos diferentes,
que ninguém removeu — algumas contradizendo as outras.
**Mecanismo.** Cada ajuste é acrescentado ao fim porque acrescentar é mais barato que reler. O arquivo
cresce por deposição, e o agente lê a camada errada.
**Evidência.** `[INDÚSTRIA]` *Sediment* entre os seis modos de falha de `writing-great-skills`.
`[CAMPO]` A defesa correspondente já existe neste corpus: ADR sem campo *"revisar quando"* é a mesma
falha em outro artefato (kb/11, cabeçalho).
**Detecção.** Duas instruções sobre o mesmo assunto escritas em estilos diferentes é sinal de duas
camadas. Pergunte de qual data é cada uma.
**Correção.** Editar no lugar em vez de acrescentar; todo artefato de processo declara quando expira.
Distinto de AP-02: enciclopédia é volume, sedimento é **estratificação contraditória** — um arquivo
curto pode ter sedimento.

### AP-37 · Conclusão Prematura 🔴

**Sintoma.** O agente declara a skill cumprida com metade dos passos executados, e o relatório final
descreve o resultado pretendido em vez do obtido.
**Mecanismo.** `[INDÚSTRIA]` Passo sem critério de conclusão checável termina quando o modelo julga
que terminou. Numa sequência, o julgamento acumula: o passo 2 herda o "pronto" duvidoso do passo 1.
**Evidência.** `[INDÚSTRIA]` *Premature completion* é o primeiro dos seis modos de falha de
`writing-great-skills`, e a razão declarada para dividir skill **por sequência**.
**Detecção.** Cada passo tem uma condição que alguém de fora consegue conferir? Se o critério é
"quando estiver bom", não há critério (AP-07).
**Correção.** Critério checável por passo; separar em skills sequenciais quando o passo seguinte não
pode começar sem evidência do anterior. Parente de AP-30 (Truncamento Silencioso), que é o mesmo
defeito no **volume** da saída, e de AP-29 (Código de Fachada), que é no **conteúdo**.

---

## Intenção

### AP-01 · Constituição Genérica 🔴

**Sintoma.** Artigos como "buscar a qualidade" e "priorizar o usuário".
**Mecanismo.** Enunciado que nenhuma decisão real violaria não restringe nada — só consome contexto.
**Detecção.** Para cada artigo: *que decisão plausível e tentadora isto proíbe?* Sem resposta concreta,
é decoração.
**Correção.** Trocar por restrições que doem: "nenhum endpoint público sem rate limit", "zero
dependência copyleft", "nenhuma migração sem rollback testado".

### AP-03 · Marreta na Noz 🔴

**Sintoma.** Bug pequeno gera 4 histórias de usuário e 16 critérios de aceite.
**Mecanismo.** Workflow único aplicado a todos os portes.
**Evidência.** `[EXPERIMENTAL]` Böckeler, com Kiro, literalmente isso — incluindo *"como desenvolvedor,
quero que a função de transformação trate casos de borda graciosamente"* para uma correção trivial. E
com o Spec Kit: *"no mesmo tempo que levei para rodar e revisar os resultados, eu teria implementado a
feature com AI-assisted coding comum, e me sentiria muito mais no controle."*
**Detecção.** O artefato é maior que a mudança que descreve?
**Correção.** INT-05 (calibração por porte) e a regra oficial: *"se você descreve o diff em uma frase,
pule o plano."*

### AP-06 · Pseudocódigo em Prosa 🟡

**Sintoma.** A spec detalha algoritmo, nome de variável interna, estrutura de pastas.
**Mecanismo.** *Over-specifying*: perde-se a inteligência do modelo sem ganhar garantia. O humano
acaba *"programando em inglês"* — mais lento e mais propenso a erro que programar.
**Detecção.** A spec menciona algo que o Nível 2 deveria decidir?
**Correção.** INT-02.

### AP-07 · Critério Vago 🔴

**Sintoma.** "A feature deve funcionar corretamente", "a performance deve ser boa".
**Mecanismo.** Sem definição compartilhada de pronto, o escopo cresce indefinidamente.
**Evidência.** `[CAMPO]` AP-02 do sdd-kit, severidade crítica. Contraste: ❌ *"o login deve ser
rápido"* × ✅ *"tempo de resposta do login < 500 ms em 95% das requisições"*.
**Correção.** INT-03 + critério discriminante (algum resultado plausível o reprova?).

### AP-08 · Três Exemplos para uma Regra Universal 🟡

**Sintoma.** Requisito diz "sempre"/"nunca"/"qualquer" e é verificado por três testes escolhidos a
dedo.
**Mecanismo.** Exemplo prova exemplo. *"Quando o requisito diz sempre, nunca, para todo ou independente
de, um exemplo não é evidência suficiente — e é exatamente aí que os bugs caros moram."*
**Evidência.** `[CAMPO]` P_Novo16: *"Regra universal vira `PROP` na spec **e** teste de propriedade —
não três exemplos"*.
**Correção.** INT-04.

### AP-09 · Interrogatório 🟡

**Sintoma.** O agente pergunta o que já está no prompt, ou o que é padrão da stack.
**Mecanismo.** Bloqueio incondicional por ambiguidade. Custa mais atrito do que o erro que evita.
**Evidência.** `[CAMPO]` O sdd-kit dedica um protocolo inteiro a isso: *"❌ RUIM: 'Que linguagem?' ← O
USUÁRIO JÁ DISSE Go!"*
**Correção.** INT-07 (árvore: prompt → default → código → só então perguntar).

### AP-14 · Namespace Colidido 🔴

**Sintoma.** O mesmo identificador significa coisas diferentes em documentos vigentes do mesmo repo.
**Mecanismo.** Dois documentos evoluíram em paralelo, cada um numerando do zero, e nenhum foi
reconciliado.
**Evidência.** `[CAMPO]` — o caso mais nítido de todo o corpus. No InscreveAI, `CLAUDE.md` e
`AGENTS.md` definem `P1`–`P6` (P4 = "proibir `var`", P6 = "logs [start]/[finish]"), enquanto
`.spec/memory/patterns.md` define os **mesmos IDs** com outro significado (P4 = "Domínio Rico",
P6 = "Relacionamento JPA"). Existem **dois formatos de log documentados como obrigatórios**, e ambos
são aceitos. Os três documentos estão vigentes e a solução adotada foi *documentar a ambiguidade*:
*"ao citar um padrão, sempre prefixe a origem"*.
**Detecção.** Grep pelo mesmo identificador em todos os arquivos de norma. Mais de uma definição = bug.
**Correção.** Prefixo de origem é mitigação, não solução. A solução é **renumerar uma das fontes** e
deixar uma só. Toda regra citável precisa de identificador globalmente único no repositório.

### AP-19 · Ambiguidade Silenciosa 🔴

**Sintoma.** O agente entrega algo coerente; ninguém sabe quantas decisões ele tomou.
**Mecanismo.** Implicatura sem common ground: o executor infere, e a inferência é invisível.
**Correção.** Marcador de ambiguidade + EXE-06 (registro de interpretação).

---

## Planejamento

### AP-10 · Contrato Emergente 🔴
**Sintoma.** As interfaces aparecem durante a implementação. **Mecanismo.** Sem contrato no plan, cada
task inventa o seu, e módulos divergem. **Correção.** PLN-01.

### AP-11 · Big Bang de Camadas 🟡
**Sintoma.** Tasks agrupadas por camada; nada é demonstrável antes do fim. **Correção.** PLN-02.

### AP-12 · Task sem Critério 🔴
**Sintoma.** "Implementar autenticação", sem definição de pronto. **Evidência.** `[CAMPO]` AP-05 do
sdd-kit, crítico: *"impossível validar; a task está 'pronta' quando alguém decide que está"*.
**Correção.** PLN-03.

### AP-13 · Task Gigante 🟡
**Sintoma.** Uma task de mais de 1–2 dias. **Mecanismo.** Progresso invisível; bloqueio escondido
dentro. **Correção.** Subtasks de 2–4 horas.

### AP-28 · Dependência Implícita 🟡
**Sintoma.** Lista de tasks sem `depends_on`. **Mecanismo.** Execução em ordem errada; bloqueio
descoberto na implementação. **Correção.** Grafo explícito + detecção de ciclo na validação.

---

## Execução

### AP-16 · Direto ao Código 🟡
**Sintoma.** Implementação começa sem exploração. **Mecanismo.** Resolve-se o problema errado com
esmero. **Correção.** EXE-01 — **calibrado**: para mudança de uma frase, ir direto é o certo.

### AP-17 · Confiança sem Verificação 🔴
**Sintoma.** Implementação plausível que não trata borda. **Evidência.** `[OFICIAL]` *"trust-then-verify
gap"*. **Correção.** *"Sempre forneça verificação. Se você não consegue verificar, não faça deploy."*

### AP-18 · Delegação em Branco 🔴
**Sintoma.** "Faça o que for necessário." **Mecanismo.** O agente decide nas lacunas sem que ninguém
tenha decidido que ele decidiria. **Correção.** EXE-04.

### AP-29 · Código de Fachada 🔴
**Sintoma.** `return {"status": "success"}` sem fazer o trabalho; `TODO` em produção; `pass`.
**Evidência.** `[CAMPO]` *Anti-Placeholder Code Protocol* do sdd-kit, com a regra correta: **lançar
`NotImplementedError`** em vez de simular sucesso.
**Detecção.** Grep por retorno constante em função que deveria ter efeito.
**Correção.** Falhar alto é melhor que fingir baixo.

### AP-30 · Truncamento Silencioso 🟡
**Sintoma.** "A entidade tem 7 campos principais…", "e outros", "os campos importantes são…".
**Evidência.** `[CAMPO]` *Anti-Truncation Protocol*: *"se a entidade tem 48 campos, documente os 48"*,
com verificação obrigatória — conte no código, conte na saída, os números têm de bater.
**Correção.** Contagem explícita antes de emitir.

### AP-31 · Teste Desligado para Passar 🔴
**Sintoma.** `@Disabled`, `it.skip`, `@pytest.mark.skip`, `t.Skip()` acrescentados durante uma
correção. **Evidência.** `[CAMPO]` *Anti-Skip Rule*: *"NUNCA pule, desabilite ou apague testes para
fazer o build passar"*. **Correção.** VER-03 (quarentena **com link para a task**) é a única forma
legítima de adiar — e ela é rastreável.

### AP-38 · Loop sem Saída 🔴
**Sintoma.** “Continue melhorando” ou retry recorrente sem check externo, estados terminais, detector
de estagnação, memória curada ou teto de custo; às vezes o agente executa a mesma skill indefinidamente.
**Mecanismo.** `[RECENTE]` Nenhuma evidência nova empurra a próxima ação e erro/budget esgotado acabam
tratados como conclusão. Em versão autônoma, custo e dano acumulam sem ponto explícito de devolução ao
humano.
**Detecção.** O resultado de uma volta muda a próxima ação? Existe um estado diferente para sucesso,
`blocked`, `stalled`, `exhausted` e `error`? Existe hard cap?
**Correção.** EXE-07/AR-04. Sem feedback adaptativo, substituir por execução única ou prompt agendado.

---

## Verificação

### AP-20 · Auto-validação 🔴
**Sintoma.** A mesma sessão implementa e audita. **Mecanismo.** *"O agente sabe POR QUE as decisões
foram tomadas → consegue racionalizar as falhas. Resultado: o validador reporta OK apesar de haver
problemas reais."* `[CAMPO]` **Correção.** VER-01, contexto isolado.

### AP-21 · Drift entre Camadas 🟡
**Sintoma.** Implementação diverge da spec técnica sem que a spec seja atualizada.
**Evidência.** `[CAMPO]` AP-09 do sdd-kit: *"specs viram mentiras documentadas; desenvolvedores futuros
são enganados"*. **Correção.** Atualizar a spec **primeiro**; manter a spec atualizada é parte do
Definition of Done.

### AP-22 · Propriedade Afrouxada 🔴
**Sintoma.** A propriedade falhava; alguém relaxou a asserção até passar.
**Mecanismo.** O teste passa a documentar o bug em vez de detectá-lo. **Correção.** VER-03.

### AP-23 · Teste Decorativo 🔴
**Sintoma.** Teste que nunca foi visto falhando. **Mecanismo.** Gerador vazio, asserção tautológica,
pré-condição que descarta tudo — passa para sempre sem medir nada.
**Evidência.** `[CAMPO]` Além disso, o caso mais perigoso observado: `SecurityConfigTest` mora em
`src/main` com `@Profile("test")` e `permitAll()`, então **qualquer teste sob o perfil `test` roda sem
autorização** — *"um teste que passe sob o perfil `test` não prova que o endpoint está protegido em
produção"*. Um conjunto inteiro de testes de segurança pode ser decorativo por configuração.
**Correção.** VER-04 (falha forçada) e, para segurança, um perfil dedicado.

### AP-24 · Over-engineering por Revisão 🟡
**Sintoma.** Cada rodada de revisão acrescenta abstração, guarda defensiva e teste para caso
impossível. **Evidência.** `[OFICIAL]` **Correção.** VER-05.

### AP-32 · Falsa Sensação de Controle 🔴
**Sintoma.** Muitos arquivos, checklists e portões — e o agente continua não seguindo tudo.
**Mecanismo.** Checklist interpretado pelo próprio avaliado não é portão. E o inverso também ocorre:
*"eu vi o agente ignorar instruções, mas também vi o agente exagerar por seguir instruções com
entusiasmo demais — por exemplo, um dos artigos da constitution"* `[EXPERIMENTAL]`.
**Evidência.** Böckeler, com Spec Kit: o passo de pesquisa descreveu classes existentes, e o agente
*"tomou as descrições como especificação nova e gerou tudo de novo, criando duplicatas"*.
**Detecção.** Existe algum portão **determinístico** (hook, teste, CI), ou todos são julgados por LLM?
**Correção.** EXE-02/EXE-03 — pelo menos um portão do fluxo tem de ser mecânico.

---

## Aprendizado

### AP-25 · Erro Recorrente 🟡
**Sintoma.** A mesma classe de defeito reaparece a cada feature.
**Mecanismo.** Nada do que se aprendeu tem destino: nem constitution, nem padrão, nem skill.
**Correção.** LRN-01 + LRN-02.

### AP-33 · Teatro de Conformidade 🔴
**Sintoma.** Existem constitution, specs e ADRs — e nenhuma decisão real foi alterada por eles.
**Mecanismo.** Problema de Grudin: o artefato é produzido para satisfazer o processo, não para
restringir a decisão.
**Detecção.** Peça um caso concreto em que o documento barrou algo. Se não houver, é teatro.
**Correção.** Reduzir drasticamente até sobrar só o que morde.

### AP-34 · Rastreabilidade Fantasma 🟡
**Sintoma.** Matriz completa que não corresponde ao código.
**Mecanismo.** Atualizada por obrigação, não por uso.
**Evidência.** `[CAMPO]` O próprio CLAUDE.md do InscreveAI sinaliza o problema em documentos irmãos:
*"`docs/AUDIT-BACKLOG.md` e o `PARECER` têm bandeiras de desatualização — o `tasks.md` de cada spec é a
fonte de verdade, não esses dois documentos"*. Reconhecer qual documento mente é bom; ter documentos
que mentem é o anti-padrão.
**Correção.** Rastreabilidade **verificada** (VER-02) ou nenhuma. Matriz não verificada é pior que
ausente, porque produz confiança falsa.

### AP-39 · Autoaperfeiçoamento sem Holdout 🔴
**Sintoma.** O agente edita seu prompt/harness a partir dos mesmos traces e testes usados para julgar
a mudança, depois declara que “aprendeu”.
**Mecanismo.** O proposer vê o alvo completo, otimiza a superfície avaliada e não há como distinguir
mecanismo reutilizável de overfit, specification gaming ou ruído favorável.
**Evidência.** `[EXPERIMENTAL]` Self-Harness (arXiv 2606.09498) evita isso fixando evaluator e usando
splits held-in/held-out; a promoção só aceita melhora sem regressão em ambos.
**Correção.** LRN-03: evaluator fixo, holdout invisível, variantes versionadas, rollback e promoção
humana para harness compartilhado. Sem esses controles, registrar hipótese; não autoeditar.

---

## Tabela de severidade

| ID | Anti-padrão | Disciplina | Severidade |
|---|---|---|---|
| AP-01 | Constituição Genérica | D1 | 🔴 |
| AP-02 | CLAUDE.md Enciclopédia | D2 | 🔴 |
| AP-03 | Marreta na Noz | D1 | 🔴 |
| AP-07 | Critério Vago | D1 | 🔴 |
| AP-10 | Contrato Emergente | D3 | 🔴 |
| AP-12 | Task sem Critério | D3 | 🔴 |
| AP-14 | **Namespace Colidido** | D1 | 🔴 |
| AP-15 | **Cópia Manual Multi-Harness** | D2 | 🔴 |
| AP-17 | Confiança sem Verificação | D4 | 🔴 |
| AP-18 | Delegação em Branco | D4 | 🔴 |
| AP-19 | Ambiguidade Silenciosa | D1 | 🔴 |
| AP-20 | Auto-validação | D5 | 🔴 |
| AP-22 | Propriedade Afrouxada | D5 | 🔴 |
| AP-23 | Teste Decorativo | D5 | 🔴 |
| AP-29 | Código de Fachada | D4 | 🔴 |
| AP-31 | Teste Desligado para Passar | D4 | 🔴 |
| AP-32 | Falsa Sensação de Controle | D5 | 🔴 |
| AP-33 | Teatro de Conformidade | D6 | 🔴 |
| AP-37 | Conclusão Prematura | D2 | 🔴 |
| AP-38 | **Loop sem Saída** | D4/D5 | 🔴 |
| AP-39 | **Autoaperfeiçoamento sem Holdout** | D6 | 🔴 |
| AP-04/05 | Sessão Entulhada / Exploração Infinita | D2 | 🟡 |
| AP-06 | Pseudocódigo em Prosa | D1 | 🟡 |
| AP-08 | Três Exemplos p/ Regra Universal | D1 | 🟡 |
| AP-09 | Interrogatório | D1 | 🟡 |
| AP-11/13/28 | Big Bang / Task Gigante / Dep. Implícita | D3 | 🟡 |
| AP-16 | Direto ao Código | D4 | 🟡 |
| AP-21 | Drift entre Camadas | D5 | 🟡 |
| AP-24 | Over-engineering por Revisão | D5 | 🟡 |
| AP-25 | Erro Recorrente | D6 | 🟡 |
| AP-26 | Estado Volátil na Constituição | D2 | 🟡 |
| AP-27 | Artefato Grande p/ o Próprio Protocolo | D2 | 🟡 |
| AP-30 | Truncamento Silencioso | D4 | 🟡 |
| AP-34 | Rastreabilidade Fantasma | D6 | 🟡 |
| AP-35/36 | Skill Negativa / Sedimento | D2 | 🟡 |

**Os quatro achados `[CAMPO]` inéditos** — AP-14, AP-15, AP-26, AP-27 — não aparecem em nenhuma fonte
oficial ou acadêmica deste corpus. São observações dos seus próprios repositórios, e por isso são a
parte mais acionável desta KB.

---

**Anterior:** [04 — Padrões](04-padroes.md) · **Próximo:** [06 — Heurísticas e invariantes](06-heuristicas-e-invariantes.md)
