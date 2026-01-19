local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local blink_status, blink = pcall(require, "blink.cmp")
if blink_status then
	M.capabilities = blink.get_lsp_capabilities(M.capabilities)
end

function M.on_attach(client, bufnr)
	local status_ok, illuminate = pcall(require, "illuminate")
	if status_ok then
		illuminate.on_attach(client)
	end
end

function M.ts_on_attach(client, bufnr)
	M.on_attach(client, bufnr)

	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

	vim.keymap.set("n", "<leader>tr", function()
		local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "typescript-tools" })
		if #clients > 0 then
			for _, c in ipairs(clients) do
				vim.lsp.stop_client(c.id, true)
			end
			vim.defer_fn(function()
				vim.cmd("edit")
			end, 300)
		end
	end, { buffer = bufnr, desc = "Restart TypeScript server" })
end

return M
