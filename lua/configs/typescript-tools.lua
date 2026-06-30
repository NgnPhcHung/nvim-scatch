require("typescript-tools").setup({
	settings = {
		separate_diagnostic_server = true,
		publish_diagnostic_on = "insert_leave",
		tsserver_max_memory = "auto",
		complete_function_calls = false,
		include_completions_with_insert_text = true,
		code_lens = "off",
		tsserver_file_preferences = {
			importModuleSpecifierEnding = "minimal",
		},
		disable_member_code_lens = true,
		expose_as_code_action = {
			"fix_all",
			"add_missing_imports",
			"remove_unused",
			"remove_unused_imports",
			"organize_imports",
		},
	},
	on_attach = function(_, bufnr)
		local opts = { buffer = bufnr, silent = true }
		vim.keymap.set("n", "<leader>to", ":TSToolsOrganizeImports<CR>", vim.tbl_extend("force", opts, { desc = "Organize imports" }))
		vim.keymap.set("n", "<leader>ti", ":TSToolsAddMissingImports<CR>", vim.tbl_extend("force", opts, { desc = "Add missing imports" }))
		vim.keymap.set("n", "<leader>ru", ":TSToolsRemoveUnused<CR>", vim.tbl_extend("force", opts, { desc = "Remove unused" }))
		vim.keymap.set("n", "<leader>ri", ":TSToolsRemoveUnusedImports<CR>", vim.tbl_extend("force", opts, { desc = "Remove unused imports" }))
		vim.keymap.set("n", "<leader>fa", ":TSToolsFixAll<CR>", vim.tbl_extend("force", opts, { desc = "Fix all" }))
	end,
})
