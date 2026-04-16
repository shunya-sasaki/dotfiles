-- luacheck: globals vim
-- user config
Config = {
  with_nf = true,
}
-- check os
if vim.fn.has("win32") == 1 then
  Config.os_name = "win32"
elseif vim.fn.has("win64") == 1 then
  Config.os_name = "win64"
else
  local script_path = debug.getinfo(1).source:match("@?(.*/)")
  package.path = package.path .. ";" .. script_path .. "?.lua"
  Config.os_name = require("util").get_os_name()
end
-- system setting
vim.opt.fileformat = "unix"
vim.opt.fileformats = { "unix", "dos" }
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number,line"
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = "utf-8,iso-2022-jp,ucs-bom,default"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

if Config.os_name == "wsl" then
  vim.opt.clipboard = "unnamedplus"
  vim.g.clipboard = {
    name = "myClipboard",
    copy = {
      ["+"] = "win32yank.exe -i",
      ["*"] = "win32yank.exe -i",
    },
    paste = {
      ["+"] = "win32yank.exe -o",
      ["*"] = "win32yank.exe -o",
    },
    cache_enabled = 1,
  }
else
  if vim.env.SSH_CONNECTION then
    vim.opt.clipboard = "unnamed,unnamedplus"
    vim.g.clipboard = {
      name = "OSC 52",
      copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
      },
      paste = {
        ["+"] = paste,
        ["*"] = paste,
      },
    }
  else
    vim.opt.clipboard = "unnamedplus"
    vim.g.clipboard = nil
  end
end

vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.matchtime = 1
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.pumheight = 10
vim.opt.laststatus = 3
vim.opt.completeopt = "menuone,noinsert"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.termguicolors = true
vim.opt.updatetime = 500
vim.opt.ttimeoutlen = 10
vim.opt.timeoutlen = 500
vim.opt.foldlevel = 99

-- keymap
vim.g.mapleader = " "
vim.keymap.set("n", "Y", "yy", { silent = true, noremap = true })
vim.keymap.set("n", "<C-n>", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<C-p>", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-N>", { noremap = true, silent = true })
-- custom commands
vim.api.nvim_create_user_command("CloseAllNotify", function()
  require("notify").dismiss({ silent = true, pending = true })
end, { desc = "Close all notifications" })
vim.cmd([[cab can CloseAllNotify]])
vim.api.nvim_create_user_command("ConfigUserInit", ":e " .. vim.fn.stdpath("config") .. "/lua/local/user_init.lua", {})
vim.api.nvim_create_user_command(
  "ConfigUserPlugins",
  ":e " .. vim.fn.stdpath("config") .. "/lua/local/plugins/user_plugins.lua",
  {}
)
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
-- filetype
vim.filetype.add({
  filename = {
    [".gitattributes"] = "gitattributes",
  },
  pattern = {
    [".*/.flake8"] = "ini",
  },
  extension = {
    ["code-snippets"] = "json",
    mdx = "markdown",
    razor = "razor",
  },
})

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
        call_code_action_synchronously("biome", "source.fixAll.biome")
        call_code_action_synchronously("biome", "source.organizeImports.biome")
        call_format("biome")
      end,
    })
  end,
})

function full_document_range(bufnr)
  local last_line = vim.api.nvim_buf_line_count(bufnr) - 1
  local last_text = (vim.api.nvim_buf_get_lines(bufnr, last_line, last_line + 1, true)[1] or "")
  return {
    start = { line = 0, character = 0 },
    ["end"] = { line = last_line, character = #last_text },
  }
end

function call_format_synchronously(lsp_name)
  vim.lsp.buf.format({
    async = false,
    filter = function(client)
      return client.name == lsp_name
    end,
  })
end

function call_code_action_synchronously(lsp_name, code_action)
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, name = lsp_name })
  if #clients == 0 then
    return
  end
  local params = vim.lsp.util.make_range_params(0, clients[1].offset_encoding)
  params.context = {
    only = { code_action },
    diagnostics = {},
  }
  params.range = full_document_range(bufnr)
  local timeout_ms = 3000
  local response = clients[1]:request_sync("textDocument/codeAction", params, timeout_ms, bufnr)

  if not response or not response.result then
    vim.notify("No response from " .. lsp_name .. " for organizing imports", vim.log.levels.WARN)
    return
  end

  local action = nil
  for _, res in ipairs(response.result or {}) do
    if res.isPreferred then
      action = res
      break
    end
  end
  if not action then
    return
  end
  local resolved = clients[1]:request_sync("codeAction/resolve", action, timeout_ms, bufnr)

  if resolved and resolved.result then
    action = resolved.result
  end
  if action.edit then
    vim.lsp.util.apply_workspace_edit(action.edit, clients[1].offset_encoding)
  elseif action.command then
    clients[1]:execute_command(action.command)
  end
end

vim.api.nvim_create_user_command("LSPFormatOrganizeImportsBiome", function()
  call_organize_imports_biome()
end, { desc = "Organize imports with Biome" })

-- auto fixAll
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "python",
  },
  callback = function(args)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        call_code_action_synchronously("ruff", "source.fixAll.ruff")
        call_code_action_synchronously("ruff", "source.organizeImports.ruff")
        call_format_synchronously("ruff")
      end,
    })
  end,
})
-- auto format
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

-- python: auto-detect .venv in project root
local venv_path = vim.fn.getcwd() .. "/.venv"
if vim.fn.isdirectory(venv_path) == 1 then
  vim.env.VIRTUAL_ENV = venv_path
  if Config.os_name == "win32" or Config.os_name == "win64" then
    vim.g.python3_host_prog = venv_path .. "/Scripts/python.exe"
  else
    vim.g.python3_host_prog = venv_path .. "/bin/python3"
  end
else
  vim.g.python3_host_prog = "python3"
end
-- ruby
vim.g.loaded_ruby_provider = 0
-- perl
vim.g.loaded_perl_provider = 0

local agent = require("util").get_nvim_agent()
vim.api.nvim_set_keymap("n", "<C-A-i>", ":term " .. agent .. "<CR>i<CR>", { silent = true, noremap = true })

-- user config
local local_init = vim.fn.stdpath("config") .. "/lua/local/user_init.lua"
if vim.loop.fs_stat(local_init) then
  require("local.user_init")
end
require("config.lazy")
