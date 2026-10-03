# Team topologies

Choose by information flow and ownership, not by role-play aesthetics.

## Manager with specialists

The orchestrator retains control and calls specialists for bounded outputs. Use when one agent must
own integration, shared guardrails, or the final answer. Specialists return artifacts; they do not
take over the user conversation.

## Handoff or routed specialists

A triage agent transfers control to one specialist. Use when exactly one domain owner should handle
the next phase directly. Require a typed handoff payload, a reason, an explicit destination, and a
return/escalation path. It is a poor fit when several specialist results must be synthesized.

## Parallel map-reduce

Independent workers inspect disjoint questions or alternatives; an integrator deduplicates,
reconciles, and checks the combined result. Use only when branches do not depend on each other's
intermediate state. Define shard boundaries and a common return schema before dispatch.

## Pipeline

Each role transforms a typed artifact for the next role. Use when ordering is real: research to
specification to implementation to verification. Every boundary declares input schema, output
schema, compatibility rule, and rejection path. Do not hide feedback dependencies in a one-way
pipeline; use a loop when downstream evidence changes upstream work.

## Maker-checker

One role produces and another evaluates against a frozen rubric or deterministic verifier. Use for
high-impact work, subjective quality, or any case where self-evaluation is predictably lenient. The
checker must receive the artifact, criteria, and raw evidence without the maker's conclusions.

## Shared-board workers

Workers claim tasks from a durable board and publish status/evidence. Use for many independent,
homogeneous items. Claims need atomic ownership, leases or stale-lock recovery, and idempotent task
identifiers. Shared filesystem access alone is not coordination.

## Hybrid hierarchy

A manager operates small subteams, each with local ownership. Use only when the task exceeds a flat
team's coordination capacity. Set a maximum depth, aggregate child cost into the parent budget, and
forbid delegation cycles.

## Selection checks

- Prefer one agent when coordination cost exceeds specialization or parallelism benefit.
- Prefer deterministic routing when categories and dependencies are known.
- Prefer model-selected routing only when the choice requires semantic judgment; constrain the
  candidate set and validate the selected contract.
- Prefer isolated contexts for noisy research and independent evaluation.
- Prefer isolated worktrees or serialized writes for overlapping code surfaces.
- Add a role only if removing it would eliminate a distinct output, check, or capability.
