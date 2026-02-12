require("mime-ext.local"):setup({
	-- Expand the existing filename database (lowercase), for example:
	with_files = {
		makefile = "text/makefile",
		["requirements.txt"] = "text/requirements",
	},

	-- Expand the existing extension database (lowercase), for example:
	with_exts = {
		mk = "text/makefile",
		ps1 = "text/x-powershell",
		["code-snippets"] = "text/code-snippets",
	},

	-- If the MIME type is not in both filename and extension databases,
	-- then fallback to Yazi's preset `mime.local` plugin, which uses `file(1)`
	fallback_file1 = false,
})
