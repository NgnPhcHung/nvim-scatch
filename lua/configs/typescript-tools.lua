local function get_capabilities()
	local status_ok, blink_cmp = pcall(require, "blink.cmp")
	if status_ok then
		return blink_cmp.get_lsp_capabilities()
	else
		local cmp_status, cmp_lsp = pcall(require, "cmp_nvim_lsp")
		if cmp_status then
			return cmp_lsp.default_capabilities()
		else
			return vim.lsp.protocol.make_client_capabilities()
		end
	end
end

-- Custom on_attach for TypeScript
local function ts_on_attach(client, bufnr)
	-- Integrate with illuminate if available
	local status_ok, illuminate = pcall(require, "illuminate")
	if status_ok then
		illuminate.on_attach(client)
	end

	-- TypeScript specific keymaps
	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

	-- Quick reload keymap for when types are regenerated externally
	vim.keymap.set("n", "<leader>tr", function()
		vim.cmd("LspRestart typescript-tools")
		vim.notify("TypeScript server restarted", vim.log.levels.INFO)
	end, { buffer = bufnr, desc = "Restart TypeScript server" })

	-- Auto-reload TypeScript server when critical files change
	local root_dir = client.config.root_dir
	if root_dir then
		local group = vim.api.nvim_create_augroup("TypeScriptReload_" .. bufnr, { clear = true })

		-- Watch for package.json changes (new dependencies)
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = group,
			pattern = root_dir .. "/package.json",
			callback = function()
				vim.notify("Reloading TypeScript server (package.json changed)", vim.log.levels.INFO)
				vim.cmd("LspRestart typescript-tools")
			end,
		})

		-- Watch for tsconfig changes
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = group,
			pattern = {
				root_dir .. "/tsconfig.json",
				root_dir .. "/tsconfig.*.json",
				root_dir .. "/*/tsconfig.json",
			},
			callback = function()
				vim.notify("Reloading TypeScript server (tsconfig changed)", vim.log.levels.INFO)
				vim.cmd("LspRestart typescript-tools")
			end,
		})

		-- Detect external file changes (like when backend regenerates types)
		-- This runs checktime periodically to detect external modifications
		local reload_timer = nil
		vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
			group = group,
			callback = function()
				vim.cmd("checktime")

				-- Debounced reload when external changes detected
				if reload_timer then
					vim.fn.timer_stop(reload_timer)
				end

				reload_timer = vim.fn.timer_start(1000, function()
					-- Check if any TypeScript files were modified externally
					local modified = vim.fn.execute("silent! checktime")
					if modified:match("changed") then
						vim.notify("External file changes detected, reloading TypeScript server...", vim.log.levels.INFO)
						vim.cmd("LspRestart typescript-tools")
					end
				end)
			end,
		})
	end
end

-- Filter out specific TypeScript diagnostics
local DIAG_FILTERS = { 80007, 80006 }

-- Create a user command to manually reload TypeScript types
vim.api.nvim_create_user_command("TSReloadTypes", function()
	vim.cmd("LspRestart typescript-tools")
	vim.notify("TypeScript server restarted - types reloaded", vim.log.levels.INFO)
end, { desc = "Reload TypeScript types by restarting TS server" })

-- Create a health check command
vim.api.nvim_create_user_command("TSHealthCheck", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local bufname = vim.api.nvim_buf_get_name(bufnr)
	local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

	vim.notify("TypeScript Health Check", vim.log.levels.INFO)
	vim.notify("- File: " .. bufname, vim.log.levels.INFO)
	vim.notify("- FileType: " .. filetype, vim.log.levels.INFO)

	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "typescript-tools" })
	if #clients > 0 then
		vim.notify("✅ typescript-tools is attached", vim.log.levels.INFO)
		for _, client in ipairs(clients) do
			vim.notify("- Root: " .. (client.config.root_dir or "none"), vim.log.levels.INFO)
		end
	else
		vim.notify("❌ typescript-tools is NOT attached", vim.log.levels.WARN)
		vim.notify("Try: :LspStart typescript-tools", vim.log.levels.WARN)
	end
end, { desc = "Check TypeScript LSP status" })

-- Auto-restart typescript-tools when it crashes
vim.api.nvim_create_autocmd("LspDetach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "typescript-tools" then
			local bufnr = args.buf
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

			-- Only auto-restart for TS/JS files
			if vim.tbl_contains({ "typescript", "typescriptreact", "javascript", "javascriptreact" }, filetype) then
				vim.notify("TypeScript server disconnected, restarting...", vim.log.levels.WARN)

				-- Try restarting multiple times with increasing delays
				local function attempt_restart(attempt)
					vim.defer_fn(function()
						if vim.api.nvim_buf_is_valid(bufnr) then
							local success = pcall(vim.cmd, "LspStart typescript-tools")
							if not success and attempt < 3 then
								vim.notify("Retry " .. attempt .. "/3: Restarting TypeScript server...", vim.log.levels.WARN)
								attempt_restart(attempt + 1)
							elseif success then
								vim.notify("✅ TypeScript server restarted successfully", vim.log.levels.INFO)
							end
						end
					end, 1000 * attempt)
				end

				attempt_restart(1)
			end
		end
	end,
})

-- Periodic health check to ensure TypeScript server stays connected
local health_check_timer = vim.loop.new_timer()
health_check_timer:start(30000, 30000, vim.schedule_wrap(function()
	-- Check all TypeScript buffers
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) then
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
			if vim.tbl_contains({ "typescript", "typescriptreact", "javascript", "javascriptreact" }, filetype) then
				local clients = vim.lsp.get_clients({ bufnr = buf, name = "typescript-tools" })
				if #clients == 0 then
					-- TypeScript server should be attached but isn't
					vim.notify("⚠️  TypeScript server not attached, restarting...", vim.log.levels.WARN)
					vim.cmd("LspStart typescript-tools")
					break
				end
			end
		end
	end
end))

return {
	-- Simplified root_dir function - more reliable
	root_dir = function(fname)
		-- First try standard TypeScript/JavaScript project markers
		local root = vim.fs.root(fname, { "package.json", "tsconfig.json", "jsconfig.json" })
		if root then
			return root
		end

		-- Fallback to .git only if node_modules exists (indicates JS/TS project)
		root = vim.fs.root(fname, { ".git" })
		if root and vim.fn.isdirectory(root .. "/node_modules") == 1 then
			return root
		end

		-- Return nil to prevent starting in non-TS/JS projects
		return nil
	end,

	-- Add memory and timeout limits to prevent crashes
	flags = {
		debounce_text_changes = 150,
		allow_incremental_sync = true,
	},

	-- Error handlers to detect crashes
	handlers = {
		["window/showMessage"] = function(err, result, ctx, config)
			-- Log errors to help debug crashes
			if result and result.type == 1 then -- Error message
				vim.notify("TypeScript Error: " .. result.message, vim.log.levels.ERROR)
			end
			return vim.lsp.handlers["window/showMessage"](err, result, ctx, config)
		end,
	},

	-- Log exit codes to diagnose disconnections
	on_exit = function(code, signal, client_id)
		if code ~= 0 then
			vim.notify(
				string.format("TypeScript server exited with code %d (signal: %d)", code, signal or 0),
				vim.log.levels.ERROR
			)
		end
	end,

	on_attach = ts_on_attach,
	capabilities = get_capabilities(),
	settings = {
		tsserver_max_memory = 8192,
		tsserver_path = nil,
		publish_diagnostic_on = "change",
		separate_diagnostic_server = true,
		tsserver_logs = "verbose",

		tsserver_file_preferences = {
			experimentalDecorators = true,
			includeInlayParameterNameHints = "all",
			includeCompletionsForModuleExports = true,
			includeCompletionsWithSnippetText = true,
			includeInlayParameterNameHintsWhenArgumentMatchesName = false,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayVariableTypeHints = true,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayEnumMemberValueHints = true,
			-- Enable faster file change detection
			disableAutomaticTypingAcquisition = false,
		},
		tsserver_format_options = {
			insertSpaceAfterCommaDelimiter = true,
			insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
			insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
		},
		expose_as_code_action = "all",
		complete_function_calls = false,
		filter_out_diagnostics_by_code = DIAG_FILTERS,
		tsserver_preferences = {
			importModuleSpecifierPreference = "relative",
			quotePreference = "double",
			importTypeSpecifier = "type",
		},
	},
}
