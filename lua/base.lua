local icon_status_ok, icon = pcall(require, "packages.icons")
local failure_icon = icon_status_ok and icon.task.Failure or "❌"

vim.cmd("syntax on")
vim.g.loaded_matchparen = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd("scriptencoding utf-8")
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.timeoutlen = 300

vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.o.conceallevel = 2

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.fillchars = { vert = "▒" }

vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.shortmess:append("Ifs")

vim.o.swapfile = false
vim.o.wrapscan = true
vim.opt.list = false

vim.o.autoread = true
vim.o.updatetime = 300

vim.o.undofile = false

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.formatoptions = "tcqrn"
vim.opt.textwidth = 80

vim.opt_local.wrap = true
vim.opt_local.textwidth = 80
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.spelllang = "en_us"
vim.o.spell = true

vim.g.root_spec = { "cwd" }

vim.api.nvim_set_hl(0, "NonText", { fg = "#4d4d4d", blend = 50 })
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "none" })
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "none" })
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "none" })

vim.diagnostic.config({
	virtual_text = {
		prefix = failure_icon,
		format = function(diagnostic)
			local message = diagnostic.message
			local max_width = 50
			if #message > max_width then
				return message:sub(1, max_width) .. "..."
			end
			return message
		end,
	},
	signs = true,
})

vim.keymap.set("n", "E", function()
	vim.diagnostic.open_float(nil, {
		scope = "cursor",
		focus = false,
	})
end, { noremap = true, silent = true, desc = "Open diagnostic float" })
