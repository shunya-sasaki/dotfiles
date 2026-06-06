---
name: agent-to-agent
description: When you're asked to communicate to other agents, you MUST use this skill.
---

# Agent to Agent

This skill is used when you're asked to communicate to other agents.
You MUST use this skill when you need to send messages to other agents,
and you MUST follow the format specified in the skill description.

- Setup agent to agent communication
- Send message to other agents

## Setup agent to agent communication

Before working on any other tasks in this skill, you MUST run this task once.

### Procedure

1. Use [[detect-multiplexer]] skill to detect your session.
2. Load the skill for the detected multiplexer.
3. Detect your pane ID and store it in the context for later use.
4. Detect other pane IDs in the same session and
   store them in the context for later use.
5. Respond to the user that the setup is complete
   and you are ready to communicate with other agents.
   You MUST include your pane ID
   and the list of other pane IDs in the response.

## Send message to other agent

When you're asked to communicate to other agents, you MUST send a message
using the skill for the session type.
After you start to communicate to the other agents,
keep to send a message to the agents when you receive a request.

### Procedure

1. Analyze the requested message.
2. Create a response message.
3. Send the message to another agent using the skill.

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
