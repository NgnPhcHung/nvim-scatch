function LogSelectionMacro()
	local selection = vim.fn.getreg("z")
	selection = selection:gsub("^%s*(.-)%s*$", "%1")
	local row = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(
		0,
		row,
		row,
		false,
		{ "console.log(" .. '"' .. selection .. '"' .. "," .. selection .. ");" }
	)
end

vim.api.nvim_set_keymap("v", "<leader>l", '"zy:lua LogSelectionMacro()<CR>', { noremap = true, silent = true })
