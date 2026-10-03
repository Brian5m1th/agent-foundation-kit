---
name: agent-team-loop
description: Execute or resume a complex task with a bounded team of agents in evidence-driven maker-checker cycles until every required acceptance criterion passes or a truthful blocked, stalled, exhausted, or error state is reached. Use when the user explicitly asks for an agent team, repeated agent rounds, or work to continue until verified completion; do not use for ordinary one-shot delegation.
---

# Agent Team Loop

Run the team until a terminal state, not until an agent says it is done. This skill authorizes team
coordination only within the user's existing task and permissions; it grants no new external,
destructive, production, financial, credential, privacy, or security authority.

Before execution, read [the team-design skill](../agent-team/SKILL.md),
[its Boundary Contract schema](../agent-team/references/contracts-and-prompts.md), and
[the loop run rules](../loop-engineering/references/run.md). For a new loop design, also read
[the loop design rules](../loop-engineering/references/design.md).

## Preflight

1. Compile the request, repository rules, active spec, and existing tests into a draft acceptance
   matrix before the first worker starts. Ask for any unresolved choice whose reversal cost is high
   before freezing affected criteria; cheap reversible assumptions are recorded. A future approval
   gate blocks only the first action that needs it, not earlier reversible work. Map every outcome
   explicitly requested by the user to a required acceptance row; an orchestrator may not downgrade
   production, delivery, cleanup, or another requested result to an optional gate.
2. Capture a comparable baseline and protected regression set. Freeze the checks for the run. For
   security-, privacy-, money-, authentication-, migration-, or production-sensitive outcomes,
   assign independently owned negative/abuse and recovery checks; rerunning maker-authored tests
   alone is insufficient.
3. Select the smallest useful team. Default to orchestrator, one or more disjoint makers, and one
   independent checker. Add an integrator only when outputs must be reconciled.
4. Create a Boundary Contract for every dispatched task. Declare exclusive write ownership and use
   isolated worktrees for parallel code edits that could overlap. Shared workers must never edit the
   same surface concurrently.
5. Create or resume a compact durable ledger using
   [references/runbook.md](references/runbook.md). Reconcile it with fresh repository evidence; fresh
   evidence wins.
6. Declare numeric hard bounds before mutation. Use user-supplied limits when present; otherwise
   default to 8 team rounds, 2 consecutive no-progress rounds, at most 3 parallel workers or the
   lower host limit, 1 attempt per worker contract per round, and no recursive team below one child
   level. Unless the user or host supplies a lower ceiling, each worker contract defaults to 30
   minutes and 40 tool calls; add a numeric token ceiling when the runtime exposes reliable usage.
   If no finite execution bound can be enforced, stop `blocked`. Reaching a bound is `exhausted`, not
   success.

## One team round

1. Read the acceptance ledger and current evidence. Select only failed or unevaluated acceptance IDs.
2. Partition work by real independence and issue disjoint Boundary Contracts. Parallelize independent
   research or edits; serialize dependencies and overlapping write surfaces. Each worker contract is
   one focused child turn; the team round is their bounded fan-out, integration turns, and one
   verification turn.
3. Dispatch workers. Require their return envelopes and continue useful local orchestration while
   they run. A worker's `completed` status means ready for integration, not globally accepted.
4. Validate return envelopes and reject out-of-contract changes. Integrate one contract at a time as
   a recoverable commit/artifact version, verify it, and retain accepted subsets instead of treating a
   multi-worker merge as one all-or-nothing blob. Never blindly restore state after a migration or
   external effect; use its approved recovery/forward-fix contract.
5. Quiesce writers and pin the integrated commit, digest, or immutable artifact version. Run
   deterministic target checks and the protected regression set against that exact version. Preserve
   raw results and bind them to the version.
6. Give that pinned artifact, frozen criteria, independent hold-outs, and raw evidence to a
   fresh-context checker that did not make the change. The checker returns PASS/FAIL per acceptance ID
   and the smallest repair for each FAIL.
7. Accept only verified changes. Update the ledger with evidence, accepted/rejected decisions, cost,
   blockers, and the next highest-value failed criterion.
8. Evaluate terminal states in this order: `error`, `blocked`, `success`, `no-op`, `stalled`,
   `exhausted`, otherwise begin the next round.

## Continuation policy

- Continue after ordinary test failures: feed exact failures into the next maker contract.
- Re-plan the team when two workers duplicate work, a dependency graph changes, or integration cost
  exceeds parallel benefit. Do not preserve a bad topology for consistency.
- On human or policy denial, return `blocked` for that action immediately. On a transient technical
  denial, retry only within its explicit retry policy; a safer route must have smaller authority or
  blast radius, not merely different syntax. Repeated equivalent denial never earns another route.
- `stalled` means the configured no-progress window elapsed with no newly accepted criterion,
  repeated oscillation, or repeated equivalent failures. Do not spend the remaining budget replaying
  an unchanged attempt.
- If the execution host supports durable continuation, checkpoint on context or run boundaries and
  resume from the ledger within the declared budget. Exhausted work needs a newly authorized budget;
  never reset a limit silently. Never use raw conversation history as the only memory.

## Completion contract

`success` requires all required acceptance IDs to pass, protected regressions to pass, final
artifacts to exist, and the independent checker to cite the evidence. No unresolved blocking
ambiguity or approval may remain. Human review remains required where the acceptance matrix labels a
human checkpoint. If any required criterion depends on model or human judgment, label the run
`ASSISTED_ONLY`; it becomes success only after every declared human checkpoint passes. Model-only
security approval cannot produce global success.

For production work, field acceptance must bind the authoritative target, immutable release ID,
approved credential channel, real post-deploy behavior, health/regression evidence, and declared
observation window. A successful deploy command alone is not acceptance.

Finish with the run receipt in [references/runbook.md](references/runbook.md). For every non-success
state, preserve the work and report the smallest condition that would allow continuation.
