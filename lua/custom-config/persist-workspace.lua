local icons_status, icons = pcall(require, "packages.icons")
local icon_package = icons_status and icons.kind.Package or "📦"
local icon_null = icons_status and icons.kind.Null or "🚫"
local icon_warn = "⚠️"

local function setup_workspace()
	-- HÀM GIT (Vẫn giữ nguyên)
	local function get_git_root()
		-- ... (logic get_git_root) ...
		local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
		local git_root = handle:read("*a")
		handle:close()
		if git_root and #git_root > 0 then
			return git_root:gsub("\n", "")
		end
		return nil
	end

	local function get_git_branch()
		-- ... (logic get_git_branch) ...
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
		-- Đảm bảo thư mục shada tồn tại, dùng stdpath('data')
		local ws_path = vim.fn.stdpath("data") .. "/workspaces/" .. hash .. "/"
		return ws_path .. "session.vim"
	end

	local function load_session()
		local session_file = get_session_file()
		local git_root = get_git_root()

		if vim.fn.filereadable(session_file) == 0 then
			vim.notify(icon_null .. " No session found for this project/branch")
			return
		end

		local ok, err = pcall(vim.cmd, "source " .. session_file)
		if not ok then
			vim.notify(icon_warn .. " Session Restore Error: " .. err)
		else
			if git_root then
				vim.cmd("cd " .. git_root)
				vim.notify(icon_package .. " session loaded (root restored): " .. git_root)
			else
				vim.notify(icon_package .. " session loaded (cwd unchanged)")
			end
		end
	end

	local function save_session()
		local session_file = get_session_file()
		local session_dir = vim.fn.fnamemodify(session_file, ":h")

		if vim.fn.isdirectory(session_dir) == 0 then
			vim.fn.mkdir(session_dir, "p")
		end

		-- Xóa các buffer không phải file (ví dụ: neo-tree) trước khi lưu
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local buf = vim.api.nvim_win_get_buf(win)
			local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf })

			if buftype ~= "" or buftype == "nofile" then
				-- Tự động xóa/ẩn neo-tree/NvimTree (vì chúng dùng buftype="")
				local bufname = vim.api.nvim_buf_get_name(buf)
				if bufname:match("NvimTree_") or bufname:match("neo-tree-buffer") then
					vim.cmd("bdelete " .. buf)
				end
			end
		end

		vim.cmd("mksession! " .. session_file)
		vim.notify("💾 Session saved: " .. session_file)
	end

	vim.api.nvim_create_user_command("WorkspaceLoad", load_session, {})
	vim.api.nvim_create_user_command("WorkspaceSave", save_session, {})

	-- ------------------------------------------------------------------
	-- AUTOCMDS (Sử dụng một Autogroup riêng)
	-- ------------------------------------------------------------------
	local ws_group = vim.api.nvim_create_augroup("WorkspacePersist", { clear = true })

	-- 1. Auto save on exit
	vim.api.nvim_create_autocmd("VimLeavePre", {
		group = ws_group,
		callback = save_session,
	})

	-- 2. Auto load when entering Vim (Chỉ load nếu có session tồn tại)
	vim.api.nvim_create_autocmd("VimEnter", {
		group = ws_group,
		pattern = "*", -- Kích hoạt trong mọi trường hợp
		callback = function()
			local session_file = get_session_file()
			-- Chỉ auto load nếu không mở file cụ thể và có session
			if vim.fn.argc() == 0 and vim.fn.filereadable(session_file) ~= 0 then
				load_session()
			end
		end,
	})
end

-- ------------------------------------------------------------------
-- GỌI HÀM SETUP TRONG VIMENTER (Đảm bảo môi trường Git ổn định)
-- ------------------------------------------------------------------
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("PersistWorkspaceSetup", { clear = true }),
	pattern = "*",
	callback = function()
		-- Gói toàn bộ setup vào VimEnter để đảm bảo môi trường shell sẵn sàng
		setup_workspace()
	end,
	once = true, -- Chỉ chạy một lần
})
