return function()
	local indentscope = require("mini.indentscope")

	-- Định nghĩa Autocmd Group (Thực hành tốt)
	local indentscope_group = vim.api.nvim_create_augroup("MiniIndentscopeConfig", { clear = true })

	-- Tạo Autocmd để TẮT indentscope cho các filetype đặc biệt
	vim.api.nvim_create_autocmd("FileType", {
		group = indentscope_group,
		pattern = {
			"help",
			"alpha",
			"neo-tree",
			"lazy",
			"mason",
			"notify",
			"toggleterm",
			"gitcommit", -- Thường không cần trong commit message
		},
		callback = function()
			-- Tắt indentscope cho buffer hiện tại
			vim.b.miniindentscope_disable = true
		end,
	})

	indentscope.setup({
		-- `version` không cần thiết, plugin sẽ tự động sử dụng version đúng

		symbol = "▏", -- Ký hiệu hiển thị

		draw = {
			delay = 0,
			-- Sửa lỗi: Gọi gen_animation an toàn qua `indentscope` đã được require
			animation = indentscope.gen_animation.none(),
			priority = 2,
		},

		-- Cấu hình hiển thị (mini.nvim dùng `opts` trong setup)
		options = {
			try_as_border = false,
		},

		-- Tùy chọn khác
		mappings = {
			-- Thêm keymap để bật/tắt nhanh
			-- toggle_and_reset = "<leader>i",
		},
	})
end
