local capabilities = require("utils.lsp").capabilities

local function ts_on_attach(client, bufnr)
	local status_ok, illuminate = pcall(require, "illuminate")
	if status_ok then
		illuminate.on_attach(client)
	end

	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

	vim.keymap.set("n", "<leader>tr", function()
		local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "typescript-tools" })
		if #clients > 0 then
			for _, client in ipairs(clients) do
				vim.lsp.stop_client(client.id, true)
			end
			vim.defer_fn(function()
				vim.cmd("edit")
			end, 300)
		end
	end, { buffer = bufnr, desc = "Restart TypeScript server" })
end

local DIAG_FILTERS = { 80007, 80006 }

return {
	root_dir = function(fname)
		local root = vim.fs.root(fname, { "package.json", "tsconfig.json", "jsconfig.json", ".git" })
		return root
	end,

	flags = {
		debounce_text_changes = 200,
		allow_incremental_sync = true,
	},

	handlers = {
		["window/showMessage"] = function(err, result, ctx, config)
			if result and result.type == 1 then
				vim.notify("TypeScript Error: " .. result.message, vim.log.levels.ERROR)
			end
			return vim.lsp.handlers["window/showMessage"](err, result, ctx, config)
		end,
	},

	on_exit = function(code, signal, client_id)
		if code ~= 0 then
			vim.notify(
				string.format("TypeScript server exited with code %d (signal: %d)", code, signal or 0),
				vim.log.levels.ERROR
			)
		end
	end,

	on_attach = ts_on_attach,
	capabilities = capabilities,
	settings = {
		tsserver_max_memory = 8192,
		tsserver_path = nil,
		publish_diagnostic_on = "change",
		separate_diagnostic_server = true,
		tsserver_logs = "off",

		tsserver_file_preferences = {
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
		},
	},
}
