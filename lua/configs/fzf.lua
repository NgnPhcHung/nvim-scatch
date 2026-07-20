local fzf = require("fzf-lua")

fzf.setup({
	winopts = {
		height = 0.85,
		width = 0.80,
		row = 0.35,
		col = 0.50,
		border = "rounded",
		preview = {
			border = "border",
			wrap = "nowrap",
			layout = "flex",
			flip_columns = 120,
			vertical = "down:45%",
			horizontal = "right:60%",
		},
	},
	-- ivy: bottom panel, no preview
	files = {
		fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude node_modules --exclude dist --exclude .99",
		winopts = {
			height = 0.4,
			width = 1.0,
			row = 0.8,
			col = 0.5,
			preview = { hidden = "hidden" },
		},
	},
	-- dropdown: centered, no preview
	buffers = {
		winopts = {
			height = 0.35,
			width = 0.5,
			row = 0.3,
			col = 0.5,
			preview = { hidden = "hidden" },
		},
		actions = {
			["default"] = fzf.actions.buf_switch_or_edit,
			["d"] = { fn = fzf.actions.buf_del, reload = true },
		},
	},
	grep = {
		rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -g '!node_modules' -g '!.git' -g '!dist' -e",
		winopts = {
			height = 0.5,
			width = 0.75,
			row = 0.35,
			col = 0.5,
		},
	},
	-- cursor: float relative to cursor
	lsp = {
		winopts = {
			relative = "cursor",
			height = 0.4,
			width = 0.9,
		},
	},
})

vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "FZF Files" })
-- respects .gitignore
local grep_rg_respect =
	"--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -g '!node_modules' -g '!.git' -g '!dist' -e"
-- ignores .gitignore (searches ignored files too)
local grep_rg_all =
	"--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --no-ignore --hidden -g '!node_modules' -g '!.git' -g '!dist' -e"

vim.keymap.set("n", "<leader>fg", function()
	fzf.live_grep({ rg_opts = grep_rg_respect })
end, { desc = "FZF Live Grep (respect .gitignore)" })
vim.keymap.set("n", "<leader>fw", function()
	fzf.live_grep({ rg_opts = grep_rg_all })
end, { desc = "FZF Live Grep (ignore .gitignore)" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fx", fzf.diagnostics_document, { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", fzf.diagnostics_workspace, { desc = "FZF Diagnostics Workspace" })

vim.keymap.set("n", "<S-h>", function()
	fzf.buffers({
		winopts = {
			height = 0.3,
			width = 0.45,
			row = 0.3,
			col = 0.5,
			preview = { hidden = "hidden" },
		},
	})
end, { desc = "FZF curent open Buffers Quick" })
