return function()
	local util = require("lspconfig.util")

	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			prisma = { "prisma_fmt" },

			-- 🧩  ESLint + Prettierd
			css = { "eslint_d", "prettierd" },
			javascript = { "eslint_d", "prettierd" },
			typescript = { "eslint_d", "prettierd" },
			javascriptreact = { "eslint_d", "prettierd" },
			typescriptreact = { "eslint_d", "prettierd" },
			json = { "eslint_d", "prettierd" },

			-- 🧩 Biome
			-- css = { "biome", stop_after_first = true },
			-- javascript = { "biome", stop_after_first = true },
			-- typescript = { "biome", stop_after_first = true },
			-- javascriptreact = { "biome", stop_after_first = true },
			-- typescriptreact = { "biome", stop_after_first = true },
			-- json = { "biome", stop_after_first = true },
		},

		formatters = {
			-- Prisma
			prisma = {
				command = "npx",
				args = { "prisma", "format", "--schema", "$FILENAME" },
				stdin = false,
				cwd = function(ctx)
					return util.root_pattern("prisma", "package.json", ".git")(ctx.dirname)
				end,
			},

			stylua = { command = "stylua", args = { "-" }, stdin = true },

			prettierd = {
				command = "prettierd",
				args = { "--stdin-file-path", "$FILENAME" },
				stdin = true,
			},

			eslint_d = {
				command = "npx",
				args = { "eslint_d", "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
				stdin = true,
				cwd = function(ctx)
					return util.root_pattern(".eslintrc*", "eslint.config.*", "package.json", ".git")(ctx.dirname)
				end,
				condition = function(ctx)
					return util.root_pattern(
						".eslintrc",
						".eslintrc.js",
						".eslintrc.cjs",
						".eslintrc.json",
						".eslintrc.yaml",
						".eslintrc.yml",
						"eslint.config.js",
						"eslint.config.mjs",
						"eslint.config.cjs"
					)(ctx.dirname) ~= nil
				end,
			},

			-- 🌿 Biome (only if no ESLint)
			biome = {
				command = "npx",
				args = { "biome", "format", "--stdin-file-path", "$FILENAME" },
				stdin = true,
				cwd = function(ctx)
					return util.root_pattern("biome.json", "package.json", ".git")(ctx.dirname)
				end,
				condition = function(ctx)
					-- ❌ Skip Biome if ESLint config is present
					local eslint_found = util.root_pattern(
						".eslintrc",
						".eslintrc.js",
						".eslintrc.cjs",
						".eslintrc.json",
						".eslintrc.yml",
						".eslintrc.yaml",
						"eslint.config.js",
						"eslint.config.mjs",
						"eslint.config.cjs"
					)(ctx.dirname)
					if eslint_found then
						return false
					end
					return util.root_pattern("biome.json", "biome.jsonc")(ctx.dirname) ~= nil
				end,
			},
		},

		default_format_opts = { lsp_format = "fallback" },

		format_on_save = {
			timeout_ms = 3000,
			lsp_format = "never",
			pattern = "*.{js,jsx,ts,tsx,lua,css,html,prisma,json}",
		},
	})
end
