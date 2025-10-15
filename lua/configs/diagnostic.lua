local tiny = require("tiny-inline-diagnostic")

tiny.setup({
	preset = "ghost",
	transparent_bg = false,
	transparent_cursorline = true,

	hi = {
		error = "DiagnosticError",
		warn = "DiagnosticWarn",
		info = "DiagnosticInfo",
		hint = "DiagnosticHint",
		arrow = "NonText",
		background = "CursorLine",
		mixing_color = "Normal",
	},

	options = {
		add_messages = true,
		throttle = 20,
		softwrap = 30,
		enable_on_insert = false,
		enable_on_select = false,
		show_all_diags_on_cursorline = false,
		multilines = false,
		overflow = { mode = "wrap" },
		severity = {
			vim.diagnostic.severity.ERROR,
			vim.diagnostic.severity.WARN,
			vim.diagnostic.severity.INFO,
			vim.diagnostic.severity.HINT,
		},
	},
})

-- ────────────────────────────────
-- Dynamic switching: inline vs virtual_text
-- ────────────────────────────────

vim.diagnostic.config({ virtual_text = true }) -- default

local function update_diagnostics_mode()
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local line = cursor[1] - 1
	local diags = vim.diagnostic.get(bufnr, { lnum = line })

	if vim.fn.mode() == "i" then
		-- disable inline while typing
		tiny.disable()
		vim.diagnostic.config({ virtual_text = false })
		return
	end

	if #diags > 0 then
		tiny.enable()
		vim.diagnostic.config({ virtual_text = false })
	else
		tiny.disable()
		vim.diagnostic.config({ virtual_text = true })
	end
end

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorHold", "InsertLeave" }, {
	callback = update_diagnostics_mode,
})
