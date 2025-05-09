local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command("!git clone --depth 1 https://github.com/wbthomason/packer.nvim " .. install_path)
  vim.cmd("packadd packer.nvim")
  print("Packer has been installed, please restart vim to apply!")
end

return require("packer").startup(function(use)
  use({
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    requires = { "windwp/nvim-ts-autotag" },
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  --Packer management
  use("wbthomason/packer.nvim")
  use({
    "williamboman/mason-lspconfig.nvim"
  })
  use({ "neovim/nvim-lspconfig" })

  -- theme
  use({
    "catppuccin/nvim",
    as = "catppuccin",
  })
  use "rebelot/kanagawa.nvim"
  use 'sainnhe/gruvbox-material'
  use "namrabtw/rusty.nvim"
  use "rose-pine/neovim"
  use "folke/tokyonight.nvim"


  use({
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      require("ui.statusline").setup()
    end,
  })

  --file actions
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
    },
  })

  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }

  use({ "nvim-telescope/telescope-ui-select.nvim" })

  -- manage history of file
  use({ "mbbill/undotree" })

  --buffers
  use({ "axkirillov/hbac.nvim" })
  use {
    "nvim-lua/plenary.nvim"
  }

  --git
  use({
    "tpope/vim-fugitive",
  })
  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup()
    end,
  })
  use({
    "TimUntersberger/neogit",
    requires = {
    },
  })
  use({
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
  })

  use({ "MunifTanjim/nui.nvim" })

  --ui
  use 'nvim-tree/nvim-web-devicons'

  use({
    'rcarriga/nvim-notify',
    config = function()
      require("configs.notify")
    end
  })

  use({
    "folke/noice.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("configs/noice-nvim")
    end,
  })

  use({
    "saghen/blink.cmp",
    requires = { "rafamadriz/friendly-snippets", "onsails/lspkind.nvim" },
    config = function()
      require("configs.blink-cmp")
    end,
  })

  use({
    "L3MON4D3/LuaSnip",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      'hrsh7th/nvim-cmp',
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip"
    },
    config = function()
      require("configs.cmp")
    end,

  })


  use({
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup()
    end,
  })

  --terminal
  use({
    "akinsho/toggleterm.nvim",
    tag = "*",
  })

  use({
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  })
  use({ "windwp/nvim-ts-autotag" })

  use({ "folke/flash.nvim", config = function() end })

  use({
    "mg979/vim-visual-multi",
    config = function() end,
  })
  use({ "lukas-reineke/indent-blankline.nvim" })

  use({
    "numToStr/Comment.nvim",
  })
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })

  use({
    "pmizio/typescript-tools.nvim",
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  })

  use({
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup({})
    end,
  })

  use({ "karb94/neoscroll.nvim" })

  --debug
  use({
    "mfussenegger/nvim-dap",
    requires = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mxsdev/nvim-dap-vscode-js",
    },
  })

  --outline
  use({
    "stevearc/aerial.nvim",
    config = function()
      require("configs.aerial").setup()
    end,
  })

  --postman
  use({ "mistweaverco/kulala.nvim", opts = {} })

  use({
    "goolord/alpha-nvim",
  })

  use("famiu/bufdelete.nvim")

  use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })

  use({ 'nvim-pack/nvim-spectre', requires = { "ray-x/sad.nvim", "ray-x/guihua.lua" } })

  -- use {
  --   'nvim-tree/nvim-tree.lua',
  --   requires = {
  --     'nvim-tree/nvim-web-devicons',
  --   },
  -- }
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  })

  use 'RRethy/vim-illuminate'

  use({
    'MeanderingProgrammer/render-markdown.nvim',
    after = { 'nvim-treesitter' },
    requires = { 'echasnovski/mini.nvim', opt = true },
  })

  use {
    "rhysd/accelerated-jk",
    config = function()
      vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
      vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
    end
  }
  use { 'echasnovski/mini.nvim', version = '*' }
  use { 'echasnovski/mini.bracketed', version = '*' }
  use { 'echasnovski/mini.indentscope', version = '*' }

  use({ "prisma/vim-prisma", ft = "prisma" })

  use "b0o/schemastore.nvim"
end)
