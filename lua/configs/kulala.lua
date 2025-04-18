require("kulala").setup({
  colorscheme = "kanagawa",
  lsp = {
    enable = true,
    servers = { "ts_ls", "eslint" },
  },
  treesitter = {
    ensure_installed = { "lua", "javascript", "typescript" },
    highlight = { enable = true },
  },
  opts = {
    display_mode = "split",
    formatters = {
      json = { "jq", "." },
      xml = { "xmllint", "--format", "-" },
      html = { "xmllint", "--format", "--html", "-" },
    },
    icons = {
      inlay = {
        loading = "󰔟",
        done = " ",
        error = " ",
      },
      lualine = " ",
    },
  },
})
