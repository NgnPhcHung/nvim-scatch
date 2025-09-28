require("focus").setup({
  enable = true,   -- Enable module
  commands = true, -- Create Focus commands
  excluded_filetypes = {
    "undotree",
    "neo-tree",
    "alpha",
    "NvimTree",        -- Example, if you use NvimTree
    "TelescopePrompt", -- Example, if you use Telescope
    "aerial"
  },
  autoresize = {
    enable = true,               -- Enable or disable auto-resizing of splits
    width = 0,                   -- Force width for the focused window
    height = 0,                  -- Force height for the focused window
    minwidth = 20,               -- Force minimum width for the unfocused window
    minheight = 0,               -- Force minimum height for the unfocused window
    focusedwindow_minwidth = 0,  --Force minimum width for the focused window
    focusedwindow_minheight = 0, --Force minimum height for the focused window
    height_quickfix = 10,        -- Set the height of quickfix panel
  },
  split = {
    bufnew = false, -- Create blank buffer for new split windows
    tmux = false,   -- Create tmux splits instead of neovim splits
  },
})
