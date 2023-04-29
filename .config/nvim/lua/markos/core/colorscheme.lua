local status, _ = pcall(vim.cmd, 'colorscheme monokai')
if not status then
   print('Colorscheme not found!')
   return
end

local monokai = require('monokai')
local palette = monokai.classic
monokai.setup()

require("transparent").setup({
  extra_groups = { -- table/string: additional groups that should be cleared
    -- In particular, when you set it to 'all', that means all available groups

    -- example of akinsho/nvim-bufferline.lua
    "BufferLineTabClose",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected",
  },
  exclude_groups = {}, -- table: groups you don't want to clear
})

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
