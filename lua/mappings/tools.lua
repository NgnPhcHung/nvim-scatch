local map = vim.keymap.set

-- Kulala REST client
map("n", "<leader>rr", "<cmd>lua require('kulala').run()<CR>", { desc = "Execute the request" })
