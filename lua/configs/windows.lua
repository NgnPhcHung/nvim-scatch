local opts = {
	autoresize = {
		enable = true,
		quickfixheight = 60,
		width = 0, -- Force min width for unfocused windows
		minwidth = 0, -- Minimum width for unfocused windows
		maxwidth = 20, -- Maximum width for unfocused windows
		height = 0, -- Force min height for unfocused windows
		minheight = 0, -- Minimum height for unfocused windows
		maxheight = 0, -- Maximum height for unfocused windows
	},
	excluded_buftypes = { "nofile", "prompt", "popup", "quickfix", "aerial" },
	excluded_filetypes = { "harpoon", "dbui", "sql" },
	compatible_filetrees = { "neo-tree" },
}

return {
	"nvim-focus/focus.nvim",
	config = function()
		require("focus").setup(opts)
		local ignore_filetypes = { "harpoon", "grapple", "aerial" }
		local ignore_buftypes = { "nofile", "prompt", "popup", "quickfix", "aerial" }

		local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

		vim.api.nvim_create_autocmd("WinEnter", {
			group = augroup,
			callback = function(_)
				if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
					vim.b.focus_disable = true
				end
			end,
			desc = "Disable focus autoresize for BufType",
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = augroup,
			callback = function(_)
				if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
					vim.b.focus_disable = true
				end
			end,
			desc = "Disable focus autoresize for FileType",
		})

		vim.cmd("FocusEqualise")
	end,
	cmd = {
		"FocusSplitDown",
		"FocusSplitRight",
		"FocusMaximise",
		"FocusEqualise",
		"FocusToggle",
	},
}
