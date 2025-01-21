--
-- require("ibl").setup {
--   indent = { highlight = highlight, char = "" },
--   whitespace = {
--     highlight = highlight,
--     remove_blankline_trail = false,
--   },
--   scope = { enabled = false },
-- }

local highlight = {
  "RainbowBlue",
  "RainbowOrange",
  "RainbowRed",
  "RainbowYellow",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}
local whitespace = {
  "CursorColumn",
  "Whitespace",
}
local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup { whitespace = {
  -- highlight = whitespace,
  remove_blankline_trail = true
}, scope = { highlight = highlight } }

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
