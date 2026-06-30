vim.o.winwidth = 10
vim.o.winminwidth = 10
vim.o.equalalways = false

require("windows").setup({
	autowidth = {
		enable = true,
		winwidth = 1.5,
	},
	ignore = {
		buftype = { "quickfix" },
		filetype = { "NvimTree", "neo-tree", "undotree", "gundo" },
	},
	animation = {
		enable = true,
		duration = 200,
		fps = 30,
		easing = "in_out_sine",
	},
})
