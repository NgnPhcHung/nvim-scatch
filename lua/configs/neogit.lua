require("neogit").setup({
	popup = {
		kind = "floating",
	},
	integrations = {
		diffview = false,
	},
})

vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", { desc = "Open Neogit", silent = true })
vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { desc = "Git commit", silent = true })
vim.keymap.set("n", "<leader>gp", ":Neogit push<CR>", { desc = "Git push", silent = true })
vim.keymap.set("n", "<leader>gl", ":Neogit pull<CR>", { desc = "Git pull", silent = true })
