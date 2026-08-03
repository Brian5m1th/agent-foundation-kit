# Eficiência no Claude Code — o que muda o resultado na prática

Notas de trabalho, não documentação oficial. Organizadas por impacto: o começo importa mais.

## 1. Onde colocar instrução (e por que quase sempre é no lugar errado)

| Mecanismo | Entra no contexto | Use para |
|---|---|---|
| `~/.claude/CLAUDE.md` | sempre, todo projeto | preferências suas que valem em qualquer lugar (idioma, estilo) |
| `<projeto>/CLAUDE.md` | sempre, naquele projeto | arquitetura, comandos, invariantes do projeto |
| `<subpasta>/CLAUDE.md` | ao tocar naquela subpasta | regras de um módulo específico |
| Slash command (`.claude/commands/*.md`) | só quando invocado | um procedimento repetível |
| Skill (`.claude/skills/<nome>/SKILL.md`) | quando o modelo julga relevante | capacidade com arquivos de apoio, scripts, referências |
| Memória (`memory/`) | quando relevante | fatos sobre você e o projeto que não estão no código |

**Erro comum:** empilhar procedimento no CLAUDE.md. Tudo que está lá é lido em toda sessão e compete
por atenção com o código. Se algo só vale às vezes, é slash command ou skill — não CLAUDE.md.

**Teste rápido:** "isso é verdade em toda mensagem que eu mandar neste projeto?" Não → tire do CLAUDE.md.

## 2. Qualidade de CLAUDE.md

Bom CLAUDE.md contém o que **não é descobrível lendo dois arquivos**:

- Por que a arquitetura é assim, e o que quebra se você mudar.
- O comando exato de build/test/lint, incluindo como rodar **um** teste.
- Invariantes não óbvios ("este arquivo é gerado, não edite", "auth roda no middleware, não no handler").
- Convenções que o código não revela sozinho.

Não contém: lista de pastas, práticas genéricas de engenharia, estrutura que um `ls` mostra.

Refine com o uso: quando você corrigir o Claude pela segunda vez sobre a mesma coisa, isso vira linha
no CLAUDE.md — ou memória, se for sobre você e não sobre o projeto.

## 3. Modos de trabalho

- **Plan mode** (`Shift+Tab` até aparecer) — o modelo investiga e propõe sem editar. Use antes de
  qualquer mudança que toque mais de dois arquivos. Barato comparado a desfazer implementação errada.
- **`/clear`** entre tarefas não relacionadas. Contexto sujo degrada a resposta e custa tokens em toda
  mensagem seguinte.
- **`/compact`** quando a tarefa é longa mas contínua — preserva o fio, corta o acúmulo.
- **`Esc`** interrompe. `Esc Esc` volta a uma mensagem anterior para reescrever o rumo. Corrigir o
  prompt na origem sai muito mais barato que discutir por cinco turnos.
- **`!comando`** roda direto no shell da sessão e joga a saída no contexto — melhor que pedir para o
  Claude rodar quando você já sabe o comando, e essencial para coisas interativas (`gcloud auth login`).
- **`@caminho/arquivo`** injeta o arquivo. Bem mais preciso que descrever onde ele está.

## 4. Subagentes e paralelismo

Subagente tem contexto próprio: o custo de investigação fica lá e só a conclusão volta. Vale quando a
resposta exige varrer muitos arquivos. **Não vale** para ler um arquivo que você já sabe qual é.

Tarefas independentes → um pedido só, várias frentes. Tarefas dependentes → sequencial, sempre.

## 5. Prompt que rende

O que mais aumenta acerto, em ordem:

1. **Critério de pronto explícito.** "Funciona" não é critério; "`npm test` passa e o endpoint devolve
   401 sem token" é. (É o mesmo princípio dos critérios de aceite do SDD.)
2. **Restrições negativas.** "Não mexa em `auth/`" e "não adicione dependência" evitam a maior parte do
   retrabalho.
3. **Um exemplo concreto** de entrada e saída esperada vale mais que três parágrafos de descrição.
4. **Peça a evidência**, não o veredito: "mostre a saída dos testes" em vez de "verifique se passa".

## 6. Permissões

Prompt de permissão repetido é atrito puro. `/permissions` para allowlist de comandos read-only que
você aprova toda hora (`git status`, `npm test`, `ls`). O skill `/fewer-permission-prompts` varre seus
transcripts e monta essa lista sozinho.

## 7. Como isso se conecta ao SDD

O fluxo em `.specify/` é a aplicação disciplinada dos itens 3 e 5: a spec é o critério de pronto
escrito antes, o plan é a restrição negativa em forma de contrato, e o `/sdd-converge` é o "peça a
evidência" transformado em auditoria. O ganho não vem de gerar mais código — vem de gerar código que não precisa
ser refeito.
