return function()
	local util = require("lspconfig.util")

	-- Smart formatter selection: returns appropriate formatters based on project config
	local function get_formatters_for_js()
		local bufnr = vim.api.nvim_get_current_buf()
		local bufname = vim.api.nvim_buf_get_name(bufnr)
		local dirname = vim.fn.fnamemodify(bufname, ":h")

		local biome_config = util.root_pattern("biome.json", "biome.jsonc")(dirname)
		if biome_config then
			return { "biome" }
		end

		local eslint_config = util.root_pattern(
			".eslintrc",
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.json",
			".eslintrc.yml",
			".eslintrc.yaml",
			"eslint.config.js",
			"eslint.config.mjs",
			"eslint.config.cjs"
		)(dirname)

		if eslint_config then
			return { "eslint_d", "prettierd" }
		end

		return { "prettierd" }
	end

	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			-- Prisma uses LSP formatting (prismals)

			-- Use smart detection for JS/TS files
			css = get_formatters_for_js,
			javascript = get_formatters_for_js,
			typescript = get_formatters_for_js,
			javascriptreact = get_formatters_for_js,
			typescriptreact = get_formatters_for_js,
			json = get_formatters_for_js,
		},

		formatters = {
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
			lsp_format = "fallback",
			pattern = "*.{js,jsx,ts,tsx,lua,css,html,prisma,json}",
		},
	})
end
