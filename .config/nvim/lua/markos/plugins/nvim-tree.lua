local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
   return
end

-- recomended settings from doc
vim.g.loaded = 1
vim.g.loaded_newtrwPlugin = 1

nvimtree.setup({
   actions = {
      open_file = {
         window_picker = {
            enable = false,
         },
      },
   },
})
