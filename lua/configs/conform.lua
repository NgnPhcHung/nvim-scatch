local util = require("lspconfig.util")

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "prettierd" },
		prisma = { "prisma_fmt" },

		javascript = { "biome", "prettierd", stop_after_first = true },
		typescript = { "biome", "prettierd", stop_after_first = true },
		javascriptreact = { "biome", "prettierd", stop_after_first = true },
		typescriptreact = { "biome", "prettierd", stop_after_first = true },
		json = { "biome", "prettierd", stop_after_first = true },
	},

	formatters = {
		prisma_fmt = {
			command = "npx",
			args = { "prisma", "format" },
			stdin = false,
		},

		biome = {
			command = "npx",
			args = { "biome", "format", "--stdin-file-path", "$FILENAME" },

			stdin = true,
			cwd = function(ctx)
				return require("lspconfig.util").root_pattern("package.json", "biome.json", ".git")(ctx.dirname)
			end,
		},

		stylua = {
			command = "stylua",
			args = { "-" },
			stdin = true,
		},

		prettierd = {
			command = "prettierd",
			args = { "--stdin-file-path", "$FILENAME" },
			stdin = true,
		},
	},

	default_format_opts = {
		lsp_format = "fallback",
	},

	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 3000,
		enabled = true,
		pattern = "*.{js,jsx,ts,tsx,lua,css,html,prisma}",
	},
})

-- vim.lsp.enable("biome")
