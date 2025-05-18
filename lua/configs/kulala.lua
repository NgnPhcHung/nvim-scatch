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
  contenttypes = {
    ["application/json"] = {
      ft = "json",
      formatter = vim.fn.executable("jq") == 1 and { "jq", "." },
      pathresolver = function(...)
        return require("kulala.parser.jsonpath").parse(...)
      end,
    },
    ["application/xml"] = {
      ft = "xml",
      formatter = vim.fn.executable("xmllint") == 1 and { "xmllint", "--format", "-" },
      pathresolver = vim.fn.executable("xmllint") == 1 and { "xmllint", "--xpath", "{{path}}", "-" },
    },
    ["text/html"] = {
      ft = "html",
      formatter = vim.fn.executable("xmllint") == 1 and { "xmllint", "--format", "--html", "-" },
      pathresolver = nil,
    },
  },
  ui = {
    winbar = true,
    display_mode = "float"
  },
  icons = {
    inlay = {
      loading = "󰔟",
      done = " ",
      error = " ",
    },
    lualine = " ",
  },

})
