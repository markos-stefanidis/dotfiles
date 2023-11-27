-- :W writes the file
vim.api.nvim_create_user_command('W', 'w', {})

-- :Q quits vim
vim.api.nvim_create_user_command('Q', 'q', {})

-- Combine the above
vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})

-- Extend to all buffers
vim.api.nvim_create_user_command('Wa', 'wa', {})
vim.api.nvim_create_user_command('Qa', 'Qq', {})
