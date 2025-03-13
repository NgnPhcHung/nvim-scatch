vim.g.catppuccin_flavour = 'macchiato' -- latte, frappe, macchiato, mocha

local catppuccin = require('catppuccin')
local cp = require('catppuccin.palettes').get_palette()

catppuccin.setup({
  dim_inactive = {
    enabled = false,
    shade = 'dark',
    percentage = 0.15,
  },
  transparent_background = true,
  term_colors = false,
  compile = {
    enabled = false,
  },
  styles = {
    comments = { 'italic' },
    conditionals = { 'italic' },
    loops = {},
    functions = {},
    keywords = { 'italic' },
    strings = {},
    variables = { 'italic' },
    numbers = {},
    booleans = { 'italic' },
    properties = { 'italic' },
    types = {},
    operators = {},
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { 'italic' },
        hints = { 'italic' },
        warnings = { 'italic' },
        information = { 'italic' },
      },
      underlines = {
        errors = { 'underline' },
        hints = { 'underline' },
        warnings = { 'underline' },
        information = { 'underline' },
      },
    },
    lsp_trouble = true,
    cmp = true,
    lsp_saga = false,
    gitgutter = false,
    gitsigns = true,
    telescope = true,
    nvimtree = {
      enabled = false,
      show_root = true,
      transparent_panel = false,
    },
    dap = {
      enabled = true,
      enable_ui = true,
    },
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    dashboard = true,
    neogit = true,
    vim_sneak = false,
    barbar = false,
    bufferline = {
      enable = false,
      italics = true,
      bolds = true,
    },
    markdown = true,
    ts_rainbow = true,
    hop = true,
    notify = false,
    telekasten = false,
    symbols_outline = true,
    aerial = false,
    beacon = true,
    navic = true,
  },
  custom_highlights = {
    TelescopeBorder = { fg = cp.blue },
    TelescopeSelectionCaret = { fg = cp.flamingo },
    TelescopeSelection = { fg = cp.text, bg = cp.surface0, style = { 'bold' } },
    TelescopeMatching = { fg = cp.blue },
    TelescopePromptPrefix = { bg = cp.crust },
    TelescopePromptNormal = { bg = cp.crust },
    TelescopeResultsNormal = { bg = cp.mantle },
    TelescopePreviewNormal = { bg = cp.crust },
    TelescopePromptBorder = { bg = cp.crust, fg = cp.crust },
    TelescopeResultsBorder = { bg = cp.mantle, fg = cp.mantle },
    TelescopePreviewBorder = { bg = cp.crust, fg = cp.crust },
    TelescopePromptTitle = { fg = cp.mauve },
    TelescopeResultsTitle = { fg = cp.mauve },
    TelescopePreviewTitle = { fg = cp.mauve },
    Beacon = { bg = cp.teal },
    BufferLineIndicatorSelected = { fg = cp.pink },
    BufferLineModifiedSelected = { fg = cp.teal },
    BufferLineVisible = { fg = cp.pink, bg = cp.mantle },
    BufferLineIndicatorVisible = { bg = cp.mante },
    BufferLineBackcrust = { fg = cp.surface1, bg = cp.mantle },
  },
  highlight_overrides = {},
})

vim.cmd([[colorscheme catppuccin]])


--- KANAGAWA
-- local kanagawa = require("kanagawa")
-- vim.g.kanagawa_style = "dragon"
-- kanagawa.setup({
--   undercurl = true,
--   commentStyle = { italic = true },
--   functionStyle = {},
--   keywordStyle = { italic = true },
--   statementStyle = {
--     bold = true
--   },
--   typeStyle = {},
--   transparent = true,
--   terminalColors = true,
--   dimInactive = {
--     enabled = false,
--     shade = "dark",
--     percentage = 0.85,
--   },
--   compile = {
--     enabled = false,
--   },
--   overrides = function(colors)
--     return {
--       TelescopeBorder = { fg = colors.fujiWhite, bg = "none" },
--       TelescopeSelectionCaret = { fg = colors.peachRed, bg = "none" },
--       TelescopeSelection = { fg = colors.sumiInk0, bg = colors.samuraiWhite, style = { "bold" } },
--       TelescopeMatching = { fg = colors.springGreen },
--       TelescopePromptPrefix = { fg = colors.dragonBlue, bg = "none" },
--       TelescopePromptNormal = { fg = colors.samuraiWhite, bg = "none" },
--       TelescopeResultsNormal = { fg = colors.samuraiWhite, bg = "none" },
--       TelescopePreviewNormal = { fg = colors.samuraiWhite, bg = "none" },
--
--     }
--   end,
-- })
--
-- vim.cmd("colorscheme kanagawa-dragon")
-- vim.cmd("highlight Normal guibg=none")
--
-- vim.cmd("highlight BufferLineSeparator guifg=none guibg=none")
-- vim.cmd([[
--   highlight BufferLineIndicatorSelected guibg=none
--   highlight BufferLineModifiedSelected  guibg=none
--   highlight BufferLineVisible           guibg=none
--   highlight BufferLineIndicatorVisible  guibg=none
--   highlight BufferLineSeparator         guibg=none guifg=none
--   highlight BufferLineBackcrust         guibg=none
-- ]])


-- Thiết lập gruvsquirrel
-- require('gruvsquirrel').setup({
--   transparent_background = true,
--   term_colors = false,
--   styles = {
--     comments = { 'italic' },
--     conditionals = { 'italic' },
--     keywords = { 'italic' },
--     variables = { 'italic' },
--     booleans = { 'italic' },
--     properties = { 'italic' },
--   },
--   integrations = {
--     treesitter = true,
--     native_lsp = {
--       enabled = true,
--       virtual_text = {
--         errors = { 'italic' },
--         hints = { 'italic' },
--         warnings = { 'italic' },
--         information = { 'italic' },
--       },
--       underlines = {
--         errors = { 'underline' },
--         hints = { 'underline' },
--         warnings = { 'underline' },
--         information = { 'underline' },
--       },
--     },
--     lsp_trouble = true,
--     cmp = true,
--     gitsigns = true,
--     telescope = true,
--     dap = {
--       enabled = true,
--       enable_ui = true,
--     },
--     indent_blankline = {
--       enabled = true,
--       colored_indent_levels = true,
--     },
--     dashboard = true,
--     neogit = true,
--     markdown = true,
--     ts_rainbow = true,
--     hop = true,
--     symbols_outline = true,
--     beacon = true,
--     navic = true,
--   },
--   custom_highlights = function(colors)
--     return {
--       TelescopeBorder = { fg = colors.blue },
--       TelescopeSelectionCaret = { fg = colors.flamingo },
--       TelescopeSelection = { fg = colors.text, bg = colors.surface0, style = { 'bold' } },
--       TelescopeMatching = { fg = colors.blue },
--       TelescopePromptPrefix = { bg = colors.crust },
--       TelescopePromptNormal = { bg = colors.crust },
--       TelescopeResultsNormal = { bg = colors.mantle },
--       TelescopePreviewNormal = { bg = colors.crust },
--       TelescopePromptBorder = { bg = colors.crust, fg = colors.crust },
--       TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
--       TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
--       TelescopePromptTitle = { fg = colors.mauve },
--       TelescopeResultsTitle = { fg = colors.mauve },
--       TelescopePreviewTitle = { fg = colors.mauve },
--       Beacon = { bg = colors.teal },
--       BufferLineIndicatorSelected = { fg = colors.pink },
--       BufferLineModifiedSelected = { fg = colors.teal },
--       BufferLineVisible = { fg = colors.pink, bg = colors.mantle },
--       BufferLineIndicatorVisible = { bg = colors.mantle },
--       BufferLineBackcrust = { fg = colors.surface1, bg = colors.mantle },
--     }
--   end,
-- })
--
-- vim.cmd([[colorscheme boxsquirrel]])
