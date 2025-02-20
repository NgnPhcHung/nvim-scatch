local null_ls = require("null-ls")

local lua_sources = {
  -- null_ls.builtins.formatting.stylua,
  null_ls.builtins.completion.luasnip,
}

local ts_js_sources = {
  -- null_ls.builtins.formatting.prettier,
  null_ls.builtins.completion.spell,
  require("none-ls.code_actions.eslint"),
  require("null-ls").builtins.diagnostics.eslint_d
}

null_ls.setup({
  sources = vim.bo.filetype == "lua" and lua_sources or ts_js_sources,

  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})
