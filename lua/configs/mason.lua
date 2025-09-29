require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "html", "cssls", "prismals", "dockerls", "jsonls", "tailwindcss" },
	automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- local capabilities = require("blink.cmp").get_lsp_capabilities()

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
	["tailwindcss"] = function()
		vim.lsp.config.tailwindcss = {
			capabilities = capabilities,
			on_attach = lsp_highlight_document,
			cmd = { "tailwindcss-language-server", "--stdio" },
			filetypes = {
				"html",
				"css",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"svelte",
				"astro",
			},
			workspace_required = true,
			root_dir = function(bufnr, on_dir)
				local root_files = {
					"tailwind.config.js",
					"tailwind.config.cjs",
					"tailwind.config.mjs",
					"tailwind.config.ts",
					"postcss.config.js",
					"postcss.config.cjs",
					"postcss.config.mjs",
					"postcss.config.ts",
				}
				local fname = vim.api.nvim_buf_get_name(bufnr)
				root_files = util.insert_package_json(root_files, "tailwindcss", fname)
				on_dir(vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1]))
			end,
			settings = {
				tailwindCSS = {
					validate = true,
					lint = {
						cssConflict = "warning",
						invalidApply = "error",
						invalidScreen = "error",
						invalidVariant = "error",
						invalidConfigPath = "error",
						invalidTailwindDirective = "error",
						recommendedVariantOrder = "warning",
					},
					classAttributes = {
						"class",
						"className",
						"class:list",
						"classList",
						"ngClass",
					},
					includeLanguages = {
						eelixir = "html-eex",
						eruby = "erb",
						templ = "html",
						htmlangular = "html",
					},
				},
			},
		}
	end,
})
