-- Get capabilities from blink.cmp or fallback
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
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

-- Filter out specific TypeScript diagnostics
local DIAG_FILTERS = { 80007, 80006 }

return {
	on_attach = ts_on_attach,
	capabilities = get_capabilities(),
	settings = {
		-- TSServer file preferences
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
		-- TSServer format options
		tsserver_format_options = {
			insertSpaceAfterCommaDelimiter = true,
			insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
			insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
		},
		-- Expose all code actions
		expose_as_code_action = "all",
		-- Disable complete function calls (can be annoying)
		complete_function_calls = false,
		-- Filter out specific diagnostics by code
		filter_out_diagnostics_by_code = DIAG_FILTERS,
		-- TSServer preferences
		tsserver_preferences = {
			importModuleSpecifierPreference = "relative",
			quotePreference = "double", -- Match with Biome
			importTypeSpecifier = "type",
		},
	},
}
