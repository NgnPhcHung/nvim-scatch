-- lua/base.lua (Phiên bản đã làm sạch)

-- 1. UTILS & SETUP BAN ĐẦU
-- =================================================================
local icon_status_ok, icon = pcall(require, "packages.icons")
local failure_icon = icon_status_ok and icon.task.Failure or "❌"

-- Bật syntax highlight (Cần thiết cho Treesitter hoạt động đúng)
vim.cmd("syntax on")
-- Tắt các plugin cũ không cần thiết (đã làm đúng)
vim.g.loaded_matchparen = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 2. ENCODING & TIMEOUT
-- =================================================================
vim.cmd("scriptencoding utf-8")
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.timeoutlen = 300

-- 3. CÁC TÙY CHỌN HIỂN THỊ (UI & Layout)
-- =================================================================
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.o.conceallevel = 2

-- Relative/Absolute Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Split Windows
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.fillchars = { vert = "▒" }

-- Status/Command Line
vim.opt.laststatus = 3 -- Global Statusline
vim.opt.showcmd = false
vim.opt.shortmess:append("Ifs")

-- 4. THAO TÁC FILE & UNDO
-- =================================================================
vim.o.swapfile = false
vim.o.wrapscan = true
vim.opt.list = false

-- Persistent Undo
local undodir = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end
vim.o.undodir = undodir
vim.o.undofile = true

-- 5. THAO TÁC CHỈNH SỬA (Indentation & Text)
-- =================================================================
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Format/Wrap Settings
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.formatoptions = "tcqrn"
vim.opt.textwidth = 80

-- Áp dụng settings cục bộ (cho Buffer hiện tại)
vim.opt_local.wrap = true
vim.opt_local.textwidth = 80
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Spell Check
vim.o.spelllang = "en_us"
vim.o.spell = true

-- 6. BIẾN TOÀN CỤC (Globals)
-- =================================================================
vim.g.root_spec = { "cwd" }
-- XÓA CÁC BIẾN CŨ CỦA INDENT-BLANKLINE DƯỚI ĐÂY (NẾU KHÔNG CÒN DÙNG)
-- vim.g.indent_blankline_char = "▏"
-- vim.g.indent_blankline_show_current_context = true

-- 7. HIGHLIGHTS CƠ BẢN (Đặt float/border về 'none' cho nền trong suốt)
-- =================================================================
-- Highlight chung
vim.api.nvim_set_hl(0, "NonText", { fg = "#4d4d4d", blend = 50 })
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

-- Highlight cho cửa sổ Float/Popup
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })

-- Highlight cho Popupmenu (Completion/Cmdline)
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "none" })
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "none" })
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "none" })

-- Highlights cho Telescope (NÊN CHUYỂN SANG CONFIG CỦA TELESCOPE.LUA)
-- vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#ffffff", bg = "none" })
-- ... (các highlight khác của Telescope)

-- 8. DIAGNOSTICS & KEYMAPS
-- =================================================================

-- Diagnostic Configuration
vim.diagnostic.config({
	virtual_text = {
		prefix = failure_icon,
		format = function(diagnostic)
			local message = diagnostic.message
			local max_width = 50
			-- Truncate message
			if #message > max_width then
				return message:sub(1, max_width) .. "..."
			end
			return message
		end,
	},
	signs = true,
})

-- Keymap để mở float diagnostic ở vị trí con trỏ
vim.keymap.set("n", "E", function()
	vim.diagnostic.open_float(nil, {
		scope = "cursor",
		focus = false,
	})
end, { noremap = true, silent = true, desc = "Mở Diagnostic Float" })
