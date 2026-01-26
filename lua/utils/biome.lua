local M = {}

local biome_cache = {}

function M.find_biome_root(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local bufname = vim.api.nvim_buf_get_name(bufnr)

	if bufname == "" then
		return nil
	end

	local dirname = vim.fn.fnamemodify(bufname, ":h")

	if biome_cache[dirname] ~= nil then
		if biome_cache[dirname] == false then
			return nil
		end
		return biome_cache[dirname]
	end

	local biome_root = vim.fs.root(dirname, { "biome.json", "biome.jsonc" })

	if biome_root then
		biome_cache[dirname] = biome_root
	else
		biome_cache[dirname] = false
	end

	return biome_root
end

function M.has_biome(bufnr)
	return M.find_biome_root(bufnr) ~= nil
end

function M.clear_cache()
	biome_cache = {}
end

return M
