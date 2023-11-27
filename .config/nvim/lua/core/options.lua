-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs and Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Line Wrapping
vim.opt.wrap = false

-- Search Settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Cursor Line
vim.opt.cursorline = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'

-- Backspace
vim.opt.backspace = 'indent,eol,start'

-- Clipboard
vim.opt.clipboard:append('unnamedplus')

-- Mouse Options
vim.opt.mouse:append('a')

-- Backup and Swap Files
vim.opt.backup = false
vim.opt.swapfile = false

-- Undo Dir
vim.opt.undodir = os.getenv('HOME') .. '/.local/nvim/undodir'
vim.opt.undofile = true

-- Split Windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Scrolling options
vim.opt.scrolloff = 8

-- Global Status Line
vim.opt.laststatus = 3

-- Word Settings
-- vim.opt.iskeyword:remove("_")
