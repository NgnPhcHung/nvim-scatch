local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		path_display = { "smart" },
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
			n = {
				["d"] = require("telescope.actions").delete_buffer,
				["q"] = require("telescope.actions").close,
			},
		},
	},
	pickers = {
		find_files = {
			theme = "dropdown",
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
			specifc_opts = {
				codeactions = true,
			},
		},
	},
	config = function()
		require("telescope").load_extension("ui-select")
		-- require("telescope").load_extension("fzf")
	end,
})
