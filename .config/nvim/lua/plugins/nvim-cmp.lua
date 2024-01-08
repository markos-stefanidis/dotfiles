return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer', -- source for text in buffer
    'hrsh7th/cmp-path', -- source for file system paths
    'L3MON4D3/LuaSnip', -- snippet engine
    'saadparwaiz1/cmp_luasnip', -- for autocompletion
    'rafamadriz/friendly-snippets', -- useful snippets
    'onsails/lspkind.nvim', -- vs-code like pictograms
  },
  config = function()
    local cmp = require('cmp')

    local luasnip = require('luasnip')

    local lspkind = require('lspkind')

    local kind_mapper = {10, -- Text
                          2, -- Method
                          3, -- Function
                          4, -- Constructor
                          5, -- Field
                          6, -- Variable
                          7, -- Class
                          8, -- Interface
                          9, -- Module
                          1, -- Property
                         11, -- Unit
                         12, -- Value
                         13, -- Enum
                         14, -- Keyword
                         15, -- Snippet
                         16, -- Color
                         17, -- File
                         18, -- Reference
                         19, -- Folder
                         20, -- EnumMember
                         21, -- Constant
                         22, -- Struct
                         23, -- Event
                         24, -- Operator
                         25} -- TypeParameter

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require('luasnip.loaders.from_vscode').lazy_load()

    -- if vim.bo.filetype == 'systemverilog' then
    --   cmp.event:on('complete_done', function()
    --     local entry = cmp.get_active_entry()
    --     if (entry ~= nil) then
    --       local kind = entry:get_kind()
    --       if (kind == 9) then
    --         local lsp_params = vim.lsp.util.make_position_params(0, self.client.offset_encoding)
    --         lsp_params.context = {}
    --         lsp_params.context.triggerKind = params.completion_context.triggerKind
    --         lsp_params.context.triggerCharacter = params.completion_context.triggerCharacter
    --
    --         local module_name = entry:get_label()
    --         local some_file = io.open('./test', 'w+b')
    --         if (some_file ~= nil) then
    --           some_file:write('  - ' .. vim.inspect(module_name) .. '\n')
    --           some_file:close()
    --         end
    --       end
    --
    --     end
    --   end)
    -- end

    cmp.setup({
      completion = {
        completeopt = 'menu,menuone,preview,noselect',
      },

      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end
      },

      sorting = {
        comparators = {
          function (entry1, entry2)
            local kind1 = kind_mapper[entry1:get_kind()]
            local kind2 = kind_mapper[entry2:get_kind()]
            if kind1 < kind2 then
              return true
            end
          end,
        }
      },

      mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
        ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(), -- show completion suggestions
        ['<C-e>'] = cmp.mapping.abort(), -- close completion window
        ['<CR>'] = cmp.mapping.confirm({ select = false })
      }),

      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- snippets
        { name = 'buffer' }, -- text within current buffer
        { name = 'path' } -- file system paths
      }),

      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = '...'
        })
      }
    })
  end
}
