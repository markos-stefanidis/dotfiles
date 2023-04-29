local mason_setup, mason = pcall(require, "mason")
if not mason_setup then
  return
end

mason.setup()

local mason_lspconfig_setup, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_setup then
  return
end

mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
    -- "svls",
    "svlangserver"
  }
})

local lspconfig_setup, lspconfig = pcall(require, "lspconfig")
if not lspconfig_setup then
  return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp= pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

local root_dir = function()
 local cur_dir = vim.loop.cwd()
 while cur_dir ~= "/home/markos" do
   if vim.fn.isdirectory(cur_dir .. "/.git") == 1 then
     return cur_dir
   end
   cur_dir = vim.fn.fnamemodify(cur_dir, ":h")
 end
 return cur_dir
end

local capabilities = cmp_nvim_lsp.default_capabilities()

local on_attach = function(_, _)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

lspconfig.lua_ls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'}
      }
    }
  }

}

lspconfig.svlangserver.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    root_dir = root_dir()
  }
}
