vim.opt.termguicolors = true

local bufferline = require("bufferline")

require("bufferline").setup {
  options = {
    indicator = {
      style = "underline",
    },
    show_buffer_close_icons = false,
    show_close_icon = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true
      }
    },
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    separator_style = "slope",
    numbers = function(opts)
    return string.format('%s',  opts.raise(opts.ordinal))
  end,
    always_show_bufferline = true,
    highlights = require("catppuccin.groups.integrations.bufferline").get(),
  }
}
