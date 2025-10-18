return {
	autoclose = true, -- Tự động đóng các buffer ẩn khi vượt ngưỡng
	threshold = 9, -- Giữ lại tối đa 9 buffer ẩn gần nhất (buffers ít được dùng sẽ bị đóng)
	close_command = function(bufnr)
		-- Xóa buffer vĩnh viễn
		vim.api.nvim_buf_delete(bufnr, { force = false })
	end,
	close_buffers_with_windows = true, -- Đóng buffer khi cửa sổ chứa nó đóng
	telescope = {}, -- Tích hợp Telescope

	-- Bạn có thể thêm các filetype hoặc buftype để loại trừ nếu cần:
	-- exclude_filetypes = { 'NvimTree', 'alpha', 'lazy' },
	-- exclude_buftypes = { 'terminal' },
}
