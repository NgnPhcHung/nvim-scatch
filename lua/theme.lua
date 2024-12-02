return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	opts = require("ui.theme-config").config,
	config = function(_, opts)
		require("gruvbox").setup(opts)
		vim.opt.background = "dark"
		vim.cmd.colorscheme("gruvbox")
	end,
}
