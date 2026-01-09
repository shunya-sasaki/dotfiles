function is_copilot_enable()
	local disable_copilot = os.getenv("DISABLE_COPILOT")
	if not disable_copilot or disable_copilot == "0" then
		return true
	else
		return false
	end
end

return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		dependencies = {
			"zbirenbaum/copilot-cmp",
		},
		enabled = is_copilot_enable(),
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
				copilot_model = "gpt-5.1-codex-mini",
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		enabled = is_copilot_enable(),
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
