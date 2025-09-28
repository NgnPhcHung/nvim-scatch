require("tokyonight").setup({
  style = "night",
  transparent = true,
  on_colors = function(colors)
    colors.hint = colors.orange
    colors.error = "#ff0000"
  end,
})

require("gruvbox").setup({
  terminal_colors = true, -- đồng bộ màu terminal
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true,    -- inverse highlight cho search, diffs, statuslines
  contrast = "hard", -- "hard", "soft" hoặc "medium"
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = true, -- bật true nếu muốn background transparent
})


vim.cmd([[colorscheme tokyonight-night]])
