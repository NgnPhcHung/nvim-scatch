local sessions_dir = vim.fn.expand("~/.local/share/nvim/sessions")
if vim.fn.isdirectory(sessions_dir) == 0 then
	vim.fn.mkdir(sessions_dir, "p")
end

local M = {}

-- Session keyed by workspace (cwd), not git branch
local function session_file()
	local cwd = vim.fn.getcwd()
	local name = cwd:gsub("[/\\]", "%%")
	return sessions_dir .. "/" .. name .. ".vim"
end

vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

local augroup = vim.api.nvim_create_augroup("Session", { clear = true })

vim.api.nvim_create_autocmd("VimLeave", {
	group = augroup,
	callback = function()
		-- only save when a real file buffer exists, otherwise quitting from
		-- the dashboard overwrites the session with an empty one
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.bo[buf].buflisted and vim.api.nvim_buf_get_name(buf) ~= "" then
				vim.cmd("mksession! " .. vim.fn.fnameescape(session_file()))
				return
			end
		end
	end,
})

-- autoload session on start (only when nvim opened without file args)
vim.api.nvim_create_autocmd("VimEnter", {
	group = augroup,
	nested = true,
	callback = function()
		local sf = session_file()
		if vim.fn.argc() == 0 and vim.fn.filereadable(sf) == 1 then
			vim.cmd("silent! source " .. vim.fn.fnameescape(sf))
		end
	end,
})

function M.load()
	local sf = session_file()
	if vim.fn.filereadable(sf) == 1 then
		vim.cmd("silent! source " .. vim.fn.fnameescape(sf))
	else
		vim.notify("No saved workspace for " .. vim.fn.getcwd(), vim.log.levels.WARN)
	end
end

return M
