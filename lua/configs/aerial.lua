local M = {}

M.setup = function()
  require('aerial').setup({
    attach_mode = "window",
    show_guides = true,
    backends = { "lsp", "treesitter", "markdown", "man" },
    layout = {
      resize_to_content = false,
      win_opts = {
        winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
        signcolumn = "yes",
        statuscolumn = " ",
      },
    },
    guides = {
      mid_item   = "├╴",
      last_item  = "└╴",
      nested_top = "│ ",
      whitespace = "  ",
    },
  })
end

return M
