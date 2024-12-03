require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = { "ts_ls", "lua_ls", "html", "cssls", "eslint" },
})

local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')


vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
	{ "╭", "FloatBorder" },
	{ "▔", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "▕", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "▁", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "▏", "FloatBorder" },
}

local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

-- Cấu hình hover handler với viền
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = border,
	focusable = true, -- Cho phép focus cửa sổ hover
})

-- Signature Help handler (tương tự như hover)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = border,
	focusable = false,
})
local win = require('lspconfig.ui.windows')
local _default_opts = win.default_opts

win.default_opts = function(options)
	local opts = _default_opts(options)
	opts.border = 'single'
	return opts
end

mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup {
			handlers = handlers,
			capabilities = vim.lsp.protocol.make_client_capabilities(),
		}
	end,
})

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

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

lspconfig.ts_ls.setup({
	handlers = handlers,
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	on_attach = function(client, bufnr)
		local opts = { noremap = true, silent = true }
		local map = vim.api.nvim_set_keymap

		-- Keybindings for LSP actions
		-- map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, buffer = bufnr })
		-- Show hover information (documentation) for the symbol under cursor.

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

		map('n', '<leader>ah', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
		-- Show the hover information (documentation) for the symbol under cursor.

		map('n', '<leader>af', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
		-- Show available code actions (fixes, refactors) for the symbol under cursor.

		map('n', '<leader>ee', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', { noremap = true, silent = true })
		-- Show diagnostics (errors/warnings) for the current line in a popup.

		map('n', '<leader>ar', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
		-- Rename the symbol under the cursor throughout the project.

		map('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', { noremap = true, silent = true })
		-- Format the code in the current buffer using the LSP.

		map('n', '<leader>ai', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', { noremap = true, silent = true })
		-- Show all incoming calls (functions that call the symbol under the cursor).

		map('n', '<leader>ao', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', { noremap = true, silent = true })
		-- Show all outgoing calls (functions called by the symbol under the cursor).
	end
})
