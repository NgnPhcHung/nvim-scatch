return function()
	-- 1. Tải và setup các loaders
	require("luasnip.loaders.from_vscode").lazy_load({ exclude = vim.g.vscode_snippets_exclude or {} })
	require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })

	require("luasnip.loaders.from_snipmate").load()
	require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.snipmate_snippets_path or "" })

	require("luasnip.loaders.from_lua").load()
	require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

	-- 2. Setup LuaSnip sau khi loaders đã được gọi
	local luasnip = require("luasnip")
	luasnip.setup({
		-- ... setup options ...
		history = true,
		update_events = "TextChanged,TextChangedI",
	})

	-- 3. Autocmds (sử dụng biến luasnip)
	vim.api.nvim_create_autocmd("InsertLeave", {
		-- ...
		callback = function()
			if luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] and not luasnip.session.jump_active then
				luasnip.unlink_current()
			end
		end,
	})
end
