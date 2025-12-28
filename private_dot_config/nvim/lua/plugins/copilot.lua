return {
	"zbirenbaum/copilot.lua",
	dependencies = {
		"copilotlsp-nvim/copilot-lsp",
	},
	enabled = function()
		return not os.getenv("DISABLE_COPILOT")
	end,
}
