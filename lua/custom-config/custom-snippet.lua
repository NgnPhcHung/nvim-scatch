function LogSelectionMacro()
  -- Lấy nội dung đã yank từ register "z"
  local selection = vim.fn.getreg("z")
  -- Loại bỏ khoảng trắng và newline thừa ở đầu và cuối chuỗi
  selection = selection:gsub("^%s*(.-)%s*$", "%1")
  -- Lấy vị trí dòng hiện tại (số dòng)
  local row = vim.api.nvim_win_get_cursor(0)[1]
  -- Chèn một dòng mới bên dưới dòng hiện tại, với nội dung console.log(...)
  vim.api.nvim_buf_set_lines(0, row, row, false,
    { "console.log(" .. "\"" .. selection .. "\"" .. "," .. selection .. ");" })
end

-- Mapping cho Visual mode:
-- Yank selection vào register "z" rồi gọi hàm macro
vim.api.nvim_set_keymap("v", "<leader>l", '"zy:lua LogSelectionMacro()<CR>', { noremap = true, silent = true })

