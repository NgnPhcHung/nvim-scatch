return function()
	local nvim_notify = require("notify")

	local icon_status_ok, icon = pcall(require, "packages.icons")

	local notify_icons = {
		ERROR = icon_status_ok and icon.diagnostics.Error or "E",
		WARN = icon_status_ok and icon.diagnostics.Warning or "W",
		INFO = icon_status_ok and icon.diagnostics.Info or "I",
		DEBUG = "", -- Giữ nguyên icon Debug
		TRACE = "", -- Giữ nguyên icon Trace
	}

	nvim_notify.setup({
		stages = "static", -- Hiệu ứng xuất hiện: static (không nhấp nháy), fade (mặc định)
		timeout = 5000,
		-- position = "top_right", -- Mặc định là 'top_right', bạn có thể bật lại nếu muốn
		top_down = false, -- Xuất hiện từ dưới lên (kiểu stack)

		-- Tính toán kích thước tự động (Rất tốt)
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,

		icons = notify_icons,
		render = "compact", -- Hiển thị gọn gàng
		-- Thêm tùy chọn để chỉnh màu nền cho các loại thông báo
		-- background_colour = "#000000",
	})

	-- Ghi đè vim.notify bằng nvim_notify sau khi setup
	vim.notify = nvim_notify
end
