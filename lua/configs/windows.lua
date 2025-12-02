return function()
	vim.o.winwidth = 10
	vim.o.winminwidth = 10
	vim.o.equalalways = true

	local windows = require("focus")
	windows.setup({
		enable = true,
		winwidth = 30,

		autoresize = {
			enable = true,
			minwidth = 20,
			width = 120,
		},
	})
end
