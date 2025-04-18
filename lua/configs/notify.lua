require('notify').setup {
  stages = 'slide',
  timeout = 5000,
  position = 'top_right',
  max_width = 130,
  top_down = false,
  icons = {
    ERROR = '',
    WARN = '',
    INFO = '',
    DEBUG = '',
    TRACE = '',
  },
  config = {
    render = "compact"
  }
}
