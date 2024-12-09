local cmp = require 'cmp'

cmp.setup({

	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},

	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	}, {
		{ name = 'buffer' },
		{ name = 'path' },
	}),

	mapping = {
		['<C-k>'] = cmp.mapping.select_prev_item(),
		['<C-j>'] = cmp.mapping.select_next_item(),
		['<C-<up>>'] = cmp.mapping.scroll_docs(-4),
		['<C-<down>>'] = cmp.mapping.scroll_docs(4),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm the selected completion
		['<C-.>'] = cmp.mapping.complete(),
	},

	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = string.format('%s', vim_item.kind)
			return vim_item
		end,
	},

	--hover
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
		completion = {
			border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
			winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine',
		},
		documentation = {
			border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
			winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine',
		},
	},
})
