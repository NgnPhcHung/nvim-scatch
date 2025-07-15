require('notify').setup({
  stages = 'slide',
  timeout = 5000,
  position = 'bottom_right',
  max_width = function()
    return math.floor(vim.o.columns * 0.75)
  end,
  max_height = function()
    return math.floor(vim.o.lines * 0.75)
  end,
  top_down = false,
  icons = {
    ERROR = '',
    WARN = '',
    INFO = '',
    DEBUG = '',
    TRACE = '',
  },
  render = "compact"
})
