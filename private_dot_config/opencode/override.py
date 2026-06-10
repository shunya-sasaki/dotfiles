"""Override the default settings for OpenCode."""

import json
from pathlib import Path

base_setting_filepath = Path("base.jsonc")
with base_setting_filepath.open() as fin:
    base_setting = json.load(fin)
opencode_setting = base_setting.copy()

override_setting_filepath = Path("override.jsonc")
if override_setting_filepath.exists():
    with override_setting_filepath.open() as fin:
        override_setting = json.load(fin)
    for key, value in override_setting.items():
        opencode_setting[key] = value

opencode_setting_filepath = Path("opencode.jsonc")
with opencode_setting_filepath.open("w") as fout:
    json.dump(opencode_setting, fout, indent=2)
