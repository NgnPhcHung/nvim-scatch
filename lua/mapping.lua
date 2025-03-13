vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

--Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files inital_mode=normal<CR>", { noremap = true, silent = true })
map("n", "<leader>fw", "<cmd>Telescope live_grep inital_mode=normal<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>")

map("n", "gi", "<cmd>Telescope lsp_implementations initial_mode=normal<CR>", opts)
map("n", "gr", "<cmd>Telescope lsp_references initial_mode=normal<CR>", opts)
map("n", "gD", "<cmd>Telescope lsp_type_definitions initial_mode=normal<CR>", opts)
map("n", "gd", "<cmd>Telescope lsp_definitions initial_mode=normal<CR>", opts)

vim.keymap.set("n", "<S-h>", function()
  require("telescope.builtin").buffers({
    initial_mode = "normal",
    previewer = false,
    layout_strategy = "center",
    layout_config = {
      width = 0.8,
      height = 0.4,
    },
  })
end, { desc = "Open telescope buffers list" })

vim.keymap.set("n", "<C-s>", ":w<CR>", opts)       -- Lưu file trong Normal mode
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", opts) -- Lưu file trong Insert mode
vim.keymap.set("i", "jk", "<Esc>", opts)

--tab/buffers actions
map("n", "<A-.>", ":BufferLineCycleNext<CR>", opts)
map("n", "<A-,>", ":BufferLineCyclePrev<CR>", opts)
for i = 1, 9 do
  map("n", "<A-" .. i .. ">", ":BufferLineGoToBuffer " .. i .. "<CR>", opts)
end
map("n", "<A-0>", ":BufferLast<CR>", opts)

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
map("n", "<A-l>", ":vertical resize -2<CR>", opts)
map("n", "<A-h>", ":vertical resize +2<CR>", opts)
map("n", "<A-k>", ":resize +2<CR>", opts)
map("n", "<A-j>", ":resize -2<CR>", opts)

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
vim.keymap.set("v", "<C-n>", "y'>pgv") -- Duplicate selection

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
vim.keymap.set("n", "rn", ":IncRename ")

map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action() initial_mode=normal<CR>", opts)

vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
vim.keymap.set(
  { "n", "v", "x" },
  "<leader>yy",
  '"+yy',
  { noremap = true, silent = true, desc = "Yank line to clipboard" }
)
