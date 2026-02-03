local map = vim.keymap.set
local _99 = require("99")

map("n", "<leader>9f", function()
	_99.fill_in_function()
end, { desc = "99: Fill function body" })

map("n", "<leader>9p", function()
	_99.fill_in_function_prompt()
end, { desc = "99: Fill function with prompt" })

map("v", "<leader>9v", function()
	_99.visual()
end, { desc = "99: Transform selection" })

map("v", "<leader>9p", function()
	_99.visual_prompt()
end, { desc = "99: Transform selection with prompt" })

map("n", "<leader>9s", function()
	_99.stop_all_requests()
end, { desc = "99: Stop all requests" })

map("n", "<leader>9l", function()
	_99.view_logs()
end, { desc = "99: View logs" })

map("n", "<leader>9i", function()
	_99.info()
end, { desc = "99: Info" })

map("n", "<leader>9q", function()
	_99.previous_requests_to_qfix()
end, { desc = "99: Requests to quickfix" })
