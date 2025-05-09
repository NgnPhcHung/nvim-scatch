require("blink.cmp").setup({
  keymap = {
    preset = 'none',
    -- ['<C-.>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-c>'] = { 'hide' },
    ['<C-.>'] = { function(cmp) cmp.show({ providers = { 'lsp' } }) end },


    ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-j>'] = { 'select_next', 'fallback_to_mappings' },

    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    -- ['<CR>'] = { 'select_and_accept', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
  },

  appearance = {
    nerd_font_variant = 'mono'
  },

  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      window = {
        border = "rounded"
      }
    },
    ghost_text = {
      enabled = false
    },
    trigger = {
      show_on_trigger_character = true,
      show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
      show_on_x_blocked_trigger_characters = {
        "'", '"', '(', '{', '['
      }
    }
  },
  signature = { enabled = true },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      lsp = {
        min_keyword_length = 0, -- Number of characters to trigger porvider
        score_offset = 4,       -- Boost/penalize the score of the items
      },
      path = {
        min_keyword_length = 0,
        score_offset = 1
      },
      snippets = {
        min_keyword_length = 1,
        score_offset = 2
      },
      buffer = {
        min_keyword_length = 0,
        max_items = 5,
      },
    },
  },
  fuzzy = { implementation = "lua" },
  snippets = { preset = 'luasnip' },

})
