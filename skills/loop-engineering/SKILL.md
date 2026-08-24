---
name: loop-engineering
description: Design, audit, run, or improve bounded agent loops whose feedback changes the next action. Use for recurring or iterative agent work that needs an explicit trigger, verifiable goal, stopping states, durable memory, and guardrails. Do not use for a one-shot task or a fixed scheduled prompt whose result does not affect the next run.
---

# Loop Engineering

Treat a loop as an external, versioned specification that operates an agent harness. It is distinct
from a programming loop and from the harness's internal perceive-act-observe cycle.

## Route the request

- To create, adapt, or audit a loop specification, read
  [references/design.md](references/design.md).
- To execute or resume an accepted loop, read [references/run.md](references/run.md).
- To improve the harness itself from execution traces, read
  [references/self-harness.md](references/self-harness.md). This mode is experimental and requires a
  fixed evaluator plus held-out regression cases.

If the project has an active SDD spec, keep the loop beside it as `specs/<id>/loop.md`. The loop wraps
approved tasks; it never invents requirements or overrides the constitution, spec, plan, task
envelope, or ordinary authorization boundaries.

## Invariants

1. Triage first: if feedback from one turn does not change the next action, return a one-shot or
   scheduled prompt instead of manufacturing a loop.
2. Define the check before the execution prompt. Label its real verification level; never present a
   model judgment as a deterministic check.
3. Name terminal states. `success`, `no-op`, `blocked`, `stalled`, `exhausted`, and `error` are
   different outcomes; an error or spent budget is never success.
4. Persist compact, curated state outside conversation history. Record evidence, decisions, attempts,
   accepted changes, and the next candidate action; do not append raw transcripts indefinitely.
5. Bound turns, cost, nested loops, tools, files, and consequential actions. A saved prompt or loop
   document grants no new permission.
6. Prefer one focused, reversible change per turn and retain it only when the declared check passes
   without regression.
7. Separate maker and checker whenever verification depends on model judgment. Use fresh context and
   a frozen rubric for the checker.
8. Report the final terminal state and evidence. Do not silently stop.

## Health signal

Track `cost per accepted change = total loop cost / changes that survived verification`. Also record
turns without measurable progress. A busy loop with no accepted change is unhealthy.
