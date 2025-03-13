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

vim.opt.wrap = true

vim.opt.cursorline = true
vim.opt.termguicolors = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.g.loaded_matchparen = true
vim.cmd("syntax on")
vim.opt.ttimeoutlen = 0

vim.opt.list = true
-- vim.opt.listchars = {
--   tab = "→ ",
--   trail = "•",
--   eol = "↴",
-- }
-- vim.api.nvim_set_hl(0, "Whitespace", { fg = "#4d4d4d", blend = 20 })
vim.api.nvim_set_hl(0, "NonText", { fg = "#4d4d4d", blend = 50 })

vim.g.indent_blankline_char = "▏"
vim.g.indent_blankline_show_current_context = true

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


vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "n:*",
  callback = function()
    vim.opt.lazyredraw = true
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*:i",
  callback = function()
    vim.opt.lazyredraw = false
  end,
})

vim.cmd([[
  highlight! link NormalFloat Normal
  highlight! link FloatBorder Normal
  highlight! Pmenu guibg=NONE
  highlight! PmenuSel guibg=#333333 guifg=#ffffff
]])

vim.cmd([[
  highlight NormalFloat guibg=#0d1b2a
  highlight FloatBorder guifg=#3e6072 guibg=#0d1b2a
]])
vim.cmd([[
  highlight FloatTitle guifg=#a9d6e5 guibg=#0d1b2a
]])
