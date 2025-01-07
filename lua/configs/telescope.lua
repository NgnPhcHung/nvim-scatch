require("telescope").setup {
  defaults = {
    mapping = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false
      },
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown"
    }
  }
}

require('telescope').load_extension('fzf')
-- vim.keymap.set("n", "gr", function()
--   require('telescope.builtin').lsp_references({
--     include_declaration = false,  -- Bỏ qua declaration
--     show_line = true,             -- Hiển thị nội dung dòng
--     layout_strategy = "vertical", -- Hiển thị dạng dọc (vertical)
--     layout_config = {
--       preview_cutoff = 40,        -- Hiển thị preview khi có đủ không gian
--       width = 0.8,
--     },
--   })
-- end, { desc = "Telescope LSP References" })
--
vim.api.nvim_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', { noremap = true, silent = true })
