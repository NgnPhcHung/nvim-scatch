vim.g.everforest_background = "hard"
vim.g.everforest_better_performance = 1
vim.g.everforest_enable_italic = 1

vim.cmd.colorscheme("everforest")

local function apply_diagnostic_hl()
	vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#e5c07b" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#e5c07b" })
	vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#e5c07b" })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = "#e5c07b", undercurl = true })
	vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { fg = "#e5c07b" })
end

apply_diagnostic_hl()
vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("DiagnosticWarnHL", { clear = true }),
	callback = apply_diagnostic_hl,
})
