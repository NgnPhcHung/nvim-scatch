local debounce = function(func, timeout)
  local timer = vim.loop.new_timer()
  return function(...)
    local args = { ... }
    timer:stop()
    timer:start(timeout, 0, vim.schedule_wrap(function()
      func(table.unpack(args))
    end))
  end
end

local format_with_debounce = debounce(function(bufnr)
  vim.lsp.buf.format({ bufnr = bufnr })
end, 1000) -- 1000ms debounce


local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("NullLsFormatting", {})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.completion.spell,
    require("none-ls.diagnostics.eslint"),
    require("none-ls.code_actions.eslint"),
    null_ls.builtins.formatting.mdformat,
    null_ls.builtins.formatting.prettier,
  },
  debounce = 1000,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>fm", function()
        format_with_debounce(bufnr)
      end, { noremap = true, silent = true, buffer = bufnr })
    end
  end,
})
