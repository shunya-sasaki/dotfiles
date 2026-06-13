---
name: agent-to-agent
description: >
  This skill provide instructions for agent-to-agent communications.
  IF you received a message that contains either of "agent-to-agent", "agent to agent", "a2a",
  or asks you to "register" / "join" / "init" / "resolve" a session or "send a message to an agent",
  or you are required to `agent-*` commands such as `agent-init`, `agent-register` and `agent-resolve`,
  you MUST use this skill.
---

# Agent to Agent

This skill is used when you're asked to communicate to other agents.
You MUST use this skill when you need to send messages to other agents,
and you MUST follow the format specified in the skill description.

## Common arguments

The `agent-*` commands share these arguments:

- `<session>` (`<session_name>`) is the session name.
  This is specified by the user. If the user does not specify it,
  use the literal string `default` as the session name. Never invent one.
- `<role>` is your role in the session.
  Use the role you were assigned as an agent (e.g. `developer`, `reviewer`,
  `architect`) — this is the role defined in your own agent definition.
  Do NOT ask the user for your role; you already know it.
- `<name>` is your name in the session.
  If it's not specified, use your role as the name.
- `<pane_id>` is the pane ID of the other agent you want to send the message to.
- `<message>` is the message you want to send to the other agent.

## Initialize Agent to Agent Session

IF you're asked to initialize an `agent-to-agent` (`a2a`) session,
THEN you MUST run `agent-init <session_name> <role> <name>` to
create a session file.

### Procedure

1. Analyze user's request and understand the session details,
   such as session name, your role, and your name.
2. Run `agent-init <session_name> <role> <name>` to
   create a session file.

## Register to Agent to Agent Session

IF the user asks you to register or join an a2a session
— for example "register agent", "register to a2a", "register to the session",
or "join the a2a session" —
THEN you MUST immediately run the `agent-register` command below.
Do NOT ask the user for confirmation, and do NOT just describe the command:
actually run it.

### Resolving the arguments (do this without asking the user)

- `<session_name>`: the session name the user gave. If the user did not give
  one, use the literal string `default`.
- `<role>`: your assigned agent role (e.g. `developer`, `reviewer`,
  `architect`). You already know this from your agent definition — use it.
- `<name>`: the name the user gave. If none, use `<role>` as the name.

Only ask the user a clarifying question if they explicitly mentioned a session,
role, or name that is genuinely ambiguous. Otherwise apply the rules above and
run the command.

### Procedure

1. Resolve `<session_name>`, `<role>`, and `<name>` using the rules above.
2. Run `agent-register <session_name> <role> <name>`.
3. Confirm to the user that you registered, reporting the session, role,
   and name you used.

### Example

The user (whose agent role is `reviewer`) says: "register to a2a".
You resolve: session = `default`, role = `reviewer`, name = `reviewer`,
then run:

```
agent-register default reviewer reviewer
```

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
3. Send the message to another agent using
   `agent-send <session> <pane_id> "<message>"`.

## Response to other agent

IF you recieved a message that contains `REQUIRED_RESPONSE: YES` from an another agent,
your MUST send a message to the agent.

### Procedure

1. Analyze the message and understand the agent intent.
2. Do the task and create a response message.
3. Extract session name in `SESSION` section of the message.
4. Extract pane id in `FROM` section of the message.
5. Send a response message to the agent using `agent-send <session> <pane_id> <message>`
   IF you're sure you have to require response from the agent,
   send a message to the agent using `agent-send <session> <pane_id> <message> --require_response`,
   OTHERWISE send a message to the agent using `agent-send <session> <pane_id> <message>`

## Test communication

When you're asked to do a communication test with another agent,
you MUST send a test message.
If you receive the test message, you reply with the response.

### Procedure

#### In case of the sender

If you're asked to send a test message to another, you are the **sender** .
The sender's tasks are the following:

1. Send a test message "ping" to another agent using
   `agent-send <session> <pane_id> "ping" --require_response`.
2. Wait for the response.
3. If you get a message that contains "pong" from another,
   the communication command is correct.

#### In case of the receiver

If you recieved a message that contains "ping", you MUST reply with the response.

1. Analyze a message from another agent.
2. Extract pane id in the FROM section and session name in the SESSION section
   of the message.
3. You send a test response message "pong" to the sender using
   `agent-send <session> <pane_id> "pong"`.
