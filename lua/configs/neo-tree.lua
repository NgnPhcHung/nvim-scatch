require("neo-tree").setup({
	close_if_last_window = true,
	window = {
		position = "float",
		mappings = {
			["<Tab>"] = "toggle_node",
		},
	},
	filesystem = {
		hijack_netrw_behavior = "open_current",
		follow_current_file = { enabled = true },
		filtered_items = {
			-- show dotfiles (.env) and gitignored files
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
		},
	},
})
