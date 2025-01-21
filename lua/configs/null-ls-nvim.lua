local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.completion.spell,
    require("none-ls.diagnostics.eslint").with({
      condition = function()
        -- Kiểm tra sự tồn tại của các tệp cấu hình ESLint sử dụng vim.fn
        return vim.fn.filereadable(".eslintrc.json") == 1 or
               vim.fn.filereadable(".eslintrc.js") == 1 or
               vim.fn.filereadable(".eslintrc.yaml") == 1
      end,
    }),
    require("none-ls.code_actions.eslint"),
    null_ls.builtins.formatting.mdformat,
    null_ls.builtins.formatting.prettier,
  },
  debounce = 1000, -- Tăng debounce để hạn chế xử lý quá nhiều lần
  -- on_attach = function(client, bufnr)
  --   local buf_map = function(mode, lhs, rhs, opts)
  --     opts = opts or { noremap = true, silent = true }
  --     vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
  --   end
  --
  --   buf_map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>")
  -- end,
})
