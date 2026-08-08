# 04 — Catálogo de padrões

Formato GoF adaptado: **Contexto → Problema → Solução → Trade-offs → Padrões relacionados →
Anti-padrões que combate → Quando NÃO usar**. A última seção é a que separa catálogo de propaganda.

Índice por disciplina: **CTX** contexto · **INT** intenção · **PLN** planejamento ·
**EXE** execução · **VER** verificação · **LRN** aprendizado.

---

## CTX-01 · Camadas de Contexto

**Contexto.** Conhecimento de projeto que não cabe — nem deve caber — num arquivo só.
**Problema.** Arquivo único fica ou incompleto ou inchado; nos dois casos o agente ignora parte.
**Solução.** Hierarquia por especificidade: global (`~/.claude/CLAUDE.md`) → projeto (`./CLAUDE.md`)
→ módulo (`subdir/CLAUDE.md`, carregado **sob demanda** ao tocar aquele diretório) → sob demanda
(skill). Cada camada só contém o que é verdade naquele escopo.
**Trade-offs.** Descobribilidade × concisão. Fragmentar demais e ninguém sabe onde a regra mora.
**Relacionados.** CTX-02, CTX-03. **Combate.** AP-02 (CLAUDE.md Enciclopédia).
**Não usar quando.** Projeto de um módulo só — a hierarquia vira cerimônia.

## CTX-02 · Skill sob Demanda

**Contexto.** Conhecimento que vale às vezes: um domínio, um procedimento, uma convenção de área.
**Problema.** Se entra no CLAUDE.md, custa contexto em toda sessão inclusive quando é irrelevante.
**Solução.** `SKILL.md` com frontmatter (`name`, `description`). No boot só os metadados são
carregados; o corpo entra quando o agente julga relevante; `references/` só depois disso.
`disable-model-invocation: true` para fluxos com efeito colateral que devem ser disparados à mão.
**Trade-offs.** Custo zero quando não usada × acionamento **não garantido** (depende da `description`).
**Relacionados.** CTX-01, CTX-03. **Combate.** AP-02.
**Não usar quando.** A regra precisa valer **sempre** — aí é CLAUDE.md; ou precisa valer **sem
exceção** — aí é hook (EXE-02).

## CTX-03 · Delegação para Preservar Contexto

**Contexto.** Investigação que exige ler muitos arquivos.
**Problema.** A exploração consome a janela do orquestrador, degradando tudo o que vem depois.
**Solução.** Subagente em contexto próprio; volta só o resumo. *"use subagents to investigate X"*.
`[OFICIAL]` Contexto inicial do subagente: prompt próprio, hierarquia de CLAUDE.md e git status
(exceto Explore/Plan, que pulam os dois), sem ver histórico da conversa nem auto memory do principal —
para regra que precisa alcançá-lo mesmo assim, restate no prompt de delegação.
**Trade-offs.** Contexto preservado × o subagente não vê o que o principal viu (perda de coerência).
**Relacionados.** VER-01 (o mesmo mecanismo, outro fim). **Combate.** AP-05 (Exploração Infinita).
**Não usar quando.** Você já sabe qual arquivo ler — delegar uma leitura conhecida é puro overhead.
**Detalhe completo.** [sub-agents.md](sub-agents.md).

## CTX-04 · Orçamento de Contexto por Faixa

**Contexto.** Sessão longa com risco de estourar a janela no meio de trabalho crítico.
**Problema.** A degradação é gradual e silenciosa; quando se percebe, já custou.
**Solução.** `[CAMPO]` Faixas com ação obrigatória: 0–40% normal · 40–60% preferir subagente ·
60–80% **delegação obrigatória** · 80%+ compactar. Com custo estimado por operação.
**Trade-offs.** Disciplina × overhead de monitorar.
**Relacionados.** CTX-03. **Combate.** AP-04 (Sessão Entulhada).
**Não usar quando.** Tarefas curtas.

## CTX-05 · Fonte Única com Geração

**Contexto.** Vários harnesses de agente no mesmo repositório (`.claude/`, `.agents/`, `.opencode/`).
**Problema.** `[CAMPO]` Cópia manual diverge. Observado: *"as versões **não são idênticas**: ao editar
uma skill, propague para as três"* — instrução que garante divergência com o tempo.
**Solução.** Uma fonte canônica + script de instalação/geração para os demais destinos. A cópia é
artefato derivado e nunca é editada.
**Trade-offs.** Um passo de build × correção garantida.
**Relacionados.** LRN-02. **Combate.** AP-15 (Cópia Manual Multi-Harness).
**Não usar quando.** Um harness só.

## CTX-06 · Linguagem Ubíqua do Projeto

**Contexto.** Projeto com jargão próprio; o agente é jogado dentro dele e deduz os termos pelo caminho.
**Problema.** Sem palavra para o conceito, o agente usa vinte palavras onde cabe uma — e cada sessão
paga de novo. Pior: nomeia variáveis, funções e arquivos de forma inconsistente, tornando o codebase
menos navegável para ele mesmo na próxima vez.
**Solução.** `[INDÚSTRIA]` Um glossário de domínio versionado no repositório (`CONTEXT.md`), contendo
**só termos — zero detalhe de implementação**. Atualizado no instante em que um termo se resolve, nunca
em lote. Decisão que é difícil de reverter, surpreendente **e** fruto de trade-off real vira ADR; as
outras não. `[CONSOLIDADO]` Base em Evans: conversa e código derivam do mesmo modelo.
**Trade-offs.** Menos token e mais consistência × mais um arquivo para manter honesto.
**Relacionados.** CTX-01, INT-06. **Combate.** AP-02 (por redução do que precisa ser explicado).
**Não usar quando.** O domínio é genérico o bastante para não ter jargão — aí o glossário é cerimônia.
**Fronteira.** No instante em que o arquivo ganha "como fazemos X", virou AP-02. Glossário, não spec.
**Detalhe completo.** [mattpocock-skills.md](mattpocock-skills.md) §5.2.

## CTX-07 · Handoff Explícito entre Sessões

**Contexto.** Sessão que precisa terminar — contexto cheio, verificação que exige contexto limpo (I-09),
ou trabalho que continua amanhã.
**Problema.** H-02 e H-15 mandam trocar de sessão; nenhum diz **o que atravessa**. Sem artefato, ou se
perde o que foi decidido, ou se cola a conversa inteira — que reintroduz exatamente o que o `/clear`
tinha resolvido.
**Solução.** `[INDÚSTRIA]` Documento de passagem gravado **fora do workspace** (diretório temporário do
SO), que **referencia** spec, ADR, issue, commit e diff por caminho/URL em vez de duplicá-los, redige
segredo e PII, declara o que ficou pendente e traz uma seção de **skills sugeridas** para quem assume.
Escrito já sabendo para que a próxima sessão vai servir.
**Trade-offs.** Continuidade × o handoff é uma interpretação, e interpretação erra.
**Relacionados.** CTX-03, CTX-04, VER-01. **Combate.** AP-04 (Sessão Entulhada).
**Não usar quando.** A próxima sessão é sobre outra coisa — aí o handoff certo é nenhum.
**Detalhe completo.** [mattpocock-skills.md](mattpocock-skills.md) §5.6.

## CTX-08 · Orçamento por Tipo de Artefato

**Contexto.** Base de conhecimento consumida por agente, que carrega **arquivos inteiros**.
**Problema.** Sem limite por tipo, o arquivo cresce até misturar assuntos — e aí carregá-lo custa 70%
de contexto irrelevante para responder 30% da pergunta. O carregamento seletivo deixa de ser possível.
**Solução.** `[CAMPO]` Limite declarado **por tipo de artefato**, derivado da pergunta que ele responde:
consulta rápida ~100 linhas (é o arquivo de primeira carga; acima disso deixa de ser consulta e vira
leitura) · conceito ~150 (força **um conceito por arquivo**) · padrão ~200 (limite antes de virar
tutorial) · dado estruturado sem limite (é parseado, não raciocinado). O limite mora em **fonte única**
e é **repetido no cabeçalho** do índice onde alguém adicionaria o arquivo — governança no ponto de uso.
**Trade-offs.** Decomposição forçada × arquivo que legitimamente excede precisa de um tipo próprio
(`referência`, sem limite) em vez de exceção silenciosa.
**Relacionados.** CTX-02, CTX-04, CTX-09. **Combate.** AP-02 (CLAUDE.md Enciclopédia), AP-27.
**Distinção.** CTX-04 orça a **sessão**; CTX-08 orça o **artefato**. São ortogonais: sessão disciplinada
com arquivos monolíticos ainda satura.
**Não usar quando.** O acervo é lido só por humanos navegando — aí o custo do limite não se paga.
**Evidência.** `[CAMPO]` ~0 violações em 493 arquivos, com o limite repetido em cada índice de domínio.
**Detalhe completo.** [kbmain-corpus.md](kbmain-corpus.md) §2.2.

## CTX-09 · Par Contrastivo Errado/Certo

**Contexto.** Documentar um padrão que o modelo vai aplicar.
**Problema.** Um modelo treinado em código público conhece a forma certa **e** a errada com
probabilidade parecida. Exemplo positivo isolado não desfaz esse empate — ele reforça o que o modelo
já ia fazer, inclusive quando o que ia fazer é a forma errada.
**Solução.** `[CAMPO]` Toda seção de erro comum traz o par: o trecho **errado** e o **corrigido**, lado
a lado, na mesma linguagem. O negativo explícito codifica o espaço que o positivo não alcança, e
ancora a falha num **diff** em vez de em prosa — que é o formato que o modelo sabe aplicar.
**Trade-offs.** Dobra o volume de exemplo × é a única correção conhecida de viés de pré-treino.
**Relacionados.** CTX-08, LRN-01. **Combate.** AP-06 (Pseudocódigo em Prosa).
**Não usar quando.** Não existe forma errada plausível — aí o par é ruído.
**Evidência.** `[CAMPO]` Presente em 104 de 254 arquivos; é a convenção mais respeitada do acervo, e
os domínios que a abandonaram são visivelmente os mais fracos.
**Detalhe completo.** [kbmain-corpus.md](kbmain-corpus.md) §2.3.

---

## INT-01 · Constituição Executável

**Contexto.** Vários artefatos de intenção produzidos ao longo do tempo por pessoas e agentes.
**Problema.** Sem regra de precedência, cada conflito é renegociado por quem estiver mais perto.
**Solução.** Documento curto com autoridade declarada sobre os demais. Executor **para e reporta** ao
detectar conflito; nunca resolve.
**Trade-offs.** Estabilidade × capacidade de evoluir.
**Relacionados.** INT-02. **Combate.** AP-01 (Constituição Genérica).
**Teste de saúde.** Para cada artigo: *que decisão plausível e tentadora isto proíbe?* Sem resposta,
apague o artigo.
**Não usar quando.** Projeto curto, uma pessoa, escopo fechado.

## INT-02 · Especificação Hierárquica

**Contexto.** Agente capaz de escolher implementação, mas não autorizado a escolher comportamento.
**Problema.** Spec detalhada demais vira "programar em inglês"; vaga demais vira alucinação.
**Solução.** Nível 1 (intenção + contrato) rígido e inegociável; Nível 2 (algoritmo, tipos internos,
pastas) livre. O agente é avaliado pelo Nível 1.
**Trade-offs.** Aproveita a inteligência do modelo × a fronteira entre níveis é difícil de manter.
**Relacionados.** INT-05, PLN-01. **Combate.** AP-06 (Pseudocódigo em Prosa).
**Não usar quando.** O contrato só é conhecível depois de tentar.

## INT-03 · Requisito EARS

**Contexto.** Requisitos em prosa que admitem mais de uma leitura.
**Problema.** Ambiguidade sintática impede tanto o humano quanto a análise estática.
**Solução.** Classificar cada requisito num dos seis tipos e escrever na sintaxe correspondente. Isso
habilita detecção de conflito lógico **antes** de gerar código.
**Trade-offs.** Precisão × rigidez de redação.
**Relacionados.** INT-04, VER-03. **Combate.** AP-07 (Critério Vago).
**Não usar quando.** Discovery exploratório, antes de existir requisito.

## INT-04 · Derivação Propriedade ↔ Critério

**Contexto.** Spec com requisitos EARS classificados.
**Problema.** Nem todo requisito merece o mesmo tipo de verificação, e escolher por intuição
desperdiça esforço nos dois sentidos.
**Solução.** `[CAMPO]` Regra de derivação: **Ubiquitous** e **State-Driven** → candidatos naturais a
`PROP` (teste por propriedade). **Event-Driven** e **Unwanted** → critério de aceite Given/When/Then.
Se um Ubiquitous **não** virar PROP, registre o motivo na própria spec (depende de serviço externo,
não-determinístico, é sobre UI, espaço não gerável).
**Trade-offs.** Cobertura forte de invariante × custo de gerador.
**Relacionados.** VER-03. **Combate.** AP-08 (Três Exemplos para uma Regra Universal).
**Teste de bolso.** Se o requisito contém *sempre, nunca, qualquer, todo, independente de, em qualquer
ordem* — é propriedade, e provar com três exemplos é fingir.
**Não usar quando.** O requisito é sobre um caso específico.

## INT-05 · Calibração por Porte

**Contexto.** Mudanças de tamanhos radicalmente diferentes no mesmo repositório.
**Problema.** Um workflow único é marreta para uns e frouxo para outros — refutado independentemente
por Böckeler, pelo modo Lite do sdd-kit e pela SDD V5.
**Solução.** Três pesos. `[CAMPO]` Bug/hotfix (<1 dia) → **Lightweight** (contexto, RF em EARS,
critérios). Feature média (1–3 dias) → **Standard** (+ fluxos, regras, fora de escopo). Módulo novo
(>3 dias) → **Full** (todas as seções).
**Trade-offs.** Adequação × necessidade de julgar o porte antes de começar.
**Relacionados.** PLN-03. **Combate.** AP-03 (Marreta na Noz).
**Regra de ouro.** *"O peso do processo deve ser proporcional ao tamanho da mudança."*
**Não usar quando.** Nunca — este é o padrão de maior consenso de todo o corpus.

## INT-06 · Entrevista Antes da Spec

**Contexto.** Feature grande cuja intenção o próprio solicitante ainda não articulou.
**Problema.** Spec escrita a partir de um pedido de duas frases herda todas as lacunas do pedido.
**Solução.** `[OFICIAL]` O agente entrevista com `AskUserQuestion` — implementação, UI/UX, casos de
borda, preocupações e trade-offs, **evitando perguntas óbvias e cavando as partes difíceis** — até
cobrir tudo, e só então escreve a spec. Em seguida, **sessão nova** para executar.
**Trade-offs.** Qualidade da spec × tempo do humano no início.
**Relacionados.** INT-07, CTX-03.
**Não usar quando.** O escopo já está claro (aí é sledgehammer).

## INT-07 · Protocolo de Pergunta Inteligente

**Contexto.** Agente que precisa de informação faltante.
**Problema.** Os dois extremos falham: assumir em silêncio, e bombardear com perguntas triviais.
**Solução.** `[CAMPO]` Árvore de decisão antes de perguntar: *está no prompt do usuário?* → infira ·
*é prática padrão?* → use o default · *está no código?* → busque primeiro · **é específico do
negócio?** → só então pergunte. Com listas explícitas de *nunca perguntar* (nome de branch, estrutura
de pastas, framework de teste) e *sempre perguntar* (protótipo ou produção? critério de aceite de
negócio? SLA?).
**Trade-offs.** Menos atrito × risco de inferir errado.
**Relacionados.** INT-06. **Combate.** AP-09 (Interrogatório).
**Não usar quando.** Domínio onde inferir errado é caro — aí pergunte mesmo o inferível.

## INT-08 · Entrevista Conduzida por Árvore de Decisão (*grilling*)

**Contexto.** A entrevista já foi decidida (INT-06) e já se sabe o que perguntar (INT-07). Falta a
parte que os dois não cobrem: **como conduzi-la**.
**Problema.** Entrevista sem condução degenera nos dois sentidos. Perguntas em rajada sobrecarregam e
produzem respostas rasas (AP-09). Perguntas em ordem arbitrária fazem o humano decidir folhas antes da
raiz — e a resposta da raiz invalida tudo o que veio antes.
**Solução.** `[INDÚSTRIA]` Oito regras, e a força está em quantas são sobre **postura**, não conteúdo:

1. Entrevistar **implacavelmente** sobre cada aspecto até chegar a **entendimento compartilhado**.
2. Descer cada ramo da árvore de decisão, **resolvendo dependências entre decisões uma a uma** — a
   ordem é topológica, não a ordem em que as dúvidas ocorreram.
3. Toda pergunta vem com **a resposta recomendada** junto.
4. **Uma pergunta por vez**, esperando a resposta antes de seguir.
5. *"Perguntar várias coisas de uma vez é desnorteante."*
6. **Fato** que a ferramenta consegue descobrir no ambiente é **buscado, nunca perguntado**.
7. **Decisão é do humano**: cada uma é apresentada e a resposta é aguardada.
8. **Não agir** até o humano confirmar que o entendimento é compartilhado.

A separação **fato × decisão** (6 e 7) é o eixo: o agente carrega todo o custo de descobrir, o humano
carrega só o de escolher. Critério de término: confirmação explícita do humano — não é o agente que
declara a entrevista encerrada.
**Trade-offs.** Alinhamento antes de gastar execução × muitos turnos, e o humano precisa estar presente.
**Relacionados.** INT-06 (quando), INT-07 (o quê), H-17 (a cadência isolada), CTX-06.
**Combate.** AP-09 (Interrogatório) — pela regra 3, que é o que separa entrevista de questionário.
**Não usar quando.** O escopo cabe numa frase (H-01), o humano já entregou tudo escrito, ou não há
humano no laço — sem confirmação, a regra 8 não tem como ser satisfeita.
**Detalhe completo.** [mattpocock-skills.md](mattpocock-skills.md) §5.1.

---

## PLN-01 · Contrato Antes de Código

**Contexto.** Executor com liberdade de implementação.
**Problema.** Interfaces inventadas durante a execução divergem entre módulos e entre iterações.
**Solução.** Assinaturas, schemas, formatos de erro e eventos fixados no plan **antes** de qualquer
código. Executor que descobre o contrato inviável **para e reporta**.
**Trade-offs.** Estabilidade × descoberta tardia de inadequação.
**Relacionados.** INT-02, PLN-02. **Combate.** AP-10 (Contrato Emergente).
**Extensão.** Em sistemas distribuídos: OpenAPI/AsyncAPI gerados **antes** do backend, e daí SDKs,
mocks e testes de contrato automaticamente.

## PLN-02 · Decomposição por História, não por Camada

**Contexto.** Plano aprovado a ser decomposto em tasks.
**Problema.** Agrupar por camada ("todos os models, depois todos os controllers") impede entregar
qualquer coisa antes do fim.
**Solução.** `[INDÚSTRIA]` Fases: Setup → **Fundação (portão rígido)** → US1 (MVP) → US2 → …
→ Acabamento. Cada história é entregável e testável isoladamente. Só entra na Fundação o que bloqueia
*todas* as histórias.
**Trade-offs.** Entregabilidade incremental × alguma repetição entre histórias.
**Relacionados.** PLN-03, PLN-04. **Combate.** AP-11 (Big Bang de Camadas).

## PLN-03 · Task Verificável e Atômica

**Contexto.** Lista de tasks a executar por agente.
**Problema.** Task sem critério é "pronta" quando alguém decide que é.
**Solução.** Cada task declara: arquivos afetados · como verificar (comando ou checagem de uma linha)
· o que cobre (RF/SC) · dependências. `[CAMPO]` No formato JSON: `depends_on`, `acceptance_criteria`
(mín. 2), `files_affected`, `tests_required`, `phase`, `status`.
**Trade-offs.** Rastreabilidade × verbosidade.
**Relacionados.** VER-02, PLN-04. **Combate.** AP-12 (Task sem Critério), AP-13 (Task Gigante).
**Regra.** Task maior que 1–2 dias é quebrada. Prefira 12 tasks nítidas a 4 vagas.

## PLN-04 · Paralelismo por Disjunção de Arquivos

**Contexto.** Tasks que poderiam rodar ao mesmo tempo.
**Problema.** Paralelizar tasks que tocam o mesmo arquivo produz conflito silencioso.
**Solução.** Marcar `[P]` **apenas** quando os arquivos são disjuntos e não há dependência. Para
sessões humanas paralelas, worktrees isolam os checkouts. `[OFICIAL]` Quando o isolamento **não** está
disponível — agent teams não colocam os companheiros em worktree — a disjunção deixa de ser otimização
e vira pré-condição: particione por arquivo antes de distribuir.
**Trade-offs.** Velocidade × coordenação.
**Relacionados.** EXE-05, [worktrees.md](worktrees.md).

## PLN-05 · Módulo Profundo

**Contexto.** Decidir onde cortar um módulo, e como é a interface dele.
**Problema.** `[INDÚSTRIA]` O agente acelera a entropia que já existia: módulos rasos se multiplicam,
cada um com interface quase tão complexa quanto a implementação, e o custo passa a ser cobrado por
sessão em vez de por trimestre.
**Solução.** `[CONSOLIDADO]` Ousterhout — *"os melhores módulos são profundos: muita funcionalidade
acessível por uma interface simples"*. `[INDÚSTRIA]` Vocabulário operacional:

| Termo | Definição |
|---|---|
| **Módulo** | qualquer coisa com interface e implementação — agnóstico de escala |
| **Interface** | tudo o que o chamador precisa saber para usar corretamente: assinatura, invariantes, ordem, modos de erro, configuração exigida, desempenho |
| **Profundidade** | comportamento exercitável por unidade de interface aprendida — **propriedade da interface, não da implementação** |
| **Seam** | `[CONSOLIDADO]` (Feathers) lugar onde se altera comportamento sem editar naquele lugar |
| **Adaptador** | coisa concreta que satisfaz uma interface num seam — descreve **papel**, não substância |
| **Alavancagem / localidade** | capacidade por interface aprendida · concentração de mudança e bug num lugar só |

Três regras de decisão: **teste da deleção** (apague o módulo mentalmente — a complexidade some, ou só
se muda de lugar?) · **a interface é a superfície de teste**, porque chamadores e testes cruzam o mesmo
seam · **um adaptador é seam hipotético, dois adaptadores é seam real**.
**Trade-offs.** Design que sobrevive × tempo gasto antes de escrever a primeira linha.
**Relacionados.** PLN-01, VER-06. **Combate.** AP-24 (Over-engineering por Revisão), pela terceira regra.
**Não usar quando.** Protótipo descartável — em `experiments/` a forma não precisa pagar por si.
**Detalhe completo.** [mattpocock-skills.md](mattpocock-skills.md) §5.3.

## PLN-06 · Mapa de Decisões sob Névoa

**Contexto.** Trabalho grande, envolto em incerteza, que não cabe numa sessão — e do qual você ainda
não sabe nem o que especificar.
**Problema.** `/sdd-specify` pressupõe escopo conhecido. Aplicado à névoa, produz spec confiante e
errada; adiar produz paralisia.
**Solução.** `[INDÚSTRIA]` Um artefato-mapa com **Destino · Decisões até aqui · Ainda não especificado ·
Fora de escopo**, e tickets filhos que se bloqueiam. O mapa é **índice, não armazenamento**: cada
decisão vive em exatamente um lugar e o mapa aponta para ele. A **fronteira** são os filhos abertos,
desbloqueados e não reivindicados — é a borda do conhecido. Uma sessão resolve **um** ticket (pesquisa
em paralelo é a exceção), e reivindica antes de trabalhar. Termina quando a fronteira esvazia: não
sobra nada a decidir antes de alguém ir e fazer.
**Trade-offs.** Progresso sob incerteza × o mapa é mais um artefato a manter verdadeiro.
**Relacionados.** PLN-02, INT-05, CTX-03. **Combate.** AP-19 (Ambiguidade Silenciosa) em escala de projeto.
**Ordem.** Roda **antes** de `/sdd-specify`, não no lugar dele. Gatilho: *"não sei nem o que
especificar"* — contra o de `/sdd-specify`, que é *"sei o que quero, falta escrever"*.
**Não usar quando.** O escopo já cabe numa spec. Aí o mapa é `/sdd-tasks` com passos extras.
**Detalhe completo.** [mattpocock-skills.md](mattpocock-skills.md) §5.4.

## PLN-07 · Execução em Dupla Trilha (Dual-Track)

**Contexto.** Lista heterogênea de tarefas ou bugs resultantes de uma auditoria/varredura pré-produção.
**Problema.** Aplicar o mesmo peso de processo a tudo: forçar o ciclo pesado de spec (SDD) para correções triviais de 1 linha causa paralisia por burocracia; dispensar a spec para mudanças estruturais causa degradação de arquitetura.
**Solução.** `[CAMPO]` Triagem e separação formal em duas trilhas independentes:
- **Trilha A (Ajuste Simples)**: Fixes diretos sem alteração de contrato ou máquina de estados. Executados 1 a 1 via Plan Mode / direct fix sem criar arquivos de spec.
- **Trilha B (Clusters de Spec)**: Mudanças de domínio ou arquitetura agrupadas em clusters funcionais, executadas obrigatoriamente através do ciclo SDD (`specify` → `clarify` → `plan` → `tasks` → `implement`).
**Trade-offs.** Necessidade de triagem inicial rigorosa × velocidade máxima em one-liners com proteção arquitetural nos clusters críticos.
**Relacionados.** INT-05, PLN-02, EXE-01. **Combate.** AP-03 (Marreta na Noz), AP-11.
**Origem.** Protocolo de implementação pós-auditoria do `auto-slide`.

---

## EXE-01 · Explore → Plan → Implement → Commit

**Contexto.** Mudança cuja abordagem não é óbvia.
**Problema.** Ir direto ao código produz código que resolve o problema errado.
**Solução.** `[OFICIAL]` Quatro fases com plan mode separando exploração de execução; `Ctrl+G` abre o
plano no editor para o humano ajustar antes de aprovar.
**Trade-offs.** Qualidade × overhead real.
**Relacionados.** INT-05, EXE-04. **Combate.** AP-16 (Direto ao Código).
**Não usar quando.** *"Se você consegue descrever o diff em uma frase, pule o plano."*

## EXE-02 · Hook em vez de Instrução

**Contexto.** Regra que precisa valer sem exceção.
**Problema.** Instrução em CLAUDE.md é advisory: o agente pode ignorá-la, e ignora.
**Solução.** Script determinístico no evento correspondente. Stop hook bloqueia o fim do turno até a
checagem passar.
**Trade-offs.** Garantia × rigidez (e o Claude Code sobrepõe o Stop hook após 8 bloqueios seguidos).
**Relacionados.** EXE-03. **Combate.** AP-02.
**Regra de conversão.** *"Se o agente já faz certo sem a instrução, apague-a — ou converta-a em hook."*

## EXE-03 · Harness Engineering

**Contexto.** Agente escrevendo código em volume.
**Problema.** Revisão humana não escala com o volume gerado.
**Solução.** Envolver o agente num ambiente que reprova automaticamente: testes, lint, typecheck,
build, CI. `[CAMPO]` Nenhuma task fecha sem passar no harness relevante. Regra de arquitetura vira
**teste** (ex.: falha se o núcleo de domínio importar Spring, AWS ou Lombok).
**Trade-offs.** Cobre o mecânico × não cobre "é isto que o usuário queria".
**Relacionados.** EXE-02, VER-01. **Combate.** AP-17 (Confiança sem Verificação).

## EXE-04 · Envelope de Autonomia

**Contexto.** Delegação de tarefas com riscos heterogêneos.
**Problema.** Autonomia tratada como configuração global do sistema.
**Solução.** Três campos por tarefa: **decide sozinho** / **consulta antes** / **vedado**. Default por
classe de tarefa; declaração explícita só no desvio. `[CAMPO]` Operação destrutiva exige aprovação
humana **mesmo em modo auto-aprovar**, com o diálogo explicando o que será afetado.
**Trade-offs.** Segurança × burocracia.
**Relacionados.** EXE-05. **Combate.** AP-18 (Delegação em Branco).

## EXE-05 · Isolamento por Worktree

**Contexto.** Várias frentes de trabalho simultâneas **que escrevem nos mesmos arquivos**.
**Problema.** Edições concorrentes colidem e o histórico fica ilegível.
**Solução.** `[CAMPO]` Worktree dedicado por frente de trabalho (`RGIT-11`), em branch convencional nomeada pelo tipo e assunto (`<tipo>/<NNN>-<slug>` ou `<tipo>/<slug>`, ex.: `feat/001-autenticacao`), respeitando estritamente os tipos do `RGIT-02` (sem prefixos `spec/` ou `sdd/`), com **commit por task concluída** — nunca um commit único no fim. `[OFICIAL]` No Claude Code: `claude --worktree <nome>` cria em `.claude/worktrees/<nome>/`; `isolation: worktree` no frontmatter isola um subagente; `.worktreeinclude` carrega os gitignorados (`.env`) para dentro; um sweep periódico limpa worktrees finalizados (`RGIT-14`).
**Trade-offs.** Isolamento de **arquivo** × custo de setup do **ambiente** (deps, `.env`, portas,
banco) — e worktree não isola runtime: duas sessões na mesma porta continuam colidindo.
**Relacionados.** PLN-04, EXE-04, VER-01. **Detalhes completos.** [git-strategy.md](git-strategy.md) · [worktrees.md](worktrees.md).
**Não usar quando.** A tarefa só lê; nenhuma outra frente escreve ao mesmo tempo; os conjuntos de
arquivos já são disjuntos; ou o setup do ambiente custa mais que o conflito que se evita.

## EXE-06 · Registro de Interpretação

**Contexto.** Executor interpretativo preenchendo lacunas inevitáveis.
**Problema.** As interpretações somem dentro do resultado; a divergência só aparece na consequência.
**Solução.** Lista curta junto à entrega, com a lacuna e a escolha. Filtro: *"outro executor competente
poderia ter escolhido diferente?"*
**Trade-offs.** Visibilidade × ruído.
**Relacionados.** INT-04. **Combate.** AP-19 (Ambiguidade Silenciosa).

## EXE-07 · Disjuntor de Loop Agêntico

**Contexto.** Agente executando em laço autônomo — corrigir até passar, iterar até convergir.
**Problema.** Retry sem teto transforma falha em custo ilimitado. E há um modo pior, que o teto de
retry não pega: **o loop que não falha e mesmo assim não avança** — cada iteração termina com sucesso
aparente e o estado é o mesmo.
**Solução.** `[CAMPO]` Quatro tetos independentes, porque medem coisas diferentes: **iterações**
(loop infinito) · **retries** (task que falha) · **disjuntor de ausência de progresso** (N iterações
sem mudança de estado) · **custo/tempo**. Cada terminação escreve um **código de saída distinto por
causa** e um registro — falha vira artefato, não silêncio. Estado persistido permite retomada, o que
converte interrupção de sessão em classe de erro recuperável.
**Trade-offs.** Quatro parâmetros para calibrar × é a diferença entre degradação silenciosa e parada
ruidosa.
**Relacionados.** EXE-04, VER-07, CTX-07. **Combate.** AP-17 (Confiança sem Verificação), AP-30.
**Distinção.** `max_retries` conta **falhas**; o disjuntor conta **ausência de progresso**. Confundi-los
é o defeito mais comum — um laço pode consumir o orçamento inteiro sem nunca disparar o teto de retry.
**Não usar quando.** A execução é de passo único, sem laço.
**Detalhe completo.** [kbmain-corpus.md](kbmain-corpus.md) §2.4.

## EXE-08 · Investigação Somente-Leitura com Lock Concorrente em Markdown

**Contexto.** Diagnóstico de bugs ou varredura de código por múltiplos agentes autônomos em paralelo.
**Problema.** Agentes investigando tendem a aplicar "patches prematuros" no código de produção sem entender a causa raiz completa. Além disso, em ambientes multi-agente sem servidor de lock dedicado, múltiplos agentes tentam pegar o mesmo item ao mesmo tempo.
**Solução.** `[CAMPO]` Dois mecanismos combinados:
1. **Regra de Somente-Leitura (Read-Only Enforcement)**: Bloqueio estrito de escrita em código de produção (`src/`) durante a fase de investigação. O agente apenas lê, testa em bancada externa e emite relatório `.md`.
2. **Reivindicação Otimista em Markdown (Markdown Optimistic Locking)**: O agente gera um ID único temporário (`sess-XXXX`), registra seu estado em uma tabela markdown (`ESTADO-BUGS.md`), salva o arquivo e **re-lê o arquivo imediatamente**. Se o seu ID foi preservado, o item é dele; se foi sobrescrito por outro agente concorrente, ele desiste e pega o próximo item `pendente`.
**Trade-offs.** Um turno extra de leitura para validar a reivindicação × zero race-condition e zero degradação de código durante diagnósticos.
**Relacionados.** EXE-04, EXE-05, VER-01, VER-08. **Combate.** AP-45 (Patching Prematuro), AP-17.
**Origem.** Protocolo de investigação de auditoria do `auto-slide`.

---

## VER-01 · Verificador Independente (Writer/Critic)

**Contexto.** Entrega produzida por um executor.
**Problema.** Auto-verificação converge para confirmação: quem decidiu sabe racionalizar a falha.
**Solução.** Verificação em contexto separado (subagente ou sessão nova), com postura de refutar e
evidência citável. `[CAMPO]` Com veredito tipado — `APPROVED` / `CAN_PROCEED_WITH_WARNINGS` /
`CANNOT_PROCEED` — e proibição explícita de sobrepor um `CANNOT_PROCEED`.
**Trade-offs.** Rigor × custo, e risco de over-engineering (ver VER-05).
**Relacionados.** CTX-03, VER-05. **Combate.** AP-20 (Auto-validação).

## VER-02 · Análise Cruzada de Artefatos

**Contexto.** Constitution, spec, plan e tasks prontos, código ainda não escrito.
**Problema.** Incoerência entre artefatos vira defeito caro depois de implementada.
**Solução.** Auditoria **artefato contra artefato** antes do código: cobertura descendente (meta →
requisito → task), cobertura ascendente (**task órfã = escopo ampliado**), contradições, conformidade
com a constitution, vazamento de tecnologia para dentro da spec.
**Trade-offs.** Pega defeito na fase mais barata × mais um passo.
**Relacionados.** VER-01. **Combate.** AP-21 (Drift entre Camadas).

## VER-03 · Propriedade Quarentenada

**Contexto.** Propriedade que codifica invariante ainda não implementada.
**Problema.** As duas saídas naturais são ruins: apagar a propriedade, ou afrouxá-la até passar.
**Solução.** `[CAMPO]` Marcar como pendente (`@Tag("pbt-pending")` / `it.skip`) **com link para a task
que a torna verde**. O build padrão exclui as pendentes; um comando roda tudo.
**Trade-offs.** Honestidade × build "verde" que não cobre tudo.
**Relacionados.** INT-04. **Combate.** AP-22 (Propriedade Afrouxada).

## VER-04 · Falha Forçada

**Contexto.** Teste ou propriedade recém-escrita.
**Problema.** Teste mal escrito — gerador vazio, asserção tautológica, pré-condição que descarta tudo
— passa alegremente para sempre.
**Solução.** `[CAMPO]` Inverter deliberadamente uma comparação no código de produção, rodar, exibir o
contra-exemplo mínimo produzido pelo shrinking, e reverter. *"Uma propriedade que nunca foi vista
falhando não foi verificada."*
**Trade-offs.** Um passo a mais × é o **único** passo que prova que a verificação mede algo.
**Relacionados.** VER-03. **Combate.** AP-23 (Teste Decorativo).

## VER-05 · Achado Proporcional

**Contexto.** Revisão adversarial rodando.
**Problema.** `[OFICIAL]` *"Um revisor instruído a achar lacunas normalmente reporta alguma, mesmo
quando o trabalho está correto."* Perseguir tudo produz abstração extra, código defensivo e testes
para casos impossíveis.
**Solução.** Instruir o revisor a sinalizar **só** o que afeta correção ou requisito declarado; o
resto é opcional e marcado como tal.
**Trade-offs.** Evita over-engineering × pode deixar passar melhoria legítima.
**Relacionados.** VER-01. **Combate.** AP-24 (Over-engineering por Revisão).

## VER-06 · Loop de Feedback Antes da Hipótese

**Contexto.** Bug difícil, teste intermitente ou regressão de desempenho.
**Problema.** Sem sinal vermelho/verde confiável, o agente hipotetiza no escuro: cada tentativa muda
várias coisas, nada é falsificado e o log vira "logar tudo e grepar".
**Solução.** `[INDÚSTRIA]` Construir o loop **é** a habilidade; o resto é mecânico. Seis fases:

1. **Loop.** Do mais barato ao mais caro: teste no seam · curl contra o dev server · CLI com fixture
   diffada · browser headless · replay de trace · harness descartável · laço de propriedade/fuzz ·
   `git bisect run` · comparação entre versões · script conduzido por humano.
   Pronto quando: **capaz de ficar vermelho** no sintoma exato · **determinístico** · **segundos** ·
   **executável sem humano**.
2. **Minimizar** até que todo elemento restante seja portante — remover qualquer um torna verde.
3. **Hipotetizar** 3–5 hipóteses ranqueadas **antes** de testar, no formato falsificável *"se X é a
   causa, mudar Y faz sumir / mudar Z piora"*. O humano reordena de graça com conhecimento de domínio.
4. **Instrumentar** uma variável por vez, cada sonda mapeando para uma predição; log com tag única
   (`[DEBUG-a4f2]`) que sai depois num grep só.
5. **Corrigir** com o teste de regressão escrito **antes** do fix, e só num seam correto — sem seam, o
   achado é arquitetural e se registra em vez de forçar.
6. **Limpar** — repro não reproduz · teste passa (ou a ausência está documentada) · nenhuma tag sobrou ·
   a hipótese correta está na mensagem do commit. Fecha em *"o que teria evitado este bug?"*.

**Trade-offs.** Investir no loop antes de tocar no bug × parecer lento nos primeiros dez minutos.
**Relacionados.** VER-04, PLN-05, EXE-03. **Combate.** AP-17 (Confiança sem Verificação).
**Distinção.** VER-04 prova que a verificação mede algo; VER-06 é anterior — **constrói** a verificação
que VER-04 vai testar.
**Não usar quando.** A causa é óbvia e o fix cabe numa linha, com teste existente que já cobre.
**Detalhe completo.** [mattpocock-skills.md](mattpocock-skills.md) §5.5.

## VER-07 · Matriz de Acordo entre Fontes

**Contexto.** Agente prestes a agir sobre conhecimento que veio de mais de uma fonte — acervo interno
curado e consulta externa (documentação oficial, busca, exemplos de produção).
**Problema.** O agente afirma com confiança uniforme independentemente de a evidência ser corroborada,
única, ausente ou **contraditória**. O modo de falha mais caro não é errar — é resolver a contradição
em silêncio e apresentar uma das versões como fato.
**Solução.** `[CAMPO]` Cruzar as duas fontes numa matriz que produz um score-base, somar modificadores,
comparar a um limiar por categoria de tarefa, e **agir de forma diferente por faixa**:

| | Externa concorda | Externa discorda | Externa silente |
|---|---|---|---|
| **Acervo tem** | alto → executa | **conflito → escala** | médio → prossegue |
| **Acervo silente** | só-externa → prossegue | n/a | baixo → pergunta |

Três decisões carregam o padrão, e sem elas ele vira decoração:

1. **O teto de concordância não é o máximo.** Duas fontes concordantes ainda podem estar ambas
   obsoletas. Consequência deliberada: tarefa crítica **não passa só com concordância**.
2. **Conflito não é média nem recência** — cai abaixo de *todos* os limiares. Ver I-19.
3. **Os modificadores são propriedades verificáveis do artefato produzido** (tem permissão curinga?
   tem segredo em texto plano? tem rollback?), não da fonte ("é recente?"). O escore vira função da
   saída. Modificadores genéricos produzem agentes que herdaram a cerimônia sem a calibração.

Falha de ferramenta propaga como **penalidade de confiança**, não como evento neutro — o que pode
empurrar a tarefa abaixo do limiar e disparar a pergunta.
**Trade-offs.** Estrutura a atenção e torna o raciocínio auditável × **nada verifica que o cálculo foi
feito**; sem enforcement é teatro de processo. Por isso AD-04 vem antes: use este padrão só onde a
propriedade **não** é decidível.
**Relacionados.** VER-01, EXE-04, EXE-07, AD-04. **Combate.** AP-38 (Escore Inventado), AP-39
(Conflito Resolvido em Silêncio), AP-17.
**Não usar quando.** A propriedade é verificável por grep, código de saída ou validador — aí o escore
é ruído com aparência de rigor (H-19). E quando há uma só fonte: escore sobre fonte única é tautologia.
**Detalhe completo.** [kbmain-corpus.md](kbmain-corpus.md) §2.1.

## VER-08 · Auditoria e Investigação com Veredito Quadripartido

**Contexto.** Conclusão do relatório de investigação de um achado de auditoria.
**Problema.** Agentes tendem a dar pareceres vagos ("parece ser um bug", "talvez precise de ajustinho"), resultando em decisões de engenharia indecisas ou na criação de fakes sintéticos para contornar a falta de hardware/ambiente real de produção.
**Solução.** `[CAMPO]` Todo relatório de investigação fecha obrigatoriamente em **exatamente um** dos quatro vereditos formais:
1. `ajuste_simples`: Bug confirmado, correção direta e inequívoca (vai para Trilha A).
2. `merece_spec`: Bug confirmado, alteração estrutural/domínio (vai para Trilha B/SDD).
3. `sem_evidencia_refutado`: Falso positivo, erro de leitura ou já corrigido.
4. `sem_evidencia_precisa_producao`: Impossível confirmar sem hardware/ambiente de produção real. Proíbe simulações sintéticas enganosas e exige a especificação de um plano de telemetria/logging adicional.
**Trade-offs.** Honestidade rigorosa sobre limitações de bancada × exige disciplina do investigador.
**Relacionados.** VER-01, VER-07, EXE-08. **Combate.** AP-20 (Auto-validação), AP-38 (Escore Inventado).
**Origem.** Protocolo de auditoria pré-produção do `auto-slide`.

---

## LRN-01 · Lições Aprendidas Consumíveis

**Contexto.** Erros que se repetem entre execuções e entre features.
**Problema.** O conhecimento fica no PR e morre.
**Solução.** `[INDÚSTRIA]` Arquivo de lições que o agente **escreve e lê**: registre erro e correção;
antes de corrigir qualquer erro, consulte se já sabe como corrigi-lo. Laço fechado dentro da execução.
**Trade-offs.** Compostos ao longo do tempo × problema de Grudin (quem captura não colhe).
**Relacionados.** LRN-02. **Combate.** AP-25 (Erro Recorrente).

## LRN-02 · Promoção Falha → Padrão → Pergunta de Revisão

**Contexto.** Auditoria ou incidente que expôs uma classe de falha.
**Problema.** A correção pontual não impede a próxima ocorrência em outro lugar.
**Solução.** `[CAMPO]` — o padrão mais bem executado deste corpus. Cada falha real vira um padrão
numerado com evidência arquivada, e o conjunto de padrões vira uma **lista de perguntas de revisão**
reutilizável (18 perguntas cobrindo P_Novo4–P_Novo21). Falha → padrão → pergunta → prevenção.
**Trade-offs.** Alto valor composto × exige disciplina de registro no momento em que dói.
**Relacionados.** LRN-01, VER-01.
**Não usar quando.** A falha foi genuinamente única e não generalizável — registre como nota, não
como padrão.

---

## Índice cruzado

| Padrão | Disciplina | Princípio | Combate |
|---|---|---|---|
| CTX-01 Camadas | D2 | P06 | AP-02 |
| CTX-02 Skill sob demanda | D2 | P07 | AP-02 |
| CTX-03 Delegação | D2 | P05 | AP-05 |
| CTX-04 Orçamento | D2 | P05 | AP-04 |
| CTX-05 Fonte única | D2 | P06 | AP-15 |
| CTX-06 Linguagem ubíqua | D2 | P06 | AP-02 |
| CTX-07 Handoff | D2 | P05 | AP-04 |
| CTX-08 Orçamento por artefato | D2 | P05 | AP-02/27 |
| CTX-09 Par contrastivo | D2 | P06 | AP-06 |
| INT-01 Constituição | D1 | — | AP-01 |
| INT-02 Hierárquica | D1 | P02 | AP-06 |
| INT-03 EARS | D1 | P01 | AP-07 |
| INT-04 PROP↔AC | D1/D5 | P01 | AP-08 |
| INT-05 Calibração | D1 | P01/P03 | AP-03 |
| INT-06 Entrevista | D1 | P03 | — |
| INT-07 Pergunta inteligente | D1 | P04 | AP-09 |
| INT-08 Grilling | D1 | P03 | AP-09 |
| PLN-01 Contrato antes | D3 | P02 | AP-10 |
| PLN-02 Por história | D3 | P08 | AP-11 |
| PLN-03 Task verificável | D3 | P08 | AP-12/13 |
| PLN-04 Disjunção | D3 | P08 | — |
| PLN-05 Módulo profundo | D3 | P02 | AP-24 |
| PLN-06 Mapa sob névoa | D3 | P03 | AP-19 |
| PLN-07 Dupla trilha | D3 | P03/P08 | AP-03/11 |
| EXE-01 Explore→Plan | D4 | P01 | AP-16 |
| EXE-02 Hook | D4 | P11 | AP-02 |
| EXE-03 Harness | D4 | P11 | AP-17 |
| EXE-04 Envelope | D4 | P10 | AP-18 |
| EXE-05 Worktree | D4 | P10 | — |
| EXE-06 Interpretação | D4 | P04 | AP-19 |
| EXE-07 Disjuntor de loop | D4 | P10 | AP-17/30 |
| EXE-08 Investigação Read-Only + Lock MD | D4 | P10 | AP-45/17 |
| VER-01 Independente | D5 | P12 | AP-20 |
| VER-02 Cruzada | D5 | P09 | AP-21 |
| VER-03 Quarentena | D5 | P13 | AP-22 |
| VER-04 Falha forçada | D5 | P13 | AP-23 |
| VER-05 Proporcional | D5 | P13 | AP-24 |
| VER-06 Loop de feedback | D5 | P13 | AP-17 |
| VER-07 Matriz de acordo | D5 | P12 | AP-38/39 |
| VER-08 Veredito Quadripartido | D5 | P12 | AP-20/38 |
| LRN-01 Lições | D6 | P14 | AP-25 |
| LRN-02 Promoção | D6 | P14 | AP-25 |

---

**Anterior:** [03 — Princípios](03-principios.md) · **Próximo:** [05 — Anti-padrões](05-antipadroes.md)
