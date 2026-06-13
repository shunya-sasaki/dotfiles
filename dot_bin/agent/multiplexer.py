"""Multiplexer class that is wrapper of Tmux, Zellij and WezTerm multiplexer."""

import os
import subprocess
import time
from argparse import ArgumentParser


class Multiplexer:
    def __init__(self):
        self.backend = self._detect_backend()
        self.pane_id = self._detect_self_pane_id()

    def _detect_backend(self) -> str:
        if (os.environ.get("ZELLIJ_PANE_ID", None)) is not None:
            backend = "Zellij"
        elif (os.environ.get("TMUX_PANE", None)) is not None:
            backend = "Tmux"
        elif (os.environ.get("WEZTERM_PANE", None)) is not None:
            backend = "WezTerm"
        return backend

    def _detect_self_pane_id(self):
        match self.backend:
            case "Zellij":
                pane_id = int(os.environ["ZELLIJ_PANE_ID"])
            case "Tmux":
                pane_id = int(os.environ["TMUX_PANE"])
            case "WezTerm":
                pane_id = int(os.environ["WEZTERM_PANE"])
        return pane_id

    def send(
        self,
        target_pane_id: int,
        message: str,
        sleep_seconds: float = 0.1,
        with_enter: bool = True,
    ):
        """Send a message to the target pane."""
        match self.backend:
            case "Zellij":
                cmd = [
                    "zellij",
                    "action",
                    "write-chars",
                    "--pane-id",
                    f"{target_pane_id}",
                    f'"{message}"',
                ]
                enter_cmd = [
                    "zellij",
                    "action",
                    "write-chars",
                    "--pane-id",
                    f"{target_pane_id}",
                    "13",
                ]
            case "Tmux":
                cmd = ["tmux", "send-keys", "-t", f"{target_pane_id}", f'"{message}"']
                enter_cmd = ["tmux", "send-keys", "-t", f"{target_pane_id}", "Enter"]
            case "WezTerm":
                cmd = [
                    "wezterm",
                    "cli",
                    "send-text",
                    "--pane-id",
                    f"{target_pane_id}",
                    f"{message}",
                ]
                enter_cmd = [
                    "wezterm",
                    "cli",
                    "send-text",
                    "--pane-id",
                    f"{target_pane_id}",
                    "--no-paste",
                    "\r",
                ]
            case _:
                cmd = []
                enter_cmd = []
        subprocess.run(cmd, shell=False)
        if with_enter:
            time.sleep(sleep_seconds)
            subprocess.run(enter_cmd, shell=False)


def main():
    parser = ArgumentParser(
        prog="multiplexer", description="Wrapper command for Tmux, Zellij and WezTerm."
    )
    subparsers = parser.add_subparsers(dest="command", required=True)
    send_parser = subparsers.add_parser("send", help="Send a message to a pane.")
    send_parser.add_argument(
        "pane_id", type=int, help="Targer pane id you send a message to"
    )
    send_parser.add_argument("message", type=str, help="Message you send to the target")
    send_parser.add_argument(
        "--without_enter", action="store_true", help="Send a message without enter"
    )
    read_parser = subparsers.add_parser("read", help="Read a buffer content of a pane.")
    read_parser.add_argument(
        "pane_id", type=int, help="Targer pane id you read a buffer content"
    )

    args = parser.parse_args()

    mp = Multiplexer()
    match args.command:
        case "send":
            mp.send(
                args.pane_id, message=args.message, with_enter=not args.without_enter
            )
        case _:
            raise ValueError(
                "The command is invalid! It should be either of 'send', 'receive'!"
            )


if __name__ == "__main__":
    main()
