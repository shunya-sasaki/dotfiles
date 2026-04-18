return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      openFilesOnly = true,
    },
    analysis = {
      autoSearchPaths = true,
      diagnosticMode = "openFilesOnly",
      typeCheckingMode = "off",
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
