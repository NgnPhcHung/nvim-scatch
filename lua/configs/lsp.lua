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
		source = true,
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

vim.o.winborder = "rounded"

local lsp_augroup = vim.api.nvim_create_augroup("LspConfig", { clear = true })

local function lsp_on_attach(ev)
	local opts = { buffer = ev.buf, silent = true }
	local fzf = require("fzf-lua")

	vim.keymap.set("n", "gd", function()
		fzf.lsp_definitions({})
	end, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
	vim.keymap.set("n", "gD", function()
		fzf.lsp_declarations({ jump_to_single_result = true })
	end, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
	vim.keymap.set("n", "gi", function()
		fzf.lsp_implementations({ jump_to_single_result = true })
	end, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
	vim.keymap.set("n", "gr", function()
		fzf.lsp_references()
	end, vim.tbl_extend("force", opts, { desc = "Go to references" }))

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
	vim.keymap.set({ "n", "v" }, "<leader>ca", function()
		fzf.lsp_code_actions()
	end, vim.tbl_extend("force", opts, { desc = "Code action" }))

	local function source_action(kind)
		return function()
			vim.lsp.buf.code_action({ context = { only = { kind }, diagnostics = {} }, apply = true })
		end
	end
	vim.keymap.set("n", "<leader>to", source_action("source.organizeImports"), vim.tbl_extend("force", opts, { desc = "Organize imports" }))
	vim.keymap.set("n", "<leader>ri", source_action("source.removeUnusedImports"), vim.tbl_extend("force", opts, { desc = "Remove unused imports" }))
	vim.keymap.set("n", "<leader>fa", source_action("source.fixAll"), vim.tbl_extend("force", opts, { desc = "Fix all" }))
end

vim.api.nvim_create_autocmd("LspAttach", { group = lsp_augroup, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

local capabilities = {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
	},
}

vim.lsp.config["*"] = {
	capabilities = require("blink.cmp").get_lsp_capabilities(capabilities),
}

vim.lsp.config("tailwindcss", {
	cmd = { "tailwindcss-language-server", "--stdio" },
	-- ponytail: gate on a real tailwind config; not calling on_dir keeps the server from starting.
	-- Without this it attaches root-less to any buffer and its ":" completion trigger fights the TS server.
	root_dir = function(bufnr, on_dir)
		local found = vim.fs.find({
			"tailwind.config.js",
			"tailwind.config.ts",
			"tailwind.config.cjs",
			"postcss.config.js",
		}, { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)) })[1]
		if found then
			on_dir(vim.fs.dirname(found))
		end
	end,
	filetypes = {
		"html",
		"css",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
})

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", "stylua.toml", ".git" },
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		},
	},
})

vim.lsp.config("bashls", {
	cmd = { "bash-language-server", "start" },
	filetypes = { "bash", "sh" },
	root_markers = { ".git" },
})

vim.lsp.config("clangd", {
	cmd = { "clangd" },
	filetypes = { "c" },
	root_markers = { ".clangd", "compile_commands.json", "compile_flags.txt", ".git" },
	capabilities = { offsetEncoding = { "utf-16" } },
	handlers = {
		["textDocument/hover"] = function(err, result, ctx, cfg)
			local contents = result and result.contents
			if type(contents) == "table" and type(contents.value) == "string" then
				contents.value = contents.value:gsub("```[%w%-]*cpp", "```c")
			end
			return vim.lsp.handlers.hover(err, result, ctx, cfg)
		end,
	},
})

-- ponytail: tls resolves the workspace's own typescript first; this only covers projects without one.
-- Follows the `tsc` on PATH so an nvm node bump doesn't break it.
local function global_ts_lib()
	local tsc = vim.fn.exepath("tsc")
	if tsc == "" then
		return nil
	end
	local real = vim.uv.fs_realpath(tsc)
	return real and vim.fs.joinpath(vim.fs.dirname(vim.fs.dirname(real)), "lib") or nil
end

vim.lsp.config("ts_ls", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
	init_options = {
		maxTsServerMemory = 4096,
		tsserver = { fallbackPath = global_ts_lib() },
	},
})

vim.lsp.config("biome", {
	cmd = { "biome", "lsp-proxy" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc", "css" },
	root_markers = { "biome.json", "biome.jsonc" },
})

vim.lsp.enable({
	"lua_ls",
	"tailwindcss",
	"bashls",
	"clangd",
	"ts_ls",
	"biome",
})

-- -- LSP progress toast (top-right) --
-- ponytail: track tokens from the event, not vim.lsp.status() — that one drains the
-- progress ring and reports `end` messages as if still active, so the toast never closes.
local progress_win, progress_buf
local pending = {}

local function render_progress()
	local msg = nil
	for _, title in pairs(pending) do
		msg = title
		break
	end

	if not msg then
		if progress_win and vim.api.nvim_win_is_valid(progress_win) then
			vim.api.nvim_win_close(progress_win, true)
		end
		progress_win = nil
		return
	end

	msg = " " .. msg:gsub("%s+", " ") .. " "
	if not (progress_buf and vim.api.nvim_buf_is_valid(progress_buf)) then
		progress_buf = vim.api.nvim_create_buf(false, true)
	end
	vim.api.nvim_buf_set_lines(progress_buf, 0, -1, false, { msg })

	local cfg = {
		relative = "editor",
		anchor = "NE",
		row = 0,
		col = vim.o.columns,
		width = vim.fn.strdisplaywidth(msg),
		height = 1,
		style = "minimal",
		border = "rounded",
		focusable = false,
		noautocmd = true,
	}
	if progress_win and vim.api.nvim_win_is_valid(progress_win) then
		vim.api.nvim_win_set_config(progress_win, cfg)
	else
		progress_win = vim.api.nvim_open_win(progress_buf, false, cfg)
	end
end

vim.api.nvim_create_autocmd("LspProgress", {
	group = lsp_augroup,
	callback = function(ev)
		local params = ev.data.params
		local value = params.value
		local key = ev.data.client_id .. ":" .. tostring(params.token)

		if type(value) ~= "table" or value.kind == "end" then
			pending[key] = nil
		else
			local title = value.title or pending[key] or ""
			pending[key] = value.message and (title .. ": " .. value.message) or title
		end
		render_progress()
	end,
})

-- a client that dies mid-progress would leave the toast up forever
vim.api.nvim_create_autocmd("LspDetach", {
	group = lsp_augroup,
	callback = function(ev)
		for key in pairs(pending) do
			if key:match("^" .. ev.data.client_id .. ":") then
				pending[key] = nil
			end
		end
		render_progress()
	end,
})
