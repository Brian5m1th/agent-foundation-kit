# Corpus KbMain — destilação

> **Selo dominante:** `[CAMPO]` · com trechos `[INDÚSTRIA]` e `[OFICIAL]` marcados no lugar.
> **Lido em:** 2026-08-04. 619 arquivos. Ver ADR-012 para a decisão de absorver em vez de importar.
> **O que é:** o acervo pessoal de um engenheiro de dados — 493 arquivos de KB, 58 agentes, um
> dossiê metodológico corporativo e um kit de verificação por propriedades — analisado por
> engenharia reversa conceitual.

Esta página existe porque o corpus é a **maior evidência `[CAMPO]` disponível de um sistema de
conhecimento agêntico operando em produção**, incluindo seus modos de apodrecimento. Diferente das
destilações oficiais, aqui há acesso ao que deu errado — e é isso que a torna citável.

---

## 1. O achado estrutural: cinco camadas epistêmicas empilhadas

Antes de extrair qualquer coisa, é preciso separar. O corpus **não é homogêneo**, e lê-lo como se
fosse produz conclusões erradas:

| Camada | Conteúdo | Como ler |
|---|---|---|
| **A** · Sistema pessoal em produção | 493 arquivos de KB + 58 agentes + mapa de infraestrutura | **Descritivo** — descreve o que alguém realmente faz |
| **B** · Dossiê de convencimento | 26 documentos de metodologia + 4 exports de wiki corporativo | **Retórico** — otimizado para persuadir um decisor, não para descrever |
| **C** · Kit metodológico autônomo | 8 arquivos de verificação por propriedades | **Prescritivo** e autocontido |
| **D** · Fonte externa | Relatório de indústria sobre desenvolvimento assistido por IA | Referência |
| **E** · Registro de conversa | Transcrição de entrevista técnica | Matéria-prima, parcialmente corrompida |

**A lição transferível é a separação em si.** Um acervo que mistura o descritivo com o retórico sem
marcar a fronteira faz o leitor tratar argumento de venda como fato de engenharia. É o mesmo problema
que os selos epistêmicos desta KB resolvem — e a confirmação `[CAMPO]` de que eles são necessários.

**A convergência que vale:** as camadas A, B e C chegam independentemente ao mesmo diagnóstico — *o
gargalo deixou de ser a capacidade do modelo e passou a ser a qualidade da restrição imposta a ele* —
por três caminhos distintos: especificação prévia (B), contexto curado com limiar (A), propriedade
verificável (C). Três abordagens independentes convergindo é o sinal mais forte do corpus.

---

## 2. O que foi extraído

Cinco padrões, quatro anti-padrões, duas heurísticas, um invariante, uma arquitetura, uma árvore de
decisão. Cada um com o identificador que recebeu nesta KB.

### 2.1 Matriz de acordo entre fontes → [VER-07](04-padroes.md#ver-07--matriz-de-acordo-entre-fontes)

O dispositivo anti-alucinação central do corpus, presente em ~45 dos 58 agentes de forma quase
idêntica. Cruza *acervo interno* × *validação externa* para produzir um score-base, ao qual se somam
modificadores, comparado a um limiar por categoria de tarefa.

Três decisões de engenharia embutidas nos números, e são elas que importam:

- **O teto de concordância não é 1,00.** Duas fontes concordantes ainda podem estar ambas obsoletas.
  A consequência é deliberada: tarefas críticas **nunca passam só com concordância** — exigem
  modificador positivo.
- **Conflito não é média nem recência.** Cai abaixo de *todos* os limiares, forçando escalonamento.
  Impede o modo de falha mais perigoso: resolver a contradição em silêncio e apresentar uma versão
  como fato. Virou **I-19** aqui.
- **Silêncio ≠ concordância**, e ignorância recebe o mesmo tratamento que contradição: pergunte.

**A evolução madura do padrão**, observada em ~18 agentes, é substituir os modificadores genéricos
("a informação é recente?") por **propriedades verificáveis do artefato produzido** ("tem permissão
curinga? tem segredo em texto plano? tem estratégia de rollback?"). O escore vira função da saída,
não da fonte. Agentes que copiaram os modificadores genéricos são efetivamente **não-calibrados** —
herdaram a cerimônia sem o conteúdo.

### 2.2 Orçamento por tipo de artefato → [CTX-08](04-padroes.md#ctx-08--orçamento-por-tipo-de-artefato)

Limites de tamanho declarados por tipo (~100 linhas para consulta rápida, ~150 para conceito, ~200
para padrão, sem limite para dado estruturado), com o racional explícito: **o arquivo é a unidade de
orçamento de contexto**, porque o agente carrega arquivos inteiros. Um conceito que não cabe em 150
linhas é dois conceitos.

O mecanismo que faz funcionar não é o limite — é **onde ele está escrito**: em fonte única *e*
repetido no cabeçalho do índice onde alguém adicionaria o arquivo. Governança no ponto de uso.
Evidência `[CAMPO]`: ~0 violações em 493 arquivos.

### 2.3 Par contrastivo Errado/Certo → [CTX-09](04-padroes.md#ctx-09--par-contrastivo-erradocerto)

O dispositivo de maior valor para consumo por modelo, e o mais barato de adotar. Racional:
**um modelo treinado em código público conhece o padrão certo e o errado com probabilidade similar.**
Exemplo positivo isolado não desfaz o empate — só o negativo explícito desfaz, e ancorando a falha
num diff em vez de em prosa.

Frequência `[CAMPO]`: presente em 104 de 254 arquivos analisados; é a convenção mais respeitada do
acervo, e os domínios que a abandonaram são visivelmente os mais fracos.

### 2.4 Disjuntor de loop agêntico → [EXE-07](04-padroes.md#exe-07--disjuntor-de-loop-agêntico)

A distinção que quase todo executor de loop erra: **`max_retries` conta falhas; o disjuntor conta
ausência de progresso.** Um loop pode não falhar e ainda não avançar. Somam-se teto de iterações,
teto de custo e teto de tempo, com **código de saída distinto por causa de terminação** — falha
vira artefato, não silêncio.

### 2.5 Topologias de orquestração → [AR-04](08-arquiteturas-e-pipelines.md)

Quatro topologias (supervisor · enxame · quadro-negro · esteira) com critério de escolha e escada de
maturidade de tolerância a falha em cinco níveis. A regra que sintetiza: **comece centralizado** —
topologia descentralizada exige maturidade que não se pula, e sua depuração é emergente, portanto
cara. Regra correlata e frequentemente violada: **o supervisor cuida só de roteamento, estado e
decisão — nunca de lógica de domínio**; violar cria o *agente-deus*.

### 2.6 Escore ou evidência? → [AD-04](09-decisao-estados-algoritmos.md)

A lição mais importante do corpus, e a que ele aprende **tarde**: onde a propriedade é decidível
(um grep, um código de saída, um validador), **troque o escore de confiança por evidência
reproduzível**. Escore é para quando não se pode testar. Um número inventado sobre um fato
verificável é pior que nenhum número.

O corpus prova isso por contraste interno: ~45 agentes dependem de preencher honestamente um
formulário de confiança que **nada verifica** — é teatro de processo com efeito real (estruturar
atenção) mas sem enforcement. Os quatro agentes de pipeline que substituíram o formulário por
relatório de grep reproduzível são, por larga margem, a parte mais madura do acervo.

Virou **H-19** aqui.

---

## 3. Anti-padrões observados

| ID | Nome | Evidência no corpus |
|---|---|---|
| [AP-38](05-antipadroes.md) | Escore Inventado 🔴 | Declarado como *warning sign* em ~20 agentes: *"seu escore de confiança foi inventado, não calculado"*. O próprio corpus reconhece a patologia e não a resolve |
| [AP-39](05-antipadroes.md) | Conflito Resolvido em Silêncio 🔴 | O caso que a matriz de acordo existe para prevenir; o template de resposta **avalia mas não decide**, apresentando as duas posições e três opções |
| [AP-40](05-antipadroes.md) | Cerimônia Herdada 🟡 | Seções de template preenchidas com placeholder idêntico em ~40 arquivos — changelog vazio, pontos de extensão genéricos |
| [AP-41](05-antipadroes.md) | Registro sem Portão 🟡 | Sete domínios existem em disco e não constam no registro machine-readable — **incluindo o mais valioso do acervo**. Para um agente que descobre capacidade pelo registro, eles não existem |

---

## 4. Padrões confirmados, não importados

O corpus **confirma com evidência de campo** itens que esta KB já tinha por outra fonte. Registro aqui
porque confirmação independente muda o selo, não o conteúdo:

| Item desta KB | O que o corpus confirma |
|---|---|
| INT-03 (EARS) | Presente em 50 arquivos — o conceito com maior penetração no corpus |
| VER-03 (Propriedade Quarentenada) | Política completa com marcação, identificador de tarefa obrigatório, configuração de build e critério de degeneração (*"sem o identificador, vira cemitério"*) |
| VER-04 (Falha Forçada) | Elevado a passo **não-opcional** do Dia 1 de adoção e da segunda rodada do prompt de auditoria |
| EXE-03 (Harness) | O termo aparece com o mesmo sentido em 12 arquivos |
| CTX-02 (Skill sob Demanda) | Revelação progressiva com metadados na inicialização e corpo sob demanda |
| AR-02 (Builder/Critic) | Descrito como *"compilador operando no nível da semântica e da lógica de negócio"* |
| P05 / AP-04 | Contexto tratado explicitamente como orçamento, com faixas e delegação |

---

## 5. O que foi lido e **recusado**

Sem esta seção a destilação vira propaganda.

| Recusado | Por quê |
|---|---|
| **A frota de 58 agentes** | `.claude/` aqui é upstream de quatro projetos reais; importar a frota impõe a todos um conjunto que ninguém pediu — o argumento de ADR-011, agora com 58 itens em vez de 21. Além disso, ~12 são vendor-locked e 6 são inseparáveis de um produto educacional de terceiro |
| **Modificadores de confiança genéricos** | Produzem agentes não-calibrados. Só a variante "propriedades verificáveis do artefato" entrou (§2.1) |
| **Seções cerimoniais do template de agente** | Changelog de uma linha, pontos de extensão genéricos, motes. Falham o teste de inclusão *"remover isto faria o agente errar?"* — viraram AP-40 em vez de padrão |
| **A tese de "código descartável / especificação como fonte única"** | A fonte mais criteriosa do próprio corpus a problematiza: risco de herdar a inflexibilidade do paradigma anterior **e** o não-determinismo do modelo. Visão, não plano |
| **Todos os números** (preços, janelas, versões, SKUs) | Já obsoletos como fato. Entrou o método — orçar, cachear prefixo repetido, escalonar modelo por complexidade, medir antes de dimensionar |
| **Padrões vendor-específicos** | Sintaxe de infraestrutura declarativa, formatos de API, propriedades de formato de tabela, plataforma analítica proprietária. Reutilizáveis por quem usa a mesma plataforma; não são conhecimento de engenharia |
| **O enquadramento retórico do dossiê** | Decisor nomeado por cargo, posicionamento de uma ferramenta contra outra, regras de tom internas. É estratégia organizacional, não metodologia |
| **Todo o conteúdo dos quatro exports de wiki corporativo** | Documentação interna restrita — ver §7 |

---

## 6. As duas tensões que o corpus **não** resolve

Registro porque ambas são armadilhas para quem adotar o material de boa-fé.

**A especificação aprovada é congelada ou viva?** As fontes afirmam as duas coisas, em documentos
diferentes, sem reconhecer o conflito: *entrada imutável da fase seguinte* versus *mantida atualizada
como parte da definição de pronto*. É a lacuna conceitual mais séria encontrada. Esta KB resolve por
ME-01 (ciclo de vida da spec), que declara os estados explicitamente — mas a resolução é **nossa**,
não do corpus.

**Revisar código gerado, ou medir métricas agregadas?** A posição *"não reviso código de agente; meço
cobertura, estrutura de dependências, complexidade ciclomática, mutation testing"* colide frontalmente
com a regra de accountability *"engenheiros são donos de cada mudança; nunca faça merge do que não
entende"*. O corpus resolve **retoricamente** ("métricas complementam, não substituem"), não
epistemicamente. Esta KB fica com a segunda posição via I-07 e AP-32, e trata a primeira como
`[RECENTE]` em disputa.

---

## 7. Manuseio de material sensível

O corpus contém material que **não foi e não deve ser incorporado como conhecimento**. Registro a
categoria e a razão, sem reproduzir valor algum — o inventário completo com recomendações de
remediação vive fora desta KB, no relatório de análise que acompanhou a leitura.

| Categoria | Por que não entra |
|---|---|
| Identidade e topologia de um cliente real, com esquema de dados sensíveis | Dois padrões de engenharia de dados nomeiam o cliente e expõem buckets, catálogos, principal de serviço e **nomes de campo de PII financeira**. Em conjunto revelam quem é, o setor e o layout dos feeds |
| Endpoint de automação vivo com identificadores acionáveis | Hostname publicamente resolvível + identificadores de workflow e credencial + inventário nominal de integrações |
| Quatro exports de wiki corporativo restrito | Política, diretrizes e runbook internos. Um deles contém portal de autenticação com identificador de diretório e caminhos de repositório privado |
| Regras comerciais proprietárias | Scorecard de qualificação com pesos, faixas de segmentação, cadência de retomada, metas de conversão |
| Dado pessoal em documentação | Um documento de identificação nacional preenchido num payload de exemplo; um número de telefone real como valor padrão de argumento |

**A lição de engenharia, essa sim transferível:** a disciplina de *"nunca commitar valores"* foi
seguida à letra — nenhuma credencial viva foi encontrada em 619 arquivos. Mas **a fronteira entre
"valor" e "identificador" foi traçada num ponto mais permissivo do que a intenção da regra
suportava**, e a exposição real está toda aí: nomes de credencial, identificadores de instância,
identificadores de projeto, hostnames. O próprio corpus declara como anti-padrão *"nunca hardcode
valores de credencial no markdown do agente"* — e os **nomes e identificadores** migraram em massa
para o markdown do agente.

É exatamente o tipo de deriva que uma regra bem-intencionada não pega, e reforça I-12/I-13: a regra
precisa nomear o que conta como segredo, não só proibir "segredos".

---

## 8. Itens citáveis desta destilação

| Tipo | ID | Nome |
|---|---|---|
| Padrão | CTX-08 | Orçamento por Tipo de Artefato |
| Padrão | CTX-09 | Par Contrastivo Errado/Certo |
| Padrão | EXE-07 | Disjuntor de Loop Agêntico |
| Padrão | VER-07 | Matriz de Acordo entre Fontes |
| Arquitetura | AR-04 | Topologias de orquestração multi-agente |
| Árvore de decisão | AD-04 | Escore de confiança ou evidência reproduzível? |
| Anti-padrão | AP-38 | Escore Inventado 🔴 |
| Anti-padrão | AP-39 | Conflito Resolvido em Silêncio 🔴 |
| Anti-padrão | AP-40 | Cerimônia Herdada 🟡 |
| Anti-padrão | AP-41 | Registro sem Portão 🟡 |
| Heurística | H-19 | Onde a propriedade é decidível, troque escore por evidência |
| Heurística | H-20 | Se o artefato a revisar ficou maior que o diff, o processo está errado |
| Invariante | I-19 | Conflito entre fontes é escalado, nunca resolvido pelo agente |

---

## 9. Condição de envelhecimento

Esta destilação **não se atualiza sozinha**. Envelhece a partir de 2026-08-04. O corpus de origem é
um sistema vivo em evolução; releitura datada é necessária antes de tratar qualquer afirmação
`[CAMPO]` aqui como corrente.

Dois itens têm prazo mais curto que o resto: a §2.1 (a calibração dos limiares depende de quais
modelos e ferramentas estão em uso) e a §7 (o inventário sensível reflete o estado do corpus na data
da leitura, e a remediação pode já ter ocorrido).

---

**Ver também:** [ADR-012](11-adrs.md) · [04 — Padrões](04-padroes.md) ·
[05 — Anti-padrões](05-antipadroes.md) · [08 — Arquiteturas](08-arquiteturas-e-pipelines.md) ·
[13 — Bibliografia](13-bibliografia.md)
