return function()
	-- ============================================
	-- 1. Core Diagnostic Configuration
	-- ============================================
	local icon_status_ok, icon = pcall(require, "packages.icons")

	local signs = {
		Error = (icon_status_ok and icon.diagnostics and icon.diagnostics.Error) or "✘",
		Warn = (icon_status_ok and icon.diagnostics and icon.diagnostics.Warn) or "▲",
		Hint = (icon_status_ok and icon.diagnostics and icon.diagnostics.Hint) or "⚑",
		Info = (icon_status_ok and icon.diagnostics and icon.diagnostics.Info) or "»",
	}

	vim.diagnostic.config({
		virtual_text = {
			prefix = function(diagnostic)
				local severity = vim.diagnostic.severity[diagnostic.severity]
				return signs[severity] or "●"
			end,
			format = function(diagnostic)
				local message = diagnostic.message
				local max_width = 50
				if #message > max_width then
					return message:sub(1, max_width) .. "..."
				end
				return message
			end,
		},
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = signs.Error,
				[vim.diagnostic.severity.WARN] = signs.Warn,
				[vim.diagnostic.severity.HINT] = signs.Hint,
				[vim.diagnostic.severity.INFO] = signs.Info,
			},
		},
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	})

	-- ============================================
	-- 2. Tiny Inline Diagnostic
	-- ============================================
	local tiny_status_ok, tiny = pcall(require, "tiny-inline-diagnostic")
	if not tiny_status_ok then
		return
	end

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

	-- Dynamic switching: inline vs virtual_text
	local function update_diagnostics_mode()
		local bufnr = vim.api.nvim_get_current_buf()
		local cursor = vim.api.nvim_win_get_cursor(0)
		local line = cursor[1] - 1
		local diags = vim.diagnostic.get(bufnr, { lnum = line })

		if vim.fn.mode() == "i" then
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
end
