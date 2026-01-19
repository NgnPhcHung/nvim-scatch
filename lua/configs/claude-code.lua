return function()
	local status_ok, claude_code = pcall(require, "claude-code")
	if not status_ok then
		vim.notify("claude-code failed to load", vim.log.levels.ERROR)
		return
	end

	claude_code.setup({
		window = {
			position = "vertical",
			split_ratio = 0.35,
			enter_insert = false,
			hide_numbers = true,
		},
		git = {
			use_git_root = true,
		},
		refresh = {
			enable = true,
			timer_interval = 500,
		},
		shell = {
			separator = "&&",
			pushd_cmd = "pushd",
			popd_cmd = "popd",
		},
	})
end
