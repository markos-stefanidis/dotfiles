local setup, lualine = pcall(require, "lualine")
if not setup then
   return
end

local lualine_theme = require('lualine.themes.molokai')
-- local lualine_theme = require('lualine.themes.solarized')

lualine.setup({
   options = {
      theme = lualine_theme
   }
})

