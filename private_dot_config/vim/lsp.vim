" yegappan/lsp (external plugin) -----------------------------------------------
autocmd User LspSetup call LspOptionsSet(#{
        \   aleSupport: v:false,
        \   autoComplete: v:false,
        \   autoHighlight: v:false,
        \   autoHighlightDiags: v:true,
        \   autoPopulateDiags: v:false,
        \   completionMatcher: 'case',
        \   completionMatcherValue: 1,
        \   diagSignErrorText: 'E>',
        \   diagSignHintText: 'H>',
        \   diagSignInfoText: 'I>',
        \   diagSignWarningText: 'W>',
        \   echoSignature: v:false,
        \   hideDisabledCodeActions: v:false,
        \   highlightDiagInline: v:true,
        \   hoverInPreview: v:false,
        \   completionInPreview: v:false,
        \   closePreviewOnComplete: v:true,
        \   ignoreMissingServer: v:false,
        \   keepFocusInDiags: v:true,
        \   keepFocusInReferences: v:true,
        \   completionTextEdit: v:true,
        \   diagVirtualTextAlign: 'above',
        \   diagVirtualTextWrap: 'default',
        \   noNewlineInCompletion: v:false,
        \   maxDiagnostics: 200,
        \   omniComplete: v:null,
        \   omniCompleteAllowBare: v:false,
        \   outlineOnRight: v:false,
        \   outlineWinSize: 20,
        \   popupBorder: v:true,
        \   popupBorderHighlight: 'Title',
        \   popupBorderHighlightPeek: 'Special',
        \   popupBorderSignatureHelp: v:false,
        \   popupHighlightSignatureHelp: 'Pmenu',
        \   popupHighlight: 'Normal',
        \   semanticHighlight: v:true,
        \   showDiagInBalloon: v:true,
        \   showDiagInPopup: v:true,
        \   showDiagOnStatusLine: v:false,
        \   showDiagWithSign: v:true,
        \   showDiagWithVirtualText: v:false,
        \   showInlayHints: v:false,
        \   showSignature: v:true,
        \   showSignatureDocs: v:false,
        \   snippetSupport: v:true,
        \   ultisnipsSupport: v:false,
        \   useBufferCompletion: v:false,
        \   usePopupInCodeAction: v:false,
        \   useQuickfixForLocations: v:false,
        \   vsnipSupport: v:true,
        \   bufferCompletionTimeout: 100,
        \   customCompletionKinds: v:false,
        \   completionKinds: {},
        \   filterCompletionDuplicates: v:false,
        \   condensedCompletionMenu: v:false,
        \   documentationFormat: ['markdown', 'plaintext'],
    \ })


let lspServers = [ 
    \ #{
    \    name: 'bash-language-server',
    \    filetype: ['sh'],
    \    path: 'bash-language-server',
    \    args: ['start'],
    \    workspaceConfig: #{
    \      bashIde: #{
    \        globPattern: "*@(.sh|.inc|.bash|.command)"
    \      }
    \    }
    \  },
    \ #{
    \    name: 'rust-analyzer',
    \    filetype: ['rust'],
    \    path: 'rust-analyzer',
    \  },
    \ #{
    \    name: 'dprint',
    \    filetype: ['markdown'],
    \    path: 'dprint',
    \    args: ['lsp'],
    \    workspaceConfig: #{
    \      useTabs: v:false,
    \      markdown: #{
    \        newLineKind: "lf",
    \        textWrap: "maintain"
    \      }
    \    }
    \  },
    \ #{
    \    name: 'clangd',
    \    filetype: ['c', 'cpp'],
    \    path: 'clangd',
    \    args: ['--background-index']
    \  },
    \ #{
    \    name: 'ruff',
    \    filetype: ['python'],
    \    path: 'ruff',
    \    args: ['server'],
    \    features: #{
    \      hover: v:false
    \    },
    \ },
    \ #{
    \    name: 'ty',
    \    filetype: ['python'],
    \    path: 'ty',
    \    args: ['server'],
    \    workspaceConfig: #{
    \      ty: #{ }
    \    }
    \ },
    \ #{
    \    name: 'pyright',
    \    filetype: ['python'],
    \    path: 'pyright-langserver',
    \    args: ['--stdio'],
    \    workspaceConfig: #{
    \      pyright: #{
    \        disableOrganizeImports: v:true,
    \      },
    \      python: #{
    \        venvPath: '',
    \        venv: '.venv',
    \        analysis: #{
    \          ignore: ['*']
    \        }
    \   }}
    \ },
    \ #{
    \    name: 'biome',
    \    filetype: ['typescript', 'javascript',
    \               'typescriptreact', 'javascriptreact',
    \               'json', 'jsonc'],
    \    path: 'biome',
    \    args: ['lsp-proxy']
    \ },
    \ #{
    \    name: 'vtsls',
    \    filetype: ['typescript', 'javascript', 'typescriptreact', 'javascriptreact'],
    \    path: 'vtsls',
    \    args: ['--stdio']
    \ },
    \ #{
    \    name: 'vscode-css-language-server',
    \    filetype: ['css', 'scss', 'less'],
    \    path: 'vscode-css-language-server',
    \    args: ['--stdio']
    \ },
    \ #{
    \    name: 'vscode-html-language-server',
    \    filetype: ['html', 'css', 'javascript'],
    \    path: 'vscode-html-language-server',
    \    args: ['--stdio']
    \ },
    \ #{
    \    name: 'taplo',
    \    filetype: ['toml'],
    \    path: 'taplo',
    \    args: ['lsp', 'stdio'],
    \ },
    \ #{
    \    name: 'nginx-language-server',
    \    filetype: ['nginx'],
    \    path: 'nginx-language-server',
    \ },
    \ #{
    \    name: 'docker-language-server',
    \    filetype: ['dockerfile', 'yaml.docker-compose'],
    \    path: 'docker-language-server',
    \    args: ['start', '--stdio'],
    \ }
    \ ]

autocmd User LspSetup call LspAddServer(lspServers)

autocmd FileType markdown autocmd BufWritePre <buffer> silent! LspFormat
autocmd FileType python autocmd BufWritePre <buffer> silent! LspFixAll
autocmd FileType typescript autocmd BufWritePre <buffer> silent! LspFixAll
autocmd FileType typescriptreact autocmd BufWritePre <buffer> silent! LspFixAll
autocmd FileType javascript autocmd BufWritePre <buffer> silent! LspFixAll
autocmd FileType javascriptreact autocmd BufWritePre <buffer> silent! LspFixAll
autocmd FileType json autocmd BufWritePre <buffer> silent! LspFormat
autocmd FileType jsonc autocmd BufWritePre <buffer> silent! LspFormat
autocmd FileType nginx autocmd BufWritePre <buffer> silent! LspFormat
autocmd FileType dockerfile autocmd BufWritePre <buffer> silent! LspFormat
autocmd FileType yaml.docker-compose autocmd BufWritePre <buffer> silent! LspFormat

