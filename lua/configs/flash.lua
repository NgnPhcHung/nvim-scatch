require("flash").setup({
	labels = "abcdefghijklmnopqrstuvwxyz",
	modes = {
		search = {
			enabled = true,
		},
		char = {
			enabled = true,
		},
		treesitter = {
			enabled = true,
		},
		remote = {
			enabled = true,
		},
	},
})

vim.api.nvim_set_keymap("n", "s", "<cmd>lua require('flash').jump()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "s", "<cmd>lua require('flash').jump()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("o", "s", "<cmd>lua require('flash').jump()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "S", "<cmd>lua require('flash').treesitter()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "R", "<cmd>lua require('flash').remote()<CR>", { noremap = true, silent = true })
