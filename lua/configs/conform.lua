local util = require("lspconfig.util")

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		prisma = { "prisma_fmt" },
		css = { "biome", "prettierd", "eslint_d" },

		javascript = { "biome", "eslint_d", "prettierd", stop_after_first = true },
		typescript = { "biome", "eslint_d", "prettierd", stop_after_first = true },
		javascriptreact = { "biome", "eslint_d", "prettierd", stop_after_first = true },
		typescriptreact = { "biome", "eslint_d", "prettierd", stop_after_first = true },
		json = { "biome", "prettierd", "eslint_d", stop_after_first = true },
	},

	formatters = {
		prisma_fmt = {
			command = "npx",
			args = { "prisma", "format" },
			stdin = false,
		},

		-- ✅ biome: chỉ chạy nếu có biome.json hoặc dependency "biome"
		biome = {
			command = "npx",
			args = { "biome", "format", "--stdin-file-path", "$FILENAME" },
			stdin = true,
			cwd = function(ctx)
				return util.root_pattern("biome.json", "package.json", ".git")(ctx.dirname)
			end,
			condition = function(ctx)
				return util.root_pattern("biome.json", "biome.jsonc")(ctx.dirname) ~= nil
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

		-- ✅ eslint_d: chỉ chạy nếu có .eslintrc.* hoặc eslint trong package.json
		eslint_d = {
			command = "npx",
			args = { "eslint_d", "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
			stdin = true,
			cwd = function(ctx)
				return util.root_pattern(".eslintrc", ".eslintrc.json", ".eslintrc.js", "package.json", ".git")(
					ctx.dirname
				)
			end,
			condition = function(ctx)
				return util.root_pattern(".eslintrc", ".eslintrc.json", ".eslintrc.js")(ctx.dirname) ~= nil
			end,
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
