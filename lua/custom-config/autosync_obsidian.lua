-- Define your current OS once
local function get_os()
  local sysname = vim.loop.os_uname().sysname
  if sysname == "Linux" then
    return "linux"
  elseif sysname == "Darwin" then      -- macOS
    return "macos"
  elseif sysname:match("Windows") then -- Windows_NT, etc.
    return "windows"
  end
  return "unknown" -- Fallback for other Unix-like or unexpected systems
end

local current_os = get_os()

-- Define vault paths based on OS
local obsidian_vault_path = nil

if current_os == "linux" then
  obsidian_vault_path = "/home/phuchung/obsidian"
elseif current_os == "macos" then
  obsidian_vault_path = "/Users/nguyenphuchung/library/Mobile Documents/iCloud~md~obsidian/Documents/PhucHungVaults"
elseif current_os == "windows" then
  vim.notify("obsidian.nvim does not support Windows in this configuration.", vim.log.levels.INFO)
end


local path = vim.fn.expand('%:p')

local function git_auto_sync()
  local vault_path = obsidian_vault_path
  if not path:find(vault_path, 1, true) then
    return
  end

  if vim.bo.filetype ~= 'markdown' then
    print("File is not markdown: " .. vim.bo.filetype)
    return
  end

  print("File is in vault and is markdown. Proceeding with Git operations.")

  local check_status_cmd = 'git -C ' .. vim.fn.shellescape(vault_path) .. "status --porcelain"
  local status_output = {}
  local full_status_output
  vim.fn.jobstart(check_status_cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data, _)
      for _, line in ipairs(data) do
        table.insert(status_output, line)
      end
    end,
    on_exit = function(job_id_add, data_add, event_add)
      full_status_output = table.concat(status_output, "\n")
    end
  })
  if full_status_output ~= "" then
    vim.notify("No file change, nothing to commit")
    return
  end

  local file_to_add = vim.fn.shellescape(path)

  local add_cmd = 'git -C ' .. vim.fn.shellescape(vault_path) .. ' add ' .. file_to_add
  print("Running git add command: " .. add_cmd)

  vim.fn.jobstart(add_cmd, {
    on_exit = function(job_id_add, data_add, event_add)
      print("git add exited with code: " .. data_add)
      if data_add == 0 then                         -- git add successful
        local commit_message = "Auto-commit: " .. vim.fn.fnamemodify(path, ":t") .. " changes from Neovim"
        print("Commit message: " .. commit_message) -- This is the print you're looking for!

        local commit_cmd = 'git -C ' ..
            vim.fn.shellescape(vault_path) .. ' commit -m ' .. vim.fn.shellescape(commit_message)
        print("Running git commit command: " .. commit_cmd)

        vim.fn.jobstart(commit_cmd, {
          on_exit = function(job_id_commit, data_commit, event_commit)
            print("git commit exited with code: " .. data_commit)
            if data_commit == 0 then -- git commit successful
              local push_cmd = 'git -C ' .. vim.fn.shellescape(vault_path) .. ' push origin main'
              print("Running git push command: " .. push_cmd)

              vim.fn.jobstart(push_cmd, {
                on_exit = function(job_id_push, data_push, event_push)
                  print("git push exited with code: " .. data_push)
                  if data_push == 0 then
                    print("Git push successful!")
                    vim.notify("Git push successful!", vim.log.levels.INFO, { title = "Git Sync" })
                  else
                    vim.notify("Git push failed (Code: " .. data_push .. "). Check terminal for errors.",
                      vim.log.levels.ERROR, { title = "Git Sync" })
                  end
                end
              })
            else
              -- git commit failed (e.g., no changes to commit, or a conflict)
              print("Git commit skipped or failed (Code: " .. data_commit .. "). No changes or conflict.")
              vim.notify("Git commit skipped or failed (Code: " .. data_commit .. "). No changes or conflict.",
                vim.log.levels.WARN, { title = "Git Sync" })
            end
          end
        })
      else
        vim.notify("Git add failed (Code: " .. data_add .. "). Check terminal for errors.", vim.log.levels.ERROR,
          { title = "Git Sync" })
      end
    end
  })
end

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.md",
  callback = git_auto_sync,
  desc = "Auto Git sync for Obsidian notes on save",
})

-- Optional: Auto-pull on entering a markdown buffer in your vault
-- vim.api.nvim_create_autocmd("BufReadPre", {
--   pattern = "*.md",
--   callback = function()
--     local path = vim.fn.expand('%:p')
--     local vault_path = macos_path
--     if not path:find(vault_path, 1, true) then
--         -- print("File not in vault for pull check: " .. path)
--         return
--     end
--
--     if vim.bo.filetype ~= 'markdown' then
--         -- print("File not markdown for pull check: " .. vim.bo.filetype)
--         return
--     end
--
--     print("Running auto Git pull on buffer open.")
--     local pull_cmd = 'git -C ' .. vim.fn.shellescape(vault_path) .. ' pull --rebase origin main'
--     print("Pull command: " .. pull_cmd)
--     vim.fn.jobstart(pull_cmd, {
--       on_exit = function(job_id, data, event)
--         print("git pull exited with code: " .. data)
--         if data ~= 0 then
--           vim.notify("Git pull failed (Code: " .. data .. "). You might have conflicts. Please resolve manually.", vim.log.levels.ERROR, { title = "Git Sync" })
--         else
--           print("Git pull successful.")
--         end
--       end
--     })
--   end,
--   desc = "Auto Git pull for Obsidian notes on buffer open",
-- })
