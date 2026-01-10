return function()
	require("gitsigns").setup({
		current_line_blame = false, -- Disable for performance (use <leader>hb instead)
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			-- Keymaps
			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Điều hướng giữa các hunk: Bắt buộc dùng {expr = true} để điều kiện (vim.wo.diff) hoạt động
			map("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Next Hunk" })

			map("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Prev Hunk" })

			-- Hành động trên các hunk
			map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
			map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
			map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, { desc = "Git Blame Line" })
			-- Thêm keymaps hữu ích khác
			map("n", "<leader>gd", gs.diffthis, { desc = "Diff Current File" })
			map({ "n", "v" }, "<leader>gS", ":Gitsigns stage_buffer<CR>", { desc = "Stage Buffer" })
		end,
	})
end
