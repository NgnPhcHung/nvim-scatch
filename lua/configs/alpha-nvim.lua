local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

vim.defer_fn(function()
  local total_plugins = #vim.tbl_keys(packer_plugins or {})
  dashboard.section.footer.val = "Total plugins: " .. total_plugins
  pcall(vim.cmd.AlphaRedraw)
end, 100)
dashboard.section.header.val =
    vim.fn.readfile(vim.fs.normalize("~/.config/nvim/lua/custom-config/files/my_header_banner.txt"))
dashboard.section.header.opts.hl = "Question"
dashboard.section.buttons.val = {
  dashboard.button("f", " Find file", ":Telescope find_files<CR>"),
  dashboard.button("p", " Update plugins", ":Packer sync<CR>"),
  dashboard.button("q", " Exit", ":qa!<CR>"),
}
alpha.setup(dashboard.config)

vim.api.nvim_create_autocmd("BufDelete", {
  group = vim.api.nvim_create_augroup("bufdelpost_autocmd", {}),
  desc = "BufDeletePost User autocmd",
  callback = function()
    vim.schedule(function()
      vim.api.nvim_exec_autocmds("User", {
        pattern = "BufDeletePost",
      })
    end)
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "BufDeletePost",
  group = vim.api.nvim_create_augroup("dashboard_delete_buffers", {}),
  desc = "Open Dashboard when no available buffers",
  callback = function(ev)
    local deleted_name = vim.api.nvim_buf_get_name(ev.buf)
    local deleted_ft = vim.api.nvim_get_option_value("filetype", { buf = ev.buf })
    local deleted_bt = vim.api.nvim_get_option_value("buftype", { buf = ev.buf })
    local dashboard_on_empty = deleted_name == "" and deleted_ft == "" and deleted_bt == ""

    if dashboard_on_empty then
      vim.cmd("Alpha")
    end
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("alpha_start", { clear = true }),
  desc = "Open Alpha dashboard on startup",
  callback = function()
    if vim.fn.argc() == 0 and vim.bo.filetype == "" then
      require("alpha").start(false)
    end
  end,
})
