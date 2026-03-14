return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	settings = {
		python = {
			venvPath = ".",
			venv = ".venv",
		},
	},
}
