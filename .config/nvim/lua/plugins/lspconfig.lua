return {
  'neovim/nvim-lspconfig',
  event = {'BufReadPre', 'BufNewFile'},
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
  },
  config = function()
    local lspconfig = require('lspconfig')
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local opts = { noremap = true, silent = true }

    local file_exists = function(file)
      local f = io.open(file, 'rb')
      if f then f:close() end
      return f ~= nil
    end

    local dirs_from = function(file, file_path)
      if not file_exists(file) then return {} end
      local lines = {}
      for line in io.lines(file) do
        lines[#lines + 1] = file_path .. line:match('(.*)/')
      end
      return lines
    end

    local remove_duplicates = function (list)
      local hash = {}
      local res  = {}

      for _, v in ipairs(list) do
        if (not hash[v]) then
          res[#res + 1] = v
          hash[v] = true
        end
      end

      return res
    end

    local create_veridian_config = function (root, dir_list)
      local veridian_path = root ..'/veridian.yml'
      if file_exists(veridian_path) then
        os.remove(veridian_path)
      end
      print (veridian_path)
      local veridian_file = io.open(veridian_path, 'w+b')
      veridian_file:write('include_dirs:\n')
      for _,v in ipairs(dir_list) do
        veridian_file:write('  - ' .. v .. '\n')
      end
      veridian_file:write('\n')
      veridian_file:write('source_dirs:\n')
      for _,v in ipairs(dir_list) do
        veridian_file:write('  - ' .. v .. '\n')
      end
      -- veridian_file:write('auto_search_workdir: false')
      veridian_file:close()
    end

    local veridian_src = function()
      local root      = os.getenv('MARKOS_ROOT')
      local list_path = root .. '/tb/'
      local list_file = list_path .. 'src.filelist'
      -- print (list_file)
      local src_list  = dirs_from(list_file, list_path)
      local dir_list  = remove_duplicates(src_list)
      -- for k,v in pairs(dir_list) do
      --   print ('line [' .. k .. ']', v )
      -- end
      create_veridian_config(root, dir_list)
    end

    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      opts.desc = 'Show LSP references'
      vim.keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts) -- show definition, references

      opts.desc = 'Go to declaration'
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = 'Show LSP definitions'
      vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts) -- show lsp definitions

      opts.desc = 'Show LSP implementations'
      vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts) -- show lsp implementations

      opts.desc = 'Show LSP type definitions'
      vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts) -- show lsp type definitions

      opts.desc = 'See available code actions'
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = 'Smart rename'
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = 'Show buffer diagnostics'
      vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts) -- show  diagnostics for file

      opts.desc = 'Show line diagnostics'
      vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = 'Go to previous diagnostic'
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = 'Go to next diagnostic'
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = 'Show documentation for what is under cursor'
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = 'Restart LSP'
      vim.keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts) -- mapping to restart lsp if necessary
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

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

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }

    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    -- lspconfig['verible'].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   root_dir = root_dir
    -- })

    -- lspconfig['svlangserver'].setup({
    --   on_init = function(client)
    --     client.config.settings.systemverlog = {
    --       disableCompletionProvider = true,
    --       disableLinting = true
    --     }
    --   end,
    --   capabilities = capabilities,
    --   handlers = {
    --     ['textDocument/publishDiagnostics'] = function() end
    --   },
    --   on_attach = on_attach,
    --   root_dir = root_dir
    -- })

    -- lspconfig['vhdl_ls'].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   root_dir = root_dir
    -- })

    -- lspconfig['veridian'].setup({
    --   -- on_init = veridian_src,
    --   capabilities = capabilities,
    --   handlers = {
    --     ['textDocument/hover'] = function() end
    --   },
    --   on_attach = on_attach,
    --   root_dir = root_dir
    -- })

    lspconfig['clangd'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = root_dir
    })

    lspconfig['cssls'].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })

    lspconfig['pyright'].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })

    lspconfig['lua_ls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize 'vim' global
          diagnostics = {
            globals = { 'vim' }
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.stdpath('config') .. '/lua'] = true
            }
          }
        }
      }
    })
  end
}
