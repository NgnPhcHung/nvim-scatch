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
		-- config = function()
		-- 	require("configs.treesitter")
		-- end,
	},

	{ "neovim/nvim-lspconfig" },

	-- theme
	{ "folke/tokyonight.nvim" },
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("ui.statusline").setup()
		end,
	},

	-- { "goolord/alpha-nvim", config = function ()
	-- require("require-configs.alpha")
	-- end },

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
		configs = function()
			require("configs.bhac")
		end,
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
	{ "folke/noice.nvim" },
	{ "folke/flash.nvim", event = "BufEnter" },
	{ "mg979/vim-visual-multi", event = "VeryLazy", lazy = true },

	----------
	-- cmp / lint / lsp
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	dependencies = {
	-- 		"neovim/nvim-lspconfig",
	-- 		"hrsh7th/cmp-buffer",
	-- 		"hrsh7th/cmp-path",
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		"hrsh7th/cmp-nvim-lua",
	-- 		"hrsh7th/cmp-cmdline",
	-- 		"saadparwaiz1/cmp_luasnip",
	-- 		"L3MON4D3/LuaSnip",
	-- 		"rafamadriz/friendly-snippets",
	-- 		"hrsh7th/cmp-vsnip",
	-- 		"hrsh7th/vim-vsnip",
	-- 	},
	-- 	config = function()
	-- 		require("configs.cmp")
	-- 	end,
	-- },

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
		config = function()
			-- require("configs.nvim-lint")
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		ft = { "tsx", "jsx", "html" },
		config = function()
			require("configs.autotag-nvim")
		end,
	},

	{ "numToStr/Comment.nvim", event = "BufReadPre" },
	{ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPre" },

	-- codings
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

	{
		"stevearc/aerial.nvim",
		config = function()
			require("configs.aerial").setup()
		end,
	},

	{
		"famiu/bufdelete.nvim",
		lazy = true,
		event = "VeryLazy",
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
	},

	{
		"rrethy/vim-illuminate",
		event = "BufReadPre",
		lazy = true,
	},

	{ "MeanderingProgrammer/render-markdown.nvim" },
	{ "echasnovski/mini.nvim", version = "*" },
	{ "echasnovski/mini.indentscope", version = "*" },
	{ "prisma/vim-prisma", ft = "prisma", event = "VeryLazy", lazy = true },
	{ "b0o/schemastore.nvim" },

	{
		"epwalsh/obsidian.nvim",
		version = "*",
		ft = "markdown",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
