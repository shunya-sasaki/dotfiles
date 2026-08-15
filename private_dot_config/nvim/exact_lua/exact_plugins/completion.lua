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
      local vscode_snippets_path = {
        vim.fn.expand(vim.env.HOME .. "/.config/snippets"),
      }
      require("luasnip.loaders.from_vscode").load({
        paths = vscode_snippets_path,
      })
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = {},
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
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {},
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
