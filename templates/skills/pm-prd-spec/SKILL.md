---
name: pm-prd-spec
description: Product Management skill to generate comprehensive PRDs (Product Requirement Documents), RFCs, and functional specifications with problem statements, success metrics, user flows, functional/non-functional requirements, and risk matrices.
---

# PM PRD & Specification Skill

> Purpose: Generate production-grade Product Requirement Documents (PRDs), RFCs, and functional specs that bridge product vision and engineering execution.

## Workflow

1. **Problem Statement & Business Justification**:
   - Clarify the core user pain point and market opportunity.
   - Document business goals, target metrics (e.g., conversion, retention, revenue impact), and non-goals (explicit scope boundaries).

2. **Target Persona & Jobs-to-be-Done (JTBD)**:
   - Identify primary and secondary personas (*"As a [Persona]..."*).
   - Define the main Job-to-be-Done (*"When [Situation], I want to [Motivation], so I can [Outcome]"*).

3. **Functional & Non-Functional Requirements**:
   - **Functional**: System capabilities, user interactions, business rules, edge-case handling.
   - **Non-Functional**: Performance SLA (latency, throughput), security/compliance (LGPD/GDPR, RBAC), scalability, accessibility (WCAG 2.2 AA).

4. **User Flows & UI/UX States**:
   - Map out primary user journey (Happy Path) and alternative flows.
   - Define UI states: Default, Loading, Empty, Partial, Error, Success.

5. **Risk Matrix & Mitigations**:
   - Risk assessment across 4 dimensions: Value, Usability, Feasibility, Business Viability (Cagan Framework).
   - Actionable mitigation plan for each high-severity risk.

6. **Output Format**:
   - Produce a structured markdown file (`PRD.md` or `specs/NNN-feature/spec.md`) ready for engineering review and RFC discussion.
