vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<C-f>f', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
map('n', '<C-f>w', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
map('n', '<C-f>b', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
map('n', '<C-b>', '<cmd>NvimTreeToggle<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<C-s>', ':w<CR>', opts)       -- Lưu file trong Normal mode
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', opts) -- Lưu file trong Insert mode
vim.keymap.set('i', 'jk', '<Esc>', opts)


--tab/buffers actions
map('n', '<A-,>', ':BufferPrevious<CR>', opts)
map('n', '<A-.>', ':BufferNext<CR>', opts)
for i = 1, 9 do
  map('n', '<A-' .. i .. '>', ':BufferGoto ' .. i .. '<CR>', opts)
end
map('n', '<A-0>', ':BufferLast<CR>', opts)
map('n', '<A-w>w', '<Cmd>BufferClose<CR>', opts)
map('n', '<A-k>w', ':BufferCloseAllButCurrent<CR>', opts)

map('n', '<C-a>', 'gg<S-v>G', opts)
map('n', 'te<CR>', ':tabedit', opts)

--window
map('n', '|', ':split<Return>', opts)
map('n', '-', ':vsplit<Return>', opts)

--swich window
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

--resize window
map('n', '<A-Right>', ':vertical resize +2<CR>', opts)
map('n', '<A-Left>', ':vertical resize -2<CR>', opts)
map('n', '<A-Up>', ':resize +2<CR>', opts)
map('n', '<A-Down>', ':resize -2<CR>', opts)

vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true })

map('i', '<C-z>', '<C-o>u', opts)
map('i', '<C-s>', '<C-o>:w<CR>', opts)

-- Visual mode editing
vim.keymap.set("v", "N", ":m '>+1<CR>gv=gv") -- Move selection up
vim.keymap.set("v", "M", ":m '<-2<CR>gv=gv") -- Move selection down
vim.keymap.set('v', "<C-n>", "y'>pgv")       -- Duplicate selection

-- Delete word in insert mode
vim.keymap.set('i', '<C-BS>', '<C-W>', { noremap = true, silent = true })

-- cpp compiler
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.keymap.set("n", "<F5>", function()
        local filepath = vim.fn.expand("%")
        local file_without_ext = vim.fn.expand("%:r")

        require("toggleterm").exec(
          "g++ -std=c++17" .. filepath .. " -o " .. file_without_ext .. " && ./" .. file_without_ext,
          1,
          nil,
          "horizontal"
        )
      end,
      { desc = "Compile and run C++ file" })
  end,
})

vim.keymap.set("n", "<leader>fm", function()
  vim.lsp.buf.format({ async = true })
end, opts)


--gitactions
map('n', '<leader>gh', ':Gitsigns preview_hunk<CR>', opts)
vim.keymap.set('n', '<leader>ng', ':Neogit<CR>', { noremap = true, silent = true, desc = "Open Neogit" })
