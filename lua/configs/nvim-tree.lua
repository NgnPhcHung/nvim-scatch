require("nvim-tree").setup({
	view = {
		side = "left",
		adaptive_size = true,
	},
	renderer = {
		icons = {
			glyphs = {
				default = "",
				symlink = "",
			},
		},
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
		-- update_root = false,
	},
	filters = {
		dotfiles = false, -- Show dotfiles like .env, .gitignore,
		-- hidden = true
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 1000,
	},
})
