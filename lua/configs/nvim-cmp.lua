-- local cmp = require 'cmp'
--
-- cmp.setup({
-- 	-- Sources for autocompletion
-- 	sources = {
-- 		{ name = 'nvim_lsp' }, -- Use LSP for autocompletion
-- 		{ name = 'buffer' }, -- Use current buffer for autocompletion
-- 		{ name = 'path' },   -- Use file paths for autocompletion
-- 		{ name = 'luasnip' }, -- Snippets source for nvim-cmp (optional)
-- 	},
--
-- 	-- Key bindings for navigation and confirmation
-- 	mapping = {
-- 		['<C-k>'] = cmp.mapping.select_prev_item(),      -- Move to previous completion item
-- 		['<C-j>'] = cmp.mapping.select_next_item(),      -- Move to next completion item
-- 		['<C-<up>>'] = cmp.mapping.scroll_docs(-4),      -- Scroll up documentation
-- 		['<C-<down>>'] = cmp.mapping.scroll_docs(4),     -- Scroll down documentation
-- 		['<C-e>'] = cmp.mapping.close(),                 -- Close completion
-- 		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm the selected completion
-- 	},
--
-- 	-- Display formatting
-- 	formatting = {
-- 		format = function(entry, vim_item)
-- 			vim_item.kind = string.format('%s', vim_item.kind) -- Show kind of completion item (e.g., function, variable)
-- 			return vim_item
-- 		end,
-- 	},
-- 	--hover
-- 	window = {
-- 		completion = {
-- 			border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }, -- Set border to custom characters
-- 			winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine', -- Highlight group for the popup
-- 		},
-- 		documentation = {
-- 			border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }, -- Set border for documentation popup
-- 			winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine',
-- 		},
-- 	},
-- })