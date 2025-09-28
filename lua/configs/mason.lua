require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "html", "cssls", "prismals", "dockerls", "jsonls" },
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
		}
	end,

	["prismals"] = function()
		vim.lsp.config.prismals = {
			capabilities = capabilities,
			on_attach = lsp_highlight_document,
		}
	end,

	["jsonls"] = function()
		vim.lsp.config.jsonls = {
			capabilities = capabilities,
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		}
	end,

	["lua_ls"] = function()
		vim.lsp.config.lua_ls = {
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					hint = {
						enable = true,
					},
				},
			},
		}
	end,
})

require("mason-lspconfig").setup_handlers({})
