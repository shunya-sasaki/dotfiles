-- luacheck: globals vim
-- load utils
local utils = require("utils")
-- check os
local os_name = utils.get_os_name()
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

if os_name == "wsl" then
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

-- python: auto-detect .venv in project root
local venv_path = vim.fn.getcwd() .. "/.venv"
if vim.fn.isdirectory(venv_path) == 1 then
  vim.env.VIRTUAL_ENV = venv_path
  if os_name == "win32" or os_name == "win64" then
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

require("config.lazy")

require("core.autocmds")
require("core.commands")
require("core.keymaps")
