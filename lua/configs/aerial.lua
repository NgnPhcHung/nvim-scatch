return {
	expand_lines = false,
	attach_mode = "window",
	autojump = false,
	close_automatic_events = {},
	show_guides = true,
	backends = { "lsp", "treesitter", "markdown", "man" },
	layout = {
		resize_to_content = false,
		min_width = 40,
		max_width = 40,
		default_direction = "right",
		placement = "edge",
		preserve_equality = false,
		win_opts = {
			winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
			signcolumn = "yes",
			statuscolumn = " ",
			winfixwidth = true,
		},
	},
	guides = {
		mid_item = "├╴",
		last_item = "└╴",
		nested_top = "│ ",
		whitespace = "  ",
	},
	on_attach = function(bufnr)
		vim.api.nvim_set_option_value("winfixwidth", true, { win = 0 })
	end,
}
