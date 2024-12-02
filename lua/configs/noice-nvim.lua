require("noice").setup({
	cmdline = {
		enabled = true,
		view = "cmdline_popup",
	},
	messages = {
		enabled = true,
		view = "notify",
	},
	lsp = {
		progress = {
			enabled = true,
		},
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = false,
			["vim.lsp.util.stylize_markdown"] = false,
			["cmp.entry.get_documentation"] = false,
		},
	},
})
