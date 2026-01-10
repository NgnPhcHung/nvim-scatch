local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local blink_status, blink = pcall(require, "blink.cmp")
if blink_status then
	M.capabilities = blink.get_lsp_capabilities(M.capabilities)
end

return M
