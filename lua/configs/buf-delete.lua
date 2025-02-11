function CloseAllBuffers()
	local buffers = vim.api.nvim_list_bufs()

	for _, buf in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "" then
			vim.cmd("Bdelete " .. buf)
		end
	end

	-- Kiểm tra nếu không còn buffer nào thì mở lại Alpha
	vim.defer_fn(function()
		local open_buffers = vim.fn.getbufinfo({ buflisted = 1 })
		if #open_buffers == 0 then
			print("No buffers left, opening Alpha...")
			require("alpha").start(false)
		end
	end, 50) -- Delay nhẹ để đảm bảo buffer đã bị xoá trước khi check
end
