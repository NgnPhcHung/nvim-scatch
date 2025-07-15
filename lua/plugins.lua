return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("configs.mason")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "1.26.0",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "windwp/nvim-ts-autotag" },
    config = function()
      require("configs.treesitter")
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
  }
  ,


  { "neovim/nvim-lspconfig" },

  { "folke/tokyonight.nvim" },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("ui.statusline").setup()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
    end
  },

  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },

  { "nvim-telescope/telescope-ui-select.nvim",  lazy = true },


  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },


  { "axkirillov/hbac.nvim" },
  { "nvim-lua/plenary.nvim" },

  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup()
    end,
  },
  { "sindrets/diffview.nvim", cmd = "DiffviewOpen" },
  { "TimUntersberger/neogit", cmd = "Neogit" },


  "MunifTanjim/nui.nvim",
  "nvim-tree/nvim-web-devicons",

  {
    "rcarriga/nvim-notify",
    lazy = true,
  },

  {
    "folke/noice.nvim",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
      {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
      },
      {
        "saadparwaiz1/cmp_luasnip",
        lazy = true,
      },
      {
        "hrsh7th/cmp-nvim-lsp",
        lazy = true,
      },
    },
    config = function()
      require("configs.blink-cmp")
    end,
  },

  -- {
  --   dependencies = {
  --     "hrsh7th/nvim-cmp",
  --     "onsails/lspkind.nvim",
  --   },
  --   config = function()
  --     require("configs.cmp")
  --   end,
  -- },

  {
    "stevearc/conform.nvim",
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
  },

  -- {
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   config = function()
  --     require("nvim-autopairs").setup({ map_cr = false })
  --   end,
  -- },

  -- "windwp/nvim-ts-autotag",

  { "folke/flash.nvim" },

  "mg979/vim-visual-multi",

  -- "lukas-reineke/indent-blankline.nvim",

  -- {
  --   "numToStr/Comment.nvim",
  --   event = "VeryLazy",
  -- },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufReadPre",
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("configs.typescript-tools")
    end

  },

  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup({})
    end,
  },

  {
    "stevearc/aerial.nvim",
    config = function()
      require("configs.aerial").setup()
    end,
  },

  { "mistweaverco/kulala.nvim", opts = {}, lazy = true },

  { "goolord/alpha-nvim" },

  { "famiu/bufdelete.nvim" },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
  },

  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
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
      "MunifTanjim/nui.nvim",
    },
  },

  { "rrethy/vim-illuminate" },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "echasnovski/mini.nvim" },
  },

  { "echasnovski/mini.nvim",        version = "*" },

  { "echasnovski/mini.bracketed",   version = "*" },

  { "echasnovski/mini.indentscope", version = "*" },

  { "prisma/vim-prisma",            ft = "prisma", lazy = true },

  { "b0o/schemastore.nvim" },

  {
    'mrcjkb/rustaceanvim',
    version = '^6',
  },

  {
    "sphamba/smear-cursor.nvim",
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  }
}
