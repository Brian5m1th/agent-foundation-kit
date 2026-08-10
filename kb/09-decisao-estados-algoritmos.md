# 09 — Árvores de decisão, máquinas de estado e algoritmos conceituais

Procedimentos. Diferente de princípio (por quê) e de padrão (como): aqui é **o que fazer, agora,
neste ponto**.

---

# Parte I — Árvores de decisão

## AD-01 · Do pedido do usuário à ação

Refinamento da árvore que você esboçou, com dois acréscimos: **calibração por porte** e **custo de
reversão** — sem eles a árvore trata typo e módulo novo do mesmo jeito.

```mermaid
graph TD
    A[Usuario pediu algo] --> A1{E defeito dificil,<br/>flaky ou regressao?}
    A1 -->|sim| A2[Construir o loop<br/>vermelho-verde VER-06] --> B
    A1 -->|nao| B{Cabe em um diff<br/>de uma frase?}
    B -->|sim| C[Executar direto] --> V[Verificar e mostrar saida]
    B -->|nao| D{Existe contexto<br/>suficiente?}
    D -->|nao| E{Esta no prompt?}
    E -->|sim| F[Inferir]
    E -->|nao| G{E pratica padrao<br/>da stack?}
    G -->|sim| H[Usar default]
    G -->|nao| I{Esta no codigo<br/>ou na memoria?}
    I -->|sim| J[Buscar - subagente se for amplo]
    I -->|nao| K{E especifico<br/>do negocio?}
    K -->|nao| L[Assumir e registrar suposicao]
    K -->|sim| M{Reverter e caro?}
    M -->|nao| L
    M -->|sim| N[PERGUNTAR ao humano]
    F --> D
    H --> D
    J --> D
    L --> D
    N --> D
    D -->|sim| O{Ha ambiguidade<br/>bloqueante aberta?}
    O -->|sim| N
    O -->|nao| P{Toca varios arquivos<br/>ou abordagem incerta?}
    P -->|nao| C
    P -->|sim| P1{Sei o que<br/>especificar?}
    P1 -->|nao| P2[Mapa de decisoes<br/>sob nevoa PLN-06] --> P1
    P1 -->|sim| Q[Explorar em plan mode]
    Q --> R[Planejar + fixar contratos]
    R --> S{Humano aprovou?}
    S -->|nao| R
    S -->|sim| T[Decompor em tasks verificaveis]
    T --> U[Executar dentro do envelope]
    U --> V
    V --> W{Passou?}
    W -->|nao| X{Ja corrigi<br/>2 vezes?}
    X -->|sim| Y[Limpar contexto e<br/>reescrever o prompt]
    X -->|nao| U
    W -->|sim| Z{Custo do erro<br/>e alto?}
    Z -->|sim| AA[Auditoria em contexto separado]
    Z -->|nao| AB[Entregar com evidencia]
    AA --> AB
    AB --> AC[Registrar licao se houve surpresa]
```

**Os seis nós que mais mudam o resultado:**
- `É defeito difícil?` — sem o loop determinístico primeiro, todo o resto da árvore roda no escuro (H-18).
- `Sei o que especificar?` — o nó que impede spec confiante e errada sobre escopo nebuloso.
- `Cabe em um diff de uma frase?` — evita AP-03 e AP-16 de uma vez.
- `Reverter é caro?` — é o que separa bloquear de assumir. Sem ele: AP-09 ou AP-19.
- `Já corrigi 2 vezes?` — o laço `X→U` sem esse corte é o modo de falha mais comum em sessão longa.
- `Custo do erro é alto?` — auditoria independente não é grátis; aplicá-la sempre produz AP-24.

## AD-02 · Onde este conhecimento deve morar

```mermaid
graph TD
    A[Tenho um conhecimento<br/>para registrar] --> B{Muda com<br/>frequencia?}
    B -->|sim| C[STATUS.md ou tasks.md<br/>NUNCA na constituicao]
    B -->|nao| D{Vale em<br/>toda sessao?}
    D -->|nao| E{Vale so num<br/>diretorio?}
    E -->|sim| F[subdir/CLAUDE.md<br/>carregado sob demanda]
    E -->|nao| G[Skill]
    D -->|sim| H{Precisa valer<br/>SEM excecao?}
    H -->|sim| I[Hook ou CI<br/>markdown e advisory]
    H -->|nao| J{E portavel entre<br/>agentes?}
    J -->|sim| K[AGENTS.md]
    J -->|nao| L[CLAUDE.md]
    L --> M{Remover a linha<br/>faria o agente errar?}
    K --> M
    M -->|nao| N[Nao escreva]
    M -->|sim| O[Escreva - uma linha]
```

## AD-03 · Que tipo de verificação usar

```mermaid
graph TD
    A[Requisito a verificar] --> B{Contem sempre/nunca/<br/>qualquer/independente de?}
    B -->|sim| C{O espaco de entrada<br/>e geravel?}
    C -->|sim| D[Teste de propriedade + shrinking]
    C -->|nao| E[Registrar o motivo na spec<br/>e usar exemplos + revisao]
    B -->|nao| F{E comportamento<br/>observavel de fora?}
    F -->|sim| G[Criterio de aceite Given/When/Then]
    F -->|nao| H{E regra estrutural?}
    H -->|sim| I[Teste de arquitetura<br/>ex.: dominio nao importa framework]
    H -->|nao| J{E softgoal<br/>elegancia confianca?}
    J -->|sim| K[Declarar julgamento humano<br/>NAO inventar proxy numerica]
    J -->|nao| L[Teste unitario por exemplo]
    D --> M[Forcar a falha de proposito<br/>e mostrar o contra-exemplo]
    M --> N{Falhou?}
    N -->|nao| O[A verificacao e decorativa<br/>refazer]
    N -->|sim| P[Reverter e seguir]
```

O nó `K` é o mais desobedecido: sob pressão de "precisamos de uma métrica", inventa-se uma proxy — e
daí nasce AP-05 do corpus de intenção (proxy capturada, Goodhart).

## AD-04 · Escore de confiança ou evidência reproduzível?

`[CAMPO]` Aplica-se **antes** de VER-07, e é a pergunta que o corpus de origem só aprendeu a fazer
tarde. Ver [kbmain-corpus.md](kbmain-corpus.md) §2.6.

```mermaid
graph TD
    A[Agente prestes a afirmar algo] --> B{A afirmacao e<br/>decidivel por maquina?}
    B -->|sim| C[Rode a verificacao<br/>grep, exit code, validador, compilador]
    C --> D[Reporte o COMANDO e a SAIDA<br/>nao um numero]
    B -->|nao| E{Existe mais<br/>de uma fonte?}
    E -->|nao| F[Escore sobre fonte unica<br/>e tautologia — declare a fonte<br/>e a limitacao]
    E -->|sim| G{As fontes<br/>concordam?}
    G -->|discordam| H[ESCALAR — I-19<br/>apresentar as duas posicoes]
    G -->|concordam ou silente| I[VER-07 · matriz + modificadores<br/>preenchidos ANTES da conclusao]
    I --> J{Escore >= limiar<br/>da categoria?}
    J -->|sim| K[Executar + citar fontes]
    J -->|nao| L{Tarefa critica?}
    L -->|sim| M[Recusar e explicar]
    L -->|nao| N[Perguntar ou executar<br/>com ressalva estrutural]
```

**O nó `B` é o que muda tudo, e é pulado por default.** Escore existe para quando não se pode testar;
onde há predicado, o número não acrescenta informação e **subtrai**, porque tem aparência de rigor sem
o ser — é AP-38. A regra de bolso é H-19.

**O nó `D` merece ênfase:** o formato da evidência importa. "Verifiquei e está correto" não é evidência;
o comando executado mais sua saída é — porque é **reproduzível por quem lê**, que é a única propriedade
que distingue verificação de afirmação.

**O nó `N` não é "executar com um aviso no fim".** A ressalva precisa ser **estrutural**: aviso textual
anexado a uma resposta confiante não funciona, porque o leitor ancora na resposta e desconta o aviso.
Abaixo do limiar, a resposta sai da posição de resposta e vira inventário do que se sabe, do que não se
sabe, e uma pergunta.

## AD-05 · Árvore de decisão Git e Worktree

`[CONSOLIDADO]` Aplica-se a todo pedido de alteração para determinar o fluxo de isolamento, branching e commits.

```mermaid
graph TD
    A[Demanda de Alteracao] --> B{Envolve alteracao<br/>de codigo/docs?}
    B -->|nao - so leitura/busca| C[Usar Subagente/Sessao Atual<br/>Sem Worktree]
    B -->|sim| D{Ja existe Worktree<br/>para esta Frente?}
    D -->|sim| E[Reusar Worktree Existente<br/>na Branch feat/slug]
    D -->|nao| F[Criar Worktree + Branch Convencional<br/>claude --worktree tipo/slug]
    F --> G[Executar Mudancas & Commits<br/>por Task RGIT-03]
    E --> G
    G --> H{Frente Concluida &<br/>Verificada /sdd-converge?}
    H -->|nao| G
    H -->|sim| I[Rebase contra main,<br/>Squash & Merge RGIT-12]
    I --> J[Remover Worktree & Branch<br/>git worktree remove RGIT-14]
```

---

# Parte II — Máquinas de estado

## ME-01 · Ciclo de vida de uma spec

```mermaid
stateDiagram-v2
    [*] --> Rascunho: /specify
    Rascunho --> Rascunho: refinar
    Rascunho --> Bloqueada: ambiguidade bloqueante detectada
    Bloqueada --> Esclarecida: humano respondeu
    Rascunho --> Esclarecida: sem bloqueantes
    Esclarecida --> Planejada: plan aprovado
    Planejada --> EmImplementacao: tasks aprovadas
    EmImplementacao --> EmImplementacao: task concluida
    EmImplementacao --> Reaberta: contrato inviavel ou criterio mudou
    Reaberta --> Esclarecida
    EmImplementacao --> Auditoria: todas as tasks fechadas
    Auditoria --> EmImplementacao: lacuna encontrada
    Auditoria --> Arquivada: aprovada com evidencia
    Arquivada --> Reaberta: mudanca de requisito
    Arquivada --> [*]
```

**Transições que a maioria dos fluxos não modela, e deveria:**
- `EmImplementacao → Reaberta` — descobrir na implementação que o contrato é inviável é **normal**.
  Sem essa transição, o executor "conserta" o contrato em silêncio (AP-21).
- `Auditoria → EmImplementacao` — auditoria que não pode reprovar não é auditoria.
- `Arquivada → Reaberta` — sem ela, `spec-anchored` é impossível e o fluxo é só `spec-first`.

## ME-02 · Ciclo de vida de uma task

```mermaid
stateDiagram-v2
    [*] --> Pendente
    Pendente --> Bloqueada: dependencia nao satisfeita
    Bloqueada --> Pendente: dependencia concluida
Processos com estados discretos e transições válidas.

## ME-01 · Estado da especificação

```mermaid
stateDiagram-v2
    [*] --> Rascunho: /sdd-specify
    Rascunho --> Rascunho: /sdd-clarify (preenche lacunas)
    Rascunho --> Esclarecida: 0 bloqueantes abertos (ADR-002)
    Esclarecida --> Planejada: /sdd-plan + /sdd-tasks
    Planejada --> EmImplementacao: /sdd-implement (task a task)
    EmImplementacao --> Implementada: todas as tasks concluidas
    Implementada --> Convergida: /sdd-converge aprovado (I-09)
    Convergida --> [*]

    EmImplementacao --> Planejada: desvio estrutural encontrado
    Rascunho --> Abandono: spec recusada pelo humano
    Abandono --> [*]
```

## ME-02 · Estado da task individual

```mermaid
stateDiagram-v2
    [*] --> PENDENTE
    PENDENTE --> EM_EXECUCAO: selecionada pelo runner
    EM_EXECUCAO --> CONCLUIDA: evidencia de teste anexada
    EM_EXECUCAO --> BLOQUEADA: obstaculo nao previsto
    BLOQUEADA --> EM_EXECUCAO: obstaculo resolvido pelo humano
    CONCLUIDA --> VERIFICADA: teste independente passou (VER-01)
    VERIFICADA --> [*]

    CONCLUIDA --> PENDENTE: regressao encontrada
    EM_EXECUCAO --> NAO_VERIFICAVEL: sem harness de teste
```

`NaoVerificavel` é um estado **de primeira classe**, não um atalho para `Concluida`. Colapsar os dois
é como o "trust-then-verify gap" entra no processo.

## ME-03 · Estado do contexto da sessão

```mermaid
stateDiagram-v2
    [*] --> Limpo
    Limpo --> Produtivo: tarefa iniciada
    Produtivo --> Elevado: 40% da janela
    Elevado --> Delegando: 60% - subagente obrigatorio
    Delegando --> Critico: 80%
    Critico --> Compactado: /compact dirigido
    Compactado --> Produtivo
    Produtivo --> Poluido: 2 correcoes falhas na mesma coisa
    Poluido --> Limpo: /clear + prompt reescrito
    Produtivo --> Limpo: /clear entre tarefas nao relacionadas
    Produtivo --> [*]: tarefa concluida
```

`Poluido` **não** se resolve compactando — a compactação preserva as abordagens falhas. Só `/clear`
com prompt reescrito sai desse estado.

## ME-04 · Ciclo de vida de Frente/Worktree

`[CONSOLIDADO]` Estado do checkout isolado por frente de trabalho (`RGIT-11`).

```mermaid
stateDiagram-v2
    [*] --> Criada: claude --worktree <tipo>/<slug>
    Criada --> EmDesenvolvimento: setup de ambiente (.env, deps)
    EmDesenvolvimento --> EmDesenvolvimento: commit por task (RGIT-03)
    EmDesenvolvimento --> EmVerificacao: build + testes + /sdd-converge
    EmVerificacao --> EmDesenvolvimento: falha na auditoria / testes
    EmVerificacao --> Integrada: rebase + squash merge para main (RGIT-12)
    EmDesenvolvimento --> Orfa: sessao abandonada sem merge
    Integrada --> Removida: git worktree remove + git branch -d (RGIT-14)
    Orfa --> Removida: sweep de limpeza
    Removida --> [*]
```

---

# Parte III — Algoritmos conceituais

Pseudocódigo de decisão. Não é código: é a política, escrita de forma inequívoca.

## AL-01 · Resolver lacuna de informação

```
resolver_lacuna(lacuna, contexto):
    se lacuna ∈ prompt_do_usuario:            devolve inferir(prompt)
    se lacuna ∈ defaults_da_stack:            devolve default(stack)
    se lacuna ∈ codebase:
        se escopo_da_busca é amplo:           devolve delegar_subagente(busca)
        senao:                                devolve buscar(codebase)
    se lacuna é especifica_do_negocio:
        se custo_de_reverter(lacuna) alto:    devolve perguntar_humano(lacuna)   # bloqueia
        senao:                                devolve assumir_e_registrar(lacuna)
    devolve marcar_UNKNOWN(lacuna)            # nunca inventar
```

Última linha é o **protocolo anti-invenção**: o caminho de saída padrão é `UNKNOWN`, jamais um palpite
plausível.

## AL-02 · Decidir o peso do processo

```
calibrar(mudanca):
    r = custo_de_reverter(mudanca)      # baixo | medio | alto
    n = arquivos_afetados(mudanca)
    c = certeza_da_abordagem(mudanca)   # alta | baixa

    se r == alto:                       devolve FULL          # custo do erro domina o tamanho
    se n == 1 e c == alta:              devolve DIRETO
    se n <= 5 e c == alta:              devolve PLANO_LEVE
    devolve PADRAO
```

A primeira linha é a que quase todo framework erra: calibrar por **tamanho** em vez de por **custo do
erro** faz uma linha alterada no cálculo de dinheiro ser tratada como typo.

## AL-03 · Ciclo de execução de task

```
executar(task, envelope, contratos):
    verificar_precondicoes(task.depends_on)
    para cada decisao em implementar(task):
        se decisao ∉ envelope.decide_sozinho:
            se decisao ∈ envelope.vedado:        aborta_e_reporta()
            senao:                               pedir_aprovacao(decisao)
        se decisao contradiz contratos:          para_e_reporta()   # nunca "corrigir" o contrato
        se decisao preenche lacuna da spec:      registrar_interpretacao(decisao)

    resultado = rodar(task.verificacao)
    se resultado == NAO_EXECUTAVEL:              marcar(NAO_VERIFICAVEL); reportar()
    se resultado == FALHA:                       corrigir(); repetir()     # nunca desabilitar teste
    se resultado == SUCESSO:                     marcar(CONCLUIDA, evidencia=resultado.saida)
```

## AL-04 · Verificação adversarial

```
auditar(entrega, spec, plan, constitution):
    exigir(contexto_atual ≠ contexto_de_execucao)      # senao a auditoria nao vale

    achados = []
    para cada criterio em spec.criterios:
        e = buscar_evidencia_no_codigo(criterio)        # arquivo:linha ou saida de comando
        se e ausente:               achados += LACUNA(criterio)
        se e nao_executavel:        achados += NAO_VERIFICADO(criterio)

    para cada unidade em entrega.codigo:                # a busca esquecida
        se unidade nao mapeia para nenhum requisito:
            achados += EXCEDENTE(unidade)               # escopo ampliado

    para cada artigo em constitution:
        se violado e nao_declarado_no_plan:
            achados += DESVIO_NAO_DECLARADO(artigo)

    devolve filtrar(achados, afeta_correcao_ou_requisito_declarado)   # evita over-engineering
```

O `filtrar` final é obrigatório. Sem ele, a auditoria sempre encontra algo e o resultado é AP-24.

## AL-05 · Promover falha a conhecimento

```
aprender(incidente):
    se incidente é unico e nao generalizavel:    registra_nota(); retorna

    padrao = generalizar(incidente)              # a CLASSE, nao o caso
    destino = escolher_destino(padrao):
        regra universal e mecanizavel        -> teste / hook / CI     # mais durável
        regra que exige julgamento           -> pergunta de revisao
        principio que muda decisoes futuras  -> artigo de constitution
        conhecimento de area especifica      -> skill

    escrever(destino, padrao, evidencia=incidente)
    se destino == pergunta_de_revisao:  anexar(checklist_de_review)
    verificar(destino aplicado a um caso real)    # senao é AP-33, teatro
```

A última linha é o que separa aprendizado de arquivamento: **se o novo padrão não muda nenhuma decisão
concreta, ele não foi aprendido.**

---

**Anterior:** [08 — Arquiteturas e pipelines](08-arquiteturas-e-pipelines.md) · **Próximo:** [10 — Métricas](10-metricas.md)
