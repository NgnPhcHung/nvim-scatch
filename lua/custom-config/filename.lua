local sticky_filename = {}


-- Lưu trữ ID của window để có thể cập nhật hoặc xoá
sticky_filename.win_id = nil
sticky_filename.buf_id = nil

function sticky_filename.show()
  local icon = require("packages.icons")

  -- Xoá window cũ nếu tồn tại
  if sticky_filename.win_id and vim.api.nvim_win_is_valid(sticky_filename.win_id) then
    vim.api.nvim_win_close(sticky_filename.win_id, true)
  end

  -- Lấy tên file hiện tại (chỉ lấy tên file, không lấy path)
  local filename = vim.fn.expand("%:t")
  if filename == "" then return end -- Không hiển thị nếu chưa có file mở
  if filename:match("NvimTree_") then
    return
  end


  -- Kiểm tra buffer có tồn tại không, nếu không thì tạo buffer mới
  if not sticky_filename.buf_id or not vim.api.nvim_buf_is_valid(sticky_filename.buf_id) then
    sticky_filename.buf_id = vim.api.nvim_create_buf(false, true) -- Buffer ẩn
  end

  -- Cập nhật nội dung buffer
  vim.api.nvim_buf_set_lines(sticky_filename.buf_id, 0, -1, false, { icon.kind.File .. " " .. filename })

  -- Tạo floating window để hiển thị tên file
  local win_id = vim.api.nvim_open_win(sticky_filename.buf_id, false, {
    relative = "editor",
    width = #filename + 4,
    height = 1,
    row = 2,                               -- Hiển thị ở dòng đầu tiên
    col = vim.o.columns - (#filename + 6), -- Hiển thị góc phải
    style = "minimal",
    border = "rounded",
    focusable = false,
    noautocmd = true,
  })

  -- Cập nhật ID của window để có thể đóng lại khi cần
  sticky_filename.win_id = win_id
end

-- Tự động cập nhật khi đổi buffer hoặc mở file mới
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {

  callback = sticky_filename.show,
})

return sticky_filename
