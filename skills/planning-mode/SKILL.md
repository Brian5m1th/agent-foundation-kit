---
name: planning-mode
description: Force the agent into Planning Mode. Use when designing complex changes, architectural refactors, or multi-file features before making any code edits.
---

# Planning Mode Skill

When activated, you MUST enter **Planning Mode** and follow these strict rules:

## 1. Zero Code Modifications Phase
* **DO NOT** edit, create, or delete any source code files during this phase.
* **DO NOT** run any code modification commands or commits.
* Conduct all research using read-only tools (`view_file`, `grep_search`, `list_dir`, `read_url_content`, etc.).
* Activate and use the `sequential-thinking` tool to analyze dependencies, architectural impact, and edge cases.

## 2. Produce Implementation Plan
* Create or update the `implementation_plan.md` artifact (or `specs/NNN-slug/plan.md` if inside the SDD workflow).
* Structure the plan with:
  - **Goal Description**: Overview of the task and background context.
  - **User Review Required**: Critical design choices or potential breaking changes.
  - **Open Questions**: Clarifications needed from the user.
  - **Proposed Changes**: Detailed breakdown of files to modify, create, or delete (`[MODIFY]`, `[NEW]`, `[DELETE]`).
  - **Verification Plan**: Commands and tests to run after implementation.

## 3. Wait for User Approval
* Present the plan clearly and **STOP**.
* **DO NOT** proceed to execution until the user gives explicit approval.
