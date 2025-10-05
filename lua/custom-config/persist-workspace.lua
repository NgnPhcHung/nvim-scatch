local icons = require("packages.icons")

local function setup_workspace()
	local function get_git_root()
		local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
		local git_root = handle:read("*a")
		handle:close()
		if git_root and #git_root > 0 then
			return git_root:gsub("\n", "")
		end
		return nil
	end

	local function get_git_branch()
		local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
		local branch = handle:read("*a")
		handle:close()
		if branch and #branch > 0 then
			return branch:gsub("\n", "")
		end
		return "default"
	end

	-- Always set safe session options
	vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }

	-- Build session path (project + branch)
	local function get_session_file()
		local dir = get_git_root() or vim.fn.getcwd()
		local branch = get_git_branch()
		local hash = vim.fn.sha256(dir .. branch)
		local ws_path = vim.fn.expand("~/.config/nvim/shada/workxpaces/") .. hash .. "/"
		return ws_path .. "session.vim"
	end

	local function load_session()
		local session_file = get_session_file()
		if vim.fn.filereadable(session_file) == 0 then
			vim.notify(icons.kind.Null .. " No session found for this project/branch")
			return
		end
		local ok, err = pcall(vim.cmd, "source " .. session_file)
		if not ok then
			vim.notify("⚠️ Session Restore Error: " .. err)
		else
			vim.notify(icons.kind.Package .. " session loaded: ")
		end
	end

	-- Save session automatically on exit
	local function save_session()
		local session_file = get_session_file()
		local session_dir = vim.fn.fnamemodify(session_file, ":h")

		if vim.fn.isdirectory(session_dir) == 0 then
			vim.fn.mkdir(session_dir, "p")
		end

		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local buf = vim.api.nvim_win_get_buf(win)
			local bufname = vim.api.nvim_buf_get_name(buf)
			if bufname:match("NvimTree_") then
				vim.cmd("bdelete " .. buf)
			end
		end

		vim.cmd("mksession! " .. session_file)
		-- Uncomment this if you want feedback every save:
		-- print("💾 Session saved: " .. session_file)
	end

	vim.api.nvim_create_user_command("WorkspaceLoad", load_session, {})
	vim.api.nvim_create_user_command("WorkspaceSave", save_session, {})

	-- auto save on exit
	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = save_session,
	})
end

setup_workspace()
