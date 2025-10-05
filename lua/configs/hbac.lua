local opts = {
	autoclose = true,
	threshold = 9,
	close_command = function(bufnr)
		vim.api.nvim_buf_delete(bufnr, {})
	end,
	close_buffers_with_windows = true,
	telescope = {},
}

require("hbac").setup(opts)
