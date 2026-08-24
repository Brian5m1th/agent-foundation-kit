---
name: diagnosing-bugs
description: 6-step empirical bug diagnosis workflow (repro, minimization, hypothesis ranking, instrumentation, fix verification).
---

# Empirical Bug Diagnosis Skill (`VER-06`)

> Adapted from `mattpocock/skills`.
> Purpose: Systematic 6-step workflow for root-cause bug isolation and resolution without guessing.

## 6-Step Workflow

1. **Build Deterministic Repro Loop**:
   - Create a fast (seconds), reproducible test, CLI fixture, or script that consistently fails with the reported bug.
2. **Reproduce & Minimize**:
   - Strip away unrelated code/config until every remaining element is portante to the failure.
3. **Rank Hypotheses**:
   - Formulate 3-5 falsifiable hypotheses (*"If X is the root cause, then changing Y fixes it"*), ranked by probability.
4. **Targeted Instrumentation**:
   - Instrument code with specific logs or debugger hooks mapped to predictions. Change ONE variable at a time.
5. **Implement Fix at Correct Seam**:
   - Write a regression test BEFORE applying the fix. Apply the minimal fix at the appropriate seam.
6. **Clean Up & Post-Mortem**:
   - Remove all debug logs (`[DEBUG-...]`), verify repro passes green, and record the root cause in the commit message.
