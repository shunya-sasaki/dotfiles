return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Markdown
			vim.lsp.enable("markdown_oxide")
			-- C/C++
			vim.lsp.enable("clangd")
			vim.lsp.enable("cmake")
			-- C#
			vim.lsp.enable("csharp_ls")
			-- Rust
			vim.lsp.enable("rust_analyzer")
			-- Json
			vim.lsp.enable("biome")
			-- HTML/CSS
			vim.lsp.enable("html")
			vim.lsp.enable("cssls")
			-- TypeScript
			vim.lsp.enable("vtsls")
			vim.lsp.enable("tailwindcss")
			-- Python
			vim.lsp.enable("ruff")
			vim.lsp.enable("ty")
			-- TOML
			vim.lsp.enable("taplo")
			-- NGINX
			vim.lsp.enable("nginx")
			-- Lua
			vim.lsp.enable("stylua")
			-- Shell/Bash
			vim.lsp.enable("bashls")
			-- PowerShell
			vim.lsp.enable("powershell_es")
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{
				"neovim/nvim-lspconfig",
			},
			{
				"mason-org/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
		},
		opts = function(_, opts)
			opts.automatic_installation = true
			opts.ensure_installed = {}
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		opts = {
			ensure_installed = {},
		},
		dependencies = { "nvimtools/none-ls.nvim" },
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvimtools/none-ls-extras.nvim" },
		opts = function(_, opts)
			local null_ls = require("null-ls")
			opts.sources = {}
			opts.on_init = function(new_client, _)
				new_client.offset_encoding = "utf-16"
			end
		end,
	},
}
