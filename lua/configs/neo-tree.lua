return function()
	local icons_status_ok, icons = pcall(require, "packages.icons")

	-- Đảm bảo sử dụng icon an toàn, fallback về biểu tượng mặc định nếu 'packages.icons' chưa load
	local folder_icon = icons_status_ok and icons.kind.Folder or "📁"

	require("neo-tree").setup({
		close_if_last_window = true,
		popup_border_style = "rounded",
		enable_git_status = true,

		-- 1. Cấu hình Filesystem (Tùy chỉnh File Explorer)
		filesystem = {
			follow_current_file = {
				enabled = true, -- Tự động nhảy đến file hiện tại
			},
			bind_to_cwd = true, -- Luôn hiển thị thư mục làm việc hiện tại
			hijack_netrw_behavior = "open_current",

			filtered_items = {
				hide_dotfiles = true,
				hide_git_ignored = true,
				hide_hidden = true,
				ignored_file_patterns = {
					"^\\.env$", -- Chỉ khớp chính xác ".env"
					-- 'node_modules', -- Nên được xử lý bằng hide_git_ignored nếu có trong .gitignore
				},
			},
		},

		-- 2. Cấu hình Buffers (Danh sách các Buffer đang mở)
		buffers = {
			follow_current_file = {
				enabled = true, -- Nhảy đến buffer hiện tại trong danh sách
			},
			bind_to_cwd = true,
		},

		-- 3. Cấu hình Mapping
		mapping_options = {
			noremap = true,
			nowait = true,
		},

		-- 4. Cấu hình Cửa sổ
		window = {
			-- Vị trí "float" thường chỉ áp dụng cho các pop-up nhỏ,
			-- nếu bạn muốn nó là cửa sổ bình thường bên trái/phải, nên dùng "left"/"right"
			position = "float",
			popup = {
				title = folder_icon .. " Explorer",
				size = {}, -- Giữ mặc định (tự điều chỉnh)
				position = "50%",
			},
			mappings = {
				["<CR>"] = "open",
				["<Tab>"] = "open",
			},
		},

		diagnostics = {
			enable = true,
			severity_sort = true,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},

		default_component_configs = {
			git_status = {
				symbols = {
					added = "",
					modified = "",
					deleted = "",
					untracked = "",
					ignored = "◌",
				},
			},
		},
	})
end
