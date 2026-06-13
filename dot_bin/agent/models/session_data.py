"""Data model for session data."""

from dataclasses import dataclass
from agent.models.session_pane import SessionPane


@dataclass
class SessionData:
    multiplexer: str
    panes: list[SessionPane]
