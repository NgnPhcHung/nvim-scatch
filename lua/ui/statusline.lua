local M = {}
vim.o.laststatus = 2
vim.o.cmdheight = 1
function M.setup()
	local icon = require("packages.icons")
	local lualine = require("lualine")

	local function mode()
		local mode_colors = {
			n = { fg = "#1e1e2e", bg = "#a6e3a1", bold = true }, -- normal = green
			i = { fg = "#1e1e2e", bg = "#89b4fa", bold = true }, -- insert = blue
			v = { fg = "#1e1e2e", bg = "#f9e2af", bold = true }, -- visual = yellow
			V = { fg = "#1e1e2e", bg = "#f9e2af", bold = true },
			[""] = { fg = "#1e1e2e", bg = "#f9e2af", bold = true },
			c = { fg = "#1e1e2e", bg = "#f38ba8", bold = true }, -- command = red
			R = { fg = "#1e1e2e", bg = "#fab387", bold = true }, -- replace = orange
			t = { fg = "#1e1e2e", bg = "#94e2d5", bold = true }, -- terminal = teal
		}

		local m = vim.api.nvim_get_mode().mode
		local text_label = string.upper(m)
		local label = text_label -- FIXED

		local color = mode_colors[m] or { fg = "#ffffff", bg = "#444444", bold = true }
		vim.api.nvim_set_hl(0, "StatusLineMode", color)

		return string.format("%%#StatusLineMode# %s %%*", label)
	end

	local filetype = { "filetype", icon_only = true, color = { fg = "#ffffff", bg = "none" } }

	local numberOfBuffers = function()
		local buffers = vim.fn.getbufinfo({ buflisted = 1 })
		return icon.kind.File .. " " .. #buffers
	end

	local branch = {
		"branch",
		icons_enabled = true,
		icon = icon.git.Branch,
		color = { fg = "#89b4fa", bg = "none" },
	}

	local diagnostics = {
		"diagnostics",
		sources = { "nvim_diagnostic" },
		sections = { "error", "warn", "info", "hint" },
		symbols = {
			error = icon.diagnostics.Error,
			hint = icon.diagnostics.Hint,
			info = icon.diagnostics.Info,
			warn = icon.diagnostics.Warning,
		},
		colored = true,
		update_in_insert = false,
		always_visible = false,
	}

	local diff = {
		"diff",
		source = function()
			local gitsigns = vim.b.gitsigns_status_dict
			if gitsigns then
				return {
					added = gitsigns.added,
					modified = gitsigns.changed,
					removed = gitsigns.removed,
				}
			end
		end,
		symbols = {
			added = icon.git.LineAdded .. " ",
			modified = icon.git.LineModified .. " ",
			removed = icon.git.LineRemoved .. " ",
		},
		colored = true,
		always_visible = true,
		diff_color = {
			added = { fg = "#a6e3a1" }, -- green
			modified = { fg = "#f9e2af" }, -- yellow
			removed = { fg = "#f38ba8" }, -- red
		},
	}

	local function filename()
		local filepath = vim.fn.expand("%:~:.") -- relative path from cwd or home
		local parts = vim.split(filepath, "/", { trimempty = true })

		if #parts > 3 then
			return ".../" .. table.concat({ parts[#parts - 2], parts[#parts - 1], parts[#parts] }, "/")
		else
			return filepath
		end
	end

	lualine.setup({
		options = {
			theme = "catppuccin-macchiato",
			globalstatus = true,
			component_separators = { left = " ", right = " " },
			section_separators = { left = " ", right = " " },
			disabled_filetypes = { statusline = { "neo-tree", "lazy", "alpha" } },
		},
		sections = {
			lualine_a = { mode() },
			lualine_b = { branch },
			lualine_c = {
				{ numberOfBuffers },
				{
					filename,
					icon = icon.kind.Event,
					bold = true,
					color = { fg = "#86B0BD", bg = "none" },
				},
			},
			lualine_x = { diff, diagnostics },
			lualine_y = {},
			lualine_z = { filetype },
		},
		globalstatus = false,
	})
end

vim.api.nvim_set_hl(0, "StatusLine", { fg = "#cdd6f4", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#6c7086", bg = "#181825" })

return M
