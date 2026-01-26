local M = {}

local biome = require("utils.biome")

function M._organize_with_biome(bufnr, filepath, biome_root)
	if vim.bo[bufnr].modified then
		vim.cmd("silent! write")
	end

	local cmd = {
		"npx",
		"biome",
		"check",
		"--write",
		"--organize-imports-enabled=true",
		"--formatter-enabled=false",
		"--linter-enabled=false",
		filepath,
	}

	vim.fn.jobstart(cmd, {
		cwd = biome_root,
		on_exit = function(_, exit_code, _)
			vim.schedule(function()
				if exit_code == 0 then
					vim.cmd("checktime")
				else
					vim.notify("Biome organize imports failed (exit: " .. exit_code .. ")", vim.log.levels.ERROR)
				end
			end)
		end,
	})
end

function M._organize_with_tsserver(bufnr)
	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "typescript-tools" })
	if #clients == 0 then
		vim.notify("TypeScript Tools is not running. Starting now...", vim.log.levels.WARN)
		vim.cmd("LspStart typescript-tools")
		vim.defer_fn(function()
			vim.cmd("TSToolsOrganizeImports")
		end, 1000)
	else
		vim.cmd("TSToolsOrganizeImports")
	end
end

function M.organize_imports()
	local bufnr = vim.api.nvim_get_current_buf()
	local filepath = vim.api.nvim_buf_get_name(bufnr)

	if filepath == "" then
		vim.notify("Buffer has no file", vim.log.levels.WARN)
		return
	end

	local biome_root = biome.find_biome_root(bufnr)

	if biome_root then
		M._organize_with_biome(bufnr, filepath, biome_root)
	else
		M._organize_with_tsserver(bufnr)
	end
end

return M
