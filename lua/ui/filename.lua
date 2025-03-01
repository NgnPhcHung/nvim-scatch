local function show_sticky_filename()
  local buf = vim.api.nvim_create_buf(false, true)
  local opts = {
    relative = "editor",
    width = 30,
    height = 1,
    row = 1,                  -- Dòng đầu tiên
    col = vim.o.columns - 35, -- Góc phải trên
    style = "minimal",
    border = "rounded",
  }

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "📂 " .. vim.fn.expand("%:t") })
  local win = vim.api.nvim_open_win(buf, false, opts)
  vim.api.nvim_win_set_option(win, "winblend", 0) -- Làm nổi bật
end

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    show_sticky_filename()
  end,
})
