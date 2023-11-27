return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {'nvim-tree/nvim-web-devicons' },
  config = function()
    local nvimtree = require('nvim-tree')
    -- recomended settings from doc
    vim.g.loaded 		 = 1
    vim.g.loaded_netrwPlugin =  1

    nvimtree.setup({
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
    })
  end,
  keys = {
    { '<leader>e',  ':NvimTreeFocus<CR>', { silent = true } },
    { '<leader>ce', ':NvimTreeClose<CR>', { silent = true } },
  }
}
