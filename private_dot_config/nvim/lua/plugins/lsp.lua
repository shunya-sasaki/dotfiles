return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.enable("csharp_ls")
			vim.lsp.enable("rust_analyzer")
			vim.lsp.enable("powershell_es")
			-- Markdown
			vim.lsp.enable("markdown_oxide")
			-- C/C++
			vim.lsp.enable("clangd")
			vim.lsp.enable("cmake")
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
			opts.ensure_installed = {
				"csharp_ls",
				"powershell_es",
			}
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		opts = {
			ensure_installed = {
				"cpplint",
				"clang-format",
				"csharpier",
				"prettier",
				"stylua",
				"shfmt",
			},
		},
		dependencies = { "nvimtools/none-ls.nvim" },
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvimtools/none-ls-extras.nvim" },
		opts = function(_, opts)
			local null_ls = require("null-ls")
			opts.sources = {
				require("none-ls.diagnostics.cpplint"),
				null_ls.builtins.formatting.shfmt.with({ filetypes = { "sh", "zsh", "ksh", "csh" } }),
				null_ls.builtins.formatting.clang_format.with({ filetypes = { "c", "cpp", "h", "hpp" } }),
				null_ls.builtins.formatting.csharpier.with({ filetypes = { "cs" } }),
				null_ls.builtins.formatting.stylua.with({ filetypes = { "lua" } }),
				null_ls.builtins.formatting.prettier.with({
					filetypes = { "markdown", "html" },
					extra_args = { "--ignore-path", ".prettierignore" },
				}),
			}
			opts.on_init = function(new_client, _)
				new_client.offset_encoding = "utf-16"
			end
		end,
	},
}
