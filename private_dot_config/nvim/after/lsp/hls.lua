return {
	cmd = { "haskell-language-server-wrapper", "--lsp" },
	filetypes = { "haskell", "lhaskell" },
	settings = {
		haskell = {
			cabalFormattingProvider = "cabal-fmt",
			formattingProvider = "ormolu",
		},
	},
}
