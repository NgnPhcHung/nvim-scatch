require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { "ts_ls", "lua_ls", "html", "cssls", "eslint", "clangd" },
})

local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')

local buffer_autoformat = function(bufnr)
  local group = 'lsp_autoformat'
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = bufnr,
    group = group,
    desc = 'LSP format on save',
    callback = function()
      vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
    end,
  })
end


local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

  if client.supports_method('textDocument/formatting') then
    buffer_autoformat(bufnr)
  end
end

mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup {
      on_attach = on_attach,
    }
  end,
})


vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local id = vim.tbl_get(event, 'data', 'client_id')
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil then
      return
    end

    if client.supports_method('textDocument/formatting') then
      buffer_autoformat(event.buf)
    end
  end
})

lspconfig.clangd.setup({
  init_options = {
    clangdFileStatus = true,
  },
})
