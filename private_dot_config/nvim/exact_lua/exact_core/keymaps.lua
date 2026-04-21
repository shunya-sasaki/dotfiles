-- keymap
vim.g.mapleader = " "
vim.keymap.set("n", "Y", "yy", { silent = true, noremap = true })
vim.keymap.set("n", "<C-n>", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<C-p>", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-N>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>x", function()
  vim.diagnostic.open_float({
    focusable = false,
    close_events = {
      "CursorMoved",
      "CursorMovedI",
      "InsertEnter",
      "BufHidden",
      "InsertCharPre",
      "WinLeave",
    },
  })
end, { noremap = true, silent = true })

-- goto definition
vim.keymap.set("n", "gd", "<C-]>", { noremap = true, silent = true })
-- rename
vim.keymap.set("n", "gr", vim.lsp.buf.rename, { noremap = true, silent = true })
-- hover & scroll
vim.keymap.set("n", "gh", vim.lsp.buf.hover, { noremap = true, silent = true })

local luasnip = require("luasnip")
vim.keymap.set({ "i", "s" }, "<C-J>", function()
  luasnip.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-K>", function()
  luasnip.jump(-1)
end, { silent = true })

-- dap ------------------------------------------------------------------------
vim.keymap.set("n", "<F5>", function()
  require("dap").continue()
end)
vim.keymap.set("n", "<F10>", function()
  require("dap").step_over()
end)
vim.keymap.set("n", "<F11>", function()
  require("dap").step_into()
end)
vim.keymap.set("n", "<F12>", function()
  require("dap").step_out()
end)
vim.keymap.set("n", "<Leader>b", function()
  require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>B", function()
  require("dap").set_breakpoint()
end)
vim.keymap.set("n", "<Leader>lp", function()
  require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)
vim.keymap.set("n", "<Leader>dr", function()
  require("dap").repl.open()
end)
vim.keymap.set("n", "<Leader>dl", function()
  require("dap").run_last()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
  require("dap.ui.widgets").hover()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
  require("dap.ui.widgets").preview()
end)
vim.keymap.set("n", "<Leader>df", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set("n", "<Leader>ds", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end)

-- render-markdown ------------------------------------------------------------
vim.api.nvim_set_keymap("n", "<Leader>v", ":RenderMarkdown buf_toggle<CR>", { noremap = true, silent = true })
