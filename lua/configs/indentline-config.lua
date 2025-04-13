-- local highlight = {
--   "RainbowBlue",
--   "RainbowOrange",
--   "RainbowRed",
--   "RainbowYellow",
--   "RainbowGreen",
--   "RainbowViolet",
--   "RainbowCyan",
-- }
--
-- local hooks = require "ibl.hooks"
-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
--   vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
--   vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
--   vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
--   vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
--   vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
--   vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
--   vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
-- end)
--
-- vim.g.rainbow_delimiters = { highlight = highlight }
-- require("ibl").setup { whitespace = {
--   -- highlight = whitespace,
--   remove_blankline_trail = true
-- }, scope = { highlight = highlight } }
--
-- hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)


require('mini.indentscope').setup({
  version = false, -- wait till new 0.7.0 release to put it back on semver
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- symbol = "▏",
    symbol = "┃",
    options = { try_as_border = true },
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
        "vifm",
      },
      callback = function()
        -- vim.b.miniindentscope_disable = true
      end,
      draw = {
        -- Delay (in ms) between event and start of drawing scope indicator
        delay = 150,

        -- Animation rule for scope's first drawing. A function which, given
        -- next and total step numbers, returns wait time (in ms). See
        -- |MiniIndentscope.gen_animation| for builtin options. To disable
        -- animation, use `require('mini.indentscope').gen_animation.none()`.
        -- animation = MiniIndentscope.gen_animation.none(),
        -- animation = function(s, n) return 0 end,

        -- Symbol priority. Increase to display on top of more symbols.
        priority = 2,
      },
    })
  end,
})
