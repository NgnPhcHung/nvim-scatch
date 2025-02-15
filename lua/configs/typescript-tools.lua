local cmp = require("cmp")
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities

local on_attach = function(client)
  client.server_capabilities.completionProvider = true
end

require("typescript-tools").setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    tsserver = {
      preferences = {
        moduleSpecifierPreference = "non-relative",
        quotePreference = "auto",
        includeCompletionsForImportStatements = true,
        preferImportModuleSpecifier = false,
        allowTextChangesInNewFiles = true,
        allowSyntheticDefaultImports = false,
        providePrefixAndSuffixTextForRename = true,
      },
      filePreferences = {
        allowJs = true,
        checkJs = true,
      },
    },
    separate_diagnostic_server = false,
    publish_diagnostic_on = "insert_leave",
    expose_as_code_action = {
      -- "fix_all", "add_missing_imports", "remove_unused_imports"
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
      includeInlayParameterNameHints = "none",
      includeCompletionsForModuleEports = true,
      quotePreference = "auto",
    },
    tsserver_locale = "en",
    complete_function_calls = true,
    include_completions_with_insert_text = true,
    code_lens = "off",
    disable_member_code_lens = true,
    jsx_close_tag = {
      enable = false,
      filetypes = { "javascriptreact", "typescriptreact" },
    },
  },
})
