local actions = require("telescope.actions")
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

local function custom_entry_maker(entry)
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

require("telescope").setup({
  defaults = {
    prompt_prefix = '   ',
    selection_caret = '▎ ',
    multi_icon = ' │ ',
    winblend = 0,
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    border = true,
    path_display = { "absolute" },
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
      n = {
        ["d"] = actions.delete_buffer,
        ["q"] = actions.close,
      },
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      winblend = 10,
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      layout_config = {
        width = 0.9,
        prompt_position = "top",
      },
      sorting_strategy = 'ascending',
      entry_maker = custom_entry_maker,
      hidden = true,
      no_ignore = true
    },
    symbols = {
      theme = 'dropdown',
    },
    registers = {
      theme = 'ivy',
    },
    grep_string = {
      initial_mode = 'normal',
      theme = 'ivy',
      sorting_strategy = 'ascending',
    },
    live_grep = {
      theme = 'dropdown',
      winblend = 10,
      sorting_strategy = 'ascending',
    },
    buffers = {
      previewer = true,
      theme = 'dropdown',
      sorting_strategy = 'ascending',
      mappings = {
        n = {
          ['<C-e>'] = 'delete_buffer',
          ['l'] = 'select_default',
        },
      },
      initial_mode = 'normal',
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
      specifc_opts = {
        codeactions = true,
      },
    },
    file_browser = {
      dir_icon = '',
      prompt_path = true,
      grouped = true,
      theme = 'dropdown',
      initial_mode = 'normal',
      previewer = false,
    },
  },
  config = function() end,
})

require("telescope").load_extension("ui-select")
pcall(function()
  require("telescope").load_extension("fzf")
end)

vim.cmd("highlight TelescopeResultsFileName guifg=white gui=bold")
vim.cmd("highlight TelescopeResultsFileLink guifg=#888888 ctermfg=8 gui=NONE")

vim.cmd("highlight CurrentBufferOpen  guifg=#789DBC")

local function truncate_path(path)
  local max_path_length = math.floor(vim.o.columns)

  if #path > max_path_length - 40 then
    return "…" .. path:sub(-math.floor(max_path_length * 2 / 5))
  end
  return path
end

local function buffer_entry_maker(entry)
  local bufnr = entry.bufnr
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local short_name = bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or "[No Name]"

  local project_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or vim.fn.getcwd()
  if not project_root or project_root == "" then
    project_root = vim.fn.getcwd()
  end

  local relative_path = bufname ~= "" and vim.fn.fnamemodify(bufname, ":.") or "[No Path]"
  if vim.startswith(relative_path, project_root) then
    relative_path = relative_path:sub(#project_root + 2)
  end

  local displayer = entry_display.create({
    separator = " ",
    items = {
      { width = 4 },
      { remaining = true },
      { remaining = true },
    },
  })

  local current_buf = vim.api.nvim_get_current_buf()
  local hl = bufnr == current_buf and "CurrentBufferOpen" or nil
  local display_path = truncate_path(relative_path)

  return {
    value = entry,
    ordinal = short_name,
    display = function()
      return displayer({
        { tostring(bufnr), hl },
        { short_name,      hl },
        { display_path,    "TelescopeResultsFileLink" }
      })
    end,
    bufnr = bufnr,
  }
end

vim.keymap.set("n", "<S-h>", function()
  require("telescope.builtin").buffers({
    initial_mode = "normal",
    previewer = false,
    layout_strategy = "center",
    layout_config = {
      width = 0.8,
      height = 0.4,
    },
    winblend = 0,
    entry_maker = buffer_entry_maker,
    sorter = nil,
    sort_lastused = true,
  })
end, { desc = "Open telescope buffers list" })
