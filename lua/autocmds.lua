local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	pattern = {
		"*.lua",
		"*.py",
		"*.go",
		"*.js",
		"*.jsx",
		"*.ts",
		"*.tsx",
		"*.json",
		"*.css",
		"*.scss",
		"*.html",
		"*.sh",
		"*.bash",
		"*.zsh",
		"*.c",
		"*.cpp",
		"*.h",
		"*.hpp",
	},
	callback = function(args)
		if vim.bo[args.buf].buftype ~= "" then
			return
		end
		if not vim.bo[args.buf].modifiable then
			return
		end
		if vim.api.nvim_buf_get_name(args.buf) == "" then
			return
		end

		local biome_client, efm_client = nil, nil
		for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
			if c.name == "biome" then
				biome_client = c
			elseif c.name == "efm" then
				efm_client = c
			end
		end

		if biome_client then
			pcall(vim.lsp.buf.format, {
				bufnr = args.buf,
				timeout_ms = 2000,
				filter = function(c)
					return c.name == "biome"
				end,
			})
			return
		end

		if efm_client then
			pcall(vim.lsp.buf.format, {
				bufnr = args.buf,
				timeout_ms = 2000,
				filter = function(c)
					return c.name == "efm"
				end,
			})
		end
	end,
})

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
		if client and client.supports_method("textDocument/documentHighlight") then
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

-- Reopen dashboard when the last real buffer is closed
vim.api.nvim_create_autocmd("BufDelete", {
	group = augroup,
	callback = function(args)
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if buf ~= args.buf and vim.bo[buf].buflisted and vim.api.nvim_buf_get_name(buf) ~= "" then
				return
			end
		end
		vim.schedule(function()
			require("mini.starter").open()
		end)
	end,
})

--format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({
			bufnr = args.buf,
			filter = function(client)
				return client.name ~= "ts_ls" -- prevent ts_ls from handling format
			end,
		})
	end,
})

--auto ignore format makrdown filter
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_augroup,
	callback = function(ev)
		if vim.bo[ev.buf].filetype == "markdown" then
			return
		end
		local clients = vim.lsp.get_clients({ bufnr = ev.buf, name = "efm" })
		if #clients > 0 then
			vim.lsp.buf.format({ bufnr = ev.buf, name = "efm", timeout_ms = 3000 })
		end
	end,
})
