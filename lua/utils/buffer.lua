local M = {}

function M.smart_close()
	local bufnr = vim.api.nvim_get_current_buf()

	-- Don't close special buffers (terminal, quickfix, etc)
	local buftype = vim.bo[bufnr].buftype
	if buftype == "terminal" or buftype == "quickfix" then
		vim.cmd("close")
		return
	end

	-- Get list of normal buffers
	local buffers = vim.tbl_filter(function(buf)
		return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and vim.bo[buf].buftype == ""
	end, vim.api.nvim_list_bufs())

	-- If this is the last buffer, create a new empty buffer
	if #buffers == 1 then
		vim.cmd("enew")
		vim.api.nvim_buf_delete(bufnr, { force = false })
		return
	end

	-- Find alternate buffer (prefer previous, fallback to next)
	local alternate = vim.fn.bufnr("#")
	if alternate == -1 or alternate == bufnr or not vim.api.nvim_buf_is_valid(alternate) then
		for _, buf in ipairs(buffers) do
			if buf ~= bufnr then
				alternate = buf
				break
			end
		end
	end

	-- Switch to alternate buffer before deleting
	if alternate and alternate > 0 and alternate ~= bufnr and vim.api.nvim_buf_is_valid(alternate) then
		vim.api.nvim_set_current_buf(alternate)
		vim.api.nvim_buf_delete(bufnr, { force = false })
		return
	end

	-- No valid alternate: show Alpha or quit
	local has_alpha, _ = pcall(require, "alpha")
	if has_alpha then
		vim.cmd("Alpha")
		if vim.api.nvim_buf_is_valid(bufnr) and bufnr ~= vim.api.nvim_get_current_buf() then
			vim.api.nvim_buf_delete(bufnr, { force = true })
		end
	else
		vim.cmd("enew")
		vim.api.nvim_buf_delete(bufnr, { force = true })
	end
end

return M
