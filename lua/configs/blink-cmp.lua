require("blink.cmp").setup({
  keymap = {
    preset = 'none',
    ['<C-k>'] = { "select_prev", 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback' },
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

    ['<CR>'] = {
      'select_and_accept',
      'fallback'
    },
    ['<C-.>'] = { 'show', 'show_documentation' },

  },

  appearance = {
    nerd_font_variant = 'mono'
  },

  completion = {
    menu = {
      border       = "rounded",
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      draw         = {
        columns = {
          { "label", "label_description", gap = 1 }
        },
        treesitter = { "lsp" }
      }
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
      window = {
        border = "rounded",
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
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
    },
    keyword = { range = "full" },
    list = { selection = { preselect = false, auto_insert = true } },

  },
  signature = { enabled = true },

  sources = {
    default = function()
      local success, node = pcall(vim.treesitter.get_node)
      if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
        return { 'buffer' }
      elseif vim.bo.filetype == 'lua' then
        return { 'lsp', 'path' }
      else
        return { 'lsp', 'path', 'snippets', 'buffer' }
      end
    end,
    providers = {
      lsp = {
        name = "LSP",
        module = 'blink.cmp.sources.lsp',
        min_keyword_length = 0,
        score_offset = 1,
        transform_items = function(_, items)
          return vim.tbl_filter(function(item)
            return item.kind ~= require('blink.cmp.types').CompletionItemKind.Keyword
          end, items)
        end,
      },
      path = {
        min_keyword_length = 0,
        score_offset = 2
      },
      snippets = {
        min_keyword_length = 1,
        score_offset = 3
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
