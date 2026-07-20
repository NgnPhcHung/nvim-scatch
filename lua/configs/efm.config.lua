-- `do...end` creates a local scope so these variables don't pollute the outer namespace.
-- EFM (efm-langserver) is a general-purpose LSP that acts as a bridge:
-- it wraps CLI linters/formatters (eslint, prettier, luacheck, etc.) and exposes
-- them as a single LSP server that Neovim can talk to.
do
	-- Lua: linter + formatter
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")

	-- JS/TS/CSS/HTML: prettier_d is the daemon version of prettier (faster startup),
	-- eslint_d is the daemon version of eslint (same reason)
	local prettier_d = require("efmls-configs.formatters.prettier_d")
	local eslint_d = require("efmls-configs.linters.eslint_d")

	-- JSON: fixjson can repair malformed JSON that eslint can't touch
	local fixjson = require("efmls-configs.formatters.fixjson")

	-- Shell: shellcheck lints, shfmt formats
	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")

	-- Biome is an all-in-one linter+formatter for JS/TS/JSON.
	-- When biome.json is present, we don't want efm running eslint_d/prettier_d
	-- on the same files — they'd conflict. This list tracks which filetypes biome owns.
	local biome_fts = {
		"javascript",
		"javascriptreact",
		"json",
		"jsonc",
		"typescript",
		"typescriptreact",
	}

	vim.lsp.config("efm", {
		cmd = { "efm-langserver" },
		-- efm starts only when one of these config files is found in the project root
		root_markers = { "stylua.toml", ".luarc.json", "tsconfig.json", "package.json" },
		filetypes = {
			"css",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"lua",
			"sh",
			"typescript",
			"typescriptreact",
			"vue",
			"svelte",
		},
		-- tell efm it is allowed to format documents (not just lint)
		init_options = { documentFormatting = true },
		settings = {
			-- maps each filetype to the tools efm should run for it
			languages = {
				css = { prettier_d },
				html = { prettier_d },
				javascript = { eslint_d, prettier_d },
				javascriptreact = { eslint_d, prettier_d },
				json = { eslint_d, fixjson },
				jsonc = { eslint_d, fixjson },
				lua = { luacheck, stylua },
				sh = { shellcheck, shfmt },
				typescript = { eslint_d, prettier_d },
				typescriptreact = { eslint_d, prettier_d },
				vue = { eslint_d, prettier_d },
				svelte = { eslint_d, prettier_d },
			},
		},
		-- `before_init` fires once, right before the LSP handshake.
		-- We use it to detect whether this project uses Biome, and if so,
		-- strip those filetypes out of efm's language map so the two don't conflict.
		before_init = function(params, config)
			-- resolve the project root from whatever the LSP client sends us
			local root = params.rootPath
				or (params.workspaceFolders and params.workspaceFolders[1] and vim.uri_to_fname(
					params.workspaceFolders[1].uri
				))
				or vim.fn.getcwd()
			-- project uses Biome if either biome.json or biome.jsonc exists at root
			local has_biome = vim.fn.filereadable(root .. "/biome.json") == 1
				or vim.fn.filereadable(root .. "/biome.jsonc") == 1
			if has_biome then
				-- remove efm's handlers for filetypes biome already covers
				for _, ft in ipairs(biome_fts) do
					config.settings.languages[ft] = nil
				end
			end
		end,
	})
end
