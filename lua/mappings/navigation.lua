local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files initial_mode=normal<CR>", opts)
map("n", "<leader>fw", "<cmd>Telescope live_grep initial_mode=normal<CR>", opts)
map("n", "<leader>ps", "<cmd>Telescope grep_string<CR>", opts)

-- File explorer
map("n", "<leader>e", ":Neotree toggle reveal<CR>", { desc = "File explorer toggle" })

-- Aerial (code outline)
map("n", "<leader>ol", "<cmd>AerialToggle<CR>", opts)
map("n", "[a", "<cmd>AerialPrev<CR>", opts)
map("n", "]a", "<cmd>AerialNext<CR>", opts)

-- Flash (enhanced jump)
map("n", "s", "<cmd>lua require('flash').jump()<CR>", opts)
map("x", "s", "<cmd>lua require('flash').jump()<CR>", opts)
map("o", "s", "<cmd>lua require('flash').jump()<CR>", opts)
map("n", "S", "<cmd>lua require('flash').treesitter()<CR>", opts)
map("n", "R", "<cmd>lua require('flash').remote()<CR>", opts)
