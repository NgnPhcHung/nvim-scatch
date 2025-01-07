local lspconfig = require('lspconfig')


-- Specify how the border looks like
local border = {
  { '┌', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '┐', 'FloatBorder' },
  { '│', 'FloatBorder' },
  { '┘', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '└', 'FloatBorder' },
  { '│', 'FloatBorder' },
}

-- Add the border on hover and on signature help popup window
local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

-- Add border to the diagnostic popup window
vim.diagnostic.config({
  virtual_text = {
    prefix = '■ ', -- Could be '●', '▎', 'x', '■', , 
  },
  float = { border = border },
})

-- Add the border (handlers) to the lua language server
lspconfig.lua_ls.setup({
  handlers = handlers,
  -- The rest of the server configuration
})

-- Add the border (handlers) to the pyright server
lspconfig.pyright.setup({
  handlers = handlers,
})

lspconfig.ts_ls.setup({
  on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    local map = vim.api.nvim_set_keymap

    map('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- Show signature help (function/method signature) for the symbol under cursor.

    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- Go to the implementation of the symbol under cursor.

    map('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- Go to the type definition of the symbol under cursor.

    map('n', '<leader>gw', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
    -- Show the document symbols (functions, classes, variables) in the current file.

    map('n', '<leader>gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
    -- Show the workspace symbols (search symbols across the entire project).

    map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- Show available code actions (fixes, refactors) for the symbol under cursor.

    map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- Rename the symbol under the cursor throughout the project.
    map('n', '<leader>bf', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
  end
})
