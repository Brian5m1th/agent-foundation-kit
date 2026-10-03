# Agent team loop runbook

## Durable ledger

Use the active spec directory when one exists: `specs/<id>/team-loop-state.md`. Otherwise follow the
repository's agent-state convention; if none exists, use `.agent/team-loop/<task-slug>.md`.

```markdown
---
team_id: <id>
round: 0
max_rounds: 8
stall_window: 2
status: continue
verification_mode: <unattended | assisted-only>
artifact_versions: {}
---

# Outcome
<observable user outcome>

# Acceptance ledger
| ID | Criterion | Verifier | State | Evidence | Owner |
|---|---|---|---|---|---|
| AC-01 | ... | ... | unevaluated | — | checker |

Row states: `unevaluated | pass | fail | blocked`.

# Protected regressions
- <check and latest result>

# Ownership
- <agent/task>: <exclusive surfaces>

# Accepted decisions
- <decision with evidence>

# Attempts
- R1/<task-id>: <accepted or rejected, evidence, cost>

# Blockers and approvals
- <blocker or none>

# Next action
<highest-value failed criterion and candidate repair>
```

Update the ledger after integration and verification, not from unverified worker claims. Keep it
compact; replace stale next actions and summarize rejected attempts by mechanism.

## Kickoff prompt

```text
Use $agent-team-loop to complete this task with an agent team: <request>.

Required outcome: <observable outcome>
Acceptance evidence: <known checks or ask the skill to derive them>
Allowed scope: <files, systems, accounts, tools>
Approval gates: <consequential actions requiring me>
Credential channel: <approved secret manager/identity, never secret values>
Budget overrides: <rounds, agents, attempts, time, calls/tokens or cost; omit for finite defaults>

Continue through maker-checker rounds until every required criterion is independently verified.
Return success only with evidence. Otherwise return the precise blocked, stalled, exhausted, or error
state and preserve a resumable ledger.
```

## Round planner prompt

```text
Read the frozen acceptance matrix, durable ledger, current repository state, and raw verifier output.
Select the highest-value failed or unevaluated criteria. Produce disjoint Boundary Contracts whose
combined scope addresses only those criteria. Respect dependencies and exclusive write ownership.
Use parallel workers only for independent tasks. Do not modify acceptance criteria or infer new
authority. Return the contracts, dependency order, and expected evidence.
```

## Repair prompt

```text
Repair only <failed acceptance IDs>. The previous attempt failed with this raw evidence: <evidence>.
Use the attached Boundary Contract and checker feedback. Change the causal mechanism, not merely the
symptom or output wording. Preserve all passing acceptance IDs and regression checks. Return a worker
envelope with new raw evidence; do not declare global success.
```

## Run receipt

```text
terminal_state: <success | no-op | blocked | stalled | exhausted | error>
round: <n>/<max>
acceptance: <passed>/<required>
accepted_changes: <summary or none>
failed_or_unevaluated: <IDs or none>
target_evidence: <commands/results/artifacts>
regression_evidence: <commands/results/artifacts>
checker: <agent/context and verdict reference>
artifact_versions: <environment/phase to commit, schema head, digest or immutable ID>
verification_mode: <unattended | assisted-only>
ledger: <path>
cost: <agents, turns, time, tokens or money available>
approval_needed: <specific action or none>
next_action: <smallest continuation action or none>
```

`no-op` is valid only when fresh evidence proves the outcome already held and no change was needed.
`error`, `blocked`, `stalled`, and `exhausted` are distinct non-success states.
