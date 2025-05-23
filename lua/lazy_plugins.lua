return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("configs.mason")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "1.26.0", -- Hoặc phiên bản ổn định
    dependencies = { "williamboman/mason.nvim" },
    config = function()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "windwp/nvim-ts-autotag" },
    opts = function()
      require("configs.treesitter")
    end,
  },
  "neovim/nvim-lspconfig",

  { "catppuccin/nvim",                          name = "catppuccin" },
  "rebelot/kanagawa.nvim",
  "sainnhe/gruvbox-material",
  "namrabtw/rusty.nvim",
  "rose-pine/neovim",
  "folke/tokyonight.nvim",

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("ui.statusline").setup()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "nvim-telescope/telescope-ui-select.nvim",

  "mbbill/undotree",
  "axkirillov/hbac.nvim",
  "nvim-lua/plenary.nvim",

  "tpope/vim-fugitive",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  "TimUntersberger/neogit",
  "sindrets/diffview.nvim",

  "MunifTanjim/nui.nvim",
  "nvim-tree/nvim-web-devicons",

  {
    "rcarriga/nvim-notify",
    config = function()
      require("configs.notify")
    end,
  },

  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("configs.noice-nvim")
    end,
  },

  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
    config = function()
      require("configs.blink-cmp")
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("configs.cmp")
    end,
  },

  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup()
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  "windwp/nvim-ts-autotag",
  { "folke/flash.nvim" },
  "mg979/vim-visual-multi",
  "lukas-reineke/indent-blankline.nvim",
  "numToStr/Comment.nvim",
  "JoosepAlviste/nvim-ts-context-commentstring",

  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
  },

  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup({})
    end,
  },

  "karb94/neoscroll.nvim",

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mxsdev/nvim-dap-vscode-js",
    },
  },

  {
    "stevearc/aerial.nvim",
    config = function()
      require("configs.aerial").setup()
    end,
  },

  { "mistweaverco/kulala.nvim", opts = {} },
  "goolord/alpha-nvim",
  "famiu/bufdelete.nvim",

  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
  },

  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      "ray-x/sad.nvim",
      "ray-x/guihua.lua",
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },

  "RRethy/vim-illuminate",
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "echasnovski/mini.nvim" },
  },

  {
    "rhysd/accelerated-jk",
    config = function()
      vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)")
      vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)")
    end,
  },

  { "echasnovski/mini.nvim",        version = "*" },
  { "echasnovski/mini.bracketed",   version = "*" },
  { "echasnovski/mini.indentscope", version = "*" },

  { "prisma/vim-prisma",            ft = "prisma" },
  "b0o/schemastore.nvim",

  -- gRPCurl (for interacting with gRPC servers)
  {
    "fullstorydev/grpcurl",
    config = function()
      -- You can add configuration for grpcurl here if needed
    end
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false,   -- This plugin is already lazy
  },

  { 'airblade/vim-rooter' }
}
