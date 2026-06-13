from pathlib import Path
import json
from pprint import pprint
from dataclasses import asdict

from agent.multiplexer import Multiplexer
from agent.models import SessionPane
from agent.models import SessionData


class SessionManager:
    def __init__(self, session: str):
        self.session = session
        self.session_filepath = (
            Path.home() / ".tmp" / "agent-to-agent" / f"{session}.json"
        )
        self.multiplexer = Multiplexer()
        self.current_pane_id = self.multiplexer.pane_id

    def init(self, name: str | None, role: str):
        if name is None:
            name = role
        session_data = SessionData(
            multiplexer=self.multiplexer.backend,
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

    def send(self, pane_id: int, message: str, require_response: bool = False):
        session_data: SessionData = json.loads(self.session_filepath.read_text())
        panes = session_data["panes"]
        for pane in panes:
            if pane["pane_id"] == self.current_pane_id:
                my_name = pane["name"]
                my_id = self.current_pane_id
            elif pane["pane_id"] == pane_id:
                target_name = pane["name"]
                target_id = pane["pane_id"]
        content = "\n".join(
            [
                f"SESSION: {self.session}",
                f"FROM: {my_name} @ pane {my_id}",
                f"TO: {target_name} @ pane {target_id}",
                "",
                "CONTENT:",
                message,
                "",
                f"RESPONSE_REQUIRED : {'YES' if require_response else 'NO'}",
            ]
        )
        self.multiplexer.send(target_pane_id=pane_id, message=f"{content}")
