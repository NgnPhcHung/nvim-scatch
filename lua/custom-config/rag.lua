local M = {}

local function get_selection()
	local _, cs = unpack(vim.fn.getpos("'<"))
	local _, ce = unpack(vim.fn.getpos("'>"))
	return table.concat(vim.api.nvim_buf_get_lines(0, cs - 1, ce, false), "\n")
end

local function get_buffer()
	return table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
end

local function request(method, path, body)
	local json = vim.fn.json_encode(body)
	local cmd = string.format([[curl -s -X %s localhost:3000/%s -d '%s']], method, path, json)
	local out = vim.fn.system(cmd)
	return vim.fn.json_decode(out)
end

function M.save_selection()
	local sel = get_selection()
	if sel and sel ~= "" then
		request("POST", "save", { text = sel })
		print("Saved to Chroma")
	end
end

function M.ask_query()
	local query = vim.fn.input("Ask Claude: ")
	local res = request("POST", "query", { query = query })

	M.open_panel(res.answer)
end

function M.open_panel(text)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, "\n"))

	local width = vim.o.columns
	local height = vim.o.lines
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = math.floor(width * 0.5),
		height = math.floor(height * 0.5),
		row = math.floor(height * 0.25),
		col = math.floor(width * 0.25),
		style = "minimal",
		border = "rounded",
	})

	M.panel_win = win
	M.panel_buf = buf
end

function M.toggle_panel()
	if M.panel_win then
		vim.api.nvim_win_close(M.panel_win, true)
		M.panel_win = nil
	end
end

return M
