return function()
	vim.o.winwidth = 10
	vim.o.winminwidth = 10
	vim.o.equalalways = false
	require("windows").setup({
		autowidth = {
			enable = true,
			winwidth = 5,
			filetype = {
				help = 2,
			},
		},
		ignore = {
			buftype = { "quickfix", "nofile", "prompt", "popup" },
			filetype = { "neo-tree", "alpha", "TelescopePrompt", "aerial", "undotree" },
		},
		animation = {
			enable = true,
			duration = 150,
			fps = 60,
			easing = "in_out_sine",
		},
	})
end
