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

    filtered_items = {
      hide_dotfiles = true,
      hide_git_ignored = true,
      hide_hidden = true,
      ignored_file_patterns = {
        '^\\.env$', -- This pattern specifically matches and ignores ".env"
        -- Add other patterns you want to ignore if necessary, e.g.:
        -- 'node_modules',
        -- '.git',
        -- '%.o',
        -- '%.obj',
      },
      -- If you want to show .env.*, you generally don't need a specific pattern
      -- because the '^\\.env$' only matches exactly '.env' and not '.env.development'
    },
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
