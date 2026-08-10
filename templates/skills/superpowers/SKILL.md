---
name: superpowers
description: Senior software engineering framework (Socratic alignment, TDD-first, dependency-aware planning, root-cause debugging).
---

# Superpowers Engineering Skill

> Adapted from `obra/superpowers`.
> Purpose: Enforce senior engineering discipline on AI agent workflows to eliminate "vibe coding" bugs and structural decay.

## Core Rules

1. **Socratic Requirement Alignment**:
   - Ask clarifying questions about assumptions, edge cases, and constraints before touching code.
   - Present recommended options for every design choice.

2. **Test-Driven Development (TDD)**:
   - RED: Write a failing unit/integration test capturing the expected behavior or reported bug FIRST.
   - GREEN: Implement the minimal code required to pass the test.
   - REFACTOR: Clean and optimize the implementation while keeping tests passing.

3. **Incremental Execution & Verification**:
   - Work in small, isolated, testable slices.
   - Never declare a task complete without running empirical build and test verification commands.

4. **Root-Cause Debugging**:
   - Never apply superficial patches or mask errors.
   - Investigate root causes using empirical logs, tracebacks, and deterministic reproductions.
