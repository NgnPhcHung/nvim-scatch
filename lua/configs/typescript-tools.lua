local api = require("typescript-tools.api")
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

local capabilities = require("blink.cmp").get_lsp_capabilities()

require("typescript-tools").setup({
	on_attach = function(_, bufnr)
		local opts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	end,
	capabilities = capabilities,

	settings = {
		tsserver_file_preferences = {
			includeInlayParameterNameHints = "all",
			includeCompletionsForModuleExports = true,
			includeCompletionsWithSnippetText = true,
		},
		tsserver_format_options = {
			insertSpaceAfterCommaDelimiter = true,
			insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
			insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
		},
		expose_as_code_action = "all",
		complete_function_calls = true,
		filter_out_diagnostics_by_code = {
			80007,
			80006,
		},
	},

	handlers = {
		["textDocument/publishDiagnostics"] = api.filter_diagnostics({
			80007,
			80006,
		}),
	},
})
