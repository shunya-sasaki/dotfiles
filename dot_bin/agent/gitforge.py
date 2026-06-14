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

    def issue_list(self):
        """List issue in a repository."""
        match self.backend:
            case "GitHub":
                proc = subprocess.run(["gh", "issue", "list"], capture_output=True)
            case "Gitea":
                proc = subprocess.run(["tea", "issue", "list"], capture_output=True)
        print(proc.stdout.decode("utf-8"))

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
        proc = subprocess.run(cmds, capture_output=True)
        print(proc.stdout.decode("utf-8"))

    def issue_view(self, number: int):
        """View an issue."""
        match self.backend:
            case "GitHub":
                cmds = ["gh", "issue", "view", f"{number}"]

            case "Gitea":
                cmds = ["tea", "issue", f"{number}"]
        proc = subprocess.run(cmds, capture_output=True)
        print(proc.stdout.decode("utf-8"))


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


if __name__ == "__main__":
    main()
