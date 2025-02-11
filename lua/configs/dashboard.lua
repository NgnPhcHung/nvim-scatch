-- require("dashboard").setup({
-- 	theme = "doom", -- Có thể dùng 'hyper', 'doom' hoặc 'default'
-- 	config = {
-- 		header = {
-- 			" ██████╗ ██████╗  ██████╗ ████████╗██╗  ██╗██╗███╗   ███╗ ",
-- 			"██╔════╝ ██╔══██╗██╔═══██╗╚══██╔══╝██║  ██║██║████╗ ████║ ",
-- 			"██║  ███╗██████╔╝██║   ██║   ██║   ███████║██║██╔████╔██║ ",
-- 			"██║   ██║██╔═══╝ ██║   ██║   ██║   ██╔══██║██║██║╚██╔╝██║ ",
-- 			"╚██████╔╝██║     ╚██████╔╝   ██║   ██║  ██║██║██║ ╚═╝ ██║ ",
-- 			" ╚═════╝ ╚═╝      ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝     ╚═╝ ",
-- 		},
-- 		shortcut = {
-- 			{ desc = "  Find File", group = "@property", action = "Telescope find_files", key = "f" },
-- 			{ desc = "  Recent Files", group = "@property", action = "Telescope oldfiles", key = "r" },
-- 			{ desc = "  New File", group = "@property", action = "ene | startinsert", key = "n" },
-- 			{ desc = "  Quit", group = "@property", action = "qa", key = "q" },
-- 		},
-- 		footer = { "🚀 Neovim powered by Lua & Love ❤️" },
-- 	},
-- })
--

--
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     if vim.fn.argc() == 0 and #vim.fn.getbufinfo({ buflisted = 1 }) == 0 then
--       vim.cmd("Dashboard")
--     end
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "dashboard",
--   callback = function()
--     vim.o.showtabline = 0
--   end,
-- })
-- vim.api.nvim_create_autocmd("BufUnload", {
--   pattern = "*",
--   callback = function()
--     vim.o.showtabline = 2
--   end,
-- })
--
---------------
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
      vim.cmd("Dashboard")
    end
  end,
})

