return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				direction = "float",
				float_opts = {
					width = vim.o.columns,
					height = vim.o.lines,
				},
			})
			local Terminal = require("toggleterm.terminal").Terminal

			local term = Terminal:new({
				hidden = true,
				direction = "float",
				count = 1,
			})

			local lazygit = Terminal:new({
				cmd = "lazygit",
				hidden = true,
				direction = "float",
				count = 2,
			})

			local gemini = Terminal:new({
				cmd = "gemini",
				hidden = true,
				direction = "float",
				count = 3,
			})

			function Lazygit_toggle()
				lazygit:toggle()
			end

			function Gemini_toggle()
				gemini:toggle()
			end

			vim.api.nvim_set_keymap(
				"n",
				"<leader>g",
				"<cmd>lua Lazygit_toggle()<CR>",
				{ noremap = true, silent = true }
			)

			vim.api.nvim_set_keymap("n", "<leader>i", "<cmd>lua Gemini_toggle()<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>t", ": ToggleTerm<CR>", { silent = true, noremap = true })
			vim.api.nvim_set_keymap("n", "<C-t>", ": ToggleTerm<CR>", { silent = true, noremap = true })
		end,
	},
}
