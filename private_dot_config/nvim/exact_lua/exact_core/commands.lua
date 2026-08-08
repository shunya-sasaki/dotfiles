local utils = require("utils")

vim.api.nvim_create_user_command("LSPFormatOrganizeImportsBiome", function()
  utils.call_code_action_synchronously("biome", "source.organizeImports.biome")
end, { desc = "Organize imports with Biome" })

vim.api.nvim_create_user_command("CloseAllNotify", function()
  require("notify").dismiss({ silent = true, pending = true })
end, { desc = "Close all notifications" })
vim.cmd([[cab can CloseAllNotify]])
