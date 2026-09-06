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

require("lazy").setup({

	-- Theme
	{
		"sainnhe/everforest",
		priority = 1000,
		config = function()
			require("configs.theme")
		end,
	},
  {
    "wtfox/luna.nvim",
    lazy = false,
    priority= 1000,
    opts= {}
  },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("configs.treesitter")
		end,
	},

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("configs.gitsigns")
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("configs.neogit")
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = function()
			require("configs.git-conflict")
		end,
	},

	-- File explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		lazy = false, -- must load at startup for hijack_netrw_behavior
		config = function()
			require("configs.neo-tree")
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
		"saghen/blink.cmp",
		version = "1.*",
		config = function()
			require("configs.blink")
		end,
	},

	{
		"stevearc/conform.nvim",
		config = function()
			require("configs.formatter")
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

	-- Indent scope
	{
		"nvim-mini/mini.indentscope",
		version = "*",
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
	},

	-- AI region generation
	{
		"NgnPhcHung/shaerk.nvim",
		keys = {
			{ "<leader>ss", function() require("shaerk").run() end, desc = "shaerk generate" },
			{ "<leader>sa", function() require("shaerk").run({ ask = true }) end, desc = "shaerk generate (ask)" },
			{ "<leader>sx", function() require("shaerk").cancel() end, desc = "shaerk cancel" },
			{ "<leader>ss", mode = "v", function()
				vim.cmd("normal! \27")
				require("shaerk").visual()
			end, desc = "shaerk visual" },
		},
		opts = {},
	},
})
