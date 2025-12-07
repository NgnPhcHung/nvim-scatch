return function()
	local lualine = require("lualine")

	-- 1. Cài đặt tùy chọn Vim
	vim.o.laststatus = 2 -- Luôn hiển thị statusline
	vim.o.cmdheight = 1 -- Chiều cao command line

	-- 2. Require Modules (Đảm bảo an toàn cho icons)
	local icon_status_ok, icon = pcall(require, "packages.icons")

	-- Fallback an toàn nếu icons chưa load (chỉ nên xảy ra nếu plugin load lỗi)
	if not icon_status_ok then
		icon = {
			kind = { File = "F", Event = "E" },
			git = { Branch = "B", LineAdded = "+", LineModified = "~", LineRemoved = "-" },
			diagnostics = { Error = "E", Warning = "W", Info = "I", Hint = "H" },
		}
	end

	-- *******************************************************
	-- 3. CÁC COMPONENT TÙY CHỈNH
	-- *******************************************************

	-- A. Custom Mode Component
	local function custom_mode()
		local mode_colors = {
			n = { fg = "#1e1e2e", bg = "#a6e3a1", bold = true }, -- normal = green
			i = { fg = "#1e1e2e", bg = "#89b4fa", bold = true }, -- insert = blue
			v = { fg = "#1e1e2e", bg = "#f9e2af", bold = true }, -- visual = yellow
			V = { fg = "#1e1e2e", bg = "#f9e2af", bold = true },
			[""] = { fg = "#1e1e2e", bg = "#f9e2af", bold = true },
			c = { fg = "#1e1e2e", bg = "#f38ba8", bold = true }, -- command = red
			R = { fg = "#1e1e2e", bg = "#fab387", bold = true }, -- replace = orange
			t = { fg = "#1e1e2e", bg = "#94e2d5", bold = true }, -- terminal = teal
			["s"] = { fg = "#1e1e2e", bg = "#f9e2af", bold = true }, -- select (Select Mode)
			["S"] = { fg = "#1e1e2e", bg = "#f9e2af", bold = true }, -- select (Line Select)
			["ts"] = { fg = "#1e1e2e", bg = "#94e2d5", bold = true }, -- terminal (Shell Mode)
		}

		local m = vim.api.nvim_get_mode().mode
		local label = string.upper(m)

		-- Thiết lập highlight group cho mode (Cần phải chạy mỗi khi component được render)
		local color = mode_colors[m] or { fg = "#ffffff", bg = "#444444", bold = true }
		vim.api.nvim_set_hl(0, "StatusLineMode", color)

		return string.format("%%#StatusLineMode# %s %%*", label)
	end

	-- B. Custom Number of Buffers
	local function numberOfBuffers()
		local buffers = vim.fn.getbufinfo({ buflisted = 1 })
		return icon.kind.File .. " " .. #buffers
	end

	-- C. Custom File Path (Rất tốt cho Monorepos!)
	local function filename_path()
		local filepath = vim.fn.expand("%:~:.") -- relative path from cwd or home
		local parts = vim.split(filepath, "/", { trimempty = true })

		if #parts > 3 then
			-- Chỉ lấy 2 thư mục cha và tên file
			return ".../" .. table.concat({ parts[#parts - 2], parts[#parts - 1], parts[#parts] }, "/")
		else
			return filepath
		end
	end

	-- *******************************************************
	-- 4. BẢNG CẤU HÌNH LUALINE
	-- *******************************************************

	lualine.setup({
		options = {
			theme = "auto",
			globalstatus = true,
			component_separators = { left = " ", right = " " },
			section_separators = { left = " ", right = " " },
			disabled_filetypes = { statusline = { "neo-tree", "lazy", "alpha", "fugitive", "vista", "dapui_stacks" } }, -- Thêm filetype nếu cần
			always_divide_middle = true,
		},
		sections = {
			lualine_a = { custom_mode }, -- Component Mode tùy chỉnh
			lualine_b = {
				{
					"branch",
					icons_enabled = true,
					icon = icon.git.Branch,
					color = { fg = "#89b4fa", bg = "none" },
				},
			},
			lualine_c = {
				numberOfBuffers,
				{
					filename_path, -- Sử dụng hàm custom filename
					icon = icon.kind.Event, -- Sử dụng Event icon cho file
					color = { fg = "#86B0BD", bg = "none" },
				},
			},
			lualine_x = {
				{
					"diff",
					-- SỬ DỤNG GITSIGNS TÍCH HỢP (Luôn đáng tin cậy hơn)
					symbols = {
						added = icon.git.LineAdded .. " ",
						modified = icon.git.LineModified .. " ",
						removed = icon.git.LineRemoved .. " ",
					},
					diff_color = {
						added = { fg = "#a6e3a1" },
						modified = { fg = "#f9e2af" },
						removed = { fg = "#f38ba8" },
					},
				},
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					sections = { "error", "warn", "info", "hint" },
					symbols = {
						error = icon.diagnostics.Error,
						hint = icon.diagnostics.Hint,
						info = icon.diagnostics.Info,
						warn = icon.diagnostics.Warning,
					},
					colored = true,
					update_in_insert = false,
					always_visible = false,
				},
			},
			lualine_y = {}, -- Để trống hoặc thêm progress/line number
			lualine_z = {
				{ "filetype", icon_only = true, color = { fg = "#ffffff", bg = "none" } },
				"location",
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = { "fugitive" },
	})

	-- *******************************************************
	-- 5. HIGHLIGHTS CƠ BẢN (Sau khi Lualine Setup)
	-- *******************************************************

	vim.api.nvim_set_hl(0, "StatusLine", { fg = "#cdd6f4", bg = "#1e1e2e" })
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#6c7086", bg = "#181825" })
end
