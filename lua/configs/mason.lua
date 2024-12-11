require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = { "ts_ls", "lua_ls", "html", "cssls", "eslint", "clangd" },
})

local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup {
			capabilities = vim.lsp.protocol.make_client_capabilities(),
		}
	end,
})

local buffer_autoformat = function(bufnr)
	local group = 'lsp_autoformat'
	vim.api.nvim_create_augroup(group, { clear = false })
	vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

	vim.api.nvim_create_autocmd('BufWritePre', {
		buffer = bufnr,
		group = group,
		desc = 'LSP format on save',
		callback = function()
			vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
		end,
	})
end

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(event)
		local id = vim.tbl_get(event, 'data', 'client_id')
		local client = id and vim.lsp.get_client_by_id(id)
		if client == nil then
			return
		end

		if client.supports_method('textDocument/formatting') then
			buffer_autoformat(event.buf)
		end
	end
})

lspconfig.clangd.setup({
	on_attach = function(client, bufnr)
		local opts = { noremap = true, silent = true, buffer = bufnr }
	end,
	init_options = {
		clangdFileStatus = true,
	},
})

lspconfig.ts_ls.setup({
	on_attach = function(client, bufnr)
		local opts = { noremap = true, silent = true }
		local map = vim.api.nvim_set_keymap


		map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
		-- Show all references to the symbol under cursor in the project.

		map('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
		-- Show signature help (function/method signature) for the symbol under cursor.

		map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
		-- Go to the implementation of the symbol under cursor.

		map('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true })
		-- Go to the type definition of the symbol under cursor.

		map('n', '<leader>gw', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', { noremap = true, silent = true })
		-- Show the document symbols (functions, classes, variables) in the current file.

		map('n', '<leader>gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', { noremap = true, silent = true })
		-- Show the workspace symbols (search symbols across the entire project).

		map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
		-- Show available code actions (fixes, refactors) for the symbol under cursor.

		map('n', '<leader>ar', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
		-- Rename the symbol under the cursor throughout the project.
		map('n', '<leader>=', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', { noremap = true, silent = true })
	end
})
