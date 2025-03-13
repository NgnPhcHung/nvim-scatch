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
    ordinal = just_file,
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
    },
    live_grep = {
      theme = 'dropdown',
    },
    buffers = {
      previewer = true,
      theme = 'dropdown',
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

vim.cmd("highlight TelescopeNormal guibg=#0d1b2a")                     -- Nền chính: xanh đậm
vim.cmd("highlight TelescopeBorder guifg=#3e6072 guibg=#0d1b2a")       -- Viền: xanh vừa, tạo điểm nhấn
vim.cmd("highlight TelescopePromptNormal guifg=#a9d6e5 guibg=#0d1b2a") -- Prompt: chữ xanh sáng
vim.cmd("highlight TelescopePromptBorder guifg=#3e6072 guibg=#0d1b2a")
vim.cmd("highlight TelescopeResultsNormal guibg=#0d1b2a")
vim.cmd("highlight TelescopeResultsBorder guifg=#3e6072 guibg=#0d1b2a")
vim.cmd("highlight TelescopePreviewNormal guibg=#0d1b2a")
vim.cmd("highlight TelescopePreviewBorder guifg=#3e6072 guibg=#0d1b2a")
