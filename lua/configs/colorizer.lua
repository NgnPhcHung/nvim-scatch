local status_ok, icons = pcall(require, "packages.icons")
local color_icon = status_ok and icons.ui.Round or "●"

return {
	filetypes = { "*" },
	user_default_options = {
		css = true,
		tailwind = "both",
		mode = "virtualtext",
		virtualtext = color_icon,
		virtualtext_inline = "before",
		virtualtext_mode = "foreground",
	},
}
