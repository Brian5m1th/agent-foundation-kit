# Self-Harness mode `[EXPERIMENTAL]`

Use only when the requested object of improvement is the agent harness itself: prompts, tools,
memory sources, verification rules, permissions, adapters, orchestration, or runtime recovery.

Do not mutate a shared or production harness from anecdotal failures. The evidence must support a
repeatable evaluation, and activation still requires the ordinary authority for that configuration.

## Fixed experimental frame

Freeze before proposing edits:

- base model and inference settings;
- task corpus and environment;
- official/deterministic evaluator;
- cost and tool budget;
- held-in cases exposed to the proposer;
- held-out cases never exposed to the proposer;
- initial harness version and editable surfaces.

Without a held-out set and a fixed evaluator, return `NOT_READY`: improvement and overfitting cannot
be distinguished.

## Optimization loop

### 1. Weakness mining

Evaluate the active harness and keep failed execution traces. Attribute each failure using verifier
evidence:

- terminal verifier cause;
- causal status of the agent behavior;
- reusable agent-side mechanism.

Cluster only failures that share that signature. Rank clusters by support and actionability. The
evidence bundle diagnoses a mechanism; it does not prescribe an edit.

### 2. Harness proposal

Generate a small set of materially distinct, minimal candidate edits. Each candidate records:

- targeted failure cluster;
- exact editable surface;
- expected behavior change;
- behaviors that must be preserved;
- regression risks;
- prior related attempts.

Reject proposals aimed at task-specific difficulty, unstable noise, or capability limits that the
editable harness cannot plausibly change.

### 3. Proposal validation

Evaluate the active and candidate harnesses on the same held-in and held-out splits. Promote a
candidate only when:

```text
delta_held_in >= 0
delta_held_out >= 0
max(delta_held_in, delta_held_out) > 0
```

Repeat evaluation when outcomes are stochastic. Reject invalid or non-executing candidates. Merge
only compatible accepted edits, then rerun the combined harness because individually safe edits can
interact.

### 4. Lineage and activation

Version every active harness, candidate, evaluator result, acceptance decision, and rejection reason.
Keep the previous active harness recoverable. Before changing a shared installation, present the
validated diff and request any approval required by the repository or environment.

## Stopping states and measures

- `success`: declared performance target reached without held-out regression.
- `stalled`: no accepted candidate for the configured rounds.
- `exhausted`: proposal/evaluation budget spent.
- `blocked`: evaluator, corpus, permissions, or environment unavailable.
- `error`: evaluation invalid; never promote.

Report pass rate by split, absolute and relative gain, accepted/proposed ratio, evaluation cost per
accepted harness edit, retained behavior, and any benchmark/model scope limit. Results on a fixed
benchmark do not establish universal harness superiority.
