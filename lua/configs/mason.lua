require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "html", "cssls", "prismals", "dockerls", "jsonls", "tailwindcss" },
	automatic_installation = true,
})

-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
local capabilities = require("blink.cmp").get_lsp_capabilities()

local function lsp_highlight_document(client)
	local status_ok, illuminate = pcall(require, "illuminate")
	if status_ok then
		illuminate.on_attach(client)
	end
end

require("mason-lspconfig").setup_handlers({
	function(server_name)
		vim.lsp.config[server_name] = {
			capabilities = capabilities,
			on_attach = lsp_highlight_document,
		}
	end,
})

vim.lsp.config.lua_ls = {
	capabilities = capabilities,
	on_attach = lsp_highlight_document,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = {
				globals = { "vim" },
				enable = false, -- disable diagnostics completely
				-- OR if you want some but not workspace ones:
				workspaceDelay = -1, -- don’t trigger workspace diagnostics
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = true,
			},
			hint = { enable = true },
		},
	},
}

vim.lsp.config.tailwindcss = {
	capabilities = capabilities,
	on_attach = lsp_highlight_document,
}

vim.lsp.config.jsonls = {
	capabilities = capabilities,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
}

vim.lsp.config.prismals = {
	capabilities = capabilities,
	on_attach = lsp_highlight_document,
}

vim.lsp.enable({ "lua_ls", "jsonls", "tailwindcss", "html", "cssls", "dockerls", "prismals" })
