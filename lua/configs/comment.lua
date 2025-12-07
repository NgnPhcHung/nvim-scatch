return function()
	local comment = require("Comment")
	local ts_context_utils = require("ts_context_commentstring.utils")
	local ts_context_internal = require("ts_context_commentstring.internal")

	comment.setup({
		-- Khai báo pre_hook để tích hợp ts_context_commentstring
		pre_hook = function(ctx)
			local U = require("Comment.utils")
			local location = nil

			-- Xác định vị trí cho block comment hoặc visual selection
			if ctx.ctype == U.ctype.block then
				location = ts_context_utils.get_cursor_location()
			elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
				location = ts_context_utils.get_visual_start_location()
			end

			-- Tính toán chuỗi commentstring chính xác dựa trên context Treesitter
			return ts_context_internal.calculate_commentstring({
				-- Sử dụng _default cho line comment, _multiline cho block/visual selection
				key = ctx.ctype == U.ctype.line and "_default" or "_multiline",
				location = location,
			})
		end,

		-- Bạn có thể thêm các tùy chọn khác tại đây nếu cần
		mappings = {
			basic = true, -- Sử dụng gc/gb
			extra = false,
		},
	})
end
