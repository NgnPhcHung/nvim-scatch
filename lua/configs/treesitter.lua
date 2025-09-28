require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "typescript",
    "html",
    "css",
    "lua",
    "javascript",
    "tsx",
    "json",
    "prisma",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = {
    enable = true,
  },

  fold = {
    enable = false,
  },

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

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  sync_install = false,
  auto_install = true,
  modules = {},
  ignore_install = {},
})
