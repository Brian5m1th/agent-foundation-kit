---
name: qa-test-plan
description: Quality Assurance (QA) skill for test plan generation, boundary testing matrices, and E2E automation scaffolding (Playwright/Cypress).
---

# Quality Assurance (QA) Test Plan & E2E Skill

> Purpose: Generate end-to-end test plans, test matrices, and automated test scripts for feature releases.

## Workflow

1. **Test Matrix Generation**:
   - **Functional Tests**: Positive scenarios, negative inputs, boundary conditions.
   - **Integration Tests**: API contracts, database persistence, external service failures.
   - **E2E UI Tests**: User flows, cross-browser interactions, responsive layouts.
   - **Accessibility & UX**: WCAG 2.2 AA compliance (screen readers, keyboard focus, color contrast).

2. **Automated Scaffolding**:
   - Generate executable E2E test suites (e.g., Playwright / Cypress / Vitest).
   - Use clean Page Object Models (POM) or fixture-based abstractions.
   - Ensure tests are deterministic, fast, and free of artificial delays/sleeps.

3. **Defect Verification**:
   - Provide step-by-step reproduction steps for any discovered failure.
   - Re-run test suite after fixes to confirm zero regressions.
