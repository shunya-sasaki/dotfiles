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

1. You're assigned a role by the user, and told the role of another agent.
2. Create a message to tell another agent the theme and the role.
   You should contain the message that tells another to start the debate.
3. Send the message using `agent-send <session> <pane_id> <message> --require_response`.

### Phase 2: Process debate

1. Receive messages from another agent.
2. Analyze the message and consider.
3. Create a message.
4. Send the message using `agent-send <session> <pane_id> <message> --require_response`.
5. Repeat from step 1 to step 4 until you get the conclusion or
   you reached the maximum number of rounds.
6. After you'll have got the conclusion or reached the maximum number of rounds,
   you MUST create a message to tell another agent to end the debate,
   and send it using `agent-send <session> <pane_id> <message>`.

### Phase 3: Wrap up

Wrap up is the final phase of the debate.
This task is for only the agent who has sent the start debate message in phase 1.

1. Analyze the messages in the debate and consider the whole debate.
2. Create a summary of the debate, including the conclusion if it exists.
3. Use "Write tool" skill to write the summary in a file.
   If the user has not specified the file format,
   create the file in Markdown format.
