local M = {}

local defaults = require('winbar.defaults')
local status_devicons, devicons = pcall(require, 'nvim-web-devicons')

local create_winbar = function()
  local filename  = vim.fn.expand('%:t')
  local filetype  = vim.fn.expand('%:e')
  local file_path = vim.api.nvim_eval_statusline('%f', {}).str
  local modified  = vim.api.nvim_eval_statusline('%M', {}).str == '+' and ' ●' or ''
  local icon
  local value = ' '

  if status_devicons then
    icon = devicons.get_icon(filename, filetype, { default = default })
  end

  if not icon then
    icon = defaults.icons.file_icon
  end

  file_path = file_path:gsub('/', ' 󰁕 ')

  -- if opts.show_file_path then
    local file_path_list = {}
    local _ = string.gsub(file_path, '[^/]+', function(w)
      table.insert(file_path_list, w)
    end)

    for i = 1, #file_path_list do
      value = value .. '%#' .. 'StatusLine' .. '#' .. file_path_list[i] .. ' ' .. defaults.icons.seperator .. ' %*'
    end
  -- end

  return '%#StatusLine#'
    .. value
    .. '%*'
end

M.show_winbar = function()
  local winbar = create_winbar()

  local status_ok, _ = pcall(vim.api.nvim_set_option_value, 'winbar', winbar, { scope = 'local' })
  if not status_ok then
    return
  end
end

return M
