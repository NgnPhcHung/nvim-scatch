vim.g.mapleader = " "

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

--Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files inital_mode=normal <CR>", { noremap = true, silent = true })
map("n", "<leader>fw", "<cmd>Telescope live_grep inital_mode=normal<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", ":Neotree toggle reveal<CR>", { desc = "File explorer toggle" })

map("n", "gi", "<cmd>Telescope lsp_implementations initial_mode=normal<CR>", opts)
map("n", "gr", "<cmd>Telescope lsp_references initial_mode=normal<CR>", opts)
map("n", "gD", "<cmd>Telescope lsp_type_definitions initial_mode=normal<CR>", opts)
map("n", "gd", "<cmd>Telescope lsp_definitions initial_mode=normal<CR>", opts)
vim.keymap.set("n", "<leader>ps", "<cmd>Telescope grep_string<CR>")


vim.keymap.set("n", "<C-s>", ":w<CR>", opts)       -- Save file in normal mode
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", opts) -- Save file in insert mode
vim.keymap.set("i", "jk", "<Esc>", opts)

map("n", "<A-a>", ":BufferCloseAllButPinned<CR>", opts)
map("n", "<A-w>", "<Cmd>Bdelete<CR>", opts)

map("n", "te", ":tabedit<CR>", opts)
map("n", "tc", ":close<CR>", opts)

--window
map("n", "|", ":vsplit<Return>", opts)
map("n", "-", ":split<Return>", opts)

--swich window
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

--resize window
map("n", "<leader><left>", ":vertical resize +2<CR>", opts)
map("n", "<leader><right>", ":vertical resize -2<CR>", opts)
map("n", "<leader><up>", ":resize +2<CR>", opts)
map("n", "<leader><down>", ":resize -2<CR>", opts)

vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true })

--file actions
map("i", "<C-z>", "<C-o>u", opts)
map("i", "<C-s>", "<C-o>:w<CR>", opts)
map("n", "<C-a>", "gg<S-v>G", opts)

-- Visual mode editing
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves Line Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves Line Up" })

-- Delete word in insert mode
vim.keymap.set("i", "<C-BS>", "<C-W>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.keymap.set("n", "<F5>", function()
      local filepath = vim.fn.expand("%")
      local file_without_ext = vim.fn.expand("%:r")

      require("toggleterm").exec(
        "g++ -std=c++17 " .. filepath .. " -o " .. file_without_ext .. " && ./" .. file_without_ext,
        1,
        nil,
        "horizontal"
      )
    end, { desc = "Compile and run C++ file", buffer = true })
  end,
})


--gitactions
map("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", opts)
vim.keymap.set("n", "<leader>ng", ":Neogit<CR>", { noremap = true, silent = true, desc = "Open Neogit" })

--rename
vim.keymap.set("n", "<leader>rn", ":IncRename ")

map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action() initial_mode=normal<CR>", opts)

vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
vim.keymap.set(
  { "n", "v", "x" },
  "<leader>yy",
  '"+yy',
  { noremap = true, silent = true, desc = "Yank line to clipboard" }
)

map("n", "<A-.>", ":bn<cr>", opts)              -- next buffer
map("n", "<A-,>", ":bp<cr>", opts)              -- prev buffer
map("n", "<esc><esc>", ":nohlsearch<cr>", opts) -- no highlight

map("n", "n", "nzzzv", opts)                    -- focus highlight next
map("n", "N", "Nzzzv", opts)                    -- focus hight prev

map('n', '<leader>ol', '<cmd>AerialToggle<CR>', opts)
map('n', '[a', '<cmd>AerialPrev<CR>', opts)
map('n', ']a', '<cmd>AerialNext<CR>', opts)

map("n", "s", "<cmd>lua require('flash').jump()<CR>", opts)
map("x", "s", "<cmd>lua require('flash').jump()<CR>", opts)
map("o", "s", "<cmd>lua require('flash').jump()<CR>", opts)
map("n", "S", "<cmd>lua require('flash').treesitter()<CR>", opts)
map("n", "R", "<cmd>lua require('flash').remote()<CR>", opts)

map(
  "n",
  "<leader>rr",
  "<cmd>lua require('kulala').run()<CR>",
  { noremap = true, silent = true, desc = "Execute the request" }
)

vim.keymap.set("n", "<leader>un",
  function()
    require("notify").dismiss({ silent = true, pending = true })
  end,
  {
    desc = "dismiss All Notifications",
  }
)
