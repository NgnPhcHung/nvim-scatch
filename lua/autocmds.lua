local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- auto highlight text under cursor position
vim.api.nvim_create_autocmd("LspAttach", {

	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method("textDocument/documentHighlight") then
			local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })

			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = group,
				buffer = args.buf,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				group = group,
				buffer = args.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})

-- format on save is handled by conform's own `format_on_save` (configs/formatter.lua)

