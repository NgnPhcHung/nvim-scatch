return function()
	-- Lệnh require này CHỈ CHẠY khi hàm này được gọi (sau khi blink.cmp đã được Lazy.nvim tải)
	local cmp_types = require("blink.cmp.types")

	require("blink.cmp").setup({
		keymap = {
			preset = "none",
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<C-.>"] = { "show", "show_documentation" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			menu = {
				border = "rounded",
				winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
				draw = {
					columns = { { "label", "label_description", gap = 1 } },
					treesitter = { "lsp" },
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 250,
				window = {
					border = "rounded",
					winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
				},
			},
			ghost_text = { enabled = false },
			trigger = {
				show_on_trigger_character = true,
				show_on_insert_on_trigger_character = false,
			},
			keyword = { range = "full" },
			list = {
				selection = {
					preselect = true, -- Pre-select first item so Enter works immediately
					auto_insert = false, -- Don't auto-insert, only insert on explicit accept
				},
			},
		},
		signature = { enabled = true },

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				lsp = {
					name = "LSP",
					module = "blink.cmp.sources.lsp",
					min_keyword_length = 0,
					score_offset = 1,
				},
				path = { min_keyword_length = 0, score_offset = 2 },
				snippets = { min_keyword_length = 1, score_offset = 3 },
				buffer = { min_keyword_length = 0, max_items = 5 },
			},
		},
		fuzzy = { implementation = "lua" },
		snippets = { preset = "luasnip" },
	})
end
