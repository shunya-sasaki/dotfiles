"""Gitforge class that wraps coommand for git forges such as GitHub, Gitea."""

from typing import Literal
import shutil
import subprocess
from dataclasses import dataclass
import json

from argparse import ArgumentParser


@dataclass()
class ForgeUrl:
    sshUrl: str
    url: str


class GitForge:
    def __init__(self, remote_name: str = "origin"):
        self.is_git_available = self.is_installed("git")
        self.is_gh_available = self.is_installed("gh")
        self.is_tea_available = self.is_installed("tea")
        self.backend = self._detect_backend(remote_name)

    def is_installed(self, cmd: Literal["git", "gh", "tea"]) -> bool:
        ret = shutil.which(cmd=cmd)
        if ret is not None:
            return True
        else:
            return False

    def _detect_backend(self, remote_name: str = "origin") -> str | None:
        proc = subprocess.run(
            ["git", "remote", "get-url", remote_name], capture_output=True
        )
        remote_url = proc.stdout.decode("utf-8").strip()
        if "github.com" in remote_url:
            return "GitHub"
        if self.is_gh_available:
            proc = subprocess.run(
                ["gh", "repo", "list", "--json", "sshUrl,url"], capture_output=True
            )
            output = proc.stdout.decode("utf-8")
            output_json = json.loads(output)
            gh_urls = [
                ForgeUrl(sshUrl=item["sshUrl"], url=item["url"]) for item in output_json
            ]
            for forge_url in gh_urls:
                if remote_url == forge_url.sshUrl:
                    return "GitHub"
                elif remote_url == forge_url.url:
                    return "GitHub"
        if self.is_tea_available:
            proc = subprocess.run(
                ["tea", "repo", "list", "-f", "ssh,url", "-o", "json"],
                capture_output=True,
            )
            output = proc.stdout.decode("utf-8")
            output_json = json.loads(output)
            tea_urls = [
                ForgeUrl(sshUrl=item["ssh"], url=item["url"]) for item in output_json
            ]
            for forge_url in tea_urls:
                if remote_url == forge_url.sshUrl:
                    return "Gitea"
                elif remote_url == forge_url.url:
                    return "Gitea"
        return None

    def _run(self, cmds: list[str]):
        """Run a forge command, streaming its output to the terminal."""
        subprocess.run(cmds)

    def issue_list(self):
        """List issue in a repository."""
        match self.backend:
            case "GitHub":
                cmds = ["gh", "issue", "list"]
            case "Gitea":
                cmds = ["tea", "issue", "list"]
        self._run(cmds)

    def issue_create(self, title: str, body: str, label: str | None):
        """Create a new issue."""
        body = body.replace("\\n", "\n").replace("\\t", "\t")
        match self.backend:
            case "GitHub":
                cmds = [
                    "gh",
                    "issue",
                    "create",
                    "--title",
                    title,
                    "--body",
                    body,
                ]
                if label is not None:
                    cmds.extend(["--label", label])

            case "Gitea":
                cmds = [
                    "tea",
                    "issue",
                    "create",
                    "--title",
                    title,
                    "--description",
                    body,
                ]
                if label is not None:
                    cmds.extend(["--labels", label])
        self._run(cmds)

    def issue_view(self, number: int):
        """View an issue."""
        match self.backend:
            case "GitHub":
                cmds = ["gh", "issue", "view", f"{number}"]

            case "Gitea":
                cmds = ["tea", "issue", f"{number}"]
        self._run(cmds)

    def pr_list(self):
        """List pull requests in a repository."""
        match self.backend:
            case "GitHub":
                cmds = ["gh", "pr", "list"]
            case "Gitea":
                cmds = ["tea", "pr", "list"]
        self._run(cmds)

    def pr_create(self, title: str, body: str, base: str | None, label: str | None):
        """Create a new pull request."""
        body = body.replace("\\n", "\n").replace("\\t", "\t")
        match self.backend:
            case "GitHub":
                cmds = [
                    "gh",
                    "pr",
                    "create",
                    "--title",
                    title,
                    "--body",
                    body,
                ]
                if base is not None:
                    cmds.extend(["--base", base])
                if label is not None:
                    cmds.extend(["--label", label])

            case "Gitea":
                cmds = [
                    "tea",
                    "pr",
                    "create",
                    "--title",
                    title,
                    "--description",
                    body,
                ]
                if base is not None:
                    cmds.extend(["--base", base])
                if label is not None:
                    cmds.extend(["--labels", label])
        self._run(cmds)

    def pr_view(self, number: int):
        """View a pull request."""
        match self.backend:
            case "GitHub":
                cmds = ["gh", "pr", "view", f"{number}"]

            case "Gitea":
                cmds = ["tea", "pr", f"{number}"]
        self._run(cmds)

    def label_list(self):
        """List labels in a repository."""
        match self.backend:
            case "GitHub":
                cmds = ["gh", "label", "list"]
            case "Gitea":
                cmds = ["tea", "label", "list"]
        self._run(cmds)


def main():
    parser = ArgumentParser(
        prog="gf",
        description="Wrapper command for git forges such as GitHub and Gitea.",
    )
    subparsers = parser.add_subparsers(dest="command", help="Command")

    # issue -------------------------------------------------------------------
    issue_parser = subparsers.add_parser("issue", help="Manage issues")
    issue_subparsers = issue_parser.add_subparsers(dest="sub_command")
    # list
    issue_subparsers.add_parser("list", help="List issue in a repository")
    # create
    issue_create_parser = issue_subparsers.add_parser(
        "create", help="Crate a new issue"
    )
    issue_create_parser.add_argument("--title", "-t", type=str, help="Supply a title")
    issue_create_parser.add_argument("--body", "-b", type=str, help="Supply a body")
    issue_create_parser.add_argument(
        "--label", "-l", type=str, default=None, help="Add labels by name"
    )
    # view
    issue_view_parser = issue_subparsers.add_parser("view", help="View an issue")
    issue_view_parser.add_argument("number", type=int, help="Issue number")

    # pr ----------------------------------------------------------------------
    pr_parser = subparsers.add_parser("pr", help="Manage pull requests")
    pr_subparsers = pr_parser.add_subparsers(dest="sub_command")
    # list
    pr_subparsers.add_parser("list", help="List pull requests in a repository")
    # create
    pr_create_parser = pr_subparsers.add_parser(
        "create", help="Create a new pull request"
    )
    pr_create_parser.add_argument("--title", "-t", type=str, help="Supply a title")
    pr_create_parser.add_argument("--body", "-b", type=str, help="Supply a body")
    pr_create_parser.add_argument(
        "--base", "-B", type=str, default=None, help="The target branch"
    )
    pr_create_parser.add_argument(
        "--label", "-l", type=str, default=None, help="Add labels by name"
    )
    # view
    pr_view_parser = pr_subparsers.add_parser("view", help="View a pull request")
    pr_view_parser.add_argument("number", type=int, help="Pull request number")

    # label -------------------------------------------------------------------
    label_parser = subparsers.add_parser("label", help="Manage labels")
    label_subparsers = label_parser.add_subparsers(dest="sub_command")
    # list
    label_subparsers.add_parser("list", help="List labels in a repository")

    forge = GitForge()
    args = parser.parse_args()
    match args.command:
        case "issue":
            match args.sub_command:
                case "list":
                    forge.issue_list()
                case "create":
                    forge.issue_create(
                        title=args.title, body=args.body, label=args.label
                    )
                case "view":
                    forge.issue_view(number=args.number)
        case "pr":
            match args.sub_command:
                case "list":
                    forge.pr_list()
                case "create":
                    forge.pr_create(
                        title=args.title,
                        body=args.body,
                        base=args.base,
                        label=args.label,
                    )
                case "view":
                    forge.pr_view(number=args.number)
        case "label":
            match args.sub_command:
                case "list":
                    forge.label_list()


if __name__ == "__main__":
    main()
