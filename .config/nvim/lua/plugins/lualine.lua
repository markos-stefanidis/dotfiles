return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons'},
  config = function ()
    local lualine = require('lualine')
    local lualine_theme = require('lualine.themes.everforest')
    local status_web_devicons_ok, web_devicons = pcall(require, 'nvim-web-devicons')
    local hl_winbar_file_icon = 'WinBarFileIcon'

    local file_path = function()
      local path      = vim.fn.expand('%:.')
      local filename  = vim.fn.expand('%:t')
      local file_type = vim.fn.expand('%:e')
      local default   = false
      local file_icon = ''
      local modified = vim.api.nvim_eval_statusline('%M', {}).str == '+' and '' or ''
      modified = '%#WarningMsg#' .. modified .. '%*'

      if (file_type == nil or file_type == '') then
        file_type = ''
        default = true
      end

      if status_web_devicons_ok then
        file_icon = web_devicons.get_icon(filename, file_type, { default = default })
        hl_winbar_file_icon = "DevIcon" .. file_type
      end

      if not file_icon then
        file_icon = ''
      end

      file_icon = '%#' .. hl_winbar_file_icon .. '#' .. file_icon .. ' %*'

      path = path:gsub('/', '   ')

      path = file_icon .. ' ' .. path .. '  ' .. modified

      return path

    end

    lualine.setup({
      options = {
        theme =  lualine_theme,
        disabled_filetypes = {
          winbar = {
            'NvimTree',
            'alpha'
          }
        }
      },

      winbar = {
        lualine_a = { function() return ' ' end },
        lualine_b = { 'diagnostics'},
        lualine_c = { file_path },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },

      inactive_winbar = {
        lualine_a = { function() return ' ' end },
        lualine_b = { 'diagnostics'},
        lualine_c = { file_path },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      }
    })


  end
}
