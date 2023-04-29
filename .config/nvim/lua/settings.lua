local set = vim.opt
local cmd = vim.cmd

-- Set relative numbers
set.relativenumber  = true
-- Set line number
set.number  = true
-- Highlihgt current lilne
set.cursorline = true
-- Set mouse usability
set.mouse=a
set.ttymouse=sgr -- Needed for mouse to work with Alarcitty
-- Always status bar at last window
set.laststatus = 2
-- Setting Right split orientation
set.splitbelow = true
set.splitright = true
-- Setting tabbing options
set.tabstop = 4
-- Setting indentation options
set.autoindent = true
-- Setting no backup/no swap
set.backup = false
