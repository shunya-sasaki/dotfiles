return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      venvPath = ".",
      venv = ".venv",
      analysis = {
        ignore = { "*" },
      },
    },
  },
}
