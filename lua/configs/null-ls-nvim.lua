local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.completion.spell,
    require("none-ls.diagnostics.eslint"),
    null_ls.builtins.formatting.mdformat,
    null_ls.builtins.formatting.prettier,
  },
  on_attach = function(client, bufnr)
    local buf_map = function(mode, lhs, rhs, opts)
      opts = opts or { noremap = true, silent = true }
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end
    buf_map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>")
  end,

})
