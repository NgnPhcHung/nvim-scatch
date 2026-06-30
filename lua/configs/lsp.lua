-- ============================================================================
-- LSP, Linting, Formatting & Completion
-- ============================================================================
local diagnostic_signs = {
	Error = " ",
	Warn = " ",
	Hint = "",
	Info = "",
}

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
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
		focusable = false,
		style = "minimal",
	},
})

do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig(contents, syntax, opts, ...)
	end
end

local lsp_augroup = vim.api.nvim_create_augroup("LspConfig", { clear = true })

local function lsp_on_attach(ev)
	local opts = { buffer = ev.buf, silent = true }
	local fzf = require("fzf-lua")

	vim.keymap.set("n", "gd", function() fzf.lsp_definitions({ jump_to_single_result = true }) end, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
	vim.keymap.set("n", "gD", function() fzf.lsp_declarations({ jump_to_single_result = true }) end, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
	vim.keymap.set("n", "gi", function() fzf.lsp_implementations({ jump_to_single_result = true }) end, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
	vim.keymap.set("n", "gr", function() fzf.lsp_references() end, vim.tbl_extend("force", opts, { desc = "Go to references" }))

	vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
	vim.keymap.set("n", "E", function()
		if vim.api.nvim_win_get_config(0).relative ~= "" then
			return
		end
		for _, w in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_get_config(w).relative ~= "" then
				vim.api.nvim_set_current_win(w)
				return
			end
		end
		vim.diagnostic.open_float()
	end, vim.tbl_extend("force", opts, { desc = "Show line diagnostics" }))
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
	vim.keymap.set({ "n", "v" }, "<leader>ca", function() fzf.lsp_code_actions() end, vim.tbl_extend("force", opts, { desc = "Code action" }))
end

vim.api.nvim_create_autocmd("LspAttach", { group = lsp_augroup, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<C-Space>"] = { "show", "hide" },
		["<C-.>"] = { "show", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-l>"] = { "scroll_documentation_down", "fallback" },
		["<C-h>"] = { "scroll_documentation_up", "fallback" },
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},
	appearance = { nerd_font_variant = "mono" },
	completion = {
		menu = {
			auto_show = true,
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "source_name" },
				},
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 100,
		},
	},
	sources = {
		default = { "lsp", "path", "buffer", "snippets" },
		per_filetype = {
			typescript = { "lsp", "buffer", "snippets" },
			typescriptreact = { "lsp", "buffer", "snippets" },
			javascript = { "lsp", "buffer", "snippets" },
			javascriptreact = { "lsp", "buffer", "snippets" },
		},
	},
	snippets = {
		expand = function(snippet)
			require("luasnip").lsp_expand(snippet)
		end,
	},

	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = { download = true },
	},
})

vim.lsp.config["*"] = {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
}

vim.lsp.config("harper-ls", {
	cmd = { "harper-ls", "--stdio" },
	settings = {
		["harper-ls"] = {
			userDictPath = vim.fn.stdpath("data") .. "/harper/dict.txt",
		},
	},
	filetypes = { "markdown", "text", "gitcommit", "lua", "typescript", "javascript" },
})

vim.lsp.config("tailwindcss", {
	cmd = { "tailwindcss-language-server", "--stdio" },
	root_markers = {
		"tailwind.config.js",
		"tailwind.config.ts",
		"tailwind.config.cjs",
		"postcss.config.js",
		"package.json",
		".git",
	},
	filetypes = {
		"html",
		"css",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
	},
})

vim.lsp.config("biome", {})
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		},
	},
})
vim.lsp.config("bashls", {})

do
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")

	local prettier_d = require("efmls-configs.formatters.prettier_d")
	local eslint_d = require("efmls-configs.linters.eslint_d")

	local fixjson = require("efmls-configs.formatters.fixjson")

	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")


	-- filetypes fully covered by biome (lint + format)
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
		init_options = { documentFormatting = true },
		settings = {
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
		before_init = function(params, config)
			local root = params.rootPath
				or (
					params.workspaceFolders
					and params.workspaceFolders[1]
					and vim.uri_to_fname(params.workspaceFolders[1].uri)
				)
				or vim.fn.getcwd()
			local has_biome = vim.fn.filereadable(root .. "/biome.json") == 1
				or vim.fn.filereadable(root .. "/biome.jsonc") == 1
			if has_biome then
				for _, ft in ipairs(biome_fts) do
					config.settings.languages[ft] = nil
				end
			end
		end,
	})
end

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

vim.lsp.enable({
	"lua_ls",
	"bashls",
	"efm",
	"biome",
	"harper-ls",
	"tailwindcss",
})

