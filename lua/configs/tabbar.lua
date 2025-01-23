require('barbar').setup({
	animation = true,
	auto_hide = false,
	tabpages = true,
	clickable = false,
	icons = {
		buffer_index = true,
		filetype = { enabled = true },
		separator = { left = '▎', right = '|' },
	},

	padding = 2,
	maximum_length = 30,
	minimum_length = 10,

	hide = { extensions = false },
	no_name_title = "[No Name]",
	sidebar_filetypes = {
		NvimTree = true,
	},
})
