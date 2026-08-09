---
name: code-review-bug-hunter
description: Comprehensive code review skill to detect logic bugs, edge cases, concurrency leaks, security flaws, and regression risks in code diffs and PRs.
---

# Code Review & Bug Hunter Skill

> Purpose: Perform a rigorous, multi-perspective code review on uncommitted changes, pull requests, or target files to detect latent bugs, edge cases, and security flaws before merge.

## Review Protocol

### 1. Dual-Axis Review
- **Axis A (Spec & Logic Conformance)**:
  - Does the implementation satisfy the exact requirements without over-engineering?
  - Are edge cases handled (null/undefined pointers, boundary values, empty arrays/strings)?
  - Are error paths and exceptions properly caught and logged without swallowing errors?
- **Axis B (Code Standards & Reliability)**:
  - **Async & Concurrency**: Are promises awaited? Are there race conditions or unhandled rejections?
  - **Memory & Resource Leaks**: Are event listeners, DB connections, or file handles properly closed?
  - **Security (OWASP)**: Are inputs sanitized? Are secrets exposed? Is authentication checked?
  - **Types & Interfaces**: Are type definitions exact without indiscriminate `any` usage?

### 2. Execution Steps
1. Inspect the `git diff` or target files using file viewing tools.
2. Run linters and typecheckers to establish a baseline of static analysis findings.
3. Analyze code paths for off-by-one errors, state mutation side-effects, and missing error handlers.
4. Output findings formatted by severity (**CRITICAL**, **MAJOR**, **MINOR**) with exact file and line references (`file:///path/to/file#L123`) and concrete refactoring suggestions.
