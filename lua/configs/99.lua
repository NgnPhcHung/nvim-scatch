local _99 = require("99")
local providers = require("99.providers")

_99.setup({
	provider = providers.ClaudeCodeProvider,
	model = "claude-sonnet-4-6",
	tmp_dir = ".99",
	auto_add_skills = true,
	display_errors = true,
})

vim.keymap.set("v", "<leader>9v", function() _99.visual() end, { desc = "99: Transform selection", silent = true })
vim.keymap.set("n", "<leader>9s", function() _99.search() end, { desc = "99: Search project", silent = true })
vim.keymap.set("n", "<leader>9x", function() _99.stop_all_requests() end, { desc = "99: Stop requests", silent = true })
