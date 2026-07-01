local starter = require("mini.starter")

starter.setup({
	evaluate_single = true,
	items = {
		-- {
		-- 	name = "Load workspace",
		-- 	action = function()
		-- 		require("configs.session").load()
		-- 	end,
		-- 	section = "Commands",
		-- },
		{
			name = "Find file",
			action = function()
				require("fzf-lua").files()
			end,
			section = "Commands",
		},
		-- { name = "Tree (neo-tree)", action = function() vim.cmd("Neotree toggle reveal=false dir=" .. vim.fn.getcwd()) end, section = "Commands" },
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
