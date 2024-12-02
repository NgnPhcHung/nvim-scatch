require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "typescript", "html", "css", "lua", "javascript", "lua", "tsx", "json" },
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	autopairs = {
		enable = true, },
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				['af'] = '@function.outer',
				['if'] = '@function.inner',
			},
		},
	},
}