-- Define your current OS once
local function get_os()
  local sysname = vim.loop.os_uname().sysname
  if sysname == "Linux" then
    return "linux"
  elseif sysname == "Darwin" then      -- macOS
    return "macos"
  elseif sysname:match("Windows") then -- Windows_NT, etc.
    return "windows"
  end
  return "unknown" -- Fallback for other Unix-like or unexpected systems
end

local current_os = get_os()

-- Define vault paths based on OS
local obsidian_vault_path = nil

if current_os == "linux" then
  obsidian_vault_path = "/home/phuchung/obsidian"
elseif current_os == "macos" then
  obsidian_vault_path = "/Users/nguyenphuchung/library/Mobile Documents/iCloud~md~obsidian/Documents/PhucHungVaults"
elseif current_os == "windows" then
  vim.notify("obsidian.nvim does not support Windows in this configuration.", vim.log.levels.INFO)
end

require("obsidian").setup({
  workspaces = {
    {
      name = "PhucHungVaults",
      path = obsidian_vault_path,
    },
  },
  notes_subdir = "inbox",
  new_notes_location = "notes_subdir",


  disable_frontmatter = true,
  templates = {
    subdir = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M:%S",
  },

  -- name new notes starting the ISO datetime and ending with note name
  -- put them in the inbox subdir
  note_id_func = function(title)
    local suffix = ""
    -- get current ISO datetime with -5 hour offset from UTC for EST
    local current_datetime = os.date("!%Y-%m-%d-%H%M%S", os.time() - 5 * 3600)
    if title ~= nil then
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return current_datetime .. "_" .. suffix
  end,

  -- key mappings, below are the defaults
  mappings = {
    -- overrides the 'gf' mapping to work on markdown/wiki links within your vault
    ["gf"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- toggle check-boxes
    ["<leader>ti"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
  },
  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },
  ui = {
    -- Disable some things below here because I set these manually for all Markdown files using treesitter
    checkboxes = {},
    bullets = {},
  },
})


-- -- convert note to template and remove leading white space
vim.keymap.set("n", "<leader>on", ":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>")

-- search for files in full vault
vim.keymap.set("n", "<leader>os",
  ":Telescope find_files search_dirs={\"/Users/nguyenphuchung/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/PhucHungVaults/notes\"}<cr>")
vim.keymap.set("n", "<leader>oz",
  ":Telescope live_grep search_dirs={\"/Users/nguyenphuchung/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/PhucHungVaults/notes\"}<cr>")

-- for review workflow
-- move file in current buffer to zettelkasten folder
vim.keymap.set("n", "<leader>ok",
  ":!mv '%:p' /Users/nguyenphuchung/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/PhucHungVaults/phuchungtemp<cr>:bd<cr>")
-- delete file in current buffer
vim.keymap.set("n", "<leader>odd", ":!rm '%:p'<cr>:bd<cr>")
