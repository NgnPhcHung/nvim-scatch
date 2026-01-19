local lsp_utils = require("utils.lsp")

return {
	on_attach = lsp_utils.ts_on_attach,
	capabilities = lsp_utils.capabilities,
	settings = {
		tsserver_max_memory = 8192,
		publish_diagnostic_on = "change",
		separate_diagnostic_server = true,
		tsserver_logs = "off",
		complete_function_calls = false,
		expose_as_code_action = "all",
		filter_out_diagnostics_by_code = { 80007, 80006 },

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
	},
}
