local groups = {
	"Normal",
	"NormalNC",
	"NormalFloat",
	"FloatBorder",
	"EndOfBuffer",
	"Pmenu",
	"PmenuSbar",
	"PmenuThumb",
	"StatusLine",
	"StatusLineNC",
	"TabLine",
	"TabLineFill",
	"WinSeparator",
	"LineNr",
	"CursorLineNr",
	"SignColumn",
}

local function apply()
	for _, name in ipairs(groups) do
		local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
		if ok then
			hl.bg = nil
			hl.ctermbg = nil
			vim.api.nvim_set_hl(0, name, hl)
		end
	end
end

apply()

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("Transparent", { clear = true }),
	callback = apply,
})
