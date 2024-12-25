return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  transparent = true,
  config = function(_, opts)
    require("kanagawa").setup({
      compile = false,   -- enable compiling the colorscheme
      undercurl = false, -- enable undercurls
      commentStyle = { italic = true },
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      transparent = false,
      dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      theme = "dragon",      -- Load "wave" theme when 'background' option is not set
      background = {         -- map the value of 'background' option to a theme
        dark = "dragon",     -- try "dragon" !
        light = "lotus"
      },
    })
    vim.cmd.colorscheme("kanagawa-dragon")
  end,
}
