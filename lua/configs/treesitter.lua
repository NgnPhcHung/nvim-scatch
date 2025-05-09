require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "typescript",
    "html",
    "css",
    "lua",
    "javascript",
    "lua",
    "tsx",
    "json",
    "http",
    "prisma"
  },
  highlight = {
    enable = true,
    use_languagetree = true,
    --markdown
  },
  indent = {
    enable = true,
  },
  autopairs = {
    enable = true,
  },
  fold = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
    },
  },
})
