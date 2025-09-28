require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "prettierd" },
		prisma = { "prisma_fmt" },

		-- ts/js
		javascript = { "biome", "prettierd", stop_after_first = true },
		typescript = { "biome", "prettierd", stop_after_first = true },
		javascriptreact = { "biome", "prettierd" },
		typescriptreact = { "biome", "prettierd" },
		json = { "biome", "prettierd" },
	},

	formatters = {
		prisma_fmt = {
			command = "npx",
			args = { "prisma", "format" },
			stdin = false,
		},

		biome = {
			command = "biome",
			args = { "format", "--stdin-file-path", "$FILENAME" },
			cwd = function(ctx)
				return require("lspconfig.util").root_pattern("biome.json", ".git")(ctx.dirname)
			end,
		},
	},

	default_format_opts = {
		lsp_format = "fallback",
	},

	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 500,
		enabled = true,
		pattern = "*.{js,jsx,ts,tsx,lua,css,html,prisma}",
	},
})

vim.lsp.enable("biome")

-- local lint = require("lint")
--
-- lint.linters.biome = {
-- 	cmd = "biome",
-- 	stdin = true,
-- 	args = { "check", "--stdin-file-path", "$FILENAME", "--format=json" },
-- 	ignore_exitcode = true,
-- 	parser = require("lint.parser").from_errorformat("%f:%l:%c: %m"),
-- }
--
-- lint.linters_by_ft = {
-- 	javascript = { "biome", "eslint_d" },
-- 	typescript = { "biome", "eslint_d" },
-- 	javascriptreact = { "biome", "eslint_d" },
-- 	typescriptreact = { "biome", "eslint_d" },
-- 	json = { "biome", "eslint_d" },
-- }
--
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 	callback = function()
-- 		require("lint").try_lint()
-- 	end,
-- })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
