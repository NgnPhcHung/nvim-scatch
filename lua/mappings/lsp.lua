local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- LSP Hover
map("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded" })
end)

-- Code actions
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

-- Rename
map("n", "<leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { noremap = true, silent = true, expr = true, desc = "Incremental rename" })

-- TypeScript Tools
map("n", "<leader>ti", function()
	local clients = vim.lsp.get_clients({ bufnr = 0, name = "typescript-tools" })
	if #clients == 0 then
		vim.notify("TypeScript Tools is not running. Starting now...", vim.log.levels.WARN)
		vim.cmd("LspStart typescript-tools")
		vim.defer_fn(function()
			vim.cmd("TSToolsAddMissingImports")
		end, 1000)
	else
		vim.cmd("TSToolsAddMissingImports")
	end
end, { desc = "Add missing import in .ts .tsx file" })

map("n", "<leader>to", function()
	local clients = vim.lsp.get_clients({ bufnr = 0, name = "typescript-tools" })
	if #clients == 0 then
		vim.notify("TypeScript Tools is not running. Starting now...", vim.log.levels.WARN)
		vim.cmd("LspStart typescript-tools")
		vim.defer_fn(function()
			vim.cmd("TSToolsOrganizeImports")
		end, 1000)
	else
		vim.cmd("TSToolsOrganizeImports")
	end
end, { desc = "Organize import in .ts .tsx file" })
