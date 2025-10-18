return function()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

	-- *******************************************************
	-- 1. HEADER
	local header_file = vim.fn.stdpath("config") .. "/lua/custom-config/files/my_header_banner.txt"
	dashboard.section.header.val = vim.fn.readfile(header_file)
	dashboard.section.header.opts.hl = "Question"

	-- *******************************************************
	-- 2. BUTTONS
	dashboard.section.buttons.val = {
		dashboard.button("f", " Find File", "<cmd>Telescope find_files<CR>"),
		dashboard.button("e", " New File", ":enew<CR>"),
		dashboard.button("s", "󰈛 Settings", ":e ~/.config/nvim/init.lua<CR>"),
		dashboard.button("l", "󰏣 Restore Session", ":WorkspaceLoad<CR>"),
		dashboard.button("q", "󰅚 Quit NVIM", "<cmd>qa<CR>"),
	}

	-- *******************************************************
	-- 3. FOOTER (Giữ nguyên logic Autocmd)

	local footer_autocmd_group = vim.api.nvim_create_augroup("AlphaLazyStats", { clear = true })
	vim.api.nvim_create_autocmd("User", {
		pattern = "LazyVimStarted",
		group = footer_autocmd_group,
		callback = function()
			local lazy_status, lazy = pcall(require, "lazy")
			if lazy_status then
				local stats = lazy.stats()
				dashboard.section.footer.val =
					string.format("⚡ Plugins loaded: %d/%d", stats.loaded or 0, stats.count or 0)
				pcall(vim.cmd.AlphaRedraw)
			end
		end,
	})

	-- *******************************************************
	-- 4. SETUP
	alpha.setup(dashboard.config)
end
