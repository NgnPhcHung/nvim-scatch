local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client)
  client.server_capabilities.documentFormattingProvider = false
end

require("typescript-tools").setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    separate_diagnostic_server = false,
    publish_diagnostic_on = "insert_leave",
    expose_as_code_action = {
      "all",
    },
    tsserver_path = nil,
    tsserver_plugins = {},
    tsserver_max_memory = "auto",
    tsserver_format_options = {
      allowIncompleteCompletions = false,
      allowRenameOfImportPath = false,
    },
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeCompletionsForModuleExports = true,
      quotePreference = "auto",
    },
    tsserver_locale = "en",
    complete_function_calls = true,
    include_completions_with_insert_text = true,
    code_lens = "off",
    disable_member_code_lens = true,
    jsx_close_tag = {
      enable = true,
      filetypes = { "javascriptreact", "typescriptreact" },
    },
    filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
  },
})
