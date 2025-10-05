local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Header
dashboard.section.header.val =
	vim.fn.readfile(vim.fs.normalize("~/.config/nvim/lua/custom-config/files/my_header_banner.txt"))
dashboard.section.header.opts.hl = "Question"

-- Buttons
dashboard.section.buttons.val = {
	dashboard.button("l", "  Restore Workspace", ":WorkspaceLoad<CR>"),

	dashboard.button("q", "󰅚  Quit NVIM", "<cmd>qa<CR>"),
}

-- Footer with Lazy stats
vim.api.nvim_create_autocmd("User", {
	pattern = "LazyVimStarted",
	callback = function()
		local stats = require("lazy").stats()
		dashboard.section.footer.val = string.format("⚡ Plugins loaded: %d/%d", stats.loaded or 0, stats.count or 0)
		pcall(vim.cmd.AlphaRedraw)
	end,
})

-- Setup
alpha.setup(dashboard.config)
