vim.g.mapleader = ' '

-- General Keymaps
vim.keymap.set('n', '<leader>nh', ':nohl<CR>', { silent = true })

vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('i', 'Jk', '<ESC>')
vim.keymap.set('i', 'jK', '<ESC>')
vim.keymap.set('i', 'JK', '<ESC>')

-- Navigation
-- if vim.fn.exists('g:loaded_tmux_navigator') == 1 then
--   vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>')
--   vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>')
--   vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>')
--   vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>')
-- else
--   vim.keymap.set('n', '<C-l>', '<C-w>l')
--   vim.keymap.set('n', '<C-k>', '<C-w>k')
--   vim.keymap.set('n', '<C-j>', '<C-w>j')
--   vim.keymap.set('n', '<C-h>', '<C-w>h')
-- end

-- VC Diff
vim.keymap.set('n', '<leader>vd', function()
  vim.cmd('VCDiff')
  vim.keymap.set('n','<C-p>', '<cmd> VCDiffOld')
  vim.keymap.set('n','<C-n>', '<cmd> VCDiffNew')
  vim.keymap.set('n', '<C-l>', '<C-w>l')
  vim.keymap.set('n', '<C-k>', '<C-w>k')
  vim.keymap.set('n', '<C-j>', '<C-w>j')
  vim.keymap.set('n', '<C-h>', '<C-w>h')
end)

-- X to cut line
vim.keymap.set('n', 'X', 'dd')

-- Deleteing into void buffer
vim.keymap.set('n', 'dd', '"_dd')
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('x', 'p', '"_dP')
vim.keymap.set('n', 's', '"_s')
vim.keymap.set('n', 'S', '"_S')

-- Maximize/Equalize Splits
vim.keymap.set('n', '<leader>sm', '<C-w>|<C-w>_')
vim.keymap.set('n', '<leader>se', '<C-w>=')

-- Q does nothing
vim.keymap.set('n', 'Q', '<nop>')

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<CR>')
vim.keymap.set('n', '<leader>fc', '<cmd>Telescope grep_string<CR>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
