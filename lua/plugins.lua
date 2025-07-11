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
    dependencies = { "windwp/nvim-ts-autotag" },
    config = function()
      require("configs.treesitter")
    end,
  },
  "neovim/nvim-lspconfig",

  "folke/tokyonight.nvim",

  {
    "nvim-lualine/lualine.nvim",
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

  { "mistweaverco/kulala.nvim",     opts = {} },
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
      "MunifTanjim/nui.nvim",
    },
  },

  "RRethy/vim-illuminate",
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "echasnovski/mini.nvim" },
  },

  { "echasnovski/mini.nvim",        version = "*" },
  { "echasnovski/mini.bracketed",   version = "*" },
  { "echasnovski/mini.indentscope", version = "*" },


  { "prisma/vim-prisma",            ft = "prisma" },

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
    -- cond = function()
    --   local cwd = vim.fn.getcwd()
    --   local obsidian_vault_path
    --   local is_windows = vim.fn.has("win32") == 1
    --   local is_mac = vim.fn.has("mac") == 1
    --   local is_linux = vim.fn.has("unix") == 1 and vim.fn.has("mac") == 0
    --
    --   if is_windows then
    --     vim.notify("Not support this os")
    --     return
    --   elseif is_linux then
    --     obsidian_vault_path = "/home/phuchung/obsidian"
    --   elseif is_mac then
    --     obsidian_vault_path =
    --     "/Users/nguyenphuchung/library/Mobile Documents/iCloud~md~obsidian/Documents/PhucHungVaults"
    --   end
    --   return cwd:find(obsidian_vault_path, 1, true) ~= nil
    -- end,
  }
}
