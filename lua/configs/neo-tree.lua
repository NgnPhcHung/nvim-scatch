require("neo-tree").setup({
  window = {
    position = "float",
    -- width = 40,
    mappings = {
    },
  },

  default_component_configs = {
    icon = {
      folder_closed = "", -- icon cho folder đóng
      folder_open = "", -- icon cho folder mở
      -- default = "", -- icon cho file
      -- symlink = "", -- icon cho symlink
    },
    git_status = {
      symbols = {
        unstaged = " ✗",
        staged = " ✓",
        unmerged = " ",
        renamed = " ➜",
        untracked = " ★",
        deleted = " ",
        ignored = " ◌",
      },
    },
    diagnostics = {
      symbols = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
  },

  filesystem = {
    filtered_items = {
      visible = true,        -- Hiển thị các file được filter (cho mục đích xem trước)
      hide_dotfiles = false, -- Không ẩn dotfiles (theo config ban đầu của bạn)
      hide_by_name = { "node_modules", ".DS_Store" },
    },
    use_libuv_file_watcher = true,
    follow_current_file = {
      enabled = true,          -- This will find and focus the file in the active buffer every time
      --               -- the current file is changed while the tree is open.
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
  },
  git_status = {
    window = {
      position = "float",
    },
  },
})
