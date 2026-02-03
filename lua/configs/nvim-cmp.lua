local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function is_in_comment()
	local success, node = pcall(vim.treesitter.get_node)
	if success and node then
		return vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
	end
	return false
end

cmp.setup({
	enabled = function()
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })
		if buftype == "prompt" then
			return false
		end
		return true
	end,

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	window = {
		completion = cmp.config.window.bordered({
			border = "rounded",
			winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
		}),
		documentation = cmp.config.window.bordered({
			border = "rounded",
			winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
		}),
	},

	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-.>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping(function(fallback)
			if cmp.visible() and cmp.get_selected_entry() then
				cmp.confirm({ select = false })
			else
				fallback()
			end
		end, { "i", "s" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),

	sources = cmp.config.sources({
		{
			name = "nvim_lsp",
			priority = 1000,
			entry_filter = function(entry)
				return entry:get_kind() ~= require("cmp.types").lsp.CompletionItemKind.Keyword
			end,
		},
		{ name = "luasnip", priority = 750 },
		{ name = "99", priority = 600 },
		{ name = "path", priority = 500 },
	}, {
		{ name = "buffer", priority = 250, keyword_length = 3, max_item_count = 5 },
	}),

	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.kind,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},

	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},

	completion = {
		completeopt = "menu,menuone,noinsert",
	},

	preselect = cmp.PreselectMode.None,

	experimental = {
		ghost_text = false,
	},
})

cmp.setup.filetype("lua", {
	sources = cmp.config.sources({
		{
			name = "nvim_lsp",
			priority = 1000,
			entry_filter = function(entry)
				return entry:get_kind() ~= require("cmp.types").lsp.CompletionItemKind.Keyword
			end,
		},
		{ name = "path", priority = 500 },
	}),
})

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		if is_in_comment() then
			cmp.setup.buffer({
				sources = cmp.config.sources({
					{ name = "buffer", keyword_length = 2, max_item_count = 5 },
				}),
			})
		end
	end,
})
