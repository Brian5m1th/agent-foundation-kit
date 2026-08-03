# Anthropic · Claude Code — destilação das fontes oficiais

> Fontes: [Best practices](https://code.claude.com/docs/en/best-practices) ·
> [Common workflows](https://code.claude.com/docs/en/common-workflows) ·
> [Prompt library](https://code.claude.com/docs/en/prompt-library). Lidas em 2026-08-02.
> Tudo aqui é `[OFICIAL]` salvo marcação em contrário. Oficial é autoritativo **sobre o produto** —
> não sobre o mundo.

## 1. A restrição da qual quase tudo deriva

> *"A maior parte das boas práticas se baseia em uma restrição: a janela de contexto do Claude enche
> rápido, e o desempenho degrada conforme ela enche."*

A janela guarda a conversa inteira — cada mensagem, cada arquivo lido, cada saída de comando. Quando
enche, o modelo começa a "esquecer" instruções anteriores e a errar mais.

**Consequência de projeto:** o contexto é o recurso escasso. Toda técnica abaixo é, no fundo, uma
forma de gastá-lo melhor. `/context` mostra o que foi carregado; um *status line* customizado
acompanha o uso continuamente.

## 2. Dê ao Claude como verificar o próprio trabalho

> *"O Claude para quando o trabalho parece pronto. Sem uma checagem que ele possa rodar, 'parece
> pronto' é o único sinal disponível — e você vira o laço de verificação."*

A checagem é qualquer coisa que devolva um sinal legível na conversa: suíte de testes, código de saída
do build, linter, script que compara com um *fixture*, screenshot do navegador comparado ao design.

| Estratégia | Antes | Depois |
|---|---|---|
| Fornecer critério | "implemente validação de e-mail" | "escreva `validateEmail`. casos: `a@b.com` true, `invalid` false, `user@.com` false. rode os testes depois de implementar" |
| Verificar UI visualmente | "deixe o dashboard melhor" | "[screenshot] implemente este design. tire um screenshot do resultado, compare com o original, liste as diferenças e corrija" |
| Atacar a causa | "o build está quebrado" | "o build falha com este erro: [erro]. corrija e verifique que o build passa. **ataque a causa raiz, não suprima o erro**" |

Quatro níveis de rigor no portão, do mais barato ao mais forte:

1. **No próprio prompt** — peça para rodar a checagem e iterar na mesma mensagem.
2. **Na sessão** — `/goal`: um avaliador separado re-checa a condição a cada turno.
3. **Determinístico** — *Stop hook*: bloqueia o fim do turno até o script passar (o Claude Code
   sobrepõe o hook após 8 bloqueios consecutivos).
4. **Segunda opinião** — subagente de verificação ou workflow: um modelo novo tenta refutar, de modo
   que quem fez não é quem corrige a prova.

> **Peça a evidência, não o veredito**: a saída do teste, o comando e o retorno, o screenshot. Revisar
> evidência é mais rápido que re-rodar a verificação — e funciona para sessões que você não assistiu.

## 3. Explore → Plan → Implement → Commit

> *"Deixar o Claude ir direto para o código pode produzir código que resolve o problema errado."*

| Fase | O que acontece | Prompt exemplo |
|---|---|---|
| **Explore** | Plan mode: lê e responde, sem alterar nada | "leia `/src/auth` e entenda como tratamos sessão e login" |
| **Plan** | Plano detalhado; `Ctrl+G` abre o plano no editor para você mesmo editar | "quero adicionar Google OAuth. Quais arquivos mudam? Crie um plano" |
| **Implement** | Sai do plan mode e implementa verificando contra o plano | "implemente o fluxo OAuth do seu plano. escreva testes do callback, rode a suíte e corrija falhas" |
| **Commit** | Commit descritivo + PR | "commit com mensagem descritiva e abra um PR" |

**Calibração — e este é o ponto que a maioria ignora:**

> *"Plan mode é útil, mas também adiciona overhead. Para tarefas de escopo claro e correção pequena
> (typo, log, renomear variável) peça direto. **Se você consegue descrever o diff em uma frase, pule o
> plano.**"*

Planejar vale quando: a abordagem é incerta, a mudança toca vários arquivos, ou você não conhece o
código que vai mudar.

## 4. Contexto específico no prompt

| Estratégia | Antes | Depois |
|---|---|---|
| **Delimitar** | "adicione testes para foo.py" | "escreva um teste para foo.py cobrindo o caso de usuário deslogado. evite mocks" |
| **Apontar a fonte** | "por que essa API é estranha?" | "veja o histórico git de `ExecutionFactory` e resuma como a API chegou nisso" |
| **Referenciar padrão existente** | "adicione um widget de calendário" | "veja como os widgets da home são implementados; `HotDogWidget.php` é bom exemplo. siga o padrão…" |
| **Descrever o sintoma** | "corrija o bug de login" | "login falha após timeout de sessão. veja `src/auth/`, especialmente refresh de token. **escreva um teste que reproduza a falha, depois corrija**" |

Prompt vago tem lugar: quando você está explorando e pode se dar ao luxo de corrigir o rumo.
*"o que você melhoraria neste arquivo?"* levanta coisas que você não pensaria em perguntar.

**Conteúdo rico:** `@arquivo` referencia (e puxa o CLAUDE.md daquele diretório e dos pais); imagens
por colar/arrastar; URLs de documentação (allowlist via `/permissions`); `cat error.log | claude`
para canalizar dados; ou instruir o Claude a buscar o que precisa por conta própria.

## 5. CLAUDE.md — a regra mais violada

> *"Mantenha conciso. Para cada linha, pergunte: **remover isto faria o Claude errar?** Se não, corte.
> CLAUDE.md inchado faz o Claude ignorar suas instruções reais!"*

| ✅ Incluir | ❌ Excluir |
|---|---|
| Comandos bash que o Claude não adivinha | Qualquer coisa descobrível lendo o código |
| Regras de estilo que **diferem** do padrão | Convenções padrão da linguagem |
| Instruções de teste e runner preferido | Documentação detalhada de API (linke) |
| Etiqueta do repositório (branch, PR) | **Informação que muda com frequência** |
| Decisões arquiteturais específicas do projeto | Explicações longas ou tutoriais |
| Peculiaridades do ambiente (env vars obrigatórias) | Descrição arquivo-a-arquivo do codebase |
| Armadilhas e comportamentos não óbvios | Práticas autoevidentes ("escreva código limpo") |

**Diagnóstico por sintoma:**
- O Claude insiste em algo contra o qual existe regra → **o arquivo está longo demais e a regra se
  perdeu no ruído**.
- O Claude pergunta algo que está no CLAUDE.md → a redação está ambígua.

**Camadas** — todas somam, e é assim que se evita um arquivo monolítico:

| Local | Alcance |
|---|---|
| `~/.claude/CLAUDE.md` | todas as sessões, todos os projetos |
| `./CLAUDE.md` | projeto, versionado, compartilhado com o time |
| `./CLAUDE.local.md` | pessoal, no `.gitignore` |
| Diretórios pais | monorepo: `root/` e `root/foo/` são ambos puxados |
| Diretórios filhos | **sob demanda**, quando o Claude lê um arquivo daquele diretório |

Imports com `@caminho/arquivo` dentro do CLAUDE.md. Ênfase ("IMPORTANT", "YOU MUST") aumenta aderência.
Trate como código: revise quando algo der errado, pode regularmente, e **teste observando se o
comportamento realmente mudou**.

> **A regra de partição:** *"CLAUDE.md é carregado toda sessão, então inclua só o que se aplica
> amplamente. Para conhecimento de domínio ou fluxos que só valem às vezes, use skills — o Claude
> carrega sob demanda sem inflar toda conversa."*

## 6. Extensões — qual usar para quê

| Mecanismo | Natureza | Use quando |
|---|---|---|
| **CLAUDE.md** | advisory, sempre carregado | vale para toda mensagem do projeto |
| **Skill** (`.claude/skills/<n>/SKILL.md`) | model-invoked, sob demanda | conhecimento de domínio ou fluxo repetível; `disable-model-invocation: true` para o que tem efeito colateral e deve ser manual |
| **Subagente** (`.claude/agents/*.md`) | contexto próprio, ferramentas próprias | tarefa que lê muitos arquivos ou exige foco isolado |
| **Hook** | **determinístico** | tem de acontecer toda vez, sem exceção |
| **MCP** | integração externa | Notion, Figma, banco, issue tracker |
| **Plugin** | pacote de tudo acima | adoção de bloco pronto |
| **CLI (`gh`, `aws`, `gcloud`)** | forma mais econômica em contexto de falar com serviços externos | sempre que existir CLI |

O Claude escreve hooks e subagentes por você: *"escreva um hook que roda eslint depois de cada edição
de arquivo"*.

## 7. Gestão de sessão

- **Corrija cedo.** `Esc` interrompe preservando contexto. `Esc Esc` / `/rewind` restaura conversa
  e/ou código a um checkpoint. **Regra dura:** *"se você corrigiu o Claude mais de duas vezes sobre a
  mesma coisa, o contexto está poluído com abordagens falhas — `/clear` e recomece com um prompt melhor
  incorporando o que aprendeu. Uma sessão limpa com prompt melhor quase sempre vence uma sessão longa
  com correções acumuladas."*
- **`/clear` entre tarefas não relacionadas.** `/compact <instrução>` para direcionar a compactação.
  `Esc Esc` → *Summarize from here* / *up to here* para compactar só um trecho.
- **Instrua a compactação no CLAUDE.md**: *"ao compactar, preserve sempre a lista de arquivos
  modificados e os comandos de teste"*.
- **`/btw`** para pergunta lateral que **não entra** no histórico.
- **Checkpoints**: cada prompt cria um. Permite tentar algo arriscado e voltar. ⚠️ **só captura
  mudanças feitas pelas ferramentas de edição** — mudanças via Bash não entram. Não substitui git.
- **Sessões nomeadas** (`/rename`, `--continue`, `--resume`) funcionam como branches de contexto.

## 8. Entreviste-se antes de features grandes

Prompt oficial, para colar:

```text
I want to build [descrição breve]. Interview me in detail using the AskUserQuestion tool.

Ask about technical implementation, UI/UX, edge cases, concerns, and tradeoffs. Don't ask obvious
questions, dig into the hard parts I might not have considered.

Keep interviewing until we've covered everything, then write a complete spec to SPEC.md.
```

> *"Uma vez a spec pronta, comece uma sessão nova para executá-la."* Contexto limpo, focado em
> implementação, com a spec escrita como referência.
>
> *"As specs mais úteis são autocontidas: nomeiam os arquivos e interfaces envolvidos, dizem o que
> está fora de escopo, e terminam com um passo de verificação ponta a ponta que prova que a feature
> funciona. **Tempo gasto tornando a spec precisa rende mais que tempo gasto assistindo a
> implementação.**"*

Isto é Spec-Driven Development descrito pela própria Anthropic, sem usar o nome.

## 9. Escala

- **Não-interativo**: `claude -p "prompt"`, com `--output-format json|stream-json`. Base para CI,
  pre-commit e pipelines.
- **Paralelo**: worktrees (`claude --worktree feature-auth`), app desktop, web, ou *agent teams*.
- **Writer/Reviewer**: sessão A implementa; sessão B, com **contexto novo**, revisa —
  *"contexto novo melhora a revisão porque o Claude não fica enviesado a favor do código que acabou de
  escrever"*.
- **Fan-out**: gerar lista de arquivos → laço chamando `claude -p` por arquivo com `--allowedTools`
  restrito → testar em 2-3 antes de rodar em escala.
- **Auto mode**: `--permission-mode auto` — um classificador bloqueia escalada de escopo,
  infraestrutura desconhecida e ações dirigidas por conteúdo hostil.
- **Revisão adversarial antes de considerar pronto**: `/code-review`, ou prompt próprio nomeando o
  trabalho, o plano e o que conta como achado.

> ⚠️ *"Um revisor instruído a achar lacunas normalmente vai reportar alguma, mesmo quando o trabalho
> está correto — porque foi isso que se pediu. Perseguir todo achado leva a over-engineering: camadas
> extras de abstração, código defensivo e testes para casos impossíveis. Diga ao revisor para
> sinalizar só o que afeta correção ou os requisitos declarados."*

## 10. Os cinco modos de falha nomeados

| Falha | Sintoma | Correção oficial |
|---|---|---|
| **Kitchen sink session** | uma tarefa, depois outra sem relação, depois volta | `/clear` entre tarefas |
| **Correcting over and over** | corrige, erra, corrige | após 2 correções falhas: `/clear` + prompt melhor |
| **Over-specified CLAUDE.md** | o Claude ignora metade | podar sem dó; o que ele já faz certo, apague ou vire hook |
| **Trust-then-verify gap** | implementação plausível que não trata borda | sempre fornecer verificação; **se não dá para verificar, não faça o deploy** |
| **Infinite exploration** | "investigue X" sem escopo → centenas de arquivos lidos | delimitar, ou usar subagente |

## 11. Common workflows — receitas

**Entender codebase novo:** visão geral → padrões de arquitetura → modelos de dados → autenticação.
Depois: *"onde ficam os arquivos que tratam X"* → *"como esses arquivos trabalham juntos"* → *"trace o
login do front ao banco"*. Comece amplo, estreite. Peça um glossário dos termos do projeto.

**Bug:** compartilhe o erro → peça algumas formas de corrigir → aplique. Diga o comando que reproduz e
se a falha é intermitente.

**Refatorar:** ache uso de API depreciada → peça recomendação → aplique mantendo comportamento →
rode os testes. Em incrementos pequenos e testáveis.

**Testes:** ache o não coberto → gere o esqueleto → acrescente casos de borda → rode e corrija.
O Claude examina os testes existentes para casar estilo, framework e forma de asserção.

**PR:** resuma as mudanças → `create a pr` → refine a descrição. A sessão fica ligada ao PR
(`claude --from-pr 1234`).

**Agendado:** Routines (infra Anthropic) · tarefas do desktop · GitHub Actions · `/loop` na sessão.
*"Seja explícito sobre o que é sucesso e o que fazer com o resultado — a tarefa roda sozinha e não pode
fazer perguntas."*

**Não-código:** funciona em vault de notas, pasta de documentação, qualquer coleção de markdown.

## 12. Prompt library — a taxonomia importa mais que os prompts

> Os 52 prompts na íntegra, traduzidos e indexados por intenção, estão em
> [prompt-library.md](prompt-library.md). Esta seção fica com a leitura estrutural.

A biblioteca é indexada por **fase do SDLC** e **categoria**, com papéis opcionais. A distribuição
observada (52 prompts):

| Fase | Qtd | Categorias |
|---|---|---|
| `build` | 22 | Implement, Test, Debug, Refactor |
| `operate` | 12 | Incident, Automate, Data |
| `discover` | 7 | Onboard, Understand |
| `design` | 6 | Plan, Prototype, Steer |
| `ship` | 5 | Release, Git, Review |

Papéis marcados: `pm`, `design`, `docs`, `marketing`, `ops`, `security`, `data` — **25 dos 52 prompts
não têm papel**, ou seja, são de engenharia geral. A existência dos papéis é o sinal: a Anthropic
posiciona o Claude Code como ferramenta de **toda a organização**, não só de quem escreve código.

Estrutura de cada entrada: `prompt` com **slots** (`{path}`, `{behavior}`, `{target}`) e valores de
exemplo. É um padrão de prompt parametrizado — o mesmo que usamos em `argument-hint` nos slash
commands.

**O que copiar dessa biblioteca para a nossa:** indexar prompt por fase e categoria, e parametrizar
com slots nomeados em vez de escrever prompts de uso único.

## 13. Onde a documentação oficial **contradiz** a prática de SDD pesado

Registro deliberado — a KB não esconde conflito.

| Doc oficial diz | Prática SDD pesada faz | Resolução proposta `[HIPÓTESE]` |
|---|---|---|
| "se você descreve o diff em uma frase, pule o plano" | roda constitution→spec→plan→tasks para tudo | Calibração por porte: Lightweight / Standard / Full |
| "CLAUDE.md conciso; o que vale às vezes vira skill" | CLAUDE.md de 200+ linhas com estado do projeto | Camadas + skills + **nunca** estado volátil no CLAUDE.md |
| "revisor que procura lacuna sempre acha" | validação exaustiva multi-agente | Restringir achados a correção e requisito declarado |
| "contexto enche e degrada" | comandos de 60–97 KB `[CAMPO]` (sdd-kit) | Progressive disclosure obrigatório em comando grande |

Estas quatro linhas são a razão de a KB existir: **a fonte oficial e a prática de campo divergem em
pontos concretos, e a divergência precisa ser arbitrada por escrito, não por hábito.**

---

**Volta ao índice:** [README](README.md)
