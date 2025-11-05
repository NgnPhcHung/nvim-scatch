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

	-- Don't set linters_by_ft statically - we'll handle it dynamically in the autocmd
	lint.linters_by_ft = {
		lua = { "luacheck" },
	}

	vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
		group = vim.api.nvim_create_augroup("LintOnSave", { clear = true }),
		callback = function()
			local ft = vim.bo.filetype
			local linters = {}

			-- Dynamically determine linters based on filetype and project config
			if
				ft == "javascript"
				or ft == "typescript"
				or ft == "javascriptreact"
				or ft == "typescriptreact"
			then
				linters = get_linter_for_js_ts()
			elseif ft == "json" then
				local buf = vim.api.nvim_get_current_buf()
				local buf_path = vim.api.nvim_buf_get_name(buf)
				local dirname = vim.fs.dirname(buf_path)
				local biome_root = util.root_pattern("biome.json", "biome.jsonc")(dirname)
				linters = biome_root and { "biomejs" } or {}
			elseif ft == "lua" then
				linters = { "luacheck" }
			end

			-- Only try to lint if we have linters configured
			if #linters > 0 then
				-- Temporarily set the linters for this filetype
				lint.linters_by_ft[ft] = linters
				require("lint").try_lint()
			end
		end,
	})
end
