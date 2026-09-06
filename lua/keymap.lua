vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<esc><esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape edit mode" })

vim.keymap.set("n", ";w", ":bdelete<CR>", { desc = "Close buffer" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

vim.keymap.set("n", "<leader>.", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>,", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "|", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "tc", ":close<CR>", { desc = "Close splitted window" })

vim.keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

vim.keymap.set("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy full file path" })

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy file to machine copy" })

vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file explorer", silent = true })

vim.keymap.set("n", "<leader>a", "ggVG", { desc = "Select all" })
