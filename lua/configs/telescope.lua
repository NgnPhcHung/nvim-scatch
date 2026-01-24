return function()
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	local builtin = require("telescope.builtin")
	local tel_utils = require("utils.telescope")

	-- *******************************************************
	-- 1. SETUP TELESCOPE
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
			cwd = tel_utils.get_project_root(),

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
				entry_maker = tel_utils.create_custom_entry_maker(),
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
			entry_maker = tel_utils.create_buffer_entry_maker(),
			sorter = nil,
			sort_lastused = true,
			prompt_title = " Buffers ", -- Chỉnh lại prompt title
			prompt = { enabled = false }, -- Tắt prompt
		})
	end, { desc = "Telescope: Open Buffers List (Custom)" })
end
