local theme = os.getenv('THEME')

if theme == 'everforest' then

  return {
    'neanias/everforest-nvim',
    version  = false,
    lazy     = false,
    priority = 1000,
    config = function()
      local everforest = require('everforest')
      everforest.setup()

      vim.cmd('colorscheme everforest')
    end
  }
elseif theme == 'gruvbox' then

  return {
   "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy     = false,
    config   = function()
      local gruvbox = require('gruvbox')
      gruvbox.setup()

      vim.cmd('colorscheme gruvbox')
    end
  }
end
