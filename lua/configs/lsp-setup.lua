return function()
	vim.defer_fn(function()
		local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")

		if not mason_lspconfig_status then
			vim.notify("❌ Lỗi: `mason-lspconfig` không tải được.", vim.log.levels.ERROR)
			return
		end

		-- ============================================
		-- 1. Capabilities (blink.cmp integration)
		-- ============================================
		local capabilities_status_ok, blink_cmp = pcall(require, "blink.cmp")
		local capabilities = capabilities_status_ok and blink_cmp.get_lsp_capabilities() or {}

		-- ============================================
		-- 2. On Attach Function
		-- ============================================
		local function on_attach(client, bufnr)
			-- Integrate with illuminate if available
			local status_ok, illuminate = pcall(require, "illuminate")
			if status_ok then
				illuminate.on_attach(client)
			end
		end

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
				"eslint",
				-- NOTE: typescript-tools handles TypeScript, so no tsserver here
				-- NOTE: Biome NOT included - it conflicts with ESLint
			},
			automatic_installation = true,
		})

		-- ============================================
		-- 4. Disable Biome globally to prevent autostart
		-- ============================================
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"json",
				"jsonc",
			},
			callback = function()
				-- Prevent Biome from auto-starting
				vim.lsp.config.biome = vim.tbl_extend("force", vim.lsp.config.biome or {}, {
					enabled = false,
					autostart = false,
				})
			end,
		})

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
		setup_server("eslint", {
			autostart = true,
			-- Only start ESLint if config file exists
			root_dir = vim.fs.root(0, {
				".eslintrc",
				".eslintrc.js",
				".eslintrc.cjs",
				".eslintrc.json",
				".eslintrc.yml",
				".eslintrc.yaml",
				"eslint.config.js",
				"eslint.config.mjs",
				"eslint.config.cjs",
				"package.json", -- Fallback if eslintConfig in package.json
			}),
			on_attach = function(client, bufnr)
				-- Only setup auto-fix if ESLint actually attached
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						-- Use pcall to avoid errors if EslintFixAll not available
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
		})

		-- ============================================
		-- 9. Diagnostic Configuration
		-- ============================================
		local icon_status_ok, icon = pcall(require, "packages.icons")

		-- Define diagnostic icons with fallbacks
		local signs = {
			Error = (icon_status_ok and icon.diagnostics and icon.diagnostics.Error) or "✘",
			Warn = (icon_status_ok and icon.diagnostics and icon.diagnostics.Warn) or "▲",
			Hint = (icon_status_ok and icon.diagnostics and icon.diagnostics.Hint) or "⚑",
			Info = (icon_status_ok and icon.diagnostics and icon.diagnostics.Info) or "»",
		}

		-- Set diagnostic signs in the sign column
		for type, icon_char in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon_char, texthl = hl, numhl = hl })
		end

		vim.diagnostic.config({
			virtual_text = {
				-- Use a function to get the appropriate icon for each severity
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
			signs = true,
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

		-- ============================================
		-- 10. Explicitly Disable Biome
		-- ============================================
		-- Set Biome config with enabled = false to prevent it from starting
		vim.lsp.config.biome = {
			enabled = false,
			autostart = false,
		}

		-- ============================================
		-- 11. Debug: Show attached LSP clients
		-- ============================================
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client then
					-- vim.notify(
					-- 	string.format("✅ LSP Attached: %s", client.name),
					-- 	vim.log.levels.INFO,
					-- 	{ title = "LSP" }
					-- )
				end
			end,
		})
	end, 200)
end
