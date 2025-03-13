--find and replace

vim.keymap.set('n', '<leader><S-f>', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre"
})
