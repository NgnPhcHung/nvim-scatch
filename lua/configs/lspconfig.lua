local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())


local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.formatting_seq_sync() end
    })
  end
end


lspconfig.lua_ls.setup({
  capabilities = capabilities
})

lspconfig.ts_ls.setup({
  handlers = {
    ["textDocument/signatureHelp"] = function(...)
      vim.lsp.handlers["textDocument/signatureHelp"](...)
    end,
  },
  init_options = {
    preferences = {
      includeCompletionsForModuleExports = true,
      includeCompletionsWithInsertText = true,
      includeCompletionsForImportStatements = true,
      includeInlayVariableTypeHints = true,
      includeInlayFunctionParameterTypeHints = true,
      includeOptionalCompletions = true,
    }
  },
  capabilities = capabilities,
  on_attach = on_attach
})
