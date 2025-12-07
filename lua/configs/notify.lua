return function()
	local nvim_notify = require("notify")

	local icon_status_ok, icon = pcall(require, "packages.icons")

	local notify_icons = {
		ERROR = icon_status_ok and icon.diagnostics.Error or "E",
		WARN = icon_status_ok and icon.diagnostics.Warning or "W",
		INFO = icon_status_ok and icon.diagnostics.Info or "I",
		DEBUG = "", -- Giữ nguyên icon Debug
		TRACE = "", -- Giữ nguyên icon Trace
	}

	nvim_notify.setup({
		stages = "fade",
		timeout = 2000,
		top_down = false,

		max_width = function()
			return math.floor(vim.o.columns * 0.5)
		end,
		max_height = function()
			return math.floor(vim.o.lines * 0.5)
		end,
		icons = notify_icons,
		render = "compact",
	})

	vim.notify = nvim_notify

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "notify",
		callback = function(event)
			vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
			vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = event.buf, silent = true })
		end,
	})
end
