local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Gitsigns
map("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", opts)

-- Neogit
map("n", "<leader>ng", ":Neogit<CR>", { desc = "Open Neogit" })
