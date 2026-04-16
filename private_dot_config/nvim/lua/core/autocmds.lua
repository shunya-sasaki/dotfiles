local utils = require("utils")

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "typescript",
    "typescriptreact",
  },
  callback = function(args)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        utils.call_code_action_synchronously("biome", "source.fixAll.biome")
        utils.call_code_action_synchronously("biome", "source.organizeImports.biome")
        utils.call_format_synchronously("biome")
      end,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "python",
  },
  callback = function(args)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        utils.call_code_action_synchronously("ruff", "source.fixAll.ruff")
        utils.call_code_action_synchronously("ruff", "source.organizeImports.ruff")
        utils.call_format_synchronously("ruff")
      end,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "c",
    "cpp",
    "cs",
    "css",
    "h",
    "haskell",
    "hpp",
    "html",
    "lua",
    "markdown",
    "nix",
    "rust",
  },
  callback = function(args)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
})

-- tabwidth dynamic
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "c",
    "cpp",
    "css",
    "h",
    "hpp",
    "html",
    "javascript",
    "json",
    "jsonc",
    "lua",
    "markdown",
    "mdx",
    "typescript",
    "typescriptreact",
  },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == "ruff" then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Ruff",
})
