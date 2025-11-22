local api = vim.api
local autocmd = api.nvim_create_autocmd
local custom_group = api.nvim_create_augroup("CustomAutocmds", { clear = true })

autocmd({ "VimEnter", "BufReadPost", "BufNewFile" }, {
	group = custom_group,
	callback = function(args)
		if not vim.g.ui_entered and args.event == "UIEnter" then
			vim.g.ui_entered = true
		end

		local file = api.nvim_buf_get_name(args.buf)
		local buftype = api.nvim_get_option_value("buftype", { buf = args.buf })

		if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
			api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })

			vim.schedule(function()
				if vim.g.editorconfig then
					local ed_config_ok, editorconfig = pcall(require, "editorconfig")
					if ed_config_ok then
						editorconfig.config(args.buf)
					end
				end
			end)
		end
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("AlphaStart", { clear = true }),
	pattern = "*",
	callback = function()
		local bufcount = #vim.fn.getbufinfo({ buflisted = 1, bufloaded = 1 })
		if bufcount <= 1 then
			vim.cmd("Alpha")
		end
	end,
})
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("AlphaOnLastBuffer", { clear = true }),
	callback = function(ev)
		local current_ft = vim.api.nvim_get_option_value("filetype", { buf = ev.buf })
		if current_ft == "alpha" then
			return
		end

		local bufname = vim.api.nvim_buf_get_name(ev.buf)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = ev.buf })
		local bufmodified = vim.api.nvim_get_option_value("modified", { buf = ev.buf })
		local buf_line_count = vim.api.nvim_buf_line_count(ev.buf)
		local is_empty = buf_line_count == 1 and vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false)[1] == ""

		local listed_bufs = vim.fn.getbufinfo({ buflisted = 1 })

		local real_file_bufs = vim.tbl_filter(function(buf)
			if buf.bufnr == ev.buf then
				return false
			end
			local bt = vim.api.nvim_get_option_value("buftype", { buf = buf.bufnr })
			local ft = vim.api.nvim_get_option_value("filetype", { buf = buf.bufnr })
			local name = vim.api.nvim_buf_get_name(buf.bufnr)
			return bt == "" and ft ~= "alpha" and name ~= "" and buf.loaded == 1
		end, listed_bufs)

		if bufname == "" and buftype == "" and is_empty and not bufmodified and #real_file_bufs == 0 then
			local empty_buf = ev.buf
			vim.schedule(function()
				vim.cmd("Alpha")
				if vim.api.nvim_buf_is_valid(empty_buf) and vim.api.nvim_get_current_buf() ~= empty_buf then
					vim.api.nvim_buf_delete(empty_buf, { force = true })
				end
			end)
		end
	end,
})

autocmd({ "FocusGained", "TermClose", "TermLeave", "CursorHold" }, {
	group = custom_group,
	callback = function()
		if vim.o.buftype == "" then
			vim.cmd("checktime")
		end
	end,
})

autocmd("FileType", {
	group = custom_group,
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.wo.conceallevel = 0
	end,
})
