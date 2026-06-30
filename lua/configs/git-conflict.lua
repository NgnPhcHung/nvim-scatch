require("git-conflict").setup({
	default_mappings = true,
	-- default keymaps:
	-- co - accept ours
	-- ct - accept theirs
	-- cb - accept both
	-- c0 - accept none
	-- ]x - next conflict
	-- [x - prev conflict
	disable_diagnostics = false,
})
