local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier.with({
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "css", "html" },
      extra_args = { "--config-precedence", "prefer-file" },
    }),

    null_ls.builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json", ".eslintrc" })
      end,
    }),
    null_ls.builtins.code_actions.eslint_d,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = "LspFormatting", buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
