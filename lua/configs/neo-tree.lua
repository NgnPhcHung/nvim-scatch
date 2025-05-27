local root_dir = vim.fn.getcwd()

require("neo-tree").setup({
  filesystem = {
    follow_current_file = {
      enabled = true,
    },
    bind_to_cwd = false,
    cwd_target = {
      sidebar = "none",
      current = "none",
    },
    hijack_netrw_behavior = "open_default",
    use_libuv_file_watcher = true,
  },
  buffers = {
    follow_current_file = {
      enabled = false,
    },
    bind_to_cwd = false,
  },
  mapping_options = {
    noremap = true,
    nowait = true,
  },
  window = {
    position = "float",
    mappings = {
      ["<CR>"] = "open",
      ["<Tab>"] = "open_split",
    },
  }
})

-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     vim.cmd("Neotree filesystem reveal dir=" .. root_dir)
--   end,
-- })
