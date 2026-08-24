# Designing and auditing a loop

## Triage

Ask whether evidence from one turn changes the next action.

- **No:** emit a one-shot prompt, optionally with a schedule. Stop there.
- **Yes:** design a loop.
- **Unknown:** identify the proposed feedback signal. If no reproducible signal can be named, do not
  claim unattended autonomy.

Loops are also a poor fit for pure taste, unresolved greenfield direction, or work whose verification
cost exceeds the expected benefit.

## Information the specification must carry

Gather what is missing without re-asking what the repository or user already supplied:

1. **Trigger:** manual, schedule, or event.
2. **Goal:** concrete state, preferably machine-verifiable.
3. **Baseline:** the comparable state before the first change.
4. **Verification:** exact command, assertion, rule, field result, rubric, or human checkpoint.
5. **Turn policy:** how evidence selects the next highest-value action.
6. **Skills and tools:** named reusable capabilities called inside a turn.
7. **Terminal states:** success, clean no-op, blocked, stalled, exhausted, and error as applicable.
8. **Memory:** file holding progress, attempts, evidence, decisions, and next action.
9. **Guardrails:** turn/cost ceilings, allowed surfaces, approvals, and forbidden actions.
10. **Actuation:** how a person, scheduler, event, or fresh-context runner starts the next turn.

Ask only for a missing choice that materially changes the design. For consequential ambiguity, ask one
question at a time. Cheap reversible details may be assumed and recorded.

## Verification ladder

Label the strongest check the loop actually has:

1. **Deterministic:** exit code, assertion, exact/golden output.
2. **Rule:** schema, linter, policy, constraint.
3. **Delayed field truth:** deployment, real environment, customer or operational result.
4. **Model judgment:** frozen rubric in fresh context; maker and checker must differ.
5. **Human checkpoint:** supervision, not automated verification.

Levels 1-2 are the unattended autonomous zone. Levels 4-5 are assisted flow. A lower number is not
automatically sufficient: prove a new verifier with a red-before/green-after check where feasible, and
keep hold-out cases outside the maker's edit surface.

## Hardening pass

- Replace self-score with external evidence.
- Freeze the yardstick across turns so progress is comparable.
- Choose one highest-impact target and one focused change per turn.
- Keep a change only if the target improves and protected behavior does not regress.
- Add a no-progress detector and a hard budget.
- Gate destructive, production, financial, security-sensitive, or externally visible actions.
- For nested loops, compute the multiplicative ceiling and reject recursive cycles.
- Curate memory: retain validated lessons; discard unsupported or stale ones.
- Record `cost per accepted change` and the evidence for every accepted change.

## Output skeleton

Write one versioned Markdown file:

```markdown
---
name: <loop-name>
trigger: <manual | schedule | event>
verification_level: <1 | 2 | 3 | 4 | 5>
architecture: <solo | maker-checker | manager-helpers>
---

# <Loop name>

## Use when
<Why feedback changes the next action.>

## Goal and baseline
- Goal: <observable final state>
- Baseline: <how to capture it>

## Verification
- Check: `<command or procedure>`
- Accept when: <condition read from the evidence>
- Protected regression set: <checks that must not worsen>

## One turn
1. Read this specification and `<state-file>`.
2. Capture the comparable current evidence.
3. Select the highest-impact unresolved target.
4. Make one focused change using <named skills/tools>.
5. Run the target check and protected regression checks.
6. Keep the change only if acceptance holds; otherwise restore the prior active variant.
7. Update `<state-file>` with evidence, decision, cost, and next candidate action.

## Terminal states
- success: <goal proved>
- no-op: <nothing actionable and the clean check proves it>
- blocked: <missing decision/access/authority>
- stalled: <N turns without measurable gain or oscillation>
- exhausted: <turn/cost ceiling>
- error: <verification or environment failure>

## Guardrails
- Maximum turns/cost: <bound>
- Allowed surfaces: <scope>
- Ask before: <consequential actions>
- Forbidden: <actions>

## Memory
State file: `<path>`. Store concise evidence and decisions, not raw transcripts.

## Actuation
<manual command, schedule/event, or fresh-context runner that rereads this file and state each turn>

## Health metric
Cost per accepted change = <cost unit> / accepted verified changes.
```

## Ready-to-use kickoff prompt

```text
Read <loop-spec-path> and <state-path>. Execute exactly one turn. Use the evidence produced by this
turn to choose the next action; do not follow a prewritten step sequence after the evidence diverges.
Make at most one focused change, run the declared target and regression checks, and retain the change
only if acceptance holds. Update the state file with evidence, cost, decision, and next candidate.
Return exactly one terminal state: success, no-op, continue, blocked, stalled, exhausted, or error.
Error or exhausted budget never means success. Do not exceed the permissions or approval boundaries
in the loop specification.
```

## Audit verdict

When auditing an existing loop, report `READY`, `ASSISTED_ONLY`, or `NOT_READY`, followed by the
smallest missing controls. `ASSISTED_ONLY` means the loop depends on level-4/5 judgment and must not be
advertised as unattended deterministic automation.
