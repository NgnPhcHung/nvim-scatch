vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function load_configs_from_directory(directory)
	local config_files = vim.fn.globpath(directory, "*.lua", false, true)
	for _, file in ipairs(config_files) do
		local module_name = file:match("lua/(.*)%.lua"):gsub("/", ".")
		require(module_name)
	end
end

require("init_lazy")

load_configs_from_directory(vim.fn.stdpath("config") .. "/lua/configs")

require("base")
require("mapping")

require("theme")

load_configs_from_directory(vim.fn.stdpath("config") .. "/lua/custom-config")
