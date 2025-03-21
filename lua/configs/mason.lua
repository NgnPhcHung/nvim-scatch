require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "html", "cssls", "clangd" },
  automatic_installation = false
})

local lspconfig = require("lspconfig")

local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup {
    }
  end,
})

lspconfig.clangd.setup({
  init_options = {
    clangdFileStatus = true,
  },
})


require('mason-lspconfig').setup_handlers {
  ['rust_analyzer'] = function() end,
}
