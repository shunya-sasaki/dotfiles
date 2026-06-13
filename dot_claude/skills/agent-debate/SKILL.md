---
name: agent-debate
description: >
  This skill provides instructions for debating with another agent.
  IF you received a message that contains either of "debate", "agent debate"
  or you're asked to debate with another agent,
  you MUST use this skill.
---

# Agent Debate

This skill is used when you're asked to debate with another agent.
The debate is built on top of the `agent-to-agent` (`a2a`) communications,
so you MUST send all messages using the `agent-to-agent` skill.

IF an `agent-to-agent` (`a2a`) session is not set up yet,
THEN you MUST use the `agent-to-agent` skill to
`agent-register` and `agent-resolve` the session before you start the debate.

## Procedure

### Phase 1: Start debate

1. The user assigns you a role, tells you the other agent's role, gives the
   debate **theme**, and sets the **round limit** (the maximum number of
   rounds, chosen by the user). Use whatever number the user gives; only when
   no round limit is given, fall back to **5 rounds**.
2. Create a message that states the theme, your role, and the other agent's
   role, and asks the other agent to begin the debate.
3. Send the message using
   `agent-send <session> <pane_id> "<message>" --require_response`.

### Phase 2: Process debate

1. Receive a message from the other agent.
2. Analyze it and consider your response.
3. Create a message.
4. Send it using `agent-send <session> <pane_id> "<message>" --require_response`.
5. Each pass through steps 1–4 is one **round**. Keep repeating them until you
   reach a conclusion or hit the **round limit** set in Phase 1 — that limit is
   whatever number the user chose, not necessarily 5.
6. Once you have a conclusion or have hit the round limit, create a message
   telling the other agent to end the debate, and send it using
   `agent-send <session> <pane_id> "<message>"`.

### Phase 3: Wrap up

Wrap up is the final phase of the debate.
This task is only for the agent who sent the start-debate message in Phase 1.

1. Re-read the whole debate and consider it as a whole.
2. Fill in the template in the [Summary report template](#summary-report-template)
   section below, extracting:
   - what both agents agreed on (**Consensus**),
   - what stayed unresolved and **why** (**Open disagreements**),
   - the **Decision & Rationale**, if a conclusion was reached,
   - concrete **Next actions** and **Open research questions**.
3. Set the `outcome` field honestly. If the debate ended without agreement,
   use `no-consensus` or `escalate` — do NOT manufacture a conclusion.
4. Use the Write tool to save the filled summary as Markdown. Default the
   filename to `<theme-slug>-debate-summary.md` unless the user specified a
   path or format.

## Summary report template

Use this template for the Phase 3 summary (Standard depth). Replace every
`<…>` placeholder, delete any section that genuinely does not apply, and set
`outcome` honestly — never manufacture a conclusion. The `→ planning` and
`→ research` tags mark where each section feeds downstream work.

```markdown
---
theme: "<one-line debate theme>"
session: "<a2a session name>"
date: <YYYY-MM-DD>
rounds: <n>
participants:
  - name: <name>
    role: <role>
    stance: "<one-line position>"
  - name: <name>
    role: <role>
    stance: "<one-line position>"
outcome: consensus | partial | no-consensus | escalate   # pick one, honestly
decision: "<one-line decision, or null if unresolved>"
---

# Debate Summary — <theme>

## TL;DR

<3 sentences max: the question, the outcome, the single recommended next move.>

## Question & Scope

- **Debated:** <the precise question on the table>
- **Out of scope:** <what was explicitly not decided>

## Positions

| Agent (role)    | Core thesis | Strongest point |
| --------------- | ----------- | --------------- |
| <name> (<role>) | <thesis>    | <best argument> |
| <name> (<role>) | <thesis>    | <best argument> |

## How it developed

<The crux: where they converged, where the real disagreement sits, and what
evidence actually moved the needle. One short paragraph or a few bullets.>

## Consensus — agreed, safe to build on

- <point both sides accepted>

## Open disagreements — unresolved

- <point> — _why unresolved:_ <missing evidence / values clash / out of scope>

## Decision & Rationale

- **Decision:** <what was concluded, or "No decision — see open disagreements">
- **Because:** <the deciding reason(s)>
- **Confidence:** <high / medium / low> — <what would raise it>

## Next actions → planning

- [ ] <action> — _owner:_ <who> — _priority:_ P1/P2/P3

## Open research questions → research

- <question> — _why it matters:_ <impact> — _resolved by:_ <experiment / data / spike>
```
