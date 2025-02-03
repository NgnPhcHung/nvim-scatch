local null_ls = require("null-ls")
local utils = require("core.utils")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.completion.spell,
    require("none-ls.diagnostics.eslint"),
    require("none-ls.code_actions.eslint"),
    null_ls.builtins.formatting.mdformat,
    null_ls.builtins.formatting.prettier,
  },
  debounce = 500,
  on_attach = function(client, bufnr)
    -- Hàm xử lý sự kiện
    local function handle_event()
      -- Logic của bạn ở đây, ví dụ: format file hoặc kiểm tra lỗi
      vim.lsp.buf.format({ async = true })
    end

    -- Debounce hàm xử lý sự kiện với thời gian chờ 300ms
    local debounced_handle_event = utils.debounce(handle_event, 300)

    -- Gắn debounced callback vào các sự kiện
    vim.api.nvim_create_autocmd({ "BufWritePost"}, {
      callback = debounced_handle_event,
    })
  end,
})
