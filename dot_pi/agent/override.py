"""Override the default settings for Pi."""

import json
from pathlib import Path

base_setting_filepath = Path("base.json")
with base_setting_filepath.open() as fin:
    base_setting = json.load(fin)
pi_setting = base_setting.copy()

override_setting_filepath = Path("override.json")
if override_setting_filepath.exists():
    with override_setting_filepath.open() as fin:
        override_setting = json.load(fin)
    for key, value in override_setting.items():
        pi_setting[key] = value

pi_setting_filepath = Path("settings.json")
with pi_setting_filepath.open("w") as fout:
    json.dump(pi_setting, fout, indent=2)
