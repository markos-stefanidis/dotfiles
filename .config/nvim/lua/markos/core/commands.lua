local api = vim.api

-- :W writes the file
api.nvim_create_user_command('W', 'w', {})

-- :Q quits
api.nvim_create_user_command('Q', 'q', {})

-- Combine the above
api.nvim_create_user_command('WQ', 'wq', {})
api.nvim_create_user_command('Wq', 'wq', {})
