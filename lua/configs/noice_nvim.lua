require("noice").setup({
	message = {
		enabled = true,
		view = "notify",
		opts = {},
	},
	notify = {
		enabled = true,
		view = "notify",
		position = "top,right",
	},
	cmdline = {
		enabled = true,
		view = "cmdline_popup",
		format = {
			cmdline = { pattern = "^:", icon = require("packages.icons").ui.Search, lang = "vim", title = "" },
		},
	},
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
		signature = { enabled = true },
		messages = { enabled = false },
	},

	routes = {
		-- hide ruler (line,col)
		{
			filter = { event = "msg_ruler" },
			opts = { skip = true },
		},
		-- hide session loaded notify
		{
			filter = { event = "notify", find = "session loaded" },
			opts = { skip = true },
		},
		-- hide list_cmd
		{
			filter = { event = "msg_show", kind = "list_cmd" },
			opts = { skip = true },
		},
		-- hide file opened messages like "82L, 2326B"
		{
			filter = { event = "msg_show", find = "%d+L, %d+B" },
			opts = { skip = true },
		},

		{
			filter = { event = "msg_show", kind = "list_cmd" },
			opts = { skip = true },
		},
		-- already had other noisy filters
		{
			filter = {
				event = "msg_show",
				any = {
					{ find = "^%d+ changes?; after #%d+" },
					{ find = "^%d+ changes?; before #%d+" },
					{ find = "^Hunk %d+ of %d+$" },
					{ find = "^%d+ fewer lines;?" },
					{ find = "^%d+ more lines?;?" },
					{ find = "^%d+ line less;?" },
					{ find = "^Already at newest change" },
					{ find = "written" },
					{ find = "bufwrite" },
					{ kind = "wmsg" },
					{ kind = "emsg", find = "E487" },
					{ kind = "quickfix" },
					{ find = "method textDocument/documentHighlight is not supported" },
					{ find = "bytes written" },
				},
			},
			opts = { skip = true },
		},
		-- hide lua_ls progress spam
		{
			filter = {
				event = "lsp",
				kind = "progress",
				cond = function(message)
					local client = vim.tbl_get(message.opts, "progress", "client")
					return client == "lua_ls"
				end,
			},
			opts = { skip = true },
		},
	},

	presets = {
		bottom_search = false,
		command_palette = false,
		long_message_to_split = true,
		inc_rename = true,
		progress = false,
		smart_move = false,
	},

	views = {
		hover = {
			border = {
				style = "rounded",
				padding = { 0, 1 },
			},
			position = { row = 2, col = 2 },
			size = {
				max_width = 80,
				max_height = 20,
			},
			win_options = {
				winblend = 0,
				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
			},
		},
	},
})
