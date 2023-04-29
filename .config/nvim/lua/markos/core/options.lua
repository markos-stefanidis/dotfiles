local opt = vim.opt

-- line numbers
opt.number = true;
opt.relativenumber = true;

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- mouse options
opt.mouse:append('a')

-- Backup and swap files
opt.backup = false
opt.swapfile = false

-- split windows
opt.splitright = true
opt.splitbelow = true

-- wrod settings
-- opt.iskeyword:remove("_")