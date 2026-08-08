---
name: grill-me
description: Relentless 8-rule interview workflow to align plans, specs, and design decisions before implementation.
---

# Grill-Me Skill (`INT-08`)

> Adapted from `mattpocock/skills`.
> Purpose: Eliminate alignment bugs and ambiguous requirements through a disciplined, one-question-at-a-time interview.

## The 8 Rules of Grilling

1. **Relentless Alignment**: Interview until shared understanding of the goal, constraints, and edge cases is achieved.
2. **Top-Down Decision Tree**: Resolve root dependencies before leaf implementation details.
3. **Always Include Recommendation**: Every question posed to the human MUST include the agent's recommended answer and rationale.
4. **One Question at a Time**: Ask exactly one focused question per turn to prevent cognitive overload.
5. **Separation of Fact vs. Decision**: Discover facts via tool calls (grep/code search); ask the human ONLY for decisions.
6. **No Action Before Confirmation**: Never write production code until alignment is confirmed.
7. **Documented Output**: Record agreed design choices directly into `spec.md` or architectural premises.
8. **Explicit Completion**: Stop grilling only when all open questions are resolved.
