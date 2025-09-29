local icon = require("packages.icons")

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.wrap = true

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.nu = true
vim.opt.rnu = true

vim.opt.ai = true
vim.opt.si = true

vim.opt.cursorline = true
vim.opt.termguicolors = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.g.loaded_matchparen = true
vim.cmd("syntax on")
vim.opt.timeoutlen = 300

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
vim.o.wrapscan = true
vim.o.swapfile = false
vim.opt.list = false
vim.api.nvim_set_hl(0, "NonText", { fg = "#4d4d4d", blend = 50 })

vim.g.indent_blankline_char = "▏"
vim.g.indent_blankline_show_current_context = true

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "NONE" })

-- noice
vim.api.nvim_set_hl(0, "NoicePopup", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NoicePopupBorder", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceScrollbarHandle", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NoiceScrollbar", { bg = "NONE" })

vim.api.nvim_set_hl(0, "NoicePopupmenu", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NoicePopupmenuBorder", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NoicePopupmenuSel", { bg = "NONE" })

vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#ffffff", bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#ffffff", bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#ffffff", bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#ffffff", bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })

vim.g.root_spec = { "cwd" }

-- disable startup message
vim.opt.laststatus = 0
-- vim.opt.shortmess:append("FI")
vim.opt.shortmess:append("Ifs")
vim.opt.showcmd = false

--split styles
vim.opt.fillchars = { vert = "▒" }
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.o.conceallevel = 2

-- Global settings
vim.opt.textwidth = 80
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.formatoptions = "tcqrn"

vim.opt_local.wrap = true
vim.opt_local.textwidth = 80
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

vim.diagnostic.config({
	virtual_text = {
		prefix = icon.task.Failure,
		format = function(diagnostic)
			local message = diagnostic.message
			local max_width = 50
			if #message > max_width then
				return message:sub(1, max_width) .. "..."
			end
			return message
		end,
	},
})

vim.keymap.set("n", "E", function()
	vim.diagnostic.open_float(nil, {
		scope = "cursor",
	})
end, { noremap = true, silent = true })
