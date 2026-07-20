local starter = require("mini.starter")

starter.setup({
	evaluate_single = true,
	items = {
		{
			name = "File explorer",
			action = function()
        	require("telescope").extensions.file_browser.file_browser()
			end,
			section = "Commands",
		},
		{
			name = "Git",
			action = function()
				vim.cmd("Neogit")
			end,
			section = "Commands",
		},
		{ name = "Quit", action = "qall", section = "Commands" },
	},
	content_hooks = {
		starter.gen_hook.adding_bullet(),
		starter.gen_hook.aligning("center", "center"),
	},
})
