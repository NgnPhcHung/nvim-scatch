local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Lua
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

lspconfig.ts_ls.setup({
  capabilities = capabilities,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "none",
        includeInlayEnumMemberValueHints = false,
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "none",
        includeInlayEnumMemberValueHints = false,
      }
    }
  }
})

require("typescript-tools").setup({
  settings = {
    separate_diagnostic_server = true,
    publish_diagnostic_on = "insert_leave",
    expose_as_code_action = {
      -- "fix_all", "add_missing_imports", "remove_unused_imports"
      "all"
    },
    tsserver_path = nil,
    tsserver_plugins = {  },
    tsserver_max_memory = "auto",
    tsserver_format_options = {
      allowIncompleteCompletions = false,
      allowRenameOfImportPath = false,
    },
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "none",
      includeCompletionsForModuleExports = true,
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
    }
  },
})
