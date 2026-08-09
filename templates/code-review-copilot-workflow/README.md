# 📦 Pacote Template: Code Review & GitHub Copilot Pro Workflow

> **Selo Epistêmico:** `[CONSOLIDADO]`  
> **Propósito:** Oferecer um workflow padronizado e automatizável de criação de PRs, revisão de código e integração com **GitHub Copilot Pro Code Review** para repositórios do ecossistema.

---

## 📂 Estrutura do Pacote

```text
templates/code-review-copilot-workflow/
├── README.md                                    # Guia e documentação deste pacote
└── copilot-code-review-instructions.template.md # Template de diretrizes (.github/copilot-instructions.md)

Arquivos relacionados no repositório upstream:
templates/master-prompts/
└── code-review-copilot-prompt.md            # System Prompt / Custom Instruction para o Agente
templates/skills/code-review/
└── SKILL.md                                 # Skill de Code Review & Bug Hunter (.github/skills/code-review/SKILL.md)
```

---

## 1. 🤖 Prompt do Agente (System Prompt / Custom Instruction)

Local de origem: [`templates/master-prompts/code-review-copilot-prompt.md`](../master-prompts/code-review-copilot-prompt.md)

```markdown
# Diretrizes Globais de Code Review e Criação de PRs (GitHub Copilot Pro)
Sempre que você finalizar uma funcionalidade, correção de bug ou refatoração:
1. **Isolamento em Branch**:
   - Trabalhe em uma branch dedicada criada a partir da `main` (ex: `feat/minha-feature` ou `fix/meu-bug`).
2. **Push & Abertura de PR**:
   - Faça push da branch e abra o PR usando o GitHub CLI:
     `gh pr create --title "tipo(escopo): descrição" --body "..."`
3. **Trigger de Revisão por IA**:
   - Inclua a menção `@github-copilot review` na descrição ou poste como comentário no PR.
4. **Respeito às Instruções do Repositório**:
   - Verifique se `.github/copilot-instructions.md` (ou `.github/copilot-code-review-instructions.md`) e `.github/skills/code-review/SKILL.md` existem no repositório antes de solicitar a revisão.
```

---

## 2. ⚡ Skill de Code Review (`.github/skills/code-review/SKILL.md`)

Local de origem: [`templates/skills/code-review/SKILL.md`](../skills/code-review/SKILL.md)

---

## 3. 🎯 Instruções do Copilot (`.github/copilot-instructions.md`)

Local de origem: [`copilot-code-review-instructions.template.md`](copilot-code-review-instructions.template.md)

---

## 🚀 Como instalar em um novo projeto

Para instalar o pacote completo de Code Review e GitHub Copilot Pro em um projeto alvo (ex: `C:\workspace\meu-projeto`):

```powershell
$target = "C:\workspace\meu-projeto"

# 1. Criar diretórios no projeto alvo
New-Item -ItemType Directory -Force -Path "$target\.github\skills\code-review"

# 2. Copiar as Instruções do Copilot Code Review (salvar como arquivo canônico .github/copilot-instructions.md)
Copy-Item "C:\workspace\labs\templates\code-review-copilot-workflow\copilot-code-review-instructions.template.md" "$target\.github\copilot-instructions.md"

# 3. Copiar a Skill de Code Review
Copy-Item "C:\workspace\labs\templates\skills\code-review\SKILL.md" "$target\.github\skills\code-review\SKILL.md"

# 4. Adicionar o Prompt do Agente ao AGENTS.md / CLAUDE.md do projeto
Get-Content "C:\workspace\labs\templates\master-prompts\code-review-copilot-prompt.md" | Add-Content "$target\AGENTS.md"
```
