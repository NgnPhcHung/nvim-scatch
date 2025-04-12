local M = {}

M.setup = function()
  require('aerial').setup({
    attach_mode = "window",
    show_guides = true,
    layout = {
      default_direction = "right",
      max_width = { 40, 0.3 },
    },
  })

  vim.api.nvim_set_keymap('n', '<leader>o', '<cmd>AerialToggle<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '[a', '<cmd>AerialPrev<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', ']a', '<cmd>AerialNext<CR>', { noremap = true, silent = true })
end

return M
