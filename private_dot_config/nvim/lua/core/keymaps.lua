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
