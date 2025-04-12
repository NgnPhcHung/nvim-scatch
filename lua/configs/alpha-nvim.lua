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
