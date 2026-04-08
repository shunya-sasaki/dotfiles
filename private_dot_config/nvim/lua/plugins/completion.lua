return {
	{
		"L3MON4D3/LuaSnip",
		version = "2.*",
		build = "make install_jsregexp",
		opts = {
			history = true,
			delete_check_events = "TextChanged", -- tidy up removed snippet text  [oai_citation:2‡github.com](https://github.com/L3MON4D3/LuaSnip?utm_source=chatgpt.com)
		},
		opts = function(_, opts)
			local luasnip = require("luasnip")
			local vscode_snippets_path = {
				vim.fn.expand(vim.env.HOME .. "/.config/snippets"),
			}
			require("luasnip.loaders.from_vscode").load({
				paths = vscode_snippets_path,
			})
			vim.keymap.set({ "i", "s" }, "<C-J>", function()
				luasnip.jump(1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-K>", function()
				luasnip.jump(-1)
			end, { silent = true })
		end,
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			"giuxtaposition/blink-cmp-copilot",
		},
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "enter" },
			appearance = {
				nerd_font_variant = "normal",
			},
			completion = { documentation = { auto_show = true } },
			snippets = {
				preset = "luasnip",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "copilot" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
