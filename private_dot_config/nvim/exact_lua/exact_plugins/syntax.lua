return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      ts = require("nvim-treesitter")
      ts.setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })
      languages = {
        "bash",
        "c",
        "c_sharp",
        "cmake",
        "css",
        "diff",
        "doxygen",
        "fortran",
        "git_config",
        "gitcommit",
        "gitignore",
        "gotmpl",
        "haskell",
        "html",
        "htmldjango",
        "http",
        "ini",
        "javascript",
        "jsdoc",
        "json",
        "kdl",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "mermaid",
        "nginx",
        "nix",
        "powershell",
        "python",
        "razor",
        "requirements",
        "rust",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "yaml",
      }
      ts.install(languages)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function()
          vim.treesitter.start()
        end,
      })
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0].foldmethod = "expr"
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  },
}
