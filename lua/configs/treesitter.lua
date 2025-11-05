return {
	-- Ensure these parsers are installed
	ensure_installed = {
		"typescript",
		"tsx",
		"javascript",
		"html",
		"css",
		"lua",
		"json",
		"jsonc",
		"prisma",
		"markdown",
		"markdown_inline",
		"mermaid",
		"bash",
		"vim",
		"vimdoc",
		"query",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	auto_install = true,

	-- List of parsers to ignore installing (or "all")
	ignore_install = {},

	-- Highlight configuration
	highlight = {
		enable = true,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,

		-- Disable highlighting for large files
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
	},

	-- Indentation based on treesitter
	indent = {
		enable = true,
		-- Disable for some languages that have issues
		disable = { "python", "yaml" },
	},

	-- Incremental selection based on named nodes
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},

	-- Textobjects module (requires nvim-treesitter-textobjects)
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj
			keymaps = {
				-- Function/Method blocks
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				-- Class blocks
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				-- Arguments/Parameters
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				-- Conditionals
				["ai"] = "@conditional.outer",
				["ii"] = "@conditional.inner",
				-- Loops
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},

	-- Required by nvim-treesitter
	modules = {},
}
