local status, cmp = pcall(require, "cmp")
if (not status) then return end
local lspkind = require 'lspkind'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-.>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp",   priority = 1000 },                -- LSP
    { name = "snippets",   priority = 11 },                  -- Custom snippets
    { name = "lazydev",    group_index = 0, priority = 10 }, -- Improved lua_ls
    { name = "nvim_lua",   priority = 9 },                   -- Nvim lua api
    { name = "dap",        priority = 8 },                   -- Extra debugger info
    -- { name = "buffer",     priority = 7 },                   -- Text within current buffer
    { name = "async_path", priority = 7 },                   -- Path
  }),

  preselect = cmp.PreselectMode.None,

  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s %s", lspkind.presets.default[vim_item.kind] or "", vim_item.kind)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        buffer = "[Buffer]",
      })[entry.source.name]
      return vim_item
    end,
  },
  --
  performance = {
    debounce = 1500,
    throttle = 10,
    fetching_timeout = 2000,
    confirm_resolve_timeout = 3000,
    async_budget = 5,
    max_view_entries = 2000,
  },

  window = {
    completion = {
      border = {
        { "󱐋", "WarningMsg" },
        { "─", "Comment" },
        { "╮", "Comment" },
        { "│", "Comment" },
        { "╯", "Comment" },
        { "─", "Comment" },
        { "╰", "Comment" },
        { "│", "Comment" },
      },
    },
    documentation = {
      border = {
        { "󰙎", "DiagnosticHint" },
        { "─", "Comment" },
        { "╮", "Comment" },
        { "│", "Comment" },
        { "╯", "Comment" },
        { "─", "Comment" },
        { "╰", "Comment" },
        { "│", "Comment" },
      },
    },
  },

})

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]
