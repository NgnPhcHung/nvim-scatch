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

vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  space = "·",
  trail = "•",
  eol = "↴",
}
vim.api.nvim_set_hl(0, "Whitespace", { fg = "#2f3030", blend = 20 })
vim.api.nvim_set_hl(0, "NonText", { fg = "#2f3030", blend = 50 })

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
