require("plugins")
require("mapping")
require("theme")
require("base")
-- persist current working workspace
require('custom-config.persist-workspace')

local function load_configs_from_directory(directory)
	local config_files = vim.fn.globpath(directory, "*.lua", false, true)
	for _, file in ipairs(config_files) do
		local module_name = file:match("lua/(.*)%.lua"):gsub("/", ".")
		require(module_name)
	end
end

load_configs_from_directory(vim.fn.stdpath("config") .. "/lua/configs")
load_configs_from_directory(vim.fn.stdpath("config") .. "/lua/custom-config")


vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.o.wrapscan = true
