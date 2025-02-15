local status, cmp = pcall(require, "cmp")
if not status then
  return
end
local lspkind = require("lspkind")

cmp.setup({
  completion = {
    autocomplte = { require("cmp.types").cmp.TriggerEvent.TextChanged },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-.>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  }),

  sources = cmp.config.sources({
    {
      name = "nvim_lsp",
      entry_filter = function(entry, ctx)
        return entry:get_kind() ~= cmp.lsp.CompletionItemKind.Text
      end,
    },
    { name = "dap" },
    { name = "luasnip" },
    { name = "path" },
  }),

  preselect = cmp.PreselectMode.None,

  formatting = {
    format = function(entry, vim_item)
      if entry.source.name == "nvim_lsp" and vim_item.kind == "Module" then
        vim_item.abbr = 'require("' .. vim_item.abbr .. '")'
      end

      vim_item.kind = string.format("%s %s", lspkind.presets.default[vim_item.kind] or "", vim_item.kind)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]

      return vim_item
    end,

    performance = {
      debounce = 6,
      throttle = 10,
      fetching_timeout = 200,
      confirm_resolve_timeout = 60,
      async_budget = 1,
      max_view_entries = 200,
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
  },
})

vim.keymap.set("n", "E", function()
  vim.diagnostic.open_float(nil, {
    scope = "cursor",
    border = {
      { "╭", "FloatBorder" }, -- Góc trên trái
      { "─", "FloatBorder" }, -- Đường ngang trên
      { "╮", "FloatBorder" }, -- Góc trên phải
      { "│", "FloatBorder" }, -- Đường dọc bên phải
      { "╯", "FloatBorder" }, -- Góc dưới phải
      { "─", "FloatBorder" }, -- Đường ngang dưới
      { "╰", "FloatBorder" }, -- Góc dưới trái
      { "│", "FloatBorder" }, -- Đường dọc bên trái
    },
  })
end, { noremap = true, silent = true })

vim.cmd([[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]])
