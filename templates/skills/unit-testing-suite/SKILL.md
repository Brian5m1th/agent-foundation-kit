---
name: unit-testing-suite
description: Comprehensive unit testing skill covering AAA pattern (Arrange-Act-Assert), mocking, boundary conditions, edge cases, and high coverage across frameworks (Jest, Vitest, PyTest, Go).
---

# Unit Testing Suite Skill

> Purpose: Generate, execute, and maintain high-quality, fast, deterministic unit tests following software engineering best practices.

## Core Rules & Strategy

1. **AAA Pattern (Arrange-Act-Assert)**:
   - **Arrange**: Set up test fixtures, input parameters, and mocks cleanly.
   - **Act**: Execute the single target function or method under test.
   - **Assert**: Verify output, state mutations, and mock calls explicitly.

2. **Test Independence & Determinism**:
   - Each unit test MUST run in total isolation. Zero global state leak between tests.
   - NO network calls, NO real DB queries, NO filesystem side-effects in unit tests (use mocks/stubs).
   - Avoid non-deterministic values (e.g., `Math.random()`, `Date.now()`) unless explicitly seeded or mocked.

3. **Coverage Targets & Boundary Mapping**:
   - **Happy Path**: Test standard expected inputs.
   - **Boundary Conditions**: Min/max values, empty arrays/strings, 0/null/undefined.
   - **Error Handling**: Verify exceptions are thrown with exact error messages/types.

4. **Framework Idioms**:
   - TypeScript/JS: `vitest` / `jest` with `describe`/`it` blocks.
   - Python: `pytest` with fixtures and `@pytest.mark.parametrize`.
   - Go: `testing` package with table-driven tests (`struct{ name string; input X; want Y }`).
