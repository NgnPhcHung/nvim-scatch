require('neogit').setup {
  integrations = {
    diffview = true  -- Kích hoạt tích hợp với diffview.nvim nếu bạn dùng diffview
  },
  kind = 'vsplit',  -- Chế độ hiển thị: có thể là 'split', 'vsplit' hoặc 'tab'
  auto_refresh = true,  -- Tự động làm mới trạng thái Git
  disable_commit_confirmation = false,  -- Tắt xác nhận trước khi commit
}

