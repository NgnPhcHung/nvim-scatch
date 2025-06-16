
require("neo-tree").setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_git_status = true,

  filesystem = {
    follow_current_file = {
      enabled = true,
    },
    bind_to_cwd = true,
    hijack_netrw_behavior = "open_current",
  },
  buffers = {
    follow_current_file = {
      enabled = true,
    },
    bind_to_cwd = true,
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

