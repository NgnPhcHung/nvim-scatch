require("typescript-tools").setup({
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  settings = {
    tsserver_path = nil,
    separate_diagnostic_server = false,
    publish_diagnostic_on = "insert_leave",
    expose_as_code_action = { "all" },
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
      filetypes = { "typescriptreact" },
    },
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },

  }
  ,
})


local api = require("typescript-tools.api")
require("typescript-tools").setup {
  handlers = {
    ["textDocument/publishDiagnostics"] = api.filter_diagnostics(
    -- Ignore 'This may be converted to an async function' diagnostics.
      { 80006, 7044, 80001 }
    ),
  },
}
