local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

require("lazy").setup({
	-- Theme
	{
		"sainnhe/everforest",
		priority = 1000,
		config = function()
			require("configs.theme")
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		config = function()
			require("configs.treesitter")
		end,
	},

	-- UI
	{ "MunifTanjim/nui.nvim", lazy = true },

	-- File explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("configs.neo-tree")
		end,
	},

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("configs.gitsigns")
		end,
	},
	{ "nvim-lua/plenary.nvim", lazy = true },
	{
		"NeogitOrg/neogit",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("configs.neogit")
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		config = function()
			require("configs.git-conflict")
		end,
	},

	-- Mini
	{
		"echasnovski/mini.nvim",
		config = function()
			require("configs.mini")
		end,
	},

	-- Fuzzy finder
	{
		"ibhagwan/fzf-lua",
		config = function()
			require("configs.fzf")
		end,
	},

	-- LSP + Completion
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"creativenull/efmls-configs-nvim",
			"saghen/blink.cmp",
			"L3MON4D3/LuaSnip",
			"ibhagwan/fzf-lua",
		},
		config = function()
			require("configs.lsp")
		end,
	},
	{
		"mason-org/mason.nvim",
		config = function()
			require("configs.mason")
		end,
	},
	{ "creativenull/efmls-configs-nvim", lazy = true },
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = { "L3MON4D3/LuaSnip" },
	},
	{ "L3MON4D3/LuaSnip", lazy = true },

	-- TypeScript
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("configs.typescript-tools")
		end,
	},
	{
		"ThePrimeagen/99",
		config = function()
			require("configs.99")
		end,
	},

	-- Buffer management
	{
		"axkirillov/hbac.nvim",
		config = function()
			require("configs.hbac")
		end,
	},

	-- Markdown
	{ "MeanderingProgrammer/render-markdown.nvim" },

	-- Smooth scroll
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("configs.scroll")
		end,
	},

	-- Windows management
	{
		"anuvyklack/windows.nvim",
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			require("configs.animations")
		end,
	},

	-- comments
	{
		"numToStr/Comment.nvim",
		dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
})
