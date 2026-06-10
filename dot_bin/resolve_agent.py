"""Resolve agent from a session file."""

from typing import Literal

import os
from argparse import ArgumentParser
from pathlib import Path
from dataclasses import dataclass
import json
from pprint import pprint


@dataclass
class SessionPane:
    pane_id: int
    name: str
    role: str


@dataclass
class SessionData:
    multiplexer: Literal["Zellij", "Tmux", "WezTerm"]
    panes: list[SessionPane]


parser = ArgumentParser(description="Register pane id for a session.")
parser.add_argument(
    "--session",
    "-s",
    type=str,
    required=True,
    help="Name of the session to register.",
)

if (env_current_pane_id := os.environ.get("ZELLIJ_PANE_ID", None)) is not None:
    current_pane_id = int(env_current_pane_id)
    multiplexer = "Zellij"
elif (env_current_pane_id := os.environ.get("TMUX_PANE", None)) is not None:
    current_pane_id = int(env_current_pane_id)
    multiplexer = "Tmux"
elif (env_current_pane_id := os.environ.get("WEZTERM_PANE", None)) is not None:
    current_pane_id = int(env_current_pane_id)
    multiplexer = "WezTerm"

args = parser.parse_args()

session_filepath = Path.home() / ".tmp" / "agent-to-agent" / f"{args.session}.json"
dict_session: SessionData = json.loads(session_filepath.read_text())
panes = dict_session["panes"]
for pane in panes:
    if pane["pane_id"] == current_pane_id:
        name = pane["name"]
other_panes = [pane for pane in panes if pane["pane_id"] != current_pane_id]
print(f"Your pane_id: {current_pane_id}")
print(f"Your name: {name}")
print("Other pane information is following:")
pprint(other_panes)
