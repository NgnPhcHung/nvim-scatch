require('dapui').setup({
  layouts = {
    {
      elements = {
        { id = 'scopes', size = 0.25 },
        { id = 'breakpoints', size = 0.25 },
        { id = 'stacks', size = 0.25 },
        { id = 'watches', size = 0.25 },
      },
      position = 'left',
      size = 40,
    },
    {
      elements = {
        { id = 'repl', size = 0.5 },
        { id = 'console', size = 0.5 },
      },
      position = 'bottom',
      size = 10,
    },
  },
})


-- setup adapters
require('dap-vscode-js').setup({
  debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
  debugger_cmd = { 'js-debug-adapter' },
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

local dap = require('dap')
local dapui = require('dapui')

--auto toggle dap ui
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end

dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end

dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

-- custom adapter for running tasks before starting debug
local custom_adapter = 'pwa-node-custom'
dap.adapters[custom_adapter] = function(cb, config)
  if config.preLaunchTask then
    local async = require('plenary.async')
    local notify = require('notify').async

    async.run(function()
      ---@diagnostic disable-next-line: missing-parameter
      notify('Running [' .. config.preLaunchTask .. ']').events.close()
    end, function()
      vim.fn.system(config.preLaunchTask)
      config.type = 'pwa-node'
      dap.run(config)
    end)
  end
end

-- language config
for _, language in ipairs({ 'typescript', 'javascript' }) do
  dap.configurations[language] = {
    {
      name = 'Launch',
      type = 'pwa-node',
      request = 'launch',
      program = '${file}',
      rootPath = '${workspaceFolder}',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      skipFiles = { '<node_internals>/**' },
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      name = 'Attach to node process',
      type = 'pwa-node',
      request = 'attach',
      rootPath = '${workspaceFolder}',
      processId = require('dap.utils').pick_process,
    },
    {
      name = 'Debug Main Process (Electron)',
      type = 'pwa-node',
      request = 'launch',
      program = '${workspaceFolder}/node_modules/.bin/electron',
      args = {
        '${workspaceFolder}/dist/index.js',
      },
      outFiles = {
        '${workspaceFolder}/dist/*.js',
      },
      resolveSourceMapLocations = {
        '${workspaceFolder}/dist/**/*.js',
        '${workspaceFolder}/dist/*.js',
      },
      rootPath = '${workspaceFolder}',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      skipFiles = { '<node_internals>/**' },
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      name = 'Compile & Debug Main Process (Electron)',
      type = custom_adapter,
      request = 'launch',
      preLaunchTask = 'npm run build-ts',
      program = '${workspaceFolder}/node_modules/.bin/electron',
      args = {
        '${workspaceFolder}/dist/index.js',
      },
      outFiles = {
        '${workspaceFolder}/dist/*.js',
      },
      resolveSourceMapLocations = {
        '${workspaceFolder}/dist/**/*.js',
        '${workspaceFolder}/dist/*.js',
      },
      rootPath = '${workspaceFolder}',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      skipFiles = { '<node_internals>/**' },
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
  }
end


---keybinding
-- Toggle breakpoint
vim.keymap.set('n', '<Leader>dt', function()
  dap.toggle_breakpoint()
end, { desc = "Toggle breakpoint" })

-- Set conditional breakpoint
vim.keymap.set('n', '<Leader>dc', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = "Set conditional breakpoint" })

-- Start debugging
vim.keymap.set('n', '<Leader>ds', function()
  dap.continue()
end, { desc = "Start/Continue debugging" })

-- Step over
vim.keymap.set('n', '<Leader>dn', function()
  dap.step_over()
end, { desc = "Step over" })

-- Step into
vim.keymap.set('n', '<Leader>di', function()
  dap.step_into()
end, { desc = "Step into" })

-- Step out
vim.keymap.set('n', '<Leader>do', function()
  dap.step_out()
end, { desc = "Step out" })

-- Terminate debugging
vim.keymap.set('n', '<Leader>dq', function()
  dap.terminate()
end, { desc = "Terminate debugging" })

-- Open/close dap-ui
local dapui = require('dapui')
vim.keymap.set('n', '<Leader>du', function()
  dapui.toggle()
end, { desc = "Toggle DAP UI" })
