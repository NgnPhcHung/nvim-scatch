require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "html", "cssls", "clangd", "prismals", "dockerls", "jsonls", "rust_analyzer" },
  automatic_installation = false
})

local lspconfig = require("lspconfig")
local capabilities = require('blink.cmp').get_lsp_capabilities()

local function lsp_highlight_document(client)
  local status_ok, illuminate = pcall(require, "illuminate")
  if status_ok then
    illuminate.on_attach(client)
  end
end

require("mason-lspconfig").setup_handlers({
  -- default setup for all
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities,
    }
  end,

  -- override for clangd
  ["clangd"] = function()
    lspconfig.clangd.setup {
      capabilities = capabilities,
      init_options = {
        clangdFileStatus = true,
      },
    }
  end,

  -- override for prismals
  ["prismals"] = function()
    lspconfig.prismals.setup {
      capabilities = capabilities,
      on_attach = lsp_highlight_document,
    }
  end,

  -- override for rust_analyzer (disable)
  ["rust_analyzer"] = function()
    -- intentionally left blank
  end,

  -- override for jsonls
  ["jsonls"] = function()
    lspconfig.jsonls.setup {
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    }
  end,
})
