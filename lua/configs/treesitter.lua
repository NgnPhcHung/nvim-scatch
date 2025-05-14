require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "typescript",
    "html",
    "css",
    "lua", -- Xoá phần "lua" thừa
    "javascript",
    "tsx",
    "json",
    "http",
    "prisma",
  },
  highlight = {
    enable = true,           -- Bật tính năng đánh dấu cú pháp
    use_languagetree = true, -- Sử dụng tree-sitter cho các ngôn ngữ
  },
  indent = {
    enable = true, -- Bật indent tự động dựa trên cây cú pháp
  },
  autopairs = {
    enable = true, -- Bật tính năng tự động đóng dấu ngoặc
  },
  fold = {
    enable = true, -- Bật tính năng gập mã
  },
  textobjects = {
    select = {
      enable = true,                -- Bật chọn đối tượng theo cú pháp
      lookahead = true,             -- Để xem trước khi chọn
      keymaps = {
        ["af"] = "@function.outer", -- Chọn toàn bộ hàm
        ["if"] = "@function.inner", -- Chọn bên trong hàm
      },
    },
  },

  sync_install = false, -- Cài đặt các parser một cách đồng bộ hay không
  auto_install = false, -- Tự động cài parser khi mở file
  modules = {},         -- Bạn có thể thêm các module nếu cần thiết
  ignore_install = {},  -- Các parser mà bạn muốn bỏ qua trong quá trình cài đặt

})
