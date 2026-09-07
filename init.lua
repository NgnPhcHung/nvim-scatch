vim.opt.termguicolors = true

require("options")
require("statusline")
require("keymap")
require("autocmds")
require("plugins")
require("configs.lsp") -- after plugins: needs blink.cmp capabilities
require("configs.session")
require("configs.transparent")
