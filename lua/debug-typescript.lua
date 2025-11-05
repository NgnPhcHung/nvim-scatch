-- Debug script for TypeScript Tools
local M = {}

function M.check_status()
	local clients = vim.lsp.get_clients({ bufnr = 0 })

	print("=== TypeScript Tools Debug Info ===")
	print("Current file: " .. vim.fn.expand("%:p"))
	print("Filetype: " .. vim.bo.filetype)
	print("\nAttached LSP clients:")

	if #clients == 0 then
		print("  No LSP clients attached!")
	else
		for _, client in ipairs(clients) do
			print("  - " .. client.name .. " (id: " .. client.id .. ")")
		end
	end

	-- Check if typescript-tools is loaded
	local ts_loaded, ts = pcall(require, "typescript-tools")
	print("\nTypeScript Tools loaded: " .. tostring(ts_loaded))

	-- Check root directory
	local bufname = vim.api.nvim_buf_get_name(0)
	local root = vim.fs.root(bufname, { "package.json", "tsconfig.json", "jsconfig.json" })
	print("Root directory: " .. (root or "NOT FOUND"))

	-- Check if package.json or tsconfig.json exists
	if root then
		local package_json = root .. "/package.json"
		local tsconfig = root .. "/tsconfig.json"
		print("\nProject files:")
		print("  package.json: " .. (vim.fn.filereadable(package_json) == 1 and "✓" or "✗"))
		print("  tsconfig.json: " .. (vim.fn.filereadable(tsconfig) == 1 and "✓" or "✗"))
	end

	print("\n=== Commands Available ===")
	local commands = vim.api.nvim_get_commands({})
	local ts_commands = {}
	for name, _ in pairs(commands) do
		if name:match("^TSTools") then
			table.insert(ts_commands, name)
		end
	end

	if #ts_commands > 0 then
		print("TypeScript Tools commands found:")
		for _, cmd in ipairs(ts_commands) do
			print("  - " .. cmd)
		end
	else
		print("No TSTools commands found! Plugin may not be loaded.")
	end
end

-- Create a command to run the diagnostic
vim.api.nvim_create_user_command("TSDebug", M.check_status, { desc = "Debug TypeScript Tools status" })

return M
