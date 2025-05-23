local M = {}

function M.find_project_root()
  local markers = { '.git', 'package.json', 'Cargo.toml' }
  local cwd = vim.fn.expand('%:p:h') -- Thư mục của file hiện tại
  local root = cwd
  for _, marker in ipairs(markers) do
    local path = vim.fn.findfile(marker, cwd .. ';')
    if path ~= '' then
      root = vim.fn.fnamemodify(path, ':h')
      break
    end
  end
  return root
end

function M.set_project_root()
  local root = M.find_project_root()
  vim.api.nvim_set_current_dir(root)
end

return M
