local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val =
    vim.fn.readfile(vim.fs.normalize("~/.config/nvim/lua/custom-config/files/my_header_banner.txt"))
dashboard.section.header.opts.hl = "Question"

dashboard.section.buttons.val = {
  dashboard.button("f", " Find file", ":Telescope find_files<CR>"),
  dashboard.button("p", " Update plugins", ":Lazy sync<CR>"),
  dashboard.button("q", " Exit", ":qa!<CR>"),
}

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    local stats = require("lazy").stats()
    dashboard.section.footer.val = "Total plugins: " .. (stats.count or 0)
    pcall(vim.cmd.AlphaRedraw)
  end,
})

alpha.setup(dashboard.config)
