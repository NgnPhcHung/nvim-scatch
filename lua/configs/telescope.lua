return function()
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	local entry_display = require("telescope.pickers.entry_display")
	local builtin = require("telescope.builtin")

	-- *******************************************************
	-- 1. UTILS: Xác định thư mục gốc (Custom CWD logic) - CACHED
	-- *******************************************************

	local cached_root = nil
	local cached_buf = nil

	local function get_project_root()
		local current_buf = vim.api.nvim_get_current_buf()
		if cached_root and cached_buf == current_buf then
			return cached_root
		end

		local buf_path = vim.fn.expand("%:p")
		local cwd = vim.fn.getcwd()

		-- Use vim.fs.root instead of shell call
		local git_root = vim.fs.root(buf_path, ".git")
		if not git_root then
			cached_root = cwd
			cached_buf = current_buf
			return cwd
		end

		local subprojects = { "apps", "packages", "services" }

		for _, dir in ipairs(subprojects) do
			local match = buf_path:match(git_root .. "/" .. dir .. "/([^/]+)/")
			if match then
				local possible_root = git_root .. "/" .. dir .. "/" .. match
				if vim.fn.isdirectory(possible_root .. "/src") == 1 or vim.fn.isdirectory(possible_root .. "/app") == 1 then
					cached_root = possible_root
					cached_buf = current_buf
					return possible_root
				end
			end
		end

		cached_root = git_root
		cached_buf = current_buf
		return git_root
	end

	-- *******************************************************
	-- 2. CUSTOM ENTRY MAKERS & DISPLAYERS
	-- *******************************************************

	local function custom_display(entry)
		local displayer = entry_display.create({
			separator = " ",
			items = {
				{ width = 30 },
				{ remaining = true },
			},
		})
		return displayer({
			{ entry.filename, "TelescopeResultsFileName" },
			{ entry.filelink, "TelescopeResultsFileLink" },
		})
	end

	local function custom_entry_maker(entry)
		local full_path = type(entry) == "table" and entry.filename or entry
		local just_file = vim.fn.fnamemodify(full_path, ":t")
		return {
			value = entry,
			display = custom_display,
			ordinal = full_path,
			filename = just_file,
			filelink = full_path,
			path = full_path,
		}
	end

	local function truncate_path(path)
		-- Giảm kích thước tối đa để tính toán an toàn hơn trong telescope
		local max_path_length = math.floor(vim.o.columns * 0.5)

		if #path > max_path_length then
			-- Cắt đầu path
			return "…" .. path:sub(-math.floor(max_path_length * 2 / 5))
		end
		return path
	end

	local function buffer_entry_maker(entry)
		local bufnr = entry.bufnr
		local bufname = vim.api.nvim_buf_get_name(bufnr)
		local short_name = bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or "[No Name]"

		-- Sử dụng logic get_project_root() đã định nghĩa ở trên thay vì gọi git lại
		local project_root = get_project_root()

		local relative_path = bufname ~= "" and vim.fn.fnamemodify(bufname, ":.") or "[No Path]"
		if vim.startswith(relative_path, project_root) then
			relative_path = relative_path:sub(#project_root + 2)
		end

		local displayer = entry_display.create({
			separator = " ",
			items = {
				{ width = 4 }, -- Bufnr
				{ width = 20 }, -- Short name
				{ remaining = true }, -- Path
			},
		})

		local current_buf = vim.api.nvim_get_current_buf()
		-- Sử dụng TelescopeResultsStatusLine thay vì highlight tùy chỉnh
		local hl = bufnr == current_buf and "TelescopeResultsStatusLine" or nil
		local display_path = truncate_path(relative_path)

		return {
			value = entry,
			ordinal = short_name,
			display = function()
				return displayer({
					{ tostring(bufnr), hl },
					{ short_name, hl },
					{ display_path, "TelescopeResultsFileLink" },
				})
			end,
			bufnr = bufnr,
		}
	end

	-- *******************************************************
	-- 3. SETUP TELESCOPE
	-- *******************************************************

	telescope.setup({

		defaults = {
			prompt_prefix = "   ",
			selection_caret = "▎ ",
			multi_icon = " │ ",
			winblend = 0,
			borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			border = true,
			path_display = { "truncate", "smart" },
			cwd = get_project_root(), -- Sử dụng hàm custom

			mappings = {
				i = {
					["<C-u>"] = actions.close, -- Mặc định là xóa line, nên đặt lại actions.close nếu muốn tắt
					["<C-d>"] = actions.move_selection_next, -- Ví dụ: Đặt lại hành động cơ bản
				},
				n = {
					["d"] = actions.delete_buffer,
					["q"] = actions.close,
				},
			},
		},
		pickers = {
			find_files = {
				prompt_title = " Find Files ", -- Đã chỉnh lại
				theme = "ivy",
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				layout_config = {
					width = 0.9,
					prompt_position = "bottom",
				},
				sorting_strategy = "ascending",
				entry_maker = custom_entry_maker,
				initial_mode = "normal",
			},
			symbols = { theme = "dropdown" },
			registers = { theme = "ivy" },
			grep_string = {
				initial_mode = "normal",
				theme = "dropdown",
				sorting_strategy = "ascending",
			},
			live_grep = {
				theme = "dropdown",
				prompt_title = " Live Grep ", -- Đã chỉnh lại
				sorting_strategy = "ascending",
				initial_mode = "normal",
			},
			buffers = {
				previewer = false,
				theme = "dropdown",
				sorting_strategy = "ascending",
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				mappings = {
					n = {
						["d"] = "delete_buffer",
						["l"] = "select_default",
					},
				},
				initial_mode = "normal",
				sort_lastused = true,
				prompt_title = " Opening Buffers ",
			},
			lsp_references = {
				theme = "cursor",
				initial_mode = "normal",
				layout_config = {
					height = 0.4,
					preview_width = 0.8,
					width = 0.9,
				},
				show_line = false,
				prompt_title = " LSP Usage ",
			},
		},
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
				specifc_opts = {
					codeactions = true,
				},
			},
			file_browser = {
				dir_icon = "",
				prompt_path = true,
				grouped = true,
				theme = "dropdown",
				initial_mode = "normal",
				previewer = false,
			},
			persisted = {
				layout_config = { width = 0.55, height = 0.55 },
			},
		},
	})

	-- *******************************************************
	-- 4. LOAD EXTENSIONS VÀ HIGHLIGHTS
	-- *******************************************************

	telescope.load_extension("ui-select")
	pcall(function()
		telescope.load_extension("fzf")
	end)

	-- Highlight tùy chỉnh (Đặt ở đây sau khi setup)
	vim.cmd("highlight TelescopeResultsFileName guifg=white gui=bold")
	vim.cmd("highlight TelescopeResultsFileLink guifg=#888888 ctermfg=8 gui=NONE")
	-- Bạn có thể bỏ highlight CurrentBufferOpen vì đã dùng TelescopeResultsStatusLine
	-- vim.cmd("highlight CurrentBufferOpen guifg=#789DBC")

	-- *******************************************************
	-- 5. KEYMAP CƠ BẢN (Sử dụng builtin)
	-- *******************************************************

	vim.keymap.set("n", "<S-h>", function()
		builtin.buffers({
			initial_mode = "normal",
			previewer = false,
			layout_strategy = "center",
			layout_config = {
				width = 0.8,
				height = 0.3,
			},
			winblend = 0,
			entry_maker = buffer_entry_maker, -- Sử dụng custom entry maker
			sorter = nil,
			sort_lastused = true,
			prompt_title = " Buffers ", -- Chỉnh lại prompt title
			prompt = { enabled = false }, -- Tắt prompt
		})
	end, { desc = "Telescope: Open Buffers List (Custom)" })
end
