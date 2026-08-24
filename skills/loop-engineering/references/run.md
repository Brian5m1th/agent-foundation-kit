# Running a loop specification

Run a loop only when the user asked to execute it or an already-authorized automation invoked it.
Designing or saving a loop does not authorize its effects.

## Preflight

1. Read the loop specification, durable state, governing project instructions, and relevant task.
2. Confirm the verifier is runnable and the baseline is comparable.
3. Confirm remaining turn/cost budget and the action envelope.
4. If the state conflicts with the repository, the repository and fresh evidence win; record the
   reconciliation.
5. Stop `blocked` before any missing approval or unavailable required dependency.

## Execute one turn

1. Capture the current target and protected regression evidence.
2. Select the worst/highest-value unresolved target from that evidence.
3. Apply one focused, reversible change through named skills or tools.
4. Run the declared target check and all protected checks.
5. Accept only on declared improvement with no forbidden regression. Otherwise restore the previously
   accepted active variant and log the rejection.
6. Update durable state atomically with attempt, evidence, decision, cost, next candidate, and budget.
7. Evaluate terminal states in this order: `error`, `blocked`, `success`, `no-op`, `stalled`,
   `exhausted`, otherwise `continue`.

Never weaken, delete, skip, or edit the verifier merely to obtain a pass unless the loop's explicit
goal is verifier repair and an independent hold-out proves the repair.

## Long-running loops

Prefer a fresh context per turn once conversation history becomes a liability. Each fresh turn must
reread the loop specification and compact state; raw previous transcripts are not the memory system.

For nested loops:

- Parent maximum cost includes all child turns.
- A child may not call an ancestor directly or indirectly.
- A child returns its terminal state and evidence before the parent continues.
- Child `blocked`, `error`, or `exhausted` is never converted to parent success.

## Run receipt

Finish with:

```text
terminal_state: <state>
turn: <n>/<ceiling>
accepted_change: <summary or none>
target_evidence: <command/result reference>
regression_evidence: <command/result reference>
cost_this_turn: <tokens/time/money>
cost_per_accepted_change: <value or undefined>
state_file: <path>
next_candidate: <action or none>
approval_needed: <decision or none>
```
