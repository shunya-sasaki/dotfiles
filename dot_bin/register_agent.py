"""Register pane id for a session."""

import os
from argparse import ArgumentParser
from pathlib import Path
from dataclasses import dataclass
from dataclasses import asdict
import json


@dataclass
class SessionPane:
    pane_id: int
    name: str
    role: str


parser = ArgumentParser(description="Register pane id for a session.")
parser.add_argument(
    "--session",
    "-s",
    type=str,
    default="default",
    help="Name of the session to register.",
)
parser.add_argument(
    "--role",
    "-r",
    type=str,
    default="agent",
    help="Name of the role to register.",
)
parser.add_argument(
    "--name",
    "-n",
    type=str,
    default=None,
    help="Name of the role to register.",
)
parser.add_argument(
    "--init",
    "-i",
    action="store_true",
    help="Whether to initialize the session.",
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
session_filepath.parent.mkdir(parents=True, exist_ok=True)
if args.name is not None:
    name = args.name
else:
    name = args.role
if args.init or not session_filepath.exists():
    dict_session = {
        "multiplexer": multiplexer,
        "panes": [
            asdict(SessionPane(pane_id=current_pane_id, name=name, role=args.role))
        ],
    }
else:
    dict_session = json.loads(session_filepath.read_text())
    panes = dict_session["panes"]
    dict_role_counts = {}
    duplicated_pane_id = None
    for i_pane, pane in enumerate(panes):
        if current_pane_id == pane["pane_id"]:
            duplicated_pane_id = i_pane
            break
    if duplicated_pane_id is not None:
        del panes[duplicated_pane_id]
    for pane in panes:
        dict_role_counts[pane["role"]] = dict_role_counts.get(pane["role"], 0) + 1
        if name == pane["name"]:
            name = f"{args.role}-{dict_role_counts[pane['role']] + 1}"
            if pane["name"] == args.role:
                pane["name"] = f"{args.role}-1"
    panes.append(
        asdict(SessionPane(pane_id=current_pane_id, name=name, role=args.role))
    )
json.dump(dict_session, session_filepath.open("w"))
