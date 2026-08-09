# AGENTS.md

<!--
═══════════════════════════════════════════════════════════════════════════════
TEMPLATE — AGENTS.md · contexto de projeto agnóstico de fornecedor
Fonte: labs/kb/  ·  Instruções de uso em labs/templates/README.md
═══════════════════════════════════════════════════════════════════════════════

PAPEL DESTE ARQUIVO
  Contém as regras de engenharia PORTÁVEIS — as que valem independentemente de
  qual agente está rodando (Claude Code, Cursor, Copilot, Codex, OpenCode).
  O CLAUDE.md importa este arquivo e acrescenta só o que é específico do harness.
  Assim não existe duplicação, e não existe contradição entre os dois.

O TESTE DE INCLUSÃO — aplique a CADA linha antes de mantê-la:
  "Remover esta linha faria o agente errar?"
  Não → apague. Este arquivo é lido em toda sessão e compete por atenção com o código.

NUNCA COLOQUE AQUI
  ✗ Estado que muda (sprint atual, contagem de testes, o que está em andamento)
      → arquivo próprio, referenciado; ver AP-26
  ✗ Qualquer coisa descobrível lendo dois arquivos de código
  ✗ Convenções padrão da linguagem que o modelo já conhece
  ✗ Conhecimento que vale só às vezes → vira skill (progressive disclosure)
  ✗ Regra que precisa valer SEM EXCEÇÃO → vira hook/CI (instrução aqui é advisory)
  ✗ Explicação didática ("JWT significa...") — o modelo já sabe

META DE TAMANHO: 60–120 linhas. Passou de 150, alguma regra vai ser ignorada.

Apague todos estes comentários ao instanciar.
-->

## O que é este projeto

<!-- 2–4 frases. O suficiente para o agente saber que decisões fazem sentido aqui.
     Domínio, quem usa, e a forma geral do sistema. Nada de história do projeto. -->

`<NOME>` — `<o que faz, para quem>`. `<Forma do sistema: monorepo com X e Y / serviço único / CLI>`.

## Comandos

<!-- Só o que o agente NÃO adivinha. Inclua SEMPRE como rodar UM teste — é o comando
     mais usado e o menos adivinhável. Se o comando muda por diretório, diga de onde rodar. -->

```bash
<build>                      # build / type check
<test-all>                   # suíte completa
<test-one>                   # UM teste — obrigatório documentar
<lint>
<run>                        # subir localmente
```

`<Pré-requisitos não óbvios: serviços que precisam estar de pé, variáveis obrigatórias, flags do CI.>`

## Arquitetura

<!-- O "porquê", não o "onde". Estrutura de pastas é descobrível; a razão dela não é.
     Escreva o que quebra se alguém mudar. Máximo ~10 linhas. -->

- `<Decisão estrutural + a razão>`. Ex.: *DDD por bounded context; cada contexto tem api/application/domain/infra e não importa de outro contexto.*
- `<Fronteira que não pode ser cruzada>`. Ex.: *o núcleo de domínio não importa framework — um teste falha se isso mudar.*
- `<Ponto de extensão>`. Ex.: *gateway de pagamento é porta com uma implementação ativa via config; adicionar um novo não muda nenhuma interface.*

## Convenções que diferem do padrão

<!-- SÓ o que difere do que o modelo faria sozinho. Se ele já faz certo, não escreva. -->

- **Idioma:** `<código em X, mensagens de usuário em Y, log em Z>`
- **Erros:** `<como se lança e como se traduz para a fronteira>`
- `<regra que já apareceu 2+ vezes em review>`
- `<armadilha específica do projeto — o "todo mundo tropeça aqui">`

## Regras invariantes

<!-- Poucas, absolutas, e cada uma com enforcement. Regra sem enforcement é aspiração:
     ou vira teste/hook/CI, ou sai daqui. Se nenhuma delas já barrou uma decisão real
     que alguém queria tomar, elas são decorativas (AP-01/AP-33). -->

- **Nunca** logar senha, token, JWT ou PII. `<como é imposto>`
- **Nunca** desabilitar, pular ou apagar teste para fazer o build passar. Adiar só com marcação de pendência **e link para a task**.
- **Nunca** segredo com valor default no código; configuração ausente derruba o boot em produção.
- **Nunca** executar operação destrutiva (drop, force push, reset --hard, rm -rf) sem aprovação humana explícita — vale inclusive em modo automático.
- **Nunca** duas frentes de trabalho editando o mesmo arquivo ao mesmo tempo: ou os conjuntos são disjuntos, ou cada frente trabalha em checkout isolado.
- **Nunca** deixar rastro de IA em commits, PRs ou comentários (sem `Co-Authored-By` de agente, sem emojis de IA, autor/committer = usuário git local).
- **Jira First:** O Jira é a única fonte de verdade para o backlog dinâmico. Arquivos `.md` são snapshots estáticos; `.spec/jira/mapa.tsv` é o checkpoint de sincronização.
- `<invariante do seu domínio, com enforcement>`

## Fluxo de trabalho

<!-- Como o trabalho entra e sai. Calibrado por porte — este é o item de maior
     consenso em toda a literatura: o peso do processo é proporcional ao tamanho da mudança. -->

- **Protocolo de Frente Automático:** Toda nova funcionalidade, sprint ou mudança relevante dispara obrigatoriamente: **Worktree por Frente (`EXE-05`, `RGIT-11`)** ──► **Spec + Entrevista (`INT-08`)** ──► **Plan & Tasks (`PLN-02`)** ──► **Execução com Commits por Task (`RGIT-02/03`)** ──► **Auditoria Converge (`I-09`)** ──► **Squash Merge & Cleanup (`RGIT-12/14`)**.

| Porte | Processo |
|---|---|
| Correção de uma frase | Direto ao código + verificação |
| Feature média | Worktree por frente → Plano → implementação → verificação |
| Módulo novo / mudança estrutural | Worktree por frente → Spec + Entrevista → plano → tasks → subagentes → auditoria virgem |

- **Branch/commit:** Conventional Branch (`<tipo>/<slug>`, `RGIT-05`) e Conventional Commit por task concluída (`RGIT-02`, `RGIT-03`). Proibido `spec/` ou `sdd/` no nome da branch.
- **Trabalho paralelo:** checkout isolado por frente (Worktree `EXE-05`, `RGIT-11`) — nunca na branch `main`. *Isolamento é de arquivo, não de runtime: portas, banco e serviços continuam compartilhados salvo se configurados explicitamente.*
- **Definition of Done:** `<harness que precisa passar>` **e** relatório `/sdd-converge` aprovado.


## Autonomia

<!-- Envelope declarado. Sem isto, o agente decide nas lacunas sem que ninguém tenha
     decidido que ele decidiria. Ajuste ao seu apetite de risco. -->

- **Decide sozinho:** nomes internos, organização de arquivos dentro do módulo, ordem de implementação, escolha de algoritmo que cumpra o contrato.
- **Consulta antes:** schema e migração, contrato público, dependência nova, mudança de escopo, decisão de segurança.
- **Vedado:** `<caminhos/áreas intocáveis>`, alterar este arquivo, operações destrutivas.

## Verificação

<!-- O agente precisa de uma checagem que ele mesmo rode. Sem isso, "parece pronto"
     é o único sinal disponível — e você vira o laço de verificação. -->

- Toda mudança de comportamento roda `<comando>` e **mostra a saída real** — nunca "os testes passam".
- Regra universal ("sempre", "nunca", "qualquer") é verificada por propriedade, não por três exemplos escolhidos.
- Auditoria de entrega roda em **sessão separada** de quem implementou.
- Verificação que não roda no ambiente é reportada como **não verificada**, nunca como "ok".

## Onde está o resto

<!-- Ponteiros, não conteúdo. Isto é o que mantém o arquivo pequeno. -->

| Precisa de | Vá para |
|---|---|
| Estado atual, o que está em andamento | `<STATUS.md / tasks.md>` |
| Padrões detalhados por área | `<caminho>` |
| Decisões arquiteturais e o porquê | `<adr/ ou docs/decisions/>` |
| Convenções por linguagem | `<caminho>` |
