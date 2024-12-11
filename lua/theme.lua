return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function(_, opts)
		require("kanagawa").setup(opts)
		vim.opt.background = "dark"
		vim.cmd.colorscheme("kanagawa-dragon")
	end,
}
