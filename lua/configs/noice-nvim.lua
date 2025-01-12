require("noice").setup({
  messages = { view_search = false },
  notify = {
    enabled = true,
    view = "mini",
    position = "middle,right",
  },
  cmdline = {
    enabled = true,
    format = {
      default = {
        position = {
          row = 40,
          col = "50%",
        },
        size = {
          width = "40%",

        },
        border = {
          style = "rounded",
        },
      },
    },
  },
  lsp = {
    progress = {
      enabled = true,
    },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["vim.lsp.buf.code_action"] = false,
      ['cmp.entry.get_documentation'] = true,
    },
    signature = {
      enabled = true,
    },

  },
  routes = {
    -- See :h ui-messages
    {
      filter = {
        event = 'msg_show',
        any = {
          { find = '%d+L, %d+B' },
          { find = '^%d+ changes?; after #%d+' },
          { find = '^%d+ changes?; before #%d+' },
          { find = '^Hunk %d+ of %d+$' },
          { find = '^%d+ fewer lines;?' },
          { find = '^%d+ more lines?;?' },
          { find = '^%d+ line less;?' },
          { find = '^Already at newest change' },
          { kind = 'wmsg' },
          { kind = 'emsg',                      find = 'E486' },
          { kind = 'quickfix' },
        },
      },
      view = 'mini',
    },
  },
  presets = {
    bottom_search = false,
    command_palette = false,
    long_message_to_split = false,
    inc_rename = true,
    lsp_doc_border = true,
    progress = false,
    smart_move = false
  },
  config = function(_, opts)
    if vim.o.filetype == 'lazy' then
      vim.cmd([[messages clear]])
    end
    require('noice').setup(opts)
  end,
})
