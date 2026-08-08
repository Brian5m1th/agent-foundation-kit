# Git Strategy — Convenções, Branches, Commits e Worktrees

> Fontes: [Conventional Commits](https://www.conventionalcommits.org/) ·
> [Conventional Branch](https://conventionalbranch.org/) ·
> [Trunk-Based Development 2026](https://trunkbaseddevelopment.com/) ·
> [GitHub Stacked PRs & CLI 2026](https://docs.github.com/).
> Selos: `[OFICIAL]` regras do repositório/Anthropic · `[INDÚSTRIA]` práticas consolidadas da indústria (2026) · `[CONSOLIDADO]` padrão unificado do repositório · `[CAMPO]` práticas dos projetos do usuário.

Padrões correspondentes: [EXE-05 · Isolamento por Worktree](04-padroes.md#exe-05--isolamento-por-worktree) · [AD-05 · Decisão de Git & Worktree](09-decisao-estados-algoritmos.md#ad-05--árvore-de-decisão-git-e-worktree) · [ME-04 · Ciclo de Vida de Worktree](09-decisao-estados-algoritmos.md#me-04--ciclo-de-vida-de-frenteworktree).

---

## 1. Princípios de Arquitetura Git (2026)

`[INDÚSTRIA]` A estratégia adota **Trunk-Based Development com Feature Branches Curtas** e **Stacked PRs**:

1. **Main é a fonte de verdade imutável**: Nenhum trabalho de alteração é realizado diretamente na branch principal (`main`/`master`).
2. **Branches de Vida Curta**: Branches duram poucas horas ou no máximo 1 a 2 dias. Branches longas geram *merge hell* e violam o princípio de integração contínua.
3. **Pequenos Lotes (≤ 400 linhas)**: PRs e integrações devem manter tamanho reduzido (`RGIT-13`). Mudanças maiores são fracionadas via Stacked PRs ou isoladas por Feature Flags.
4. **História Linear**: Integrações utilizam `rebase` em branches locais antes do merge e `squash` (ou rebase limpo) na unificação final para a `main`, garantindo um histórico limpo e auditável.

---

## 2. Conventional Commits (`RGIT-02`, `RGIT-10`)

`[CONSOLIDADO]` Todo commit deve seguir o formato:

```text
tipo(escopo): descrição concisa em minúsculas sem ponto final
```

### Tipos Permitidos (`RGIT-02`)
- **`feat`**: Nova funcionalidade para o usuário ou sistema.
- **`fix`**: Correção de bug / comportamento indesejado.
- **`refactor`**: Alteração de código que não altera comportamento nem adiciona funcionalidade.
- **`test`**: Adição ou correção de testes automatizados.
- **`docs`**: Mudança exclusiva em documentação.
- **`chore`**: Tarefas de manutenção, atualização de dependências, configs.
- **`perf`**: Mudança focada em melhoria de desempenho.
- **`build`**: Alterações em scripts de build ou dependências externas.
- **`ci`**: Mudanças em workflows de integração contínua ou automação de hooks.

### Regras de Qualidade
- **Assunto ≤ 100 caracteres**.
- **Explica o Porquê (`RGIT-10`)**: O diff já mostra o *o quê*. A mensagem deve indicar a motivação ou o impacto.
- **Commit por Task Concluída (`RGIT-03`)**: Nunca fazer um único commit massivo ao final da sessão.
- **Sem Autoria de Agente (`RGIT-01`)**: Proibido adicionar `Co-Authored-By: Claude` ou assinaturas de IA.

---

## 3. Conventional Branches (`RGIT-05`)

`[CONSOLIDADO]` O nome das branches deve espelhar estritamente os tipos autorizados do Conventional Commit (`RGIT-02`):

### Formato Obrigatório
```text
<tipo>/<slug-da-frente>
<tipo>/<NNN>-<slug-da-frente>   (quando associado a uma spec/issue)
```

### Exemplos Válidos
- `feat/001-autenticacao-jwt`
- `fix/calculo-desconto`
- `refactor/extracao-modulo-pagamento`
- `test/cobertura-usuario-service`
- `docs/atualiza-readme-instalacao`

### Restrições Absolutas 🔴
- **PROIBIDO o uso dos prefixos `spec/` ou `sdd/`** no nome da branch ou título (ex.: `spec/001-auth` é **inválido**; use `feat/001-auth`).
- **PROIBIDO branches sem prefixo de tipo** (ex.: `minha-branch` é **inválida**).

---

## 4. Worktrees por Frente de Trabalho (`RGIT-11`, `EXE-05`)

`[CONSOLIDADO]` O isolamento de arquivo via Git Worktree é dimensionado **por Frente de Trabalho** (Work Front):

- **Work Front (Frente de Trabalho)**: Uma unidade funcional de mudança (ex.: implementação da US1 de uma spec, refatoração de um submódulo) que dura horas ou dias e exige setup de ambiente.
- **Task**: Um passo executável dentro da frente. Múltiplas tasks da mesma frente **reusam o mesmo worktree**.
- **Investigação / Leitura**: Deve ser feita via subagentes na sessão principal ou worktree existente; leitura nunca justifica a criação de um worktree novo.

### Ciclo de Vida do Worktree (`ME-04`)
1. **Criação**: `claude --worktree feat/001-autenticacao` (cria `.claude/worktrees/feat-001-autenticacao/` no checkout da branch `feat/001-autenticacao`).
2. **Setup**: Carregar arquivos gitignorados via `.worktreeinclude` (`.env`), instalar dependências isoladas se necessário.
3. **Desenvolvimento & Commits**: Realizar commits por task (`RGIT-03`).
4. **Verificação & Auditoria**: Rodar testes automatizados e auditores independentes (`/sdd-converge`).
5. **Integração**: Rebase da branch contra a `main`, squash e merge.
6. **Destruição (`RGIT-14`)**: Remover o worktree (`git worktree remove`) e apagar a branch temporária (`git branch -d`).

---

## 5. Validação & Guardrails por Hooks (`RGIT-15`, `AD-02`)

`[CONSOLIDADO]` A conformidade com a Git Strategy é garantida por dois níveis de automação:

### 1. Git Hooks (`.git/hooks/`)
- **`commit-msg`**: Bloqueia commits cuja mensagem não siga Conventional Commits (`RGIT-02`) ou que contenham assinaturas de IA (`RGIT-01`).
- **`pre-commit`**: Impede o commit de segredos (`RSEC-01`), arquivos `.env` ou artefatos de build (`RGIT-08`).
- **`pre-push`**: Valida se o nome da branch segue a convenção (`RGIT-05`) e impede push direto na `main`.

### 2. Claude Code Hooks & Settings
- `"attribution": {"commit": "", "pr": ""}` no `settings.json` para desabilitar atrelamento autômato de autoria.
- Respeito integral aos scripts executados pela IDE / CLI agentic.

---

## 6. Links e Referências

- [worktrees.md](worktrees.md) — Detalhes operacionais e comandos de worktrees.
- [RULES.md §2 RGIT](RULES.md#2--git-e-commits-rgit) — As 15 regras oficiais de Git.
- [09-decisao-estados-algoritmos.md](09-decisao-estados-algoritmos.md) — Diagramas `AD-05` e `ME-04`.
