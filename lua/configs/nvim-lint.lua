return function()
	local lint = require("lint")
	local util = require("lspconfig.util")

	local function get_linter_for_js_ts()
		local buf = vim.api.nvim_get_current_buf()
		local buf_path = vim.api.nvim_buf_get_name(buf)
		local dirname = vim.fs.dirname(buf_path)

		if not dirname then
			return {}
		end

		local eslint_root = util.root_pattern(
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

		if eslint_root then
			return { "eslint" }
		end

		local biome_root = util.root_pattern("biome.json", "biome.jsonc")(dirname)
		if biome_root then
			return { "biomejs" }
		end

		return {}
	end

	lint.linters_by_ft = {
		javascript = get_linter_for_js_ts(),
		typescript = get_linter_for_js_ts(),
		javascriptreact = get_linter_for_js_ts(),
		typescriptreact = get_linter_for_js_ts(),
		json = function()
			local buf = vim.api.nvim_get_current_buf()
			local buf_path = vim.api.nvim_buf_get_name(buf)
			local dirname = vim.fs.dirname(buf_path)
			local biome_root = util.root_pattern("biome.json", "biome.jsonc")(dirname)
			return biome_root and { "biomejs" } or {}
		end,
		lua = { "luacheck" },
	}

	vim.api.nvim_create_autocmd("BufWritePost", {
		group = vim.api.nvim_create_augroup("LintOnSave", { clear = true }),
		callback = function()
			require("lint").try_lint()
		end,
	})
end
