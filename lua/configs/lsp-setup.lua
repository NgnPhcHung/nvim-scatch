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
				"biome",
			},
			automatic_installation = true,
		})

		-- ============================================
		-- 4. Server Setup using vim.lsp.config (new API)
		-- ============================================

		-- Helper function to setup a server
		local function setup_server(server_name, custom_config)
			local config = vim.tbl_deep_extend("force", {
				capabilities = capabilities,
				on_attach = on_attach,
			}, custom_config or {})

			vim.lsp.config[server_name] = config
		end

		-- Default servers with basic config
		local default_servers = { "html", "cssls", "dockerls" }
		for _, server in ipairs(default_servers) do
			setup_server(server)
		end

		-- ==========================================
		-- Custom Server Configurations
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

		-- Tailwind CSS
		setup_server("tailwindcss", {
			root_dir = vim.fs.root(0, {
				"tailwind.config.js",
				"tailwind.config.cjs",
				"tailwind.config.ts",
				"package.json",
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

		-- Prisma Language Server
		setup_server("prismals", {
			root_dir = vim.fs.root(0, { "schema.prisma" }),
		})

		-- Biome Language Server (for linting & formatting)
		setup_server("biome", {
			on_attach = function(client, bufnr)
				-- Enable formatting from Biome
				client.server_capabilities.documentFormattingProvider = true
				client.server_capabilities.documentRangeFormattingProvider = true
				on_attach(client, bufnr)
			end,
			root_dir = vim.fs.root(0, { "biome.json", "biome.jsonc" }),
			filetypes = {
				"javascript",
				"javascriptreact",
				"json",
				"jsonc",
				"typescript",
				"typescript.tsx",
				"typescriptreact",
				"astro",
				"svelte",
				"vue",
				"css",
			},
		})

		-- ============================================
		-- 5. Diagnostic Configuration
		-- ============================================
		local icon_status_ok, icon = pcall(require, "packages.icons")
		local failure_icon = icon_status_ok and icon.task.Failure or "❌"

		vim.diagnostic.config({
			virtual_text = {
				prefix = failure_icon,
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
			update_in_insert = false,
			severity_sort = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
				linehl = {
					[vim.diagnostic.severity.ERROR] = "E",
					[vim.diagnostic.severity.WARN] = "W",
				},
			},
		})

		vim.notify("✅ LSP setup hoàn tất!", vim.log.levels.INFO)
	end, 200)
end
