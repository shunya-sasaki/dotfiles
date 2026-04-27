require("mime-ext.local"):setup({
  -- Expand the existing filename database (lowercase), for example:
  with_files = {
    makefile = "text/makefile",
    vimrc = "text/vim",
    config = "text/config",
    ["requirements.txt"] = "text/requirements",
    [".gitattributes"] = "text/gitattributes",
    ["dot_zshrc"] = "text/zsh",
    ["dot_bashrc"] = "text/bash",
    [".chezmoiignore"] = "text/chezmoiignore",
    ["dockerfile"] = "text/dockerfile",
  },

  -- Expand the existing extension database (lowercase), for example:
  with_exts = {
    mk = "text/makefile",
    ps1 = "text/x-powershell",
    vim = "text/vim",
    kdl = "text/kdl",
    ["code-snippets"] = "text/code-snippets",
    ["json.tmpl"] = "text/json",
  },

  -- If the MIME type is not in both filename and extension databases,
  -- then fallback to Yazi's preset `mime.local` plugin, which uses `file(1)`
  fallback_file1 = false,
})
