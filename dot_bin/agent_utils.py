"""Resolve agent from a session file."""

from typing import Literal

import os
from argparse import ArgumentParser
from pathlib import Path
from dataclasses import dataclass
import json
from pprint import pprint
from dataclasses import asdict


@dataclass
class SessionPane:
    pane_id: int
    name: str
    role: str


@dataclass
class SessionData:
    multiplexer: str
    panes: list[SessionPane]


class SessionManager:
    def __init__(self, session: str):
        self.session = session
        self.multiplexer, self.current_pane_id = self._detect_muliplexer()
        self.session_filepath = (
            Path.home() / ".tmp" / "agent-to-agent" / f"{session}.json"
        )

    def _detect_muliplexer(self) -> tuple[str, int]:
        if (env_current_pane_id := os.environ.get("ZELLIJ_PANE_ID", None)) is not None:
            current_pane_id = int(env_current_pane_id)
            multiplexer = "Zellij"
        elif (env_current_pane_id := os.environ.get("TMUX_PANE", None)) is not None:
            current_pane_id = int(env_current_pane_id)
            multiplexer = "Tmux"
        elif (env_current_pane_id := os.environ.get("WEZTERM_PANE", None)) is not None:
            current_pane_id = int(env_current_pane_id)
            multiplexer = "WezTerm"
        return multiplexer, current_pane_id

    def init(self, name: str | None, role: str):
        if name is None:
            name = role
        session_data = SessionData(
            multiplexer=self.multiplexer,
            panes=[SessionPane(pane_id=self.current_pane_id, name=name, role=role)],
        )
        json.dump(asdict(session_data), self.session_filepath.open("w"))
        print(
            "You have initialized the session registry, and registered the following pane to the session:"
        )
        pprint(asdict(session_data))

    def register(self, name: str | None, role: str):
        if name is None:
            name = role
        session_data = json.loads(self.session_filepath.read_text())
        panes = session_data["panes"]
        dict_role_counts = {}
        duplicated_pane_id = None
        for i_pane, pane in enumerate(panes):
            if self.current_pane_id == pane["pane_id"]:
                duplicated_pane_id = i_pane
                break
        if duplicated_pane_id is not None:
            del panes[duplicated_pane_id]
        for pane in panes:
            dict_role_counts[pane["role"]] = dict_role_counts.get(pane["role"], 0) + 1
            if name == pane["name"]:
                name = f"{role}-{dict_role_counts[pane['role']] + 1}"
                if pane["name"] == role:
                    pane["name"] = f"{role}-1"
        panes.append(
            asdict(SessionPane(pane_id=self.current_pane_id, name=name, role=role))
        )
        json.dump(session_data, self.session_filepath.open("w"))
        print("You have registered the following pane to the session:")
        pprint(session_data)

    def resolve(self):
        session_data: SessionData = json.loads(self.session_filepath.read_text())
        panes = session_data["panes"]
        for pane in panes:
            if pane["pane_id"] == self.current_pane_id:
                name = pane["name"]
        other_panes = [
            pane for pane in panes if pane["pane_id"] != self.current_pane_id
        ]
        print(f"Your pane_id: {self.current_pane_id}")
        print(f"Your name: {name}")
        print("Other pane information is following:")
        pprint(other_panes)


def main():
    parser = ArgumentParser(description="Register pane id for a session.")
    subparsers = parser.add_subparsers(dest="command", required=True)

    init_parser = subparsers.add_parser("init", help="Initialize the session registry.")
    init_parser.add_argument(
        "--session",
        "-s",
        type=str,
        required=True,
        help="Name of the session to register.",
    )
    init_parser.add_argument(
        "--name",
        "-n",
        type=str,
        help="Name of the agent.",
    )
    init_parser.add_argument(
        "--role",
        "-r",
        type=str,
        help="Role of the agent.",
    )
    register_parser = subparsers.add_parser(
        "register", help="Initialize the session registry."
    )
    register_parser.add_argument(
        "--session",
        "-s",
        type=str,
        required=True,
        help="Name of the session to register.",
    )
    register_parser.add_argument(
        "--name",
        "-n",
        type=str,
        help="Name of the agent.",
    )
    register_parser.add_argument(
        "--role",
        "-r",
        type=str,
        help="Role of the agent.",
    )

    resolve_parser = subparsers.add_parser(
        "resolve", help="Resolve the session registry."
    )
    resolve_parser.add_argument(
        "--session",
        "-s",
        type=str,
        required=True,
        help="Name of the session to register.",
    )

    args = parser.parse_args()
    manager = SessionManager(session=args.session)
    match args.command:
        case "init":
            manager.init(args.name, args.role)
        case "register":
            manager.register(args.name, args.role)
        case "resolve":
            manager.resolve()
        case _:
            raise RuntimeError("The command is unknown!")


if __name__ == "__main__":
    main()
