require("kulala").setup({
  colorscheme = "tokyonight",
  lsp = {
    enable = true,
    servers = { "tsserver", "eslint" }
  },
  treesitter = {
    ensure_installed = { "lua", "javascript", "typescript" },
    highlight = { enable = true },
  },
})


vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<CR>",
  "<cmd>lua require('kulala').run()<cr>",
  { noremap = true, silent = true, desc = "Execute the request" }
)
