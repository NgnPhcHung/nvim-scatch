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
  use("williamboman/mason-lspconfig.nvim")
  use("neovim/nvim-lspconfig")

  -- theme
  use({
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      vim.cmd.colorscheme("catpuccin-mocha")
    end
  })

  use({
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      require("ui.statusline").setup()
    end,
  })
  use({ "nvim-tree/nvim-web-devicons" })

  --file actions
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
    },
  })

  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }

  use({
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
  })
  use({ "nvim-telescope/telescope-ui-select.nvim" })

  use({ "mbbill/undotree" })

  --buffers
  use({ "axkirillov/hbac.nvim" })

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
      "nvim-lua/plenary.nvim",
      -- "sindrets/diffview.nvim",
      "lewis6991/gitsigns.nvim",
    },
  })
  use({
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
  })
  use({
    "akinsho/git-conflict.nvim",
    tag = "*",
    config = function()
      require("git-conflict").setup()
    end,
  })

  --ui
  use({
    "folke/noice.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("configs/noice-nvim")
    end,
  })

  use({ "onsails/lspkind.nvim" })
  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("configs.nvim-cmp")
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  })
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path" })
  use({
    "L3MON4D3/LuaSnip",
    requires = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  })

  -- use({
  --   "nvimtools/none-ls.nvim",
  --   requires = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
  --   config = function()
  --     require("configs.null-ls-nvim")
  --   end,
  -- })

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
    config = function()
      require("typescript-tools").setup({})
    end,
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
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
  })

  use("famiu/bufdelete.nvim")

  use({
    "MeanderingProgrammer/render-markdown.nvim",
    after = { "nvim-treesitter" },
    requires = { "nvim-tree/nvim-web-devicons", opt = true }, -- if you prefer nvim-web-devicons
    config = function()
      require("render-markdown").setup({})
    end,
  })

  use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })

  use('mini.animate')
end)
