vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'GitGutterAdd' })
vim.api.nvim_set_hl(0, 'GitSignsAddLn', { link = 'GitGutterAdd' })
vim.api.nvim_set_hl(0, 'GitSignsAddNr', { link = 'GitGutterAdd' })

vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'GitGutterChange' })
vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { link = 'GitGutterChange' })
vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { link = 'GitGutterChange' })

vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GitGutterDelete' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteLn', { link = 'GitGutterDelete' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { link = 'GitGutterDelete' })

vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { link = 'GitGutterDelete' })
vim.api.nvim_set_hl(0, 'GitSignsTopdeleteLn', { link = 'GitGutterDelete' })
vim.api.nvim_set_hl(0, 'GitSignsTopdeleteNr', { link = 'GitGutterDelete' })

vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { link = 'GitGutterChange' })
vim.api.nvim_set_hl(0, 'GitSignsChangedeleteLn', { link = 'GitGutterChange' })
vim.api.nvim_set_hl(0, 'GitSignsChangedeleteNr', { link = 'GitGutterChange' })


require('neogit').setup {
	kind = "floating",
	disable_commit_confirmation = true,
	popup = {
		kind = 'floating',
	},
	integrations = {
		diffview = true,

	}
}

require('diffview').setup {
	enhanced_diff_hl = true, -- Highlight differences more visually
	use_icons = true,       -- Use devicons for file types
}
require('gitsigns').setup {
	current_line_blame = true, -- Hiển thị blame cho dòng hiện tại
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		-- Keymaps
		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Điều hướng giữa các hunk
		map('n', ']c', function()
			if vim.wo.diff then return ']c' end
			vim.schedule(function() gs.next_hunk() end)
			return '<Ignore>'
		end, { expr = true })

		map('n', '[c', function()
			if vim.wo.diff then return '[c' end
			vim.schedule(function() gs.prev_hunk() end)
			return '<Ignore>'
		end, { expr = true })

		-- Hành động trên các hunk
		map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
		map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
		map('n', '<leader>hp', gs.preview_hunk)
		map('n', '<leader>hb', function() gs.blame_line { full = true } end)
	end,
}
