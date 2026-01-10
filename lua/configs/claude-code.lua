return function()
	local status_ok, claude_code = pcall(require, "claude-code")
	if not status_ok then
		vim.notify("claude-code failed to load", vim.log.levels.ERROR)
		return
	end

	claude_code.setup({
		split = "botright",
		split_ratio = 0.35,
		enter_insert = false,
		show_line_numbers = false,
		git_root = true,
		auto_refresh = true,
		refresh_interval = 500,
		shell = "bash",
	})
end
