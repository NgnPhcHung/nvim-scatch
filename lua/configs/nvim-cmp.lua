local cmp = require 'cmp'

cmp.setup({

  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),

  mapping = {
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-.>'] = cmp.mapping.complete(),
    ['<C-,>'] = function()
      vim.lsp.buf.code_action()
    end,
  },

  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s', vim_item.kind)
      return vim_item
    end,
  },

  --hover
  window = {
  },
})
