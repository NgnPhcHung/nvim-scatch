local M = {}

M.setup = function()
  require('aerial').setup({
    attach_mode = "window",        -- Tự động hiển thị outline trong cửa sổ mới
    show_guides = true,            -- Hiển thị đường dẫn hướng dẫn
    layout = {
      default_direction = "right", -- Hiển thị ở bên phải
      max_width = { 40, 0.3 },     -- Chiều rộng tối đa
    },
  })

  vim.api.nvim_set_keymap('n', '<leader>o', '<cmd>AerialToggle<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '[a', '<cmd>AerialPrev<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', ']a', '<cmd>AerialNext<CR>', { noremap = true, silent = true })
end

return M
