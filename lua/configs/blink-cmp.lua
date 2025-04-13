require("blink-cmp").setup({
  keymap = {
    preset = 'none',
    ['<C-.>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-c>'] = { 'hide' },

    ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-j>'] = { 'select_next', 'fallback_to_mappings' },

    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<CR>'] = { 'select_and_accept', 'fallback' },
  },

  appearance = {
    nerd_font_variant = 'mono'
  },

  completion = { documentation = { auto_show = true } },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = { implementation = "lua" }
})
