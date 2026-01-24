local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local blink_status, blink = pcall(require, "blink.cmp")
if blink_status then
	M.capabilities = blink.get_lsp_capabilities(M.capabilities)
end

-- Setup custom LSP handlers
function M.setup_handlers()
	vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
		config = config or {}
		config.border = "rounded"
		config.max_width = 80
		config.max_height = 30
		config.focusable = true
		config.title = " Hover "
		return vim.lsp.handlers.hover(err, result, ctx, config)
	end
end

function M.on_attach(client, bufnr)
	-- Only set keymaps once per buffer (avoid duplicates when multiple LSP servers attach)
	if not vim.b[bufnr].lsp_keymaps_set then
		local opts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
		vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
		vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
		vim.keymap.set("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
		vim.b[bufnr].lsp_keymaps_set = true
	end

	local status_ok, illuminate = pcall(require, "illuminate")
	if status_ok then
		illuminate.on_attach(client)
	end
end

function M.ts_on_attach(client, bufnr)
	M.on_attach(client, bufnr)

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
