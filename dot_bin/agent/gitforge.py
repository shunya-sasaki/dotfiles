"""Gitforge class that wraps coommand for git forges such as GitHub, Gitea."""

from typing import Literal
import shutil
import subprocess
from dataclasses import dataclass
import json


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
        print(f"Git forge backend: {self.backend}")

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


def main():
    forge = GitForge()


if __name__ == "__main__":
    main()
