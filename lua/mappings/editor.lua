local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Save
map("n", "<C-s>", ":w<CR>", opts)
map("i", "<C-s>", "<Esc>:w<CR>a", opts)
map("i", "jk", "<Esc>", opts)

-- Buffers
map("n", ";a", ":BufferCloseAllButPinned<CR>", opts)
map("n", ";w", function()
	require("utils.buffer").smart_close()
end, opts)
map("n", "<A-.>", ":bn<cr>", opts)
map("n", "<A-,>", ":bp<cr>", opts)

-- Tabs
map("n", "te", ":tabedit<CR>", opts)
map("n", "tc", "<cmd>close<cr>", opts)

-- Window splits
map("n", "|", ":vsplit<Return>", opts)
map("n", "-", ":split<Return>", opts)

-- Switch windows
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize windows
map("n", "<leader><left>", ":vertical resize +2<CR>", opts)
map("n", "<leader><right>", ":vertical resize -2<CR>", opts)
map("n", "<leader><up>", ":resize +2<CR>", opts)
map("n", "<leader><down>", ":resize -2<CR>", opts)

-- Editing
map("i", "<C-z>", "<C-o>u", opts)
map("n", "<leader>a", "gg<S-v>G", opts)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves Line Down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves Line Up" })
map("i", "<C-BS>", "<C-W>", opts)

-- Clipboard
map({ "n", "v" }, "<leader>y", '"+y', opts)
map("n", "<leader>yy", '"+yy', opts)

-- Search
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("n", "<esc><esc>", function()
	vim.cmd("nohlsearch")
	require("notify").dismiss({ silent = true, pending = true })
end, { desc = "Clear search highlight & notifications" })
