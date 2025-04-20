require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "html", "cssls", "clangd", "prismals", "dockerls", "jsonls" },
  automatic_installation = false
})

local lspconfig = require("lspconfig")
local capabilities = require('blink.cmp').get_lsp_capabilities()
local mason_lspconfig = require('mason-lspconfig')

local function lsp_highlight_document(client)
  -- if client.server_capabilities.document_highlight then
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
  -- end
end

mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities,
    }
  end,
})

lspconfig.clangd.setup({
  init_options = {
    clangdFileStatus = true,
  },
})

lspconfig.prismals.setup({
  capabilities = capabilities,
  on_attach = function(client, _)
    lsp_highlight_document(client)
  end
})

require('mason-lspconfig').setup_handlers {
  ['rust_analyzer'] = function() end,
}

require('lspconfig').jsonls.setup {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}
