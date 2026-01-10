local map = vim.keymap.set
local opts = { noremap = true, silent = true }

--Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files initial_mode=normal <CR>", { noremap = true, silent = true })
map("n", "<leader>fw", "<cmd>Telescope live_grep initial_mode=normal<CR>", { noremap = true, silent = true })
map("n", "<leader>e", ":Neotree toggle reveal<CR>", { desc = "File explorer toggle" })

map("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded" })
end)

map("n", "<leader>ti", function()
	local clients = vim.lsp.get_clients({ bufnr = 0, name = "typescript-tools" })
	if #clients == 0 then
		vim.notify("TypeScript Tools is not running. Starting now...", vim.log.levels.WARN)
		vim.cmd("LspStart typescript-tools")
		vim.defer_fn(function()
			vim.cmd("TSToolsAddMissingImports")
		end, 1000)
	else
		vim.cmd("TSToolsAddMissingImports")
	end
end, { desc = "Add missing import in .ts .tsx file" })

map("n", "<leader>to", function()
	local clients = vim.lsp.get_clients({ bufnr = 0, name = "typescript-tools" })
	if #clients == 0 then
		vim.notify("TypeScript Tools is not running. Starting now...", vim.log.levels.WARN)
		vim.cmd("LspStart typescript-tools")
		vim.defer_fn(function()
			vim.cmd("TSToolsOrganizeImports")
		end, 1000)
	else
		vim.cmd("TSToolsOrganizeImports")
	end
end, { desc = "Organize import in .ts .tsx file" })

map("n", "gi", "<cmd>Telescope lsp_implementations initial_mode=normal<CR>", opts)
map("n", "gr", "<cmd>Telescope lsp_references initial_mode=normal<CR>", opts)
map("n", "gD", "<cmd>Telescope lsp_type_definitions initial_mode=normal<CR>", opts)
map("n", "gd", "<cmd>Telescope lsp_definitions initial_mode=normal<CR>", opts)
map("n", "<leader>ps", "<cmd>Telescope grep_string<CR>", opts)

map("n", "<C-s>", ":w<CR>", opts) -- Save file in normal mode
map("i", "<C-s>", "<Esc>:w<CR>a", opts) -- Save file in insert mode
map("i", "jk", "<Esc>", opts)

map("n", ";a", ":BufferCloseAllButPinned<CR>", opts)
map("n", ";w", ":bdelete<CR>", opts)

map("n", "te", ":tabedit<CR>", opts)
map("n", "tc", ":close<CR>", opts)

--window
map("n", "|", ":vsplit<Return>", opts)
map("n", "-", ":split<Return>", opts)

--switch window
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

--resize window
map("n", "<leader><left>", ":vertical resize +2<CR>", opts)
map("n", "<leader><right>", ":vertical resize -2<CR>", opts)
map("n", "<leader><up>", ":resize +2<CR>", opts)
map("n", "<leader><down>", ":resize -2<CR>", opts)

-- vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true })
-- vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true })
-- vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true })
-- vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true })

--file actions
map("i", "<C-z>", "<C-o>u", opts)
map("i", "<C-s>", "<C-o>:w<CR>", opts)
map("n", "<leader>a", "gg<S-v>G", opts)

-- Visual mode editing
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves Line Down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves Line Up" })

-- Delete word in insert mode
map("i", "<C-BS>", "<C-W>", { noremap = true, silent = true })

--gitactions
map("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", opts)
map("n", "<leader>ng", ":Neogit<CR>", { noremap = true, silent = true, desc = "Open Neogit" })

--rename
map("n", "<leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { noremap = true, silent = true, expr = true, desc = "Incremental rename" })

map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action() initial_mode=normal<CR>", opts)

map({ "n", "v" }, "<leader>y", '"+y', opts)
map("n", "<leader>yy", '"+yy', opts)

map("n", "<A-.>", ":bn<cr>", opts) -- next buffer
map("n", "<A-,>", ":bp<cr>", opts) -- prev buffer
map("n", "<esc><esc>", function()
	vim.cmd("nohlsearch")
	require("notify").dismiss({ silent = true, pending = true })
end, { noremap = true, silent = true, desc = "Clear search highlight & notifications" })

map("n", "n", "nzzzv", opts) -- focus highlight next
map("n", "N", "Nzzzv", opts) -- focus hight prev

map("n", "<leader>ol", "<cmd>AerialToggle<CR>", opts)
map("n", "[a", "<cmd>AerialPrev<CR>", opts)
map("n", "]a", "<cmd>AerialNext<CR>", opts)

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

--claude-code
map("n", "<leader>cc", "<cmd>ClaudeCode<CR>", { desc = "Toggle Claude Code" })
map("t", "<C-,>", "<cmd>ClaudeCode<CR>", { desc = "Toggle Claude Code from terminal" })
map("n", "<leader>ce", "<cmd>ClaudeCodeContinue<CR>", { desc = "Claude Code continue" })
map("n", "<leader>cR", "<cmd>ClaudeCodeResume<CR>", { desc = "Claude Code resume" })
map("n", "<leader>cV", "<cmd>ClaudeCodeVerbose<CR>", { desc = "Claude Code verbose" })

------------------------
