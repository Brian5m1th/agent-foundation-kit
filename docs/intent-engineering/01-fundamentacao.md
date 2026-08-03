# 01 — Fundamentação

## 1. O problema

Um humano quer algo. Entre esse querer e um sistema em produção existe uma cadeia de traduções:
querer → dizer → especificar → planejar → instruir → executar → verificar. Cada elo é uma tradução
entre representações incompatíveis, feita por um agente diferente, com informação parcial.

O problema não é novo. O que mudou é o **último elo**.

Na engenharia de software clássica, o executor final é um compilador: determinístico, literal, com
fidelidade de tradução essencialmente 1. Se o programa faz a coisa errada, a culpa está antes — na
especificação ou no código. O compilador nunca interpreta.

Com agentes baseados em modelos de linguagem, o executor **interpreta**. Ele preenche lacunas,
resolve ambiguidade por conta própria, generaliza a partir de exemplos, e faz isso sem sinalizar que
fez. A fidelidade da última tradução deixou de ser 1 e passou a ser uma variável — e uma variável que
depende de como a intenção foi representada.

> **Tese central deste corpus** `[HIPÓTESE]`
> Engenharia de Intenção é o que Requirements Engineering se torna quando o executor deixa de ser
> fiel e passa a ser interpretativo. As disciplinas clássicas resolveram *como especificar*; nenhuma
> delas precisou resolver *como especificar para um executor que também interpreta e que pode discordar
> em silêncio*.
>
> **Falsificação:** se for demonstrado que técnicas clássicas de RE (KAOS, i*, Design by Contract),
> aplicadas sem modificação, produzem a mesma fidelidade de execução em agentes LLM que em
> compiladores, a tese cai e a disciplina é apenas RE aplicada a um novo runtime.

### 1.1 O sintoma que dá nome ao problema

`[CONSOLIDADO]` **Gulf of Execution / Gulf of Evaluation** (Norman, *Cognitive Engineering*, 1986 —
HCI). O golfo de execução é a distância entre a intenção do usuário e as ações que o sistema aceita;
o golfo de avaliação é a distância entre o estado do sistema e a percepção do usuário sobre ele. Todo
sistema interativo paga os dois. A contribuição de Norman foi mostrar que essa distância é uma
propriedade de *design*, não de competência do usuário.

`[CONSOLIDADO]` **Specification gaming / reward hacking** (Krakovna et al., DeepMind, 2018–2020;
Amodei et al., *Concrete Problems in AI Safety*, 2016 — AI Safety). Um sistema otimizador satisfaz a
especificação literal sem produzir o resultado pretendido. O catálogo de exemplos da DeepMind
documenta dezenas de casos. A generalização importante: **a lacuna entre o que foi pedido e o que se
queria é explorável, e otimizadores mais capazes a exploram melhor.**

`[CONSOLIDADO]` **Lei de Goodhart** (Goodhart, 1975 — Economia; formalizada por Manheim & Garrabrant).
Quando uma medida vira alvo, deixa de ser boa medida. É a mesma estrutura: a proxy da intenção
substitui a intenção.

Três disciplinas independentes — HCI, AI Safety, Economia — descrevendo o mesmo fenômeno. Isso é
evidência de que o objeto existe. Ainda não é evidência de que existe uma disciplina para tratá-lo.

## 2. Definição proposta

> `[HIPÓTESE]` **Engenharia de Intenção** é a disciplina que trata da **representação, transmissão,
> preservação e verificação da intenção** ao longo de uma cadeia de executores com autonomia parcial,
> de modo que o resultado produzido seja atribuível à intenção original e as divergências sejam
> detectáveis antes de terem consequência.

Quatro verbos, quatro subproblemas, cada um com literatura própria:

| Verbo | Pergunta | Disciplina de origem |
|---|---|---|
| **Representar** | Em que forma a intenção sobrevive fora da cabeça de quem a tem? | Knowledge Representation, RE, Linguística |
| **Transmitir** | Como ela atravessa fronteiras entre agentes sem se degradar? | Teoria da Informação, Pragmática, CSCW |
| **Preservar** | Como ela sobrevive ao tempo, à mudança de contexto e à troca de executor? | Software Architecture, Design Rationale |
| **Verificar** | Como se prova que o resultado corresponde à intenção, e não a uma proxy dela? | V&V, Decision Theory, AI Safety |

### 2.1 Delimitação — o que a disciplina NÃO é

Delimitar é mais importante que definir, porque o risco desta disciplina é virar um guarda-chuva
vazio que renomeia coisas existentes.

- **Não é Prompt Engineering.** Prompt engineering otimiza a *formulação* de uma instrução para um
  modelo específico. É tática, acoplada ao modelo, e sua validade expira com a versão do modelo.
  Engenharia de Intenção trata do que precisa ser verdade **antes** de existir um prompt, e do que
  continua verdade depois que o modelo muda.
- **Não é Context Engineering.** `[INDÚSTRIA]` Context engineering — curar e manter a informação
  disponível ao agente durante a inferência (Anthropic, 2025) — é o **mecanismo de entrega**. A
  intenção é a **carga**. Confundir os dois é confundir protocolo com mensagem.
- **Não é Alignment.** `[CONSOLIDADO]` Alignment trata de alinhar o comportamento de um modelo a
  valores humanos em geral, no nível do treinamento e da política. Engenharia de Intenção opera no
  nível da tarefa, do projeto e da organização, com o modelo dado. As duas compartilham o conceito
  central — a lacuna entre pedido e querer — e divergem no lugar onde intervêm.
- **Não é Requirements Engineering clássica**, mas é sua herdeira mais direta. A diferença está na
  premissa de fidelidade do executor (§1) e na descoberta de que a intenção não é estável (§4.2).

## 3. Mapa do conhecimento existente

O que segue é o levantamento por disciplina. **Nada aqui é original**; é o que já existe e precisa
ser conhecido antes de propor qualquer coisa.

### 3.1 Requirements Engineering — a fundação mais próxima

`[CONSOLIDADO]` **Four Dark Corners of Requirements Engineering** (Jackson & Zave, ACM TOSEM, 1997).
A contribuição decisiva: separar o **mundo** (domínio, onde as coisas são) da **máquina** (sistema, o
que construímos), e distinguir enunciados no **modo indicativo** (o que é verdade sobre o mundo) do
modo **optativo** (o que se deseja que passe a ser verdade). Requisito é optativo; propriedade de
domínio é indicativo. Confundir os dois é a origem de uma classe inteira de erros.

*Por que surgiu:* a RE dos anos 1980 tratava "requisito" como categoria única e produzia
especificações que misturavam desejo, fato e restrição de implementação.
*Limitação:* assume que a fronteira mundo/máquina é conhecida e estável. Em sistemas agênticos, o
agente atravessa essa fronteira em tempo de execução.

`[CONSOLIDADO]` **KAOS / Goal-Oriented Requirements Engineering** (van Lamsweerde, *Goal-Oriented
Requirements Engineering: A Guided Tour*, RE'01; van Lamsweerde & Letier, *Handling Obstacles in
Goal-Oriented RE*, IEEE TSE, 2000). Metas de alto nível são refinadas por decomposição AND/OR até
chegarem a requisitos operacionais; cada folha é **atribuída como responsabilidade** a um agente
(humano ou sistema); **obstáculos** — condições que impedem a satisfação da meta — são gerados
sistematicamente e resolvidos. Há uma camada formal opcional em lógica temporal linear.

*Por que surgiu:* requisitos isolados não explicam a si mesmos. A meta responde ao "por quê" e permite
detectar conflito e incompletude.
*Limitação:* custo de elaboração alto; a camada formal raramente é usada fora de domínios críticos;
pressupõe que as metas são conhecidas no início.

`[CONSOLIDADO]` **i\* e NFR Framework** (Yu, U. Toronto, 1995–97; Chung, Nixon, Yu & Mylopoulos,
2000). Modelagem de atores, dependências entre atores, e **softgoals** — metas sem critério binário de
satisfação, que são *satisfeitas o suficiente* (satisficing, no sentido de Simon) em vez de
satisfeitas. Introduz o conceito de intenção **distribuída entre atores com interesses próprios**.

*Onde deixa de funcionar:* softgoals resistem à verificação automática — exatamente o que é preciso
quando o executor é um agente.

`[CONSOLIDADO]` **ISO/IEC/IEEE 29148** e o corpo de Systems Engineering (INCOSE): rastreabilidade
bidirecional, V&V, o modelo em V. Boehm (1984) fixou a distinção operacional: **verificação** é
construir o produto corretamente; **validação** é construir o produto certo. Engenharia de Intenção
vive quase toda na validação.

### 3.2 Filosofia da ação e arquiteturas cognitivas — o que "intenção" significa

`[CONSOLIDADO]` **Bratman, *Intention, Plans, and Practical Reason*** (1987 — Filosofia). Intenção
não é desejo forte: é um estado com **força de compromisso** que restringe deliberação futura,
resiste à reconsideração e serve de âncora para planos. Um agente que reconsidera tudo a cada passo
não tem intenção — tem preferências instantâneas.

*Implicação direta:* um artefato de intenção que é reescrito a cada iteração não é intenção. É registro
de preferência. A estabilidade é constitutiva.

`[CONSOLIDADO]` **BDI — Belief-Desire-Intention** (Rao & Georgeff, 1995 — Multi-Agent Systems).
Operacionalização de Bratman em arquitetura de agentes: crenças (estado do mundo), desejos (estados
preferidos), intenções (desejos aos quais o agente se comprometeu e está executando). Décadas de
sistemas construídos sobre isso.

*Limitação:* BDI pressupõe que as intenções são representadas explicitamente e simbolicamente. Agentes
LLM não têm um slot de intenção inspecionável — a intenção está implícita nos pesos e no contexto.
Essa é uma lacuna concreta, não uma objeção retórica (ver [07](07-agenda-de-pesquisa.md)).

`[CONSOLIDADO]` **Newell, *The Knowledge Level*** (Artificial Intelligence, 1982 — Cognitive
Architectures). Existe um nível de descrição de sistemas acima do simbólico, no qual o sistema é
caracterizado por seus **objetivos e conhecimento**, e seu comportamento é previsto pelo *princípio da
racionalidade* — o agente age para atingir seus objetivos dado o que sabe. Newell mostra que esse
nível tem poder preditivo real mesmo sem acesso à implementação.

*Relevância:* é a justificativa teórica mais sólida para descrever um agente LLM por metas e
conhecimento sem inspecionar seus pesos. Também é o nível em que a Engenharia de Intenção opera.

`[CONSOLIDADO]` **Dennett, *The Intentional Stance*** (1987 — Filosofia da Mente). Atribuir crenças e
desejos a um sistema é uma **estratégia preditiva**, não uma afirmação sobre sua natureza interna. Ela
se justifica pelo poder de previsão que oferece.

*Por que importa aqui:* dispensa o debate estéril sobre se um LLM "realmente" tem intenções. A pergunta
de engenharia é se a postura intencional prevê o comportamento melhor que as alternativas. Muitas vezes
prevê — e é isso que a licencia.

`[CONSOLIDADO]` **SOAR e ACT-R** (Laird/Newell/Rosenbloom; Anderson, CMU). Arquiteturas com pilha de
metas, subdivisão de metas e resolução de impasses. O mecanismo de *impasse* do SOAR — quando o agente
não consegue decidir, ele cria uma submeta explícita para resolver a indecisão — é um precedente
direto e pouco explorado para o tratamento de ambiguidade em agentes.

### 3.3 Linguística e pragmática — como intenção viaja em linguagem

`[CONSOLIDADO]` **Teoria dos Atos de Fala** (Austin, 1962; Searle, 1969 — Linguística). Dizer é agir.
Um enunciado tem conteúdo proposicional e **força ilocucionária**: a mesma frase pode ser ordem,
pedido, promessa, declaração. Diretivas (fazer o outro agir) e comissivas (comprometer-se) são as
duas classes que sustentam qualquer delegação.

*Implicação:* "implemente cache" e "considere implementar cache" têm o mesmo conteúdo e forças
diferentes. Nenhum formato de especificação corrente marca força ilocucionária explicitamente. Lacuna.

`[CONSOLIDADO]` **Máximas de Grice / Princípio Cooperativo** (Grice, *Logic and Conversation*, 1975).
Comunicação funciona porque o ouvinte assume cooperação e infere o que não foi dito (implicatura).
Quantidade, qualidade, relação, modo.

*Implicação central e desconfortável:* toda instrução depende de implicatura para ser econômica. Um
executor que não compartilha o mesmo pano de fundo infere errado. **A ambiguidade não é defeito de
redação; é a condição normal da linguagem eficiente.** Por isso a solução não pode ser "escrever
melhor" — tem de ser tornar a inferência inspecionável.

`[CONSOLIDADO]` **Winograd & Flores, *Understanding Computers and Cognition*** (1986 — HCI /
Linguística). A perspectiva linguagem-ação: o trabalho coordenado é uma rede de compromissos criados e
cumpridos em conversa. Deles vem a ideia de *conversation for action* — pedido, promessa,
cumprimento, aceitação — como estrutura mínima de delegação.

`[CONSOLIDADO]` **Clark, *Using Language*** (1996 — Psicolinguística). **Common ground**: o
conhecimento mútuo que interlocutores presumem partilhar, construído incrementalmente por *grounding*.
Sem common ground, a comunicação eficiente é impossível; com common ground falso, ela falha em
silêncio.

`[CONSOLIDADO]` **Klein, Woods, Bradshaw, Hoffman & Feltovich, *Ten Challenges for Making Automation
a Team Player*** (IEEE Intelligent Systems, 2004 — HCI / Cognitive Systems Engineering). Automação
que não mantém common ground, não sinaliza seu estado e não é **direcionável** falha como parceiro
mesmo quando é competente na tarefa. É provavelmente o texto mais subestimado para quem projeta
agentes hoje.

### 3.4 Engenharia de software — intenção como artefato

`[CONSOLIDADO]` **Naur, *Programming as Theory Building*** (1985). O programa não é o código: é a
**teoria** que os programadores têm na cabeça sobre por que o código é assim. Documentação é projeção
parcial dessa teoria e não a reconstitui. Quando a equipe se dispersa, a teoria morre, e o código
sobrevivente vira legado ininteligível mesmo estando documentado.

*Por que este é o texto mais importante desta seção:* é a **objeção mais forte** contra a própria
Engenharia de Intenção. Se a intenção é irredutivelmente tácita, capturá-la é impossível por
princípio. A disciplina precisa responder a Naur, não ignorá-lo (ver §4.4 e
[07](07-agenda-de-pesquisa.md)).

`[CONSOLIDADO]` **Design Rationale — gIBIS, QOC** (Conklin & Begeman, 1988; MacLean, Young, Bellotti &
Moran, *Questions, Options, Criteria*, HCI Journal, 1991). Registrar não a decisão, mas as
**questões, opções consideradas e critérios** que levaram a ela. Decisão sem alternativas rejeitadas
não é rastreável.
*Onde deixa de funcionar:* décadas de tentativa mostraram que a captura de rationale falha na prática
por assimetria de incentivo — quem paga o custo de capturar não é quem colhe o benefício (o *problema
de Grudin*, 1988, CSCW). Qualquer proposta de captura de intenção que ignore essa assimetria repetirá
o fracasso.

`[CONSOLIDADO]` **Design by Contract** (Meyer, IEEE Computer, 1992). Pré-condições, pós-condições e
invariantes tornam a intenção de uma unidade **verificável e localizada**. É o exemplo mais bem
sucedido de intenção formalizada que sobreviveu à indústria — porque o custo de escrever é baixo e o
benefício é imediato e local.

`[CONSOLIDADO]` **Especificação formal** — Z, Alloy (Jackson, MIT), TLA+ (Lamport). Lamport, *Who
Builds a House Without Drawing Blueprints?* (CACM, 2015): especificar força o pensamento que o código
permite adiar. `[EXPERIMENTAL]` Relatos industriais (notadamente da AWS, 2015) mostram TLA+ achando
defeitos de design que testes não achariam.
*Onde deixa de funcionar:* cobre propriedades estruturais e de concorrência; não cobre "isto é o que o
usuário queria".

`[CONSOLIDADO]` **ADRs — Architecture Decision Records** (Nygard, 2011) e **Quality Attribute
Scenarios / ATAM** (SEI, CMU). Decisão registrada com contexto, alternativas e consequências;
atributos de qualidade expressos como cenários mensuráveis em vez de adjetivos.

`[ACADÊMICO]` **Intentional Programming** (Simonyi, Microsoft Research, anos 1990; depois Intentional
Software). O programador captura a **intenção** do domínio em abstrações editáveis, e o código é
gerado a partir delas; especialistas de domínio descrevem o comportamento pretendido diretamente.
*Por que importa:* é a tentativa histórica mais literal de fazer "engenharia de intenção" em software.
*Por que falhou comercialmente:* exigia investimento enorme em toolbox por domínio, e a representação
intencional era editável apenas por ferramenta proprietária. **Lição:** representação de intenção que
exige ferramenta especial não sobrevive.

`[CONSOLIDADO]` **Brooks, *No Silver Bullet*** (1986). Complexidade essencial versus acidental. A
especificação da intenção é essencial; nenhuma ferramenta a elimina. Isso limita, por princípio, o
ganho máximo que qualquer disciplina de intenção pode prometer.

### 3.5 Redes e sistemas — intenção como categoria operacional

`[CONSOLIDADO]` **Intent-Based Networking** (RFC 9315, IRTF NMRG, outubro de 2022). Um documento
inteiro dedicado a definir o que é "intent" em sistemas operacionais de rede, precisamente porque o
termo era usado de forma inconsistente e confundido com "policy". A distinção central: **intent é
declarativo, independente de mecanismo, e o sistema é responsável por manter o estado desejado**,
inclusive re-derivando a configuração quando o ambiente muda.

*Por que isso é valioso:* é a prova de que uma comunidade de engenharia séria enfrentou exatamente o
problema de definir "intenção" como categoria técnica e produziu um vocabulário estável. Vale mais
como precedente metodológico do que pelo conteúdo específico de redes.

### 3.6 Teoria da decisão e economia — delegação

`[CONSOLIDADO]` **Teoria principal-agente** (Holmström, 1979; Jensen & Meckling) e **contratos
incompletos** (Hart & Moore, 1990 — Economia). É impossível escrever um contrato que cubra todas as
contingências; a incompletude é estrutural, não preguiça. Daí decorre a necessidade de *direitos
residuais de controle*: alguém precisa decidir o que fazer no caso não previsto.

*Transposição direta:* toda especificação é um contrato incompleto. A pergunta de engenharia não é
"como eliminar as lacunas" (impossível) mas **"quem decide nas lacunas, e como isso fica visível"**.

`[CONSOLIDADO]` **Simon — racionalidade limitada e satisficing** (*Sciences of the Artificial*, 1969).
Agentes reais não otimizam; buscam alternativa suficientemente boa dado um nível de aspiração. O
softgoal de Chung/Mylopoulos vem daqui.

`[CONSOLIDADO]` **Multi-Attribute Utility Theory** (Keeney & Raiffa, 1976) e elicitação de
preferências. Corpo maduro sobre extrair preferências de humanos que não as conhecem
introspectivamente — e sobre como o próprio processo de elicitação as constrói.

### 3.7 Automação e fator humano — o limite da delegação

`[CONSOLIDADO]` **Bainbridge, *Ironies of Automation*** (Automatica, 1983). Quanto mais a automação
assume, menos o humano pratica; quando a automação falha, o humano precisa intervir justamente na
situação mais difícil, e é aí que está menos preparado. A automação parcial cria um operador
degradado.

`[CONSOLIDADO]` **Níveis de automação** (Sheridan & Verplank, 1978; Parasuraman, Sheridan & Wickens,
IEEE SMC, 2000). A autonomia não é binária: há um espectro por função (aquisição de informação,
análise, decisão, execução), e o nível certo depende da função e do custo do erro.

*Consequência para agentes:* "nível de autonomia" deve ser declarado **por tarefa**, não por sistema.
Nenhum framework agêntico atual faz isso de forma explícita e auditável. Lacuna.

### 3.8 IA e agentes — o material recente

`[CONSOLIDADO]` **RLHF e alinhamento a intenção** (Christiano et al., 2017; Leike et al., 2018;
Ouyang et al., *InstructGPT*, 2022). O enquadramento explícito do InstructGPT é *seguir a intenção do
usuário* — incluindo a intenção implícita, não apenas a instrução literal. É a admissão, dentro do
mainstream de ML, de que instrução ≠ intenção.

`[CONSOLIDADO]` **Gabriel, *Artificial Intelligence, Values and Alignment*** (Minds and Machines,
2020 — DeepMind). Distingue seis alvos possíveis de alinhamento: **instruções, intenções expressas,
preferências reveladas, preferências informadas, interesse/bem-estar, valores**. Argumenta que a
escolha do alvo é uma questão normativa, não técnica, e que uma abordagem baseada em princípios tem
vantagens sobre cada alvo isolado.

*Este é o artigo mais importante para a taxonomia deste corpus* — ver [02](02-taxonomia-e-glossario.md).
Ele resolve, com rigor filosófico, a pergunta "intenção de quê, exatamente?" que a literatura de
engenharia costuma pular.

`[INDÚSTRIA]` **Constitutional AI** (Bai et al., Anthropic, 2022). Um conjunto explícito de princípios
escritos governa o comportamento do modelo, e o próprio modelo os aplica na crítica e revisão de suas
saídas. Precedente direto para "constituição" como artefato de intenção de nível superior, hierarquicamente
acima de instruções específicas.

`[RECENTE]` **DSPy** (Khattab, Singhvi et al., Stanford; arXiv 2310.03714, ICLR 2024). Pipelines de LM
como **módulos declarativos com assinaturas tipadas em linguagem natural**, compilados
automaticamente em prompts ou fine-tuning por um otimizador, dada uma métrica. O slogan — *programar,
não prompt-ar* — é preciso: a intenção é declarada uma vez, e a formulação para o modelo vira
artefato compilado e descartável.

*Por que é a peça técnica mais relevante:* demonstra empiricamente que a **separação entre declaração
de intenção e formulação de instrução é implementável e vantajosa**. É o suporte mais forte para o
princípio da Separação Intenção/Formulação ([03](03-arvore-de-principios.md)).
*Limitação:* exige métrica automatizável, o que só existe em tarefas com verificação barata.

`[EXPERIMENTAL]` **Shankar, Zamfirescu-Pereira, Hartmann, Parameswaran & Arora, *Who Validates the
Validators?*** (UIST 2024, Berkeley; arXiv 2404.12272). Estudo com usuários construindo avaliadores
para saídas de LLM. Achado central, chamado pelos autores de **criteria drift**: *usuários precisam de
critérios para julgar saídas, mas é julgando saídas que passam a definir seus critérios*. Alguns
critérios só se tornam formuláveis depois de observar saídas específicas — ou seja, **não são
independentes da observação e não podem ser definidos a priori**.

*Consequência devastadora para o modelo em cascata:* qualquer processo que exija a especificação
completa antes da execução assume uma independência que este estudo refuta empiricamente. O escopo é
específico (avaliação de saídas de LLM, N pequeno, contexto de laboratório) e não deve ser
sobre-generalizado — mas o mecanismo é plausível muito além do escopo medido.

`[EXPERIMENTAL]` **Zamfirescu-Pereira et al., *Why Johnny Can't Prompt*** (CHI 2023, Berkeley).
Não-especialistas projetando prompts generalizam demais a partir de exemplos isolados, atribuem ao
modelo um modelo mental social, e têm dificuldade em separar "o modelo não entendeu" de "eu não
especifiquei". Evidência empírica de que a lacuna de intenção é uma dificuldade cognitiva sistemática,
não falta de esforço.

`[INDÚSTRIA]` **Context engineering e arquitetura de agentes** (Anthropic, 2024–2025; padrões de
ReAct — Yao et al., 2022; AutoGen — Microsoft Research, 2023; MetaGPT; Generative Agents — Park et
al., Stanford, UIST 2023). Corpo grande, majoritariamente sem validação controlada. O achado
recorrente e verossímil é que a qualidade do agente depende mais da estrutura do contexto que da
capacidade bruta do modelo, e que contexto longo degrada atenção (*context rot*).

`[INDÚSTRIA]` **Spec-driven development com IA** (GitHub Spec Kit, AWS Kiro e similares, 2025).
Formalizam o fluxo constituição → spec → plano → tarefas → implementação. **Não há, até onde este
levantamento alcança, estudo controlado publicado comparando SDD assistido por IA contra prompting
direto em métricas de retrabalho, defeito ou tempo.** É consenso emergente de indústria, não evidência.

## 4. Conflitos entre escolas

Onde a literatura discorda. Um corpus que esconde o conflito é propaganda, não fundamentação.

### 4.1 Especificação antecipada versus intenção emergente

- **Escola formal/GORE** (van Lamsweerde, Jackson, Lamport): o custo do defeito cresce com a distância
  até sua introdução; portanto especifique antes. `[CONSOLIDADO]`
- **Escola ágil** (Beck, Cockburn): a especificação antecipada é desperdício porque o cliente não sabe
  o que quer até ver algo funcionando; o código e os testes são a especificação viva. `[INDÚSTRIA]`
- **Evidência que arbitra parcialmente:** o *criteria drift* (Shankar et al., 2024) `[EXPERIMENTAL]`
  dá razão empírica ao lado ágil sobre a **impossibilidade** de completude a priori — mas não sobre a
  inutilidade da especificação. Especificar continua valioso; **esperar que a especificação esteja
  completa antes de executar é que é falso.**
- **Síntese proposta** `[HIPÓTESE]`: a especificação não é um documento a ser completado antes da
  execução, é um **artefato de convergência** cuja taxa de mudança é o sinal de maturidade. Ver o
  padrão *Refinamento por Amostra* em [05](05-catalogo-de-padroes.md).

### 4.2 Alinhar a instruções versus alinhar a intenções

- **Literalismo:** execute o que foi pedido; interpretar é usurpar autoridade. Protege contra o agente
  impor sua leitura.
- **Interpretativismo:** execute o que foi querido; o literalismo produz specification gaming e o
  clássico "fiz exatamente o que você pediu". `[CONSOLIDADO]` (Krakovna; Ouyang et al.)
- **Gabriel (2020)** mostra que a escolha entre os dois **não é técnica, é normativa** — depende de
  quanta autoridade interpretativa se quer delegar, e essa é uma decisão de governança.
- **Consequência prática:** o nível de literalismo deve ser uma **decisão declarada por contexto**, não
  um default implícito do agente. É o que a ADR-005 em [06](06-decisoes-arquiteturais.md) trata.

### 4.3 Intenção como estado mental versus como compromisso social

- **Escola mentalista** (Bratman, BDI, cognitivismo): intenção é estado interno com força de
  compromisso.
- **Escola linguístico-social** (Winograd & Flores, Searle, CSCW): intenção só existe publicamente,
  como compromisso assumido em conversa entre partes.
- **Por que isto não é filosofia ociosa:** a escola mentalista leva a projetar *representações internas
  de meta* no agente; a escola social leva a projetar *protocolos de compromisso* entre agente e
  humano. São arquiteturas diferentes.
- **Posição deste corpus:** a postura de Dennett dissolve a disputa ontológica, e para engenharia a
  escola social é mais produtiva — porque compromisso público é **auditável** e estado mental não é.
  Isso é escolha metodológica declarada, não um resultado.

### 4.4 Captura de intenção versus intenção irredutivelmente tácita

- **Naur (1985)** `[CONSOLIDADO]`: a teoria do programa é tácita e não se transfere por documento.
- **Design rationale** `[CONSOLIDADO]`: partes substanciais são capturáveis, e o benefício aparece na
  manutenção.
- **Grudin (1988)** `[CONSOLIDADO]`: capturáveis sim, mas o custo recai sobre quem não colhe o
  benefício, e por isso a captura não acontece.
- **O que muda com LLMs** `[HIPÓTESE]`: a assimetria de Grudin depende de o custo de captura ser
  humano. Se o custo de redigir e manter o artefato de rationale cai por ordens de grandeza, a
  economia do problema muda — e a objeção de Grudin enfraquece sem que a de Naur seja tocada.
  **Falsificação:** medir se equipes assistidas por IA de fato mantêm rationale atualizado ao longo de
  meses. Se não mantiverem, o custo não era o gargalo — o incentivo era.

### 4.5 Autonomia alta versus controle

- **Agentic AI** `[INDÚSTRIA]`: mais autonomia, mais valor; o humano é gargalo.
- **Cognitive Systems Engineering** `[CONSOLIDADO]` (Bainbridge; Parasuraman et al.; Klein et al.): a
  autonomia mal calibrada produz operador degradado, perda de common ground e falha catastrófica na
  exceção.
- **Não há síntese fácil aqui**, e desconfie de quem oferecer uma. O que a literatura sustenta é a
  calibração por função e por custo do erro — não um nível global.

## 5. Lacunas identificadas

Onde a literatura existente não responde. Cada lacuna vira item da agenda em
[07](07-agenda-de-pesquisa.md).

| # | Lacuna | Por que a literatura atual não cobre |
|---|---|---|
| L1 | **Métrica de fidelidade de intenção.** Não existe medida aceita de quanto de uma intenção sobreviveu a uma tradução | RE mede completude e consistência do documento, não fidelidade da transmissão |
| L2 | **Intenção em executores interpretativos.** BDI pressupõe slot de intenção inspecionável; LLMs não têm | Toda a literatura de MAS assume representação simbólica explícita |
| L3 | **Autonomia declarada por tarefa e auditável.** Parasuraman dá o espectro conceitual; nenhum framework agêntico o instrumenta | O modelo é de 2000, anterior a agentes generativos |
| L4 | **Ambiguidade como cidadã de primeira classe.** Falta notação padrão para marcar, propagar e resolver ambiguidade em artefatos | Specs tratam ambiguidade como defeito a eliminar, não como estado a gerenciar |
| L5 | **Economia da captura de rationale sob custo marginal baixo.** O problema de Grudin foi formulado sob premissas de custo que mudaram | Literatura de CSCW é anterior à geração assistida |
| L6 | **Eficácia do SDD assistido por IA.** Nenhum estudo controlado publicado | Prática de indústria com ~1 ano de idade |
| L7 | **Força ilocucionária em artefatos técnicos.** Nenhum formato de spec distingue ordem, sugestão, restrição e default | Pragmática nunca foi aplicada a formatos de especificação |
| L8 | **Deriva de intenção ao longo do tempo.** Como detectar que a intenção registrada deixou de corresponder à intenção atual | Rastreabilidade clássica liga artefatos, não detecta obsolescência semântica |

---

**Próximo:** [02 — Taxonomia e glossário](02-taxonomia-e-glossario.md)
