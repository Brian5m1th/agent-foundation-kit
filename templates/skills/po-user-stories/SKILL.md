---
name: po-user-stories
description: Product Owner skill to convert feature descriptions into structured PRDs, User Stories with Gherkin acceptance criteria, and edge-case mapping.
---

# Product Owner (PO) User Story & Requirement Skill

> Purpose: Transform raw feature ideas into production-ready Product Requirement Documents (PRDs), User Stories, and Gherkin acceptance criteria (`Given/When/Then`).

## Workflow

1. **Context & Objective Breakdown**:
   - Define the persona/user role (*"As a [user type]..."*).
   - State the goal (*"I want to [action]..."*).
   - State the business value (*"So that [benefit]..."*).

2. **Gherkin Acceptance Criteria**:
   - Write clear `Given / When / Then` scenarios covering:
     - Happy path.
     - Negative/Error path (invalid inputs, network timeouts, auth failures).
     - Edge cases (boundary values, empty states, rate limits).

3. **Technical & UX Constraints**:
   - Highlight required APIs, security requirements, and UI/UX states (loading, error, empty, success).
   - List dependencies or blocking items.

4. **Output Format**:
   - Save structured specification to `specs/NNN-feature/spec.md` or present directly to the team.
