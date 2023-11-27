return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons'},
  config = function ()
    local lualine = require('lualine')
    local lualine_theme = require('lualine.themes.everforest')

    lualine.setup({
      options = {
        theme =  lualine_theme
      }
    })

  end
}
