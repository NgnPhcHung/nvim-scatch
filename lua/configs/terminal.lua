require('toggleterm').setup({
  size = 25,
  open_mapping = [[<C-\>]],
  direction = 'horizontal',
  start_in_insert = true,
})

vim.keymap.set('t', '<C-h>', function()
  vim.cmd("stopinsert")
  vim.api.nvim_set_current_win(vim.fn.win_getid(vim.fn.winnr("#")))
end, { noremap = true, silent = true, desc = "Move focus back to previous window" })
