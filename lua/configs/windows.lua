local opts = {
	autoresize = {
		enable = true,
		quickfixheight = 60,
		width = 0,
		minwidth = 0,
		maxwidth = 20,
		height = 0,
		minheight = 0,
		maxheight = 0,
	},
	excluded_buftypes = { "nofile", "prompt", "popup", "quickfix", "aerial" },
	excluded_filetypes = { "harpoon", "dbui", "sql" },
	compatible_filetrees = { "neo-tree" },
	ui = {
		signcolumn = false,
	},
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
