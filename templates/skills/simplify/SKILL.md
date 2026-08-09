---
name: simplify
description: Multi-agent code simplification and refactoring pipeline (Code Reuse, Quality & Readability, Complexity Reduction).
---

# Multi-Agent Code Simplification Skill (`/simplify`)

> Adapted from Anthropic Claude Code native `/simplify` & system prompts.
> Purpose: Review recently modified files (`git diff`) using 3 specialized sub-agents in parallel to refactor, simplify, and polish code without altering external behavior or breaking tests.

## Workflow Execution

When `/simplify` is invoked:
1. Inspect the recent `git diff` or uncommitted changes.
2. Launch 3 parallel sub-agents (or sequential review passes if single agent):

### Track 1: Code Reuse Agent
- Search for duplicated logic, inline helper functions, or copy-pasted structures across the diff and adjacent codebase.
- Extract common logic into modular, single-responsibility helper utilities.

### Track 2: Code Quality & Readability Agent
- Review variable, function, and parameter naming for clarity and domain alignment.
- Improve formatting, eliminate dead code, and ensure clear type annotations and comments.

### Track 3: Complexity Reduction Agent
- Flatten deeply nested `if/else` conditionals using guard clauses and early returns.
- Simplify over-engineered abstractions, redundant wrappers, and excessive indirect calls.

## Safeguards
- MUST run project unit tests / linter after applying simplifications.
- MUST NOT change public API contracts or external behavior without explicit authorization.
