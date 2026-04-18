return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      -- Markdown
      vim.lsp.enable("dprint")
      vim.lsp.enable("markdown_oxide")
      -- C/C++
      vim.lsp.enable("clangd")
      vim.lsp.enable("cmake")
      -- C#
      vim.lsp.enable("csharp_ls")
      -- Fortran
      vim.lsp.enable("fortls")
      -- Rust
      vim.lsp.enable("rust_analyzer")
      -- Json
      vim.lsp.enable("biome")
      -- HTML/CSS
      vim.lsp.enable("html")
      vim.lsp.enable("cssls")
      -- TypeScript
      vim.lsp.enable("vtsls")
      vim.lsp.enable("tailwindcss")
      -- Python
      vim.lsp.enable("ruff")
      vim.lsp.enable("ty")
      vim.lsp.enable("basedpyright")
      -- TOML
      vim.lsp.enable("taplo")
      -- NGINX
      vim.lsp.enable("nginx")
      -- Lua
      vim.lsp.enable("stylua")
      -- Hasskell
      vim.lsp.enable("hls")
      -- Shell/Bash
      vim.lsp.enable("bashls")
      -- PowerShell
      vim.lsp.enable("powershell_es")
      -- Nix
      vim.lsp.enable("nixd")
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
    end,
  },
}
