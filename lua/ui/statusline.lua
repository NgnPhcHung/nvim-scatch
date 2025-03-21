local M = {}
vim.o.laststatus = 2 -- Ensure per-window statusline
vim.o.cmdheight = 1  -- Ensure space for status messages
function M.setup()
  local icon = require("packages.icons")
  local lualine = require("lualine")

  local mode = "mode"
  local filetype = { "filetype", icon_only = true }

  local numberOfBuffers = function()
    local buffers = vim.fn.getbufinfo({ buflisted = 1 })
    return "[  " .. #buffers .. " ]"
  end
  local branch = {
    "branch",
    icons_enabled = true,
    icon = require("packages.icons").git.Branch,
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
    always_visible = false,
  }

  lualine.setup({
    options = {
      theme = "catppuccin",
      globalstatus = true,
      section_separators = "",
      component_separators = "",
      disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
    },
    sections = {
      lualine_a = { mode, },
      lualine_b = { branch },
      lualine_c = {
        { numberOfBuffers },
        { "filename",     path = 1 }, -- Hiển thị đường dẫn tệp
      },
      lualine_x = { diff, diagnostics, filetype },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    globalstatus = false
  })
end

return M
