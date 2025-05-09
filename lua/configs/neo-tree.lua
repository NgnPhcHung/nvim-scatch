require("neo-tree").setup({
  window = {
    position = "float",
    popup_border_style = "rounded",
    mappings = {
      ["<Tab>"] = "open",
      ["<CR>"] = "open",
    },
  },
  filesystem = {
    follow_current_file = {
      enabled = true
    }
  }
})
