require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<C-space>"] = { "show", "fallback" },
		["<C-,>"] = { "show", "fallback" },
		["<CR>"] = { "accept", "fallback" },

		["<C-j>"] = { "select_next", "show_documentation", "fallback" },
		["<C-k>"] = { "select_prev", "show_documentation", "fallback" },

		["<C-l>"] = { "scroll_documentation_down", "fallback" },
		["<C-h>"] = { "scroll_documentation_up", "fallback" },
		["<Tab>"] = { "accept", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},
	appearance = { nerd_font_variant = "mono" },
	completion = {
		accept = { auto_brackets = { enabled = false } },
		menu = {
			auto_show = true,
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "source_name", "kind" },
				},
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
		},
		ghost_text = { enabled = true },
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		providers = {
			-- ponytail: sync so the menu opens once, complete (ts_ls warm ~20ms).
			-- timeout_ms caps the stall on cold start, then buffer/snippets show first.
			lsp = { timeout_ms = 500 },
		},
		per_filetype = {
			typescript = { "lsp", "buffer", "snippets" },
			typescriptreact = { "lsp", "buffer", "snippets" },
			javascript = { "lsp", "buffer", "snippets" },
			javascriptreact = { "lsp", "buffer", "snippets" },
		},
	},
	snippets = {
		preset = "default",
	},

	fuzzy = {
		implementation = "prefer_rust_with_warning",
	},
})
