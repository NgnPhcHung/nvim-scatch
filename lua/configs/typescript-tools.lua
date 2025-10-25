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

	-- local eslint_root = vim.fs.root(bufnr, {
	-- 	".eslintrc",
	-- 	".eslintrc.js",
	-- 	".eslintrc.cjs",
	-- 	".eslintrc.json",
	-- 	"eslint.config.js",
	-- })
	--
	-- if eslint_root then
	-- 	client.server_capabilities.documentFormattingProvider = false
	-- 	client.server_capabilities.documentRangeFormattingProvider = false
	-- end

	-- TypeScript specific keymaps
	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

-- Filter out specific TypeScript diagnostics
local DIAG_FILTERS = { 80007, 80006 }

return {
	-- FIX: Use a function for root_dir instead of calling vim.fs.root directly
	root_dir = function(fname)
		return vim.fs.root(fname, { "package.json", "tsconfig.json", "jsconfig.json" })
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
