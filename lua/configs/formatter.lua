require("conform").setup({
	-- ponytail: biome-check resolves node_modules/.bin/biome; skips silently when absent
	notify_no_formatters = false,
	formatters_by_ft = {
		lua = { "stylua" },
		-- organize imports first, biome-check formats last
		javascript = { "biome-organize-imports", "biome-check" },
		javascriptreact = { "biome-organize-imports", "biome-check" },
		typescript = { "biome-organize-imports", "biome-check" },
		typescriptreact = { "biome-organize-imports", "biome-check" },
		json = { "biome-check" },
		jsonc = { "biome-check" },
		css = { "biome-check" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "never", -- only formatters_by_ft above; LSP never formats on save
	},
})
