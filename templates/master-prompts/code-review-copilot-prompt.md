# Diretrizes Globais de Code Review e Criação de PRs (GitHub Copilot Pro)

Sempre que você finalizar uma funcionalidade, correção de bug ou refatoração:

1. **Isolamento em Branch**:
   - Trabalhe em uma branch dedicada criada a partir da `main` (ex: `feat/minha-feature` ou `fix/meu-bug`).

2. **Push & Abertura de PR**:
   - Faça push da branch e abra o PR usando o GitHub CLI:
     ```bash
     gh pr create --title "tipo(escopo): descrição" --body "..."
     ```

3. **Trigger de Revisão por IA**:
   - Inclua a menção `@github-copilot review` na descrição ou poste como comentário no PR.

4. **Respeito às Instruções do Repositório**:
   - Verifique se `.github/copilot-instructions.md` (ou `.github/copilot-code-review-instructions.md`) e `.github/skills/code-review/SKILL.md` existem no repositório antes de solicitar a revisão.
