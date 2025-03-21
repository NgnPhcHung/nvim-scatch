require("noice").setup({
  messages = { view_search = false },
  message = {
    enabled = true,
    view = "notify",
    opts = {},
  },
  notify = {
    enabled = true,
    view = "mini",
    position = "middle,right",
  },
  cmdline = {
    enabled = true,
    view = "cmdline_popup",
    format = {
      default = {
        position = { row = 41, col = "50%" },
        size = { width = "41%" },
        border = { style = "rounded" },
      },
    },
  },
  lsp = {
    progress = { enabled = true },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["vim.lsp.buf.code_action"] = false,
      ["cmp.entry.get_documentation"] = false,
      ["vim.lsp.buf.hover"] = true,
    },
    signature = { enabled = true },
    messages = { enabled = false },
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "^%d+ changes?; after #%d+" },
          { find = "^%d+ changes?; before #%d+" },
          { find = "^Hunk %d+ of %d+$" },
          { find = "^%d+ fewer lines;?" },
          { find = "^%d+ more lines?;?" },
          { find = "^%d+ line less;?" },
          { find = "^Already at newest change" },
          { kind = "wmsg" },
          { kind = "emsg",                      find = "E487" },
          { kind = "quickfix" },
        },
      },
      view = "mini",
    },
    {
      filter = { event = "msg_show", kind = "", find = "written" },
      opts = { skip = true },
    },
  },
  presets = {
    bottom_search = false,
    command_palette = false,
    long_message_to_split = false,
    inc_rename = true,
    lsp_doc_border = true,
    progress = false,
    smart_move = false,
  },
  views = {
    hover = {
      border = { style = "rounded" },
      relative = "cursor",
      size = {
        width = "auto",
        height = "auto",
        max_width = math.floor(vim.o.columns * 1.5),
        max_height = math.floor(vim.o.lines * 1.4),
      },
      position = { row = 2, col = 1 },
      win_options = {
        winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" },
      },
    },
    cmdline_popup = {
      win_options = {
        winblend = 1, -- You can try increasing this value (e.g., 20) to see if transparency becomes visible.
        winhl = "Normal:NoiceCmdLine,FloatBorder:NoiceCmdLineBorder",
      },
    },
  },
})
vim.cmd [[
  augroup NoiceCustomHighlights
    autocmd!
    autocmd ColorScheme * highlight NoiceCmdLine guibg=none ctermbg=none
    autocmd ColorScheme * highlight NoiceCmdLineBorder guibg=none ctermbg=none
  augroup END
]]
