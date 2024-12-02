require("telescope").setup {
	defaults = {
		mapping = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false
			},
		},
	},
	pickers = {
		find_files = {
			theme = "dropdown"
		}
	}
}

require('telescope').load_extension('fzf')

vim.api.nvim_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', { noremap = true, silent = true })
