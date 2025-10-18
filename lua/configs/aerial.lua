return {
	expand_lines = false, -- Không mở rộng dòng để hiển thị toàn bộ nội dung
	attach_mode = "window", -- Luôn mở trong một cửa sổ riêng (thay vì buffer)
	autojump = false, -- Tắt tự động nhảy khi di chuyển trong cửa sổ Aerial
	close_automatic_events = {}, -- Không tự động đóng (giữ mở cho đến khi đóng thủ công)
	show_guides = true, -- Hiển thị đường dẫn kết nối
	backends = { "lsp", "treesitter", "markdown", "man" }, -- Thứ tự ưu tiên backend
	layout = {
		resize_to_content = false, -- Không resize theo nội dung
		min_width = 40, -- Chiều rộng tối thiểu
		win_opts = {
			-- Tùy chỉnh highlight và cột dấu
			winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
			signcolumn = "yes",
			statuscolumn = " ",
		},
	},
	guides = {
		mid_item = "├╴",
		last_item = "└╴",
		nested_top = "│ ",
		whitespace = "  ", -- Sử dụng non-breaking space cho khoảng trắng
	},
}
