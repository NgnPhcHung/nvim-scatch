local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())


local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   group = vim.api.nvim_create_augroup("Format", { clear = true }),
    --   buffer = bufnr,
    --   callback = function() vim.lsp.buf.formatting_seq_sync() end
    -- })
  end
end


lspconfig.lua_ls.setup({
  capabilities = capabilities
})
require("typescript-tools").setup({
  on_attach = on_attach,
  settings = {
    separate_diagnostic_server = true,
    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
    publish_diagnostic_on = "insert_leave",
    expose_as_code_action = {
      "fix_all", "add_missing_imports", "remove_unused_imports"
    },
    tsserver_path = nil,
    tsserver_plugins = {},
    tsserver_max_memory = "auto",
    tsserver_format_options = {},
    tsserver_file_preferences = {},
    tsserver_locale = "en",
    complete_function_calls = false,
    include_completions_with_insert_text = true,
    code_lens = "off",
    disable_member_code_lens = true,
    jsx_close_tag = {
      enable = false,
      filetypes = { "javascriptreact", "typescriptreact" },
    }
  },
})
