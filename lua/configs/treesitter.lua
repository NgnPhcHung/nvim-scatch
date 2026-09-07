-- nvim-treesitter `main` branch: no setup() options, features are enabled per-buffer
local parsers = {
	"vim",
	"vimdoc",
	"html",
	"css",
	"javascript",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"typescript",
	"tsx",
	"bash",
	"c",
}

-- No-op when already installed; runs async
require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("Treesitter", { clear = true }),
	pattern = {
		"vim",
		"help",
		"html",
		"css",
		"javascript",
		"javascriptreact",
		"json",
		"lua",
		"markdown",
		"python",
		"typescript",
		"typescriptreact",
		"sh",
		"bash",
		"c",
	},
	callback = function(ev)
		vim.treesitter.start(ev.buf)
		vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
