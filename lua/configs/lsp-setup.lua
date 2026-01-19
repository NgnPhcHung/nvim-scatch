return function()
	local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")

	if not mason_lspconfig_status then
		vim.notify("mason-lspconfig failed to load", vim.log.levels.ERROR)
		return
	end

	-- ============================================
	-- 1. Shared LSP utilities
	-- ============================================
	local lsp_utils = require("utils.lsp")
	local capabilities = lsp_utils.capabilities
	local on_attach = lsp_utils.on_attach

	-- ============================================
	-- 3. Setup Mason-LSPConfig
	-- ============================================
	mason_lspconfig.setup({
		ensure_installed = {
			"lua_ls",
			"html",
			"cssls",
			"prismals",
			"dockerls",
			"jsonls",
			"tailwindcss",
		},
		automatic_installation = true,
	})

	-- ============================================
	-- 4. Disable Biome globally
	-- ============================================
	vim.lsp.config.biome = {
		enabled = false,
		autostart = false,
	}

	-- ============================================
	-- 5. Helper function to setup a server
	-- ============================================
	local function setup_server(server_name, custom_config)
		local config = vim.tbl_deep_extend("force", {
			capabilities = capabilities,
			on_attach = on_attach,
		}, custom_config or {})

		vim.lsp.config[server_name] = config
	end

	-- ============================================
	-- 6. Default Server Setup
	-- ============================================
	local default_servers = { "html", "cssls", "dockerls" }
	for _, server in ipairs(default_servers) do
		setup_server(server)
	end

	-- ==========================================
	-- 7. Custom Server Configurations
	-- ==========================================

	-- Lua Language Server
	setup_server("lua_ls", {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = {
					globals = { "vim" },
					enable = true,
					workspaceDelay = -1,
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				hint = { enable = true },
				telemetry = { enable = false },
			},
		},
	})

	-- Tailwind CSS - Only start if config exists
	setup_server("tailwindcss", {
		root_dir = vim.fs.root(0, {
			"tailwind.config.js",
			"tailwind.config.cjs",
			"tailwind.config.ts",
			"tailwind.config.mjs",
		}),
	})

	-- JSON Language Server
	local schemastore_status, schemastore = pcall(require, "schemastore")
	setup_server("jsonls", {
		settings = {
			json = {
				schemas = schemastore_status and schemastore.json.schemas() or {},
				validate = { enable = true },
			},
		},
	})

	-- Prisma Language Server - Only start if schema exists
	setup_server("prismals", {
		root_dir = vim.fs.root(0, { "schema.prisma" }),
	})

	-- ==========================================
	-- 8. ESLint Configuration (Only if config exists)
	-- ==========================================
	vim.lsp.config.eslint = {
		enabled = false,
		autostart = false,
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				callback = function()
					pcall(vim.cmd, "EslintFixAll")
				end,
			})
			on_attach(client, bufnr)
		end,
		settings = {
			format = { enable = true },
			validate = "on",
			workingDirectory = { mode = "auto" },
		},
	}

	-- Only start ESLint if config file actually exists
	vim.api.nvim_create_autocmd("FileType", {
		pattern = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
			"svelte",
		},
		callback = function(args)
			local bufnr = args.buf
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			local dirname = vim.fn.fnamemodify(bufname, ":h")

			local eslint_config = vim.fs.root(dirname, {
				".eslintrc",
				".eslintrc.js",
				".eslintrc.cjs",
				".eslintrc.json",
				".eslintrc.yml",
				".eslintrc.yaml",
				"eslint.config.js",
				"eslint.config.mjs",
				"eslint.config.cjs",
			})

			if eslint_config then
				vim.lsp.enable("eslint", bufnr)
			end
		end,
	})

	-- ============================================
	-- 9. Diagnostic Configuration
	-- ============================================
	local icon_status_ok, icon = pcall(require, "packages.icons")

	local signs = {
		Error = (icon_status_ok and icon.diagnostics and icon.diagnostics.Error) or "✘",
		Warn = (icon_status_ok and icon.diagnostics and icon.diagnostics.Warn) or "▲",
		Hint = (icon_status_ok and icon.diagnostics and icon.diagnostics.Hint) or "⚑",
		Info = (icon_status_ok and icon.diagnostics and icon.diagnostics.Info) or "»",
	}

	vim.diagnostic.config({
		virtual_text = {
			prefix = function(diagnostic)
				local severity = vim.diagnostic.severity[diagnostic.severity]
				return signs[severity] or "●"
			end,
			format = function(diagnostic)
				local message = diagnostic.message
				local max_width = 50
				if #message > max_width then
					return message:sub(1, max_width) .. "..."
				end
				return message
			end,
		},
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = signs.Error,
				[vim.diagnostic.severity.WARN] = signs.Warn,
				[vim.diagnostic.severity.HINT] = signs.Hint,
				[vim.diagnostic.severity.INFO] = signs.Info,
			},
		},
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	})
end
