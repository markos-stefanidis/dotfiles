vim.g.mapleader = " "

local keymap = vim.keymap

-- general keymaps
keymap.set('n', '<leader>nh', ':nohl<CR>')
keymap.set('n', 'x', '"_x')

keymap.set('n', '<leader>sv', '<C-w>v')
keymap.set('n', '<leader>sh', '<C-w>h')
keymap.set('n', '<leader>se', '<C-w>=')
keymap.set('n', '<leader>sx', ':close<CR>')
keymap.set('i', 'jk', '<ESC>')
keymap.set('i', 'jK', '<ESC>')

-- plugin keymaps
keymap.set('n', '<leader>sm', ':MaximizerToggle<CR>')
keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>')
keymap.set('n', '<leader>ce', ':NvimTreeClose<CR>')

keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<CR>')
keymap.set('n', '<leader>fc', '<cmd>Telescope grep_string<CR>')
keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')

