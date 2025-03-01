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

  local dir = get_git_root() or vim.fn.getcwd()
  local hash = vim.fn.sha256(dir)
  local workspace_dir = vim.fn.expand("~/.config/nvim/shada/workxpaces/")
  local shada_path = workspace_dir .. hash .. "/shada"

  vim.opt.shadafile = shada_path
  vim.g.session_file = workspace_dir .. hash .. "/session.vim"

  if vim.fn.isdirectory(workspace_dir) == 0 then
    vim.fn.mkdir(workspace_dir, "p")
  end

  vim.opt.sessionoptions = { "blank", "folds", "help", "tabpages", "winsize", "buffers" }

  local function restore_session()
    local files_before_load = vim.fn.argv()

    if vim.fn.filereadable(vim.g.session_file) == 0 then
      print("No session file found: " .. vim.g.session_file)
      return
    end

    local ok, err = pcall(vim.cmd, "source " .. vim.g.session_file)
    if not ok then
      print("⚠️ Session Restore Error: " .. err)
    end

    if #files_before_load > 0 then
      for _, file in ipairs(files_before_load) do
        if vim.fn.filereadable(file) == 1 then
          vim.cmd("edit " .. file)
        end
      end
    end
  end

  restore_session()

  vim.cmd([[
    augroup SessionAutoSave
      autocmd!
      autocmd VimLeavePre * call v:lua.save_session()
    augroup END
  ]])

  function _G.save_session()
    local session_dir = vim.fn.fnamemodify(vim.g.session_file, ":h")
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
    vim.cmd("mksession! " .. vim.g.session_file)
  end
end

setup_workspace()
