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
