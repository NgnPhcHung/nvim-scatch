local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.api.nvim_command("!git clone --depth 1 https://github.com/wbthomason/packer.nvim " .. install_path)
	vim.cmd("packadd packer.nvim")
	print("Packer đã được cài đặt. Vui lòng khởi động lại Neovim.")
end

return require("packer").startup(function(use)
	use {
		'williamboman/mason.nvim',
		config = function()
			require('mason').setup()
		end
	}

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}


	--Packer management
	use("wbthomason/packer.nvim")
	use 'williamboman/mason-lspconfig.nvim'
	use 'neovim/nvim-lspconfig'

	-- theme
	use {
		'rebelot/kanagawa.nvim', }
	use { 'morhetz/gruvbox', config = function()
		vim.cmd.colorscheme("gruvbox")
	end }
	use { 'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true },
		config = function()
			require("ui.statusline").setup()
		end,
	}
	use { 'nvim-tree/nvim-web-devicons' }

	--file actions
	use {
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
		}
	}
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons',
		}
	}

	--tab
	use {
		'romgrk/barbar.nvim',
		requires = {
			'DaikyXendo/nvim-material-icon'
		}
	}

	--git
	use {
		'lewis6991/gitsigns.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('gitsigns').setup()
		end
	}

	use {
		'folke/noice.nvim',
		requires = {
			'MunifTanjim/nui.nvim',
			'rcarriga/nvim-notify',
			'nvim-lua/plenary.nvim',
		},
		config = function()
			require('configs/noice-nvim')
		end,
	}
	use {
		"folke/flash.nvim",
		config = function()
			require('configs/folke-flash')
		end,
	}
	use { "hrsh7th/nvim-cmp" }
	use { "hrsh7th/cmp-nvim-lsp" }
	use { "hrsh7th/cmp-buffer" }
	use { "hrsh7th/cmp-path" }
	use { "saadparwaiz1/cmp_luasnip" }
	use { "L3MON4D3/LuaSnip" }
	use { 'axkirillov/hbac.nvim' }
end)
