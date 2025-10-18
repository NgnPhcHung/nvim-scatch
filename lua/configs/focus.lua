return {
	enable = true, -- Enable module
	commands = true, -- Create Focus commands
	excluded_filetypes = {
		"undotree",
		"neo-tree",
		"alpha",
		"TelescopePrompt",
		"aerial",
	},
	excluded_buftypes = { "nofile", "prompt", "popup" },

	autoresize = {
		enable = true,
		width = 0,
		height = 0,
		minwidth = 20,
		minheight = 0,
		focusedwindow_minwidth = 0,
		focusedwindow_minheight = 0,
		height_quickfix = 10,
	},
	split = {
		bufnew = false,
	},
}
