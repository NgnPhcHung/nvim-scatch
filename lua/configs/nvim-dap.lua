local dap = require("dap")

dap.configurations.lua = {
	{
		type = "nlua",
		request = "attach",
		name = "Attach to running instance",
	},
}

dap.adapters.nlua = function(callback, config)
	callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
end

vim.fn.sign_define("DapBreakpoint", { text = "D", texthl = "", linehl = "", numhl = "" })

-- keymap config for nvim-dap

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "[_Debugger]c", "<Cmd>lua require'dap'.continue()<CR>", opts)
vim.api.nvim_set_keymap("n", "[_Debugger]n", "<Cmd>lua require'dap'.step_over()<CR>", opts)
vim.api.nvim_set_keymap("n", "[_Debugger]i", "<Cmd>lua require'dap'.step_into()<CR>", opts)
vim.api.nvim_set_keymap("n", "[_Debugger]o", "<Cmd>lua require'dap'.step_out()<CR>", opts)
vim.api.nvim_set_keymap("n", "[_Debugger]R", "<Cmd>lua require'dap'.repl.open()<CR>", opts)
vim.api.nvim_set_keymap(
	"n",
	"[_Debugger]B",
	"<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"[_Debugger]l",
	"<Cmd>lua require'dap'.load_launchjs()<CR>",
	{ noremap = true, silent = true }
)
