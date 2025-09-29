require("aerial").setup({
	expand_lines = false,
	attach_mode = "window",
	autojump = false,
	close_automatic_events = {},
	show_guides = true,
	backends = { "lsp", "treesitter", "markdown", "man" },
	layout = {
		resize_to_content = false,
		min_width = 40,
		win_opts = {
			winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
			signcolumn = "yes",
			statuscolumn = " ",
		},
	},
	guides = {
		mid_item = "├╴",
		last_item = "└╴",
		nested_top = "│ ",
		whitespace = "  ",
	},
})
