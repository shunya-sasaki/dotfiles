"""Resolve agent from a session file."""

from argparse import ArgumentParser

from agent import SessionManager


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

    send_parser = subparsers.add_parser("send", help="Send a message to another agent.")
    send_parser.add_argument(
        "--session",
        "-s",
        type=str,
        required=True,
        help="Name of the session to register.",
    )
    send_parser.add_argument("--pane_id", "-p", type=int, help="Target pane id")
    send_parser.add_argument("--message", "-m", type=str, help="Message")
    send_parser.add_argument(
        "--require_response",
        action="store_true",
        help="If you use this option, `RQUIRED_RESPONSE: True` is addded to message.",
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
        case "send":
            manager.send(
                pane_id=args.pane_id,
                message=args.message,
                require_response=args.require_response,
            )
        case _:
            raise RuntimeError("The command is unknown!")


if __name__ == "__main__":
    main()
