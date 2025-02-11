local actions = require("telescope.actions")

require("telescope").setup {
  defaults = {
    path_display = { "smart" },
    mapping = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next, },
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown"
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {

      },
      specifc_opts = {
        codeactions = true
      }

    }
  },
  config = function()
  end,
}

require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
map('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
map("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
