local M = {}

local cached_root = nil
local cached_buf = nil

function M.get_project_root()
	local current_buf = vim.api.nvim_get_current_buf()
	if cached_root and cached_buf == current_buf then
		return cached_root
	end

	local buf_path = vim.fn.expand("%:p")
	local cwd = vim.fn.getcwd()

	local git_root = vim.fs.root(buf_path, ".git")
	if not git_root then
		cached_root = cwd
		cached_buf = current_buf
		return cwd
	end

	local subprojects = { "apps", "packages", "services" }

	for _, dir in ipairs(subprojects) do
		local match = buf_path:match(git_root .. "/" .. dir .. "/([^/]+)/")
		if match then
			local possible_root = git_root .. "/" .. dir .. "/" .. match
			if vim.fn.isdirectory(possible_root .. "/src") == 1 or vim.fn.isdirectory(possible_root .. "/app") == 1 then
				cached_root = possible_root
				cached_buf = current_buf
				return possible_root
			end
		end
	end

	cached_root = git_root
	cached_buf = current_buf
	return git_root
end

function M.truncate_path(path)
	local max_path_length = math.floor(vim.o.columns * 0.5)

	if #path > max_path_length then
		return "…" .. path:sub(-math.floor(max_path_length * 2 / 5))
	end
	return path
end

function M.create_custom_entry_maker()
	local entry_display = require("telescope.pickers.entry_display")

	local function custom_display(entry)
		local displayer = entry_display.create({
			separator = " ",
			items = {
				{ width = 30 },
				{ remaining = true },
			},
		})
		return displayer({
			{ entry.filename, "TelescopeResultsFileName" },
			{ entry.filelink, "TelescopeResultsFileLink" },
		})
	end

	return function(entry)
		local full_path = type(entry) == "table" and entry.filename or entry
		local just_file = vim.fn.fnamemodify(full_path, ":t")
		return {
			value = entry,
			display = custom_display,
			ordinal = full_path,
			filename = just_file,
			filelink = full_path,
			path = full_path,
		}
	end
end

function M.create_buffer_entry_maker()
	local entry_display = require("telescope.pickers.entry_display")

	return function(entry)
		local bufnr = entry.bufnr
		local bufname = vim.api.nvim_buf_get_name(bufnr)
		local short_name = bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or "[No Name]"

		local project_root = M.get_project_root()

		local relative_path = bufname ~= "" and vim.fn.fnamemodify(bufname, ":.") or "[No Path]"
		if vim.startswith(relative_path, project_root) then
			relative_path = relative_path:sub(#project_root + 2)
		end

		local displayer = entry_display.create({
			separator = " ",
			items = {
				{ width = 4 },
				{ width = 20 },
				{ remaining = true },
			},
		})

		local current_buf = vim.api.nvim_get_current_buf()
		local hl = bufnr == current_buf and "TelescopeResultsStatusLine" or nil
		local display_path = M.truncate_path(relative_path)

		return {
			value = entry,
			ordinal = short_name,
			display = function()
				return displayer({
					{ tostring(bufnr), hl },
					{ short_name, hl },
					{ display_path, "TelescopeResultsFileLink" },
				})
			end,
			bufnr = bufnr,
		}
	end
end

return M
