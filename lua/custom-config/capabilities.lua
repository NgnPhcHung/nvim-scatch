local status_ok, cmp = pcall(require, "blink.cmp")
if status_ok then
	return cmp.get_lsp_capabilities()
else
	local cmp_status, cmp_lsp = pcall(require, "cmp_nvim_lsp")
	if cmp_status then
		return cmp_lsp.default_capabilities()
	else
		return vim.lsp.protocol.make_client_capabilities()
	end
end
