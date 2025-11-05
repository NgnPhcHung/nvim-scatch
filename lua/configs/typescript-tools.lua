local function get_capabilities()
	local status_ok, blink_cmp = pcall(require, "blink.cmp")
	if status_ok then
		return blink_cmp.get_lsp_capabilities()
	else
		local cmp_status, cmp_lsp = pcall(require, "cmp_nvim_lsp")
		if cmp_status then
			return cmp_lsp.default_capabilities()
		else
			return vim.lsp.protocol.make_client_capabilities()
		end
	end
end

-- Custom on_attach for TypeScript
local function ts_on_attach(client, bufnr)
	-- Integrate with illuminate if available
	local status_ok, illuminate = pcall(require, "illuminate")
	if status_ok then
		illuminate.on_attach(client)
	end

	-- TypeScript specific keymaps
	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

	-- Auto-reload TypeScript server when package.json or tsconfig changes
	local root_dir = client.config.root_dir
	if root_dir then
		local group = vim.api.nvim_create_augroup("TypeScriptReload_" .. bufnr, { clear = true })

		-- Watch for package.json changes (new dependencies)
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = group,
			pattern = root_dir .. "/package.json",
			callback = function()
				vim.notify("Reloading TypeScript server (package.json changed)", vim.log.levels.INFO)
				vim.cmd("LspRestart typescript-tools")
			end,
		})

		-- Watch for tsconfig changes
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = group,
			pattern = {
				root_dir .. "/tsconfig.json",
				root_dir .. "/tsconfig.*.json",
				root_dir .. "/*/tsconfig.json",
			},
			callback = function()
				vim.notify("Reloading TypeScript server (tsconfig changed)", vim.log.levels.INFO)
				vim.cmd("LspRestart typescript-tools")
			end,
		})
	end
end

-- Filter out specific TypeScript diagnostics
local DIAG_FILTERS = { 80007, 80006 }

-- Create a user command to manually reload TypeScript types
vim.api.nvim_create_user_command("TSReloadTypes", function()
	vim.cmd("LspRestart typescript-tools")
	vim.notify("TypeScript server restarted - types reloaded", vim.log.levels.INFO)
end, { desc = "Reload TypeScript types by restarting TS server" })

-- Create a health check command
vim.api.nvim_create_user_command("TSHealthCheck", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local bufname = vim.api.nvim_buf_get_name(bufnr)
	local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

	vim.notify("TypeScript Health Check", vim.log.levels.INFO)
	vim.notify("- File: " .. bufname, vim.log.levels.INFO)
	vim.notify("- FileType: " .. filetype, vim.log.levels.INFO)

	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "typescript-tools" })
	if #clients > 0 then
		vim.notify("✅ typescript-tools is attached", vim.log.levels.INFO)
		for _, client in ipairs(clients) do
			vim.notify("- Root: " .. (client.config.root_dir or "none"), vim.log.levels.INFO)
		end
	else
		vim.notify("❌ typescript-tools is NOT attached", vim.log.levels.WARN)
		vim.notify("Try: :LspStart typescript-tools", vim.log.levels.WARN)
	end
end, { desc = "Check TypeScript LSP status" })

return {
	-- Use a function for root_dir - only start if we find a proper root
	root_dir = function(fname)
		-- Look for package.json, tsconfig.json, or jsconfig.json
		local root = vim.fs.root(fname, { "package.json", "tsconfig.json", "jsconfig.json" })
		if root then
			return root
		end
		-- Also check for .git as fallback for JS/TS projects
		root = vim.fs.root(fname, { ".git" })
		if root then
			-- Verify it's actually a JS/TS project by checking for node_modules or common files
			if vim.fn.isdirectory(root .. "/node_modules") == 1 or
			   vim.fn.filereadable(root .. "/package.json") == 1 or
			   vim.fn.glob(root .. "/**/*.ts", false, true)[1] or
			   vim.fn.glob(root .. "/**/*.tsx", false, true)[1] then
				return root
			end
		end
		-- Return nil to prevent starting in non-TS/JS projects
		return nil
	end,
	on_attach = ts_on_attach,
	capabilities = get_capabilities(),
	settings = {
		tsserver_file_preferences = {
			experimentalDecorators = true,
			includeInlayParameterNameHints = "all",
			includeCompletionsForModuleExports = true,
			includeCompletionsWithSnippetText = true,
			includeInlayParameterNameHintsWhenArgumentMatchesName = false,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayVariableTypeHints = true,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayEnumMemberValueHints = true,
		},
		tsserver_format_options = {
			insertSpaceAfterCommaDelimiter = true,
			insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
			insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
		},
		expose_as_code_action = "all",
		complete_function_calls = false,
		filter_out_diagnostics_by_code = DIAG_FILTERS,
		tsserver_preferences = {
			importModuleSpecifierPreference = "relative",
			quotePreference = "double",
			importTypeSpecifier = "type",
		},
	},
}
