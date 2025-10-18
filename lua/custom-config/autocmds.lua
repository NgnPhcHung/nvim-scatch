local api = vim.api
local autocmd = api.nvim_create_autocmd

-- Sử dụng một Autogroup chính để quản lý tất cả các Autocmd tùy chỉnh
local custom_group = api.nvim_create_augroup("CustomAutocmds", { clear = true })

-- *******************************************************
-- 1. FILE/BUFFER HANDLING & LAZY LOADING HELPERS
-- *******************************************************

-- A. Mô phỏng FilePost & Editorconfig Loading
--   (Logic này phức tạp và có thể được thay thế bằng các event/hook của Lazy.nvim)
--   *GHI CHÚ: Logic tự tạo 'NvFilePost' này thường được dùng cho cấu hình cũ hơn.
--    Nếu bạn dùng Lazy.nvim, tốt nhất là sử dụng event 'User FilePost' của các plugin.*
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
	group = custom_group, -- Sử dụng custom_group đã clear
	callback = function(args)
		-- Đảm bảo UI đã vào (Nếu dùng Lazy.nvim, nên dùng 'VimEnter' thay 'UIEnter')
		if not vim.g.ui_entered and args.event == "UIEnter" then
			vim.g.ui_entered = true
		end

		local file = api.nvim_buf_get_name(args.buf)
		local buftype = api.nvim_get_option_value("buftype", { buf = args.buf })

		if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
			-- 1. Kích hoạt 'User FilePost'
			api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })

			-- 2. Tải Editorconfig (Nên dùng plugin 'editorconfig' với event 'BufReadPre'/'BufNewFile' của nó)
			vim.schedule(function()
				if vim.g.editorconfig then
					-- Sử dụng pcall để tránh lỗi nếu plugin chưa load
					local ed_config_ok, editorconfig = pcall(require, "editorconfig")
					if ed_config_ok then
						editorconfig.config(args.buf)
					end
				end
			end)

			-- *LƯU Ý: Không cần xóa Autogroup nếu bạn dùng custom_group đã clear*
		end
	end,
})

-- B. Xử lý BufDeletePost (Tạo sự kiện User tùy chỉnh)
--   (Bạn đã định nghĩa một Autogroup trống, có thể dùng custom_group)
autocmd("BufDelete", {
	group = custom_group,
	desc = "Kích hoạt User BufDeletePost",
	callback = function()
		vim.schedule(function()
			api.nvim_exec_autocmds("User", {
				pattern = "BufDeletePost",
			})
		end)
	end,
})

-- Lua Autocmd để mở Dashboard khi khởi động
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("AlphaStart", { clear = true }),
	-- Đảm bảo Alpha chỉ chạy nếu không có file nào được mở
	pattern = "*",
	callback = function()
		local bufcount = #vim.fn.getbufinfo({ buflisted = 1, bufloaded = 1 })

		-- Chỉ mở Alpha nếu số lượng buffer đang được tải và niêm yết là 0 hoặc 1 (No Name)
		if bufcount <= 1 then
			pcall(vim.cmd, "Alpha")
		end
	end,
})

-- *******************************************************
-- 2. TÙY CHỈNH THEO FILETYPE
-- *******************************************************

-- Vô hiệu hóa Conceallevel (Dấu hiệu) cho một số filetype
autocmd("FileType", {
	group = custom_group,
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.wo.conceallevel = 0 -- Thiết lập cho window hiện tại
	end,
})
