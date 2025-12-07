return {
	autoclose = true,
	threshold = 9,
	close_command = function(bufnr)
		vim.api.nvim_buf_delete(bufnr, { force = false })
	end,
	close_buffers_with_windows = false,
	telescope = {},
}
