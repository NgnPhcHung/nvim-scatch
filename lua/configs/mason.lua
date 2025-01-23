require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { "ts_ls", "lua_ls", "html", "cssls", "eslint", "clangd" },
})

local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')

-- local buffer_autoformat = function(bufnr)
--   -- local group = "null_ls_autoformat"
-- vim.api.nvim_create_augroup(group, { clear = false })
-- vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = group,
--   buffer = bufnr,
--   desc = "Auto format on save with null-ls",
--   callback = function()
--     vim.lsp.buf.format({ async = false, timeout_ms = 5000 })
--   end,
-- })
-- end

local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    -- buffer_autoformat(bufnr)
  end
end

mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup {
      on_attach = on_attach,
    }
  end,
})
--
-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(event)
--     local id = vim.tbl_get(event, 'data', 'client_id')
--     local client = id and vim.lsp.get_client_by_id(id)
--     if client == nil then
--       return
--     end
--
--     if client.supports_method('textDocument/formatting') then
--       buffer_autoformat(event.buf)
--     end
--   end
-- })

lspconfig.clangd.setup({
  init_options = {
    clangdFileStatus = true,
  },
})
