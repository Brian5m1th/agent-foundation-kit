---
name: qc-quality-gate
description: Quality Control (QC) skill to audit code diffs against quality gates (linter, static analysis, coverage, security, architecture).
---

# Quality Control (QC) Quality Gate Skill

> Purpose: Automated quality gate inspection before code merge to enforce zero regressions, clean architecture, and strict static analysis.

## Verification Checklist

1. **Static Analysis & Type Integrity**:
   - Run typechecker (e.g., `tsc`, `mypy`, `go vet`). ZERO errors allowed.
   - Run linter (e.g., `eslint`, `ruff`). ZERO warnings/errors allowed.

2. **Test Coverage & Regression Check**:
   - Verify all unit and integration tests pass green.
   - Check test coverage thresholds on newly added or modified lines.

3. **Architecture & Seam Audit**:
   - Ensure clean separation of concerns (no UI logic inside domain models, no direct DB queries in UI components).
   - Verify no hardcoded secrets, plain-text credentials, or unchecked input sanitization.

4. **Verdict Reporting**:
   - Output clear pass/fail status with explicit file and line references for any violation.
