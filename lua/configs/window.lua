require("focus").setup({
	enable = true, -- Enable module
	commands = true, -- Create Focus commands
	excluded_filetypes = {
		"undotree",
		"neo-tree",
		"alpha",
		"TelescopePrompt", -- Example, if you use Telescope
		"aerial",
	},
	excluded_buftypes = { "nofile" },
	autoresize = {
		enable = true, -- Enable or disable auto-resizing of splits
		width = 0, -- Force width for the focused window
		height = 0, -- Force height for the focused window
		minwidth = 20, -- Force minimum width for the unfocused window
		minheight = 0, -- Force minimum height for the unfocused window
		focusedwindow_minwidth = 0, --Force minimum width for the focused window
		focusedwindow_minheight = 0, --Force minimum height for the focused window
		height_quickfix = 10, -- Set the height of quickfix panel
	},
	split = {
		bufnew = false, -- Create blank buffer for new split windows
	},
})

local ignore_filetypes = { "aerial" }
local ignore_buftypes = { "nofile", "prompt", "popup" }

local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

vim.api.nvim_create_autocmd("WinEnter", {
	group = augroup,
	callback = function(_)
		if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
			vim.w.focus_disable = true
		else
			vim.w.focus_disable = false
		end
	end,
	desc = "Disable focus autoresize for BufType",
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	callback = function(_)
		if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
			vim.b.focus_disable = true
		else
			vim.b.focus_disable = false
		end
	end,
	desc = "Disable focus autoresize for FileType",
})
