-- config/flash.lua
local M = {}

function M.setup()
  require("flash").setup({
    labels = "asdfghjklqwertyuiopzxcvbnm", -- Các phím gán nhảy
    modes = {
      char = {
        enabled = true,
        keys = { "f", "F", "t", "T" }, -- Nhảy tới ký tự
      },
    },
    highlight = {
      backdrop = true,
    },
  })
end

return M

