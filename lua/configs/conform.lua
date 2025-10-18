return function()
	local util = require("lspconfig.util")

	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			prisma = { "prisma_fmt" },
			css = { "biome", "prettierd", "eslint_d", stop_after_first = true },
			javascript = { "biome", "eslint_d", "prettierd", stop_after_first = true },
			typescript = { "biome", "eslint_d", "prettierd", stop_after_first = true },
			javascriptreact = { "biome", "eslint_d", "prettierd", stop_after_first = true },
			typescriptreact = { "biome", "eslint_d", "prettierd", stop_after_first = true },
			json = { "biome", "prettierd", "eslint_d", stop_after_first = true },
		},

		formatters = {
			prisma = {
				command = "npx",
				args = { "prisma", "format" },
				stdin = false,
			},
			-- prisma_fmt = {
			-- 	command = "npx",
			-- 	args = { "prisma", "format", "--schema", "$FILENAME" },
			-- 	stdin = false,
			-- 	cwd = function(ctx)
			-- 		return util.root_pattern("prisma", "package.json", ".git")(ctx.dirname)
			-- 	end,
			-- 	timeout_ms = 5000,
			-- },

			-- Biome
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

			stylua = { command = "stylua", args = { "-" }, stdin = true },
			prettierd = { command = "prettierd", args = { "--stdin-file-path", "$FILENAME" }, stdin = true },

			-- Eslint_d
			eslint_d = {
				command = "npx",
				args = { "eslint_d", "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
				stdin = true,
				cwd = function(ctx)
					return util.root_pattern(".eslintrc", "package.json", ".git")(ctx.dirname)
				end,
				condition = function(ctx)
					return util.root_pattern(
						".eslintrc",
						".eslintrc.json",
						".eslintrc.js",
						".eslintrc.yaml",
						".eslintrc.yml"
					)(ctx.dirname) ~= nil
				end,
			},
		},

		default_format_opts = { lsp_format = "fallback" },

		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 3000,
			enabled = true,
			pattern = "*.{js,jsx,ts,tsx,lua,css,html,prisma,json}",
		},
	})
end
