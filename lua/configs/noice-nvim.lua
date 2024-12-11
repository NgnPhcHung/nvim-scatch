require("noice").setup({
	cmdline = {
		enabled = true,
		format = {
			default = {
				position = {
					row = 40, -- Hàng (tính bằng số, để giữa màn hình theo ý muốn)
					col = "50%", -- Cột (giữa màn hình theo chiều ngang)
				},
				size = {
					width = "40%",

				},
				border = {
					style = "rounded",
					padding = { 1, 2 },
				},
			},
		},
	},
	lsp = {
		progress = {
			enabled = true,
		},
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["vim.lsp.buf.code_action"] = false,
		},
		signature = {
			enabled = true,
		},

	},
	presets = {
		bottom_search = false,
		command_palette = false,
		long_message_to_split = true,
		inc_rename = true,
		lsp_doc_border = true,
	},
})
