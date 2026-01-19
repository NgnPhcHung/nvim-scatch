return {
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "MunifTanjim/nui.nvim", lazy = true },
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	------------------------------------------------------
	-- ✨ UI & Theme
	------------------------------------------------------
	{ "catppuccin.nvim", name = "catppuccin", priority = 1000, opts = {} },
	{ "rebelot/kanagawa.nvim", lazy = true },

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = require("ui.statusline"),
	},

	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = require("configs.notify"),
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = require("configs.noice"),
	},
	{
		"catgoose/nvim-colorizer.lua",
		event = "VeryLazy",
		opts = require("configs.colorizer"),
	},
	{
		"nvim-focus/focus.nvim",
		event = "WinNew",
		config = require("configs.windows"),
	},
	{ "goolord/alpha-nvim", cmd = "Alpha", config = require("configs.alpha") },

	------------------------------------------------------
	-- 💻 LSP, TS, JS/TSX
	------------------------------------------------------
	-- 1. Cấu hình Mason cơ bản (Đảm bảo nó chạy sớm)
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		lazy = false,
		priority = 200,
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		lazy = false,
		priority = 100,
	},

	{
		"neovim/nvim-lspconfig",
		lazy = false,
		priority = 50,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"prisma/vim-prisma",
			"b0o/schemastore.nvim",
		},
		config = require("configs.lsp-setup"),
	},

	{
		"pmizio/typescript-tools.nvim",
		lazy = false,
		priority = 90,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("typescript-tools").setup(require("configs.typescript-tools"))
		end,
	},

	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {
			progress = {
				display = {
					render_limit = 5,
					done_ttl = 2,
					progress_icon = { pattern = "dots", period = 1 },
				},
			},
			notification = {
				window = {
					winblend = 0,
					align = "bottom",
					relative = "editor",
				},
			},
		},
	},

	------------------------------------------------------
	-- 🔍 Completion & Snippets
	------------------------------------------------------
	{
		"saghen/blink.cmp",
		event = "BufReadPre",
		dependencies = {
			-- "hrsh7th/nvim-cmp",
			-- "hrsh7th/cmp-nvim-lsp",
			-- "saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
			{ "L3MON4D3/LuaSnip", event = "InsertEnter" },
		},
		config = require("configs.blink-cmp"),
	},
	{
		"L3MON4D3/LuaSnip",
		version = "2.*", -- Khuyến nghị dùng version cụ thể
		event = "InsertEnter",
		-- Sử dụng config để đảm bảo hàm setup chạy sau khi plugin được tải
		config = require("configs.luasnip"),
	},

	------------------------------------------------------
	-- 🛠️ Formatter & Linter (Conform & Lint)
	------------------------------------------------------
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = require("configs.conform"),
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("configs.nvim-lint")()
		end,
	},

	------------------------------------------------------
	-- 🌲 Treesitter & Syntax
	------------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/nvim-treesitter-textobjects", -- Add this for textobjects
		},
		config = function()
			require("nvim-treesitter.configs").setup(require("configs.treesitter"))
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		ft = { "tsx", "jsx", "html", "xml", "vue", "svelte" },
		opts = {
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = true,
			},
		},
	},

	{
		"numToStr/Comment.nvim",
		event = "BufReadPre",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = require("configs.comment"),
	},
	------------------------------------------------------
	-- 💾 Git & VCS
	------------------------------------------------------
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		opts = require("configs.neogit"),
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = require("configs.gitsigns"),
	},

	{ "tpope/vim-fugitive", cmd = { "Git", "G" } },
	-- { "sindrets/diffview.nvim", cmd = "DiffviewOpen", config = true, lazy = true },
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		event = "BufReadPre",
		opts = require("configs.git-conflict"),
	},

	------------------------------------------------------
	-- 📂 File, Buffer & Navigation
	------------------------------------------------------

	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "echasnovski/mini.files", optional = true },
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
		config = require("configs.telescope"),
	},

	{
		"axkirillov/hbac.nvim",
		event = "BufWinLeave",
		opts = require("configs.hbac"),
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = require("configs.flash"),
	},

	{ "mg979/vim-visual-multi", lazy = true, event = "VeryLazy" },
	{
		"smjonas/inc-rename.nvim",
		event = "LspAttach",
		config = function()
			require("inc_rename").setup({
				post_hook = function()
					vim.cmd("silent! wall")
				end,
			})
		end,
	},

	{
		"stevearc/aerial.nvim",
		event = "BufReadPost",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		cmd = "AerialToggle",
		opts = require("configs.aerial"),
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- Cần thiết cho icons
			"MunifTanjim/nui.nvim", -- Dependency cho các pop-up/UI
		},
		config = require("configs.neo-tree"),
	},

	------------------------------------------------------
	-- 💡 Utility & Quality of Life
	------------------------------------------------------
	{
		"echasnovski/mini.indentscope",
		version = "*",
		event = "BufReadPost",
		config = function()
			require("mini.indentscope").setup({
				symbol = "│",
				options = { try_as_border = true },
			})
		end,
	},

	-- {
	-- 	"ravibrock/spellwarn.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		vim.opt.spell = true
	-- 		vim.opt.spelllang = "en"
	-- 		require("spellwarn").setup({
	-- 			event = { "CursorHold", "InsertLeave", "TextChanged" },
	-- 			suggest = false,
	-- 		})
	-- 	end,
	-- },
	-- tiny-inline-diagnostic disabled (conflicts with lsp diagnostic config)
	-- { "rachartier/tiny-inline-diagnostic.nvim", event = "VeryLazy", priority = 1000 },

	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "md", "markdown" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},

	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle undo tree" },
		},
		config = function()
			vim.g.undotree_WindowLayout = 2
			vim.g.undotree_ShortIndicators = 1
			vim.g.undotree_SetFocusWhenToggle = 1
		end,
	},

	------------------------------------------------------
	-- 🤖 AI Assistant
	------------------------------------------------------
	{
		"greggh/claude-code.nvim",
		cmd = { "ClaudeCode", "ClaudeCodeContinue", "ClaudeCodeResume", "ClaudeCodeVerbose" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = require("configs.claude-code"),
	},
}
