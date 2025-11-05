vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("init_lazy")

require("base")
require("mapping")

require("theme")

require("custom-config.autocmds")
require("custom-config.custom-snippet")
require("custom-config.persist-workspace")
require("debug-typescript")
