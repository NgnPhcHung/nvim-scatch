require("dashboard").setup({
	theme = "doom", -- Có thể dùng 'hyper', 'doom' hoặc 'default'
	config = {
		header = {
			" ██████╗ ██████╗  ██████╗ ████████╗██╗  ██╗██╗███╗   ███╗ ",
			"██╔════╝ ██╔══██╗██╔═══██╗╚══██╔══╝██║  ██║██║████╗ ████║ ",
			"██║  ███╗██████╔╝██║   ██║   ██║   ███████║██║██╔████╔██║ ",
			"██║   ██║██╔═══╝ ██║   ██║   ██║   ██╔══██║██║██║╚██╔╝██║ ",
			"╚██████╔╝██║     ╚██████╔╝   ██║   ██║  ██║██║██║ ╚═╝ ██║ ",
			" ╚═════╝ ╚═╝      ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝     ╚═╝ ",
		},
		shortcut = {
			{ desc = "  Find File", group = "@property", action = "Telescope find_files", key = "f" },
			{ desc = "  Recent Files", group = "@property", action = "Telescope oldfiles", key = "r" },
			{ desc = "  New File", group = "@property", action = "ene | startinsert", key = "n" },
			{ desc = "  Quit", group = "@property", action = "qa", key = "q" },
		},
		footer = { "🚀 Neovim powered by Lua & Love ❤️" },
	},
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and #vim.fn.getbufinfo({ buflisted = 1 }) == 0 then
      vim.cmd("Dashboard")
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dashboard",
  callback = function()
    vim.o.showtabline = 0
  end,
})
vim.api.nvim_create_autocmd("BufUnload", {
  pattern = "*",
  callback = function()
    vim.o.showtabline = 2
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    -- Kiểm tra nếu chỉ còn 1 buffer và buffer đó là [No Name]
    if #vim.fn.getbufinfo({ buflisted = 1 }) == 0 then
      vim.cmd("Dashboard")
    end
  end,
})

