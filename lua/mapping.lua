local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.wrap = true

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.nu = true
vim.opt.rnu = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.ai = true
vim.opt.si = true

vim.opt.wrap = true

vim.opt.cursorline = true
vim.opt.termguicolors = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.cmd("syntax on")

map('n', '<C-f>f', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
map('n', '<C-f>w', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
map('n', '<C-f>b', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
map('n', '<C-b>', '<cmd>NvimTreeToggle<CR>', { noremap = true, silent = true })

--tab/buffers actions
map('n', '<A-,>', ':BufferPrevious<CR>', opts)
map('n', '<A-.>', ':BufferNext<CR>', opts)
map('n', '<A-1>', ':BufferGoto 1<CR>', opts)
map('n', '<A-2>', ':BufferGoto 2<CR>', opts)
map('n', '<A-3>', ':BufferGoto 3<CR>', opts)
map('n', '<A-4>', ':BufferGoto 4<CR>', opts)
map('n', '<A-5>', ':BufferGoto 5<CR>', opts)
map('n', '<A-6>', ':BufferGoto 6<CR>', opts)
map('n', '<A-7>', ':BufferGoto 7<CR>', opts)
map('n', '<A-8>', ':BufferGoto 8<CR>', opts)
map('n', '<A-9>', ':BufferGoto 9<CR>', opts)
map('n', '<A-0>', ':BufferLast<CR>', opts)
map('n', '<A-w>w', '<Cmd>BufferClose<CR>', opts)
map('n', '<A-k>w', ':BufferCloseAllButCurrent<CR>', opts)

map('n', '<C-a>', 'gg<S-v>G', opts)
map('n', 'te<CR>', ':tabedit', opts)

--window
map('n', 'sw', ':split<Return>', opts)
map('n', 'sv', ':vsplit<Return>', opts)

--swich window
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

--resize window
map('n', '<A-<right>>', '<C-w>>', opts)
map('n', '<A-<left>>', '<C-w><', opts)
map('n', '<A-<up>>', '<C-w>+', opts)
map('n', '<A-<down>>', '<C-w>-', opts)

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


vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, opts)

--gitactions
map('n', '<leader>gh', ':Gitsigns preview_hunk<CR>', opts)
vim.keymap.set('n', '<leader>ng', ':Neogit<CR>', { noremap = true, silent = true, desc = "Open Neogit" })


map("n", "s", "<cmd>lua require('flash').jump()<CR>", { noremap = true, silent = true })
map("o", "s", "<cmd>lua require('flash').jump()<CR>", { noremap = true, silent = true })
map("x", "s", "<cmd>lua require('flash').jump()<CR>", { noremap = true, silent = true })
