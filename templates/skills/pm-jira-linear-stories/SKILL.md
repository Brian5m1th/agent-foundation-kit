---
name: pm-jira-linear-stories
description: Product Management skill to decompose epics into granular, developer-ready Jira/Linear User Stories complete with Gherkin acceptance criteria, technical dependencies, story points, and definition of done.
---

# PM Jira & Linear User Story Decomposer Skill

> Purpose: Break down epics and complex feature specs into developer-ready Jira or Linear tickets with rigorous Gherkin acceptance criteria and technical context.

## Workflow

1. **Epic Slicing & Vertical Decomposition**:
   - Decompose high-level feature into small, independently deployable vertical slices (Tracer-bullet approach).
   - Ensure every story delivers end-to-end user value (avoid horizontal slicing like "DB only" or "Frontend only").

2. **User Story Formatting**:
   - Title: Short, action-oriented (`[Component] Action description`).
   - Body Structure:
     - **As a** [user role]
     - **I want to** [specific action]
     - **So that** [clear value/benefit]

3. **Gherkin Acceptance Criteria**:
   - Write executable criteria (`Given / When / Then`) covering:
     - Primary happy path.
     - Validation & error handling.
     - Edge cases & empty states.

4. **Technical & QA Context**:
   - Technical Notes: Impacted endpoints, DB tables, feature flags, telemetry events.
   - Design / Figma links & UI state requirements.
   - Story Point estimate recommendation (Fibonacci: 1, 2, 3, 5, 8).
   - Definition of Done (DoD) checklist.

5. **Jira / Linear Markdown Output**:
   - Format ready to copy-paste into Jira, Linear, or GitHub Issues.
