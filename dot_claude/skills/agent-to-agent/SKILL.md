---
name: agent-to-agent
description: When you're asked to communicate to other agents (a2a session), you MUST use this skill.
---

# Agent to Agent

This skill is used when you're asked to communicate to other agents.
You MUST use this skill when you need to send messages to other agents,
and you MUST follow the format specified in the skill description.

## Initialize Agent to Agent Session

IF you're asked to initialize an `agent-to-agent` (`a2a`) session,
THEN you MUST run `agent-init <session_name> <role> <name>` to
create a session file.

### Procedure

1. Analyze user's request and understand the session details,
   such as session name, your role, and your name.
2. Run `agent-init <session_name> <role> <name>` to
   create a session file.

### Rules

- If `session_name` is not specified, use "default" as the session name.
- If `name` is not specified, use your role as the name.

## Register to Agent to Agent Session

IF you're asked to register to an `agent-to-agent` (`a2a`) session,
THEN you MUST run `agent-register <session_name> <role> <name>` to
register to the session.

### Procedure

1. Analyze user's request and understand the session details,
   such as session name, your role, and your name.
2. Run `agent-register <session_name> <role> <name> --init` to
   create a session file.

### Rules

- If `session_name` is not specified, use "default" as the session name.
- If `name` is not specified, use your role as the name.

## Resolve Agent to Agent Session

If you're asked to resolve an `agent-to-agent` (`a2a`) session,
THEN you MUST run `agent-resolve <session_name>` to
reolve the your pane id, name and other agents' information from the session file.

### Procedure

1. Run `agent-resolve <session_name>` to resolve the session information.
2. Get your pane id, name and other agents' information from the session file.

## Send message to other agent

When you're asked to communicate to other agents, you MUST send a message
using the skill for the session type.
After you start to communicate to the other agents,
keep to send a message to the agents when you receive a request.

### Procedure

1. Analyze the requested message.
2. Create a response message.
3. Send the message to another agent using following command:

   ```
   agent-send <pane_id> "<message>"
   ```

### Rules

- `<pane_id>` is the pane ID of the other agent you want to send the message to.
- `<message>` is the message you want to send to the other agent.

## Test communication

When you're asked to do a communication test with another agent,
you MUST send a test message.
If you receive the test message, you reply with the response.

### Procedure

#### In case of the sender

If you're asked to send a test message to another, you are the **sender** .
The sender's tasks are the following:

1. Send a test message "ping" to another agent with the skill.
2. Wait for the response.
3. If you get "pong" from another, the communication command is correct.
   Otherwise, you have to review the command.
   After modifying the command, retry the test.

#### In case of the receiver

If you're requested to reply to the test message, you are the **receiver** .

1. You receive a test message "ping" from the sender.
2. You send a test response message "pong" to the sender.

## Debate with another agent

When you're asked to debate with another agent, you MUST use this skill.

### Procedure

#### Phase 1: Start debate

1. You're assigned a role by the user, and told the role of another agent.
2. Create a message to tell another agent the theme and the role.
   You should contain the message that tells another to start the debate.
3. Send the message using skills.

#### Phase 2: Process debate

1. Receive messages from another agent.
2. Analyze the message and consider.
3. Create a message.
4. Send the message using skills.
5. Repeat from step 1 to step 4 until you get the conclusion or
   you reached the maximum number of rounds.
6. After you'll have got the conclusion or reached the maximum number of rounds,
   you MUST create a message to tell another agent to end the debate,
   and send it using skills.

#### Phase 3: Wrap up

Wrap up is the final phase of the debate.
This task is for only the agent who has sent the start debate message in phase 1.

1. Analyze the messages in the debate and consider the whole debate.
2. Create a summary of the debate, including the conclusion if it exists.
3. Use "Write tool" skill to write the summary in a file.
   If the user has not specified the file format,
   create the file in Markdown format.
