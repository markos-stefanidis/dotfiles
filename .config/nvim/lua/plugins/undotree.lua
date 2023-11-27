return {
  'mbbill/undotree',
  event  = {'BufReadPre', 'BufNewFile'},
  config = function()
    vim.g.undotree_WindowLayout       = 3
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_TreeNodeShape      = ''
    -- vim.g.undotree_TreeNodeShape      = ''
    -- vim.g.undotree_TreeSplitShape     = '󱞿'
    -- vim.g.undotree_TreeReturnShape    = '󱞧'
  end,
  keys = {
    { '<leader>u',  ':UndotreeShow<CR>', { silent = true } },
    { '<leader>cu', ':UndotreeHide<CR>', { silent = true } },
  }
}
