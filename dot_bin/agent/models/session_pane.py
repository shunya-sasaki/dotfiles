"""Data model for session pane."""

from dataclasses import dataclass


@dataclass
class SessionPane:
    pane_id: int
    name: str
    role: str
