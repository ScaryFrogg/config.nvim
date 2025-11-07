local M = {}

function M.reveal_in_explorer()
  local system = vim.uv.os_uname().sysname -- Get the current OS name
  local file_path = vim.fn.expand "%:p" -- Get the full path of the current file

  if system == "Windows_NT" then -- 'Windows_NT' is the identifier for Windows
    -- On Windows, use 'explorer /select,' to open and highlight the file
    local dir_path = vim.fn.expand "%:h"
    local escaped_dir = vim.fn.shellescape(dir_path)

    -- The command uses 'cmd /c' to execute and close the command prompt.
    -- First, 'cd' to the directory, then 'start explorer .' to open it.
    local command = 'cmd /c "cd /d ' .. escaped_dir .. ' && start explorer ."'
    print(command)
    os.execute(command)
  elseif system == "Linux" then
    -- On Linux, use xdg-open to launch the default file manager
    -- We pass the current directory ('expand('%:h')') to open the folder
    os.execute("xdg-open " .. vim.fn.shellescape(vim.fn.expand "%:h"))
  elseif system == "Darwin" then -- 'Darwin' is the identifier for macOS
    -- On macOS, use 'open' to reveal the file in Finder
    os.execute("open --reveal " .. vim.fn.shellescape(file_path))
  else
    print "Unsupported OS for this keymap."
  end
end

return M
