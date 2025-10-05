local icon = require("packages.icons")

local nvim_notify = require("notify")

nvim_notify.setup({
	stages = "static",
	timeout = 5000,
	-- position = "top_right",
	max_width = function()
		return math.floor(vim.o.columns * 0.75)
	end,
	max_height = function()
		return math.floor(vim.o.lines * 0.75)
	end,
	top_down = false,
	icons = {
		ERROR = icon.diagnostics.Error,
		WARN = icon.diagnostics.Warning,
		INFO = icon.diagnostics.Info,
		DEBUG = "",
		TRACE = "",
	},
	render = "compact",
})

vim.notify = nvim_notify
