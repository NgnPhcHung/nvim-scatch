return {
	{
		"williamboman/mason.nvim",
	},
	{
		"williamboman/mason-lspconfig.nvim",
		version = "1.26.0",
		dependencies = { "williamboman/mason.nvim" },
		config = function() end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		-- build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
	},

	{ "neovim/nvim-lspconfig" },

	-- theme
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("ui.statusline").setup()
		end,
	},

	{
		"nvim-focus/focus.nvim",
		event = "WinNew",
	},

	----------------
	-- file/buffer
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({})
		end,
	},

	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
	{ "nvim-telescope/telescope-ui-select.nvim", lazy = true },

	{
		"axkirillov/hbac.nvim",
		event = "BufEnter",
	},

	{
		"famiu/bufdelete.nvim",
		lazy = true,
		event = "VeryLazy",
	},

	-- git
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
	{
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
		config = true,
		event = "VeryLazy",
	},
	{
		"TimUntersberger/neogit",
		cmd = "Neogit",
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
		event = "VeryLazy",
	},

	-- extensions
	{ "nvim-lua/plenary.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{ "nvim-tree/nvim-web-devicons" },

	{ "folke/noice.nvim", dependencies = {
		"rcarriga/nvim-notify",
	}, config = true, event = "VeryLazy" },

	{ "folke/flash.nvim", event = "BufEnter" },
	{ "mg979/vim-visual-multi", event = "VeryLazy", lazy = true },
	{ "goolord/alpha-nvim" },

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
	},

	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},

	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
	},

	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "tsx", "jsx", "html" },
		config = function()
			require("nvim-ts-autotag").setup(require("configs.autotag-nvim"))
		end,
	},

	{ "numToStr/Comment.nvim", event = "BufReadPre" },
	{ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPre" },

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
		event = "VeryLazy",
	},

	--  outline
	{
		"stevearc/aerial.nvim",
		lazy = true,
		event = "VeryLazy",
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
	},

	-- {
	-- 	"rrethy/vim-illuminate",
	-- 	event = "BufReadPre",
	-- 	lazy = true,
	-- },

	-- { "MeanderingProgrammer/render-markdown.nvim", lazy = true, event = "VeryLazy", ft = "markdown" },
	{ "echasnovski/mini.nvim", version = "*" },
	{ "echasnovski/mini.indentscope", version = "*" },
	{ "prisma/vim-prisma", ft = "prisma", event = "VeryLazy", lazy = true },
	{ "b0o/schemastore.nvim" },

	-- {
	-- 	"epwalsh/obsidian.nvim",
	-- 	version = "*",
	-- 	ft = "markdown",
	-- 	event = "VeryLazy",
	-- },
	{
		"catgoose/nvim-colorizer.lua",
		event = "VeryLazy",
		config = function()
			require("colorizer").setup({
				filetypes = { "*" },
				user_default_options = {
					css = true,
					tailwind = "both",
					mode = "virtualtext",
					virtualtext = require("packages.icons").ui.Round,
					virtualtext_inline = "before",
					virtualtext_mode = "foreground",
				},
			})
		end,
	},
	{
		"ravibrock/spellwarn.nvim",
		event = "VeryLazy",
		config = function()
			vim.opt.spell = true
			vim.opt.spelllang = "en"
			require("spellwarn").setup({
				event = {
					"CursorHold",
					"InsertLeave",
					"TextChanged",
					"TextChangedI",
					"TextChangedP",
				},
				suggest = false,
			})
		end,
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
	},
}
