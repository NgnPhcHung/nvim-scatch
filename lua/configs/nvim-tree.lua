require("nvim-tree").setup({
  view = {
    side = "left",
    adaptive_size = true,
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        file = true,
        folder = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = " ✗",
          staged = " ✓",
          unmerged = " ",
          renamed = " ➜",
          untracked = " ★",
          deleted = " ",
          ignored = " ◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    -- update_root = false,
  },
  modified = {
    enable = false,
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 1000,
  },
})
