local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

config.color_scheme = "Tokyo Night"
config.window_background_opacity = 0.9
config.max_fps = 120
config.dpi = 144

config.initial_cols = 80
config.initial_rows = 30
config.font = wezterm.font_with_fallback({
	"Moralerspace Neon HW",
	"Monaspace Neon",
	"Symbols Nerd Font Mono",
	"Moralerspace Neon HW",
	"FiraCode Nerd Font",
	"IBM Plex Sans JP",
	"Apple Color Emoji",
})
config.harfbuzz_features = {
	"calt=1",
	"liga=1",
	"ss01=1",
	"ss02=1",
	"ss03=1",
	"ss04=1",
	"ss05=1",
	"ss06=1",
	"ss07=1",
	"ss08=1",
	"ss09=1",
	"ss10=1",
}

-- Set the default shell based on the target platform
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh.exe" }
	config.font_size = 12
	config.enable_kitty_graphics = false
elseif wezterm.target_triple == "aarch64-apple-darwin" then
	config.default_prog = { "/bin/zsh" }
	config.font_size = 12
	config.enable_kitty_graphics = true
else
	config.default_prog = { "/bin/bash" }
	config.font_size = 12
	config.enable_kitty_graphics = true
end

wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = "TABLE: " .. name
	end
	window:set_right_status(name or "")
end)

local custom_leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
local custom_keys = {
	{
		key = "i",
		mods = "CTRL|ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		key = "a",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "resize_pane",
			timeout_milliseconds = 1000,
			one_shot = false,
		}),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		key = "t",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	-- Activate pane
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	-- Activate tab relative to current
	{
		key = "[",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "]",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(1),
	},
	-- Activate copy mode
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},
	-- Paste from clipboard
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{
		key = ",",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = "Rename Tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

local custom_key_tables = {
	resize_pane = {
		{
			key = "h",
			mods = "SHIFT",
			action = wezterm.action.AdjustPaneSize({ "Left", 1 }),
		},
		{
			key = "l",
			mods = "SHIFT",
			action = wezterm.action.AdjustPaneSize({ "Right", 1 }),
		},
		{
			key = "k",
			mods = "SHIFT",
			action = wezterm.action.AdjustPaneSize({ "Up", 1 }),
		},
		{
			key = "j",
			mods = "SHIFT",
			action = wezterm.action.AdjustPaneSize({ "Down", 1 }),
		},
	},
}

config.disable_default_key_bindings = true
config.leader = custom_leader
config.keys = custom_keys
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end
config.key_tables = custom_key_tables

wezterm.on("user-var-changed", function(window, pane, name, value)
	if name == "TMUX_MODE" then
		local overrides = window:get_config_overrides() or {}
		if value == "1" then
			overrides.disable_default_key_bindings = false
			overrides.keys = {}
			overrides.key_tables = {}
			overrides.leader = { key = "_", mods = "CTRL|ALT|SUPER" }
		else
			overrides = nil
		end
		window:set_config_overrides(overrides)
	end
end)

return config
