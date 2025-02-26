local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

local function capture(cmd, raw)
	local f = assert(io.popen(cmd, "r"))
	local s = assert(f:read("*a"))
	f:close()
	if raw then
		return s
	end
	s = string.gsub(s, "^%s+", "")
	s = string.gsub(s, "%s+$", "")
	s = string.gsub(s, "[\n\r]+", " ")
	return s
end

vim.defer_fn(function()
	local total_plugins = #vim.tbl_keys(packer_plugins or {})
	dashboard.section.footer.val = "Total plugins: " .. total_plugins
	pcall(vim.cmd.AlphaRedraw)
end, 100)
dashboard.section.header.val =
	vim.fn.readfile(vim.fs.normalize("~/.config/nvim/lua/custom-config/files/my_header_banner.txt"))
dashboard.section.header.opts.hl = "Question"
dashboard.section.buttons.val = {
	dashboard.button("f", " Find file", ":Telescope find_files<CR>"),
	dashboard.button("p", " Update plugins", ":Packer sync<CR>"),
	dashboard.button("q", " Exit", ":qa!<CR>"),
}
alpha.setup(dashboard.config)

vim.api.nvim_create_autocmd("BufDelete", {
	group = vim.api.nvim_create_augroup("bufdelpost_autocmd", {}),
	desc = "BufDeletePost User autocmd",
	callback = function()
		vim.schedule(function()
			vim.api.nvim_exec_autocmds("User", {
				pattern = "BufDeletePost",
			})
		end)
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "BufDeletePost",
	group = vim.api.nvim_create_augroup("dashboard_delete_buffers", {}),
	desc = "Open Dashboard when no available buffers",
	callback = function(ev)
		local deleted_name = vim.api.nvim_buf_get_name(ev.buf)
		local deleted_ft = vim.api.nvim_get_option_value("filetype", { buf = ev.buf })
		local deleted_bt = vim.api.nvim_get_option_value("buftype", { buf = ev.buf })
		local dashboard_on_empty = deleted_name == "" and deleted_ft == "" and deleted_bt == ""

		if dashboard_on_empty then
			vim.cmd("Alpha")
		end
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("alpha_start", { clear = true }),
  desc = "Open Alpha dashboard on startup",
  callback = function()
    
    if vim.fn.argc() == 0 and vim.bo.filetype == "" then
      require("alpha").start(false)
    end
  end,
})

--load dashboard when no buffer open
-- vim.api.nvim_create_augroup("vimrc_alpha", { clear = true })
-- vim.api.nvim_create_autocmd({ "User" }, {
-- 	group = "vimrc_alpha",
-- 	pattern = "AlphaReady",
-- 	callback = function()
-- 		if vim.fn.executable("onefetch") == 1 then
-- 			local header = split(
-- 				capture(
-- 					[[onefetch 2>/dev/null | sed 's/\x1B[@A-Z\\\]^_]\|\x1B\[[0-9:;<=>?]*[-!"#$%&'"'"'()*+,.\/]*[][\\@A-Z^_`a-z{|}~]//g']],
-- 					true
-- 				),
-- 				"\n"
-- 			)
-- 			if next(header) ~= nil then
-- 				require("alpha.themes.dashboard").section.header.val = header
-- 				require("alpha").redraw()
-- 			end
-- 		end
-- 	end,
-- 	once = true,
-- })

-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = vim.api.nvim_create_augroup("alpha_on_empty", { clear = true }),
--   desc = "Open Alpha when no buffers are left",
--   callback = function()
--     vim.defer_fn(function()
--       local buffers = vim.fn.getbufinfo({ buflisted = 1 })
--       -- Nếu không còn buffer nào hiển thị, mở Alpha
--       if #buffers == 0 then
--         require("alpha").start(false)
--       end
--     end, 50)
--   end,
-- })
--
--
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	group = vim.api.nvim_create_augroup("alpha_start", { clear = true }),
-- 	desc = "Start Alpha dashboard on startup",
-- 	callback = function()
-- 		-- Kiểm tra nếu không có buffer nào được mở thì mở Alpha
-- 		if vim.fn.argc() == 0 and not vim.bo.filetype then
-- 			require("alpha").start(false)
-- 		end
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("BufDelete", {
--   group = vim.api.nvim_create_augroup("bufdelete_to_alpha", { clear = true }),
--   desc = "Open Alpha when last buffer is deleted",
--   callback = function()
--     vim.defer_fn(function()
--       local buffers = vim.fn.getbufinfo({ buflisted = 1 })
--       if #buffers == 0 then
--         require("alpha").start(false)
--       end
--     end, 50)
--   end,
-- })
--
--
-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "BufDeletePost",
-- 	group = vim.api.nvim_create_augroup("dashboard_delete_buffers", {}),
-- 	desc = "Open Alpha Dashboard when no available buffers",
-- 	callback = function()
-- 		-- Lấy danh sách buffer đang mở
-- 		local buffers = vim.api.nvim_list_bufs()
-- 		local open_buffers = 0
--
-- 		for _, buf in ipairs(buffers) do
-- 			if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "" then
-- 				open_buffers = open_buffers + 1
-- 			end
-- 		end
--
-- 		-- Debug: In số lượng buffer hiện tại
-- 		print("Open buffers count:", open_buffers)
--
-- 		-- Nếu không còn buffer nào mở, mở lại Alpha Dashboard
-- 		if open_buffers == 0 then
-- 			print("Opening Alpha...")
-- 			require("alpha").start(false)
-- 		end
-- 	end,
-- })
