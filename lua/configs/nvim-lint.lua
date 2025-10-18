return function()
	local lint = require("lint")

	lint.linters_by_ft = {
		javascript = { "biomejs" },
		typescript = { "biomejs" },
		javascriptreact = { "biomejs" },
		typescriptreact = { "biomejs" },
		json = { "biomejs" },
		lua = { "luacheck" },
	}

	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		group = vim.api.nvim_create_augroup("LintOnSave", { clear = true }), -- Tạo Autogroup
		callback = function()
			require("lint").try_lint()
		end,
		desc = "Lint file sau khi ghi",
	})
end
