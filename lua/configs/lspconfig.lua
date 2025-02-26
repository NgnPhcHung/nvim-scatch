local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Lua
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

-- lspconfig.ts_ls.setup({
-- 	capabilities = capabilities,
-- 	settings = {
-- 		typescript = {
-- 			inlayHints = {
-- 				includeInlayParameterNameHints = "none",
-- 				includeInlayEnumMemberValueHints = false,
-- 			},
-- 		},
-- 		javascript = {
-- 			inlayHints = {
-- 				includeInlayParameterNameHints = "none",
-- 				includeInlayEnumMemberValueHints = false,
-- 			},
-- 		},
-- 	},
-- })
