# Prompt Mestre para Inicialização de Novos Projetos

<!--
═══════════════════════════════════════════════════════════════════════════════
TEMPLATE — Prompt Mestre de Inicialização de Governança, SDD & Jira First
Fonte: labs/kb/  ·  Instruções de uso em labs/templates/README.md
═══════════════════════════════════════════════════════════════════════════════

PAPEL DESTE TEMPLATE:
  Este é o prompt mestre para copiar e colar ao abrir o primeiro contato do agente
  com um novo repositório ou projeto alvo. Ele instrui o agente a analisar a stack,
  configurar a governança (CLAUDE.md e AGENTS.md), formalizar o pipeline SDD,
  integrar a skill jira-sync, inicializar a memória em .spec/ e criar o script
  de aferição empírica.

INSTRUÇÕES DE USO:
  1. Copie o bloco Markdown abaixo.
  2. Substitua os placeholders do Jira (<SUBSTITUA: ex: ...>) com os dados reais do projeto.
  3. Cole na primeira mensagem do agente no projeto alvo.
-->

```markdown
primeiro contato nesse repo.
Inicialize o repositório configurando os arquivos de governança, o pipeline SDD e a integração Jira First.

### 📌 Coordenadas do Jira deste Projeto Alvo:
- Site Jira: <SUBSTITUA: ex: wwmatech.atlassian.net>
- URL do Board: <SUBSTITUA: ex: https://wwmatech.atlassian.net/jira/software/projects/PROJ/boards/1>
- Chave do Projeto Jira: <SUBSTITUA: ex: PROJ>
- cloudId: <SUBSTITUA_SE_SOUBER_OU_DEIXE_O_AGENTE_DESCOBRIR>

---

## 🎯 Instruções de Execução Obrigatórias

### 1. Análise do Ambiente e da Stack do Projeto
1. Explore a estrutura do projeto (`README.md`, dependências, arquivos de configuração, código-fonte de backend/frontend/mobile).
2. Identifique as tecnologias utilizadas, arquitetura por bounded contexts, comandos de execução (`build`, `dev`, `test`), e peculiaridades do ambiente/toolchain.
3. Se o repositório estiver vazio, configure a estrutura inicial e uma suíte mínima de verificação.

---

### 2. Governança do Repositório (`CLAUDE.md`, `.agents/AGENTS.md` e `AGENTS.md`)
Crie e/ou atualize os arquivos de instrução de governança no projeto com base nos padrões do repositório `C:\workspace\labs`:
1. **`CLAUDE.md`** (na raiz):
   - Visão geral do projeto e stack.
   - Comandos de execução do servidor, app, compilação e testes.
   - O pipeline SDD exato com o diagrama ASCII e regras abaixo.
   - A integração com o Jira (`<PROJ>`).
   - Convenções de código, segurança (`RSEC`), testes (`RTEST`) e Git hygiene.
2. **`.agents/AGENTS.md`** e **`AGENTS.md`** (na raiz):
   - Diretrizes e 23 regras globais da empresa WWMA-Tech adaptadas à stack deste repositório.
   - Padrões de Domínio Rico (P1-P6: construtores de domínio, métodos ricos na entidade, validação de domínio sem Bean Validation nas entidades, exceções de negócio, etc.).
   - Padrões derivados de auditoria (P_Novo4 a P_Novo23).
   - Seção 5.1 **Jira First & `jira-sync`**: O Jira é o único backlog operacional dinâmico.
   - Seção 5.2 **Resumibilidade de Migração**: O mapa `.spec/jira/mapa.tsv` como checkpoint versionado.

---

### 3. Pipeline SDD + Worktree + Grill-Me + Sequential Thinking
Formalize e siga estritamente o pipeline de desenvolvimento abaixo:

```text
EnterWorktree ──> /grill-me ──> spec-new ──> spec-review ──> spec-plan ──> spec-tasks
                                                                                  │
   ExitWorktree <── PR <── /spec-converge (sessão limpa) <── Implementação <──────┘
```

**Regras Invioláveis do Pipeline:**
1. **Isolamento via Git Worktree (`EnterWorktree` / `ExitWorktree`)**: Toda sessão roda em um worktree dedicado em `.claude/worktrees/<branch>` aberto via `EnterWorktree` no início e fechado via `ExitWorktree` após o merge.
2. **Entrevista `/grill-me` Obrigatória**: Na criação de qualquer especificação (`spec-new`), rode a skill `grill-me` para interrogar a proposta antes de escrever o documento.
3. **Uso Obrigatório de `sequential-thinking`**: A partir da fase de intenção (`spec-new`) em conjunto com o `/grill-me`, ative e utilize a ferramenta `sequentialthinking` para raciocinar de forma sequencial antes do planejamento (`spec-plan`), tarefas (`spec-tasks`) e implementação.
4. **Sub-documentação SDD Sequencial**: `spec-new` (o quê/por quê) ──> `spec-review` (validação humana) ──> `spec-plan` (como/arquitetura) ──> `spec-tasks` (decomposição por história).
5. **Commit por Task Concluída**: Commits incrementais por funcionalidade concluída, em formato Conventional Commits (`tipo(escopo): descrição`).
6. **Zero Rastro de IA**: Proibido `Co-Authored-By` de agente, emojis de IA ou menções à geração por IA em commits, PRs ou comentários. Autor e committer são sempre o usuário git local.
7. **Stage Explícito**: `git add` por caminho explícito (nunca `git add .` ou `git add -A`).
8. **Gate de Convergência (`/spec-converge`)**: Auditoria em sessão limpa (`/clear`) antes do PR. `CANNOT_PROCEED` impede abertura de PR.

---

### 4. Criação e Adaptação da Skill `jira-sync`
Crie os arquivos `.agents/skills/jira-sync/SKILL.md` e `.claude/skills/jira-sync/SKILL.md` adaptados ao projeto `<PROJ>` no Jira (`<SITE>`):
- **Regra Zero (Jira First)**: O backlog operacional vive no Jira (`<PROJ>`). Os arquivos `.md` são apenas snapshots datados.
- **Coordenadas**: Registrar site, board URL, cloudId (descobrindo automaticamente via MCP `getAccessibleAtlassianResources` se não informado), projeto (`<PROJ>`), tipos (`Epic`, `Task`, `Bug`, `Story`, `Subtask`), statuses (`To Do`, `In Progress`, `In Review`, `Done`) e transições (`11` → To Do, `21` → In Progress, `31` → In Review, `41` → Done).
- **Cascata em 4 Degraus (JQL)**: Deduplicação por **substantivos do domínio** (descartando palavras genéricas como `bug`, `erro`, `corrigir`, `ajuste`).
- **Ciclo de Vida Automático do Status**:
  - Descoberta / Catalogação: Cria issue no Jira (`createJiraIssue` no projeto `<PROJ>`). Status **`Done`** para históricos/entregues ou `To Do` para novos pendentes. Registra a correspondência em `.spec/jira/mapa.tsv`.
  - Início da Execução: Altera status no Jira para **`In Progress`** (Transição `21`).
  - PR & Review: Insere o link direto da issue (`https://<SITE>/browse/<PROJ>-XXX`) no corpo da descrição do PR e altera status no Jira para **`In Review`** (Transição `31`).
  - Merge Concluído: Altera status no Jira para **`Done`** (Transição `41`).
- **Mapa Versionado**: Inicialize `.spec/jira/mapa.tsv` com o cabeçalho tab-separated:
  `id_origem	tipo	chave_jira	epico	onda	criado_em	caminho_origem`

---

### 5. Inicialização da Memória `.spec/`
Crie a estrutura `.spec/` do projeto:
- `.spec/CENTRAL-BACKLOG.md`: Estado atual aferido com comando, data e números de testes reais.
- `.spec/memory/architecture.md`: Visão de componentes, diagramas e fluxos de domínio.
- `.spec/memory/conventions.md`: Convenções de código, idioma, tratamento de erros RFC 7807 e padrões da stack.
- `.spec/memory/patterns.md`: Invariantes inderrubáveis de negócio e padrões derivados de auditoria.
- Subdiretórios: `.spec/discovery/`, `.spec/changes/`, `.spec/archive/`, `.spec/templates/`.

---

### 6. Script de Aferição e Validação Empírica
1. Crie um script de verificação do harness em `scripts/aferir-estado.ps1` (e `scripts/aferir-estado.sh` se cross-platform) que execute a checagem de sintaxe e as suítes de teste do projeto.
2. Execute o script de aferição, garanta que 100% dos testes/checagens passaram, e apresente um resumo final dos arquivos criados e aferições realizadas.
```
