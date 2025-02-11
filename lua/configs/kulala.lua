require("kulala").setup({
	colorscheme = "catppuccin",
	lsp = {
		enable = true,
		servers = { "ts_ls", "eslint" },
	},
	treesitter = {
		ensure_installed = { "lua", "javascript", "typescript" },
		highlight = { enable = true },
	},
	opts = {
		display_mode = "split",
		formatters = {
			json = { "jq", "." },
			xml = { "xmllint", "--format", "-" },
			html = { "xmllint", "--format", "--html", "-" },
		},
		icons = {
			inlay = {
				loading = "󰔟",
				done = " ",
				error = " ",
			},
			lualine = " ",
		},
	},
})

vim.api.nvim_set_keymap(
	"n",
	"<leader>r",
	"<cmd>lua require('kulala').run()<CR>",
	{ noremap = true, silent = true, desc = "Execute the request" }
)
