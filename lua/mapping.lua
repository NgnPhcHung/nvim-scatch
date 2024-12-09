local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

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
map('n', 'te', ':tabedit', opts)

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

--gitactions
map('n', '<leader>gh', ':Gitsigns preview_hunk<CR>', opts)
-- cpp compiler
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	callback = function()
		vim.keymap.set("n", "<F5>", function()
				vim.cmd([["<C-\>"]])
				vim.cmd("<cmd>!g++ -std=c++17 % -o %< && ./%<<CR>")
			end,
			{ desc = "Compile and run C++ file" })
	end,
})

map('n', 'tgt', ':Telescope git_status<CR>', opts)
