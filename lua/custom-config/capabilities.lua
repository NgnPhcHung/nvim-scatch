local cmp_status, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_status then
	return cmp_lsp.default_capabilities()
else
	return vim.lsp.protocol.make_client_capabilities()
end
