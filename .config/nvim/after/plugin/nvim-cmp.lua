-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

local mapping_insert = cmp.mapping.preset.insert {
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
}
local mapping_cmdline = cmp.mapping.preset.cmdline {
  ['<C-n>'] = function()
    vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
  end,
  ['<C-p>'] = function()
    vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
  end,
}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- Default mappings are in "~/.local/share/nvim/lazy/nvim-cmp/lua/cmp/config/mapping.lua"
  mapping = mapping_insert,
  sources = {
    { name = 'luasnip' },
    {
      name = 'buffer',
      option = {
        -- Get words from all opened buffers
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      }
    },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'path' },
    { name = 'nvim_lua' },
  },
  formatting = {
    format = function(entry, vim_item)
      -- Add source name to menu
      vim_item.menu = "[" .. entry.source.name .. "]"
      return vim_item
    end
  },
}

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = mapping_cmdline,
  sources = {
    { name = 'buffer' },
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- FIXME: a weird bug that nvim-cmp cannot iterate in ':s/' command
-- https://github.com/hrsh7th/cmp-cmdline/issues/92
cmp.setup.cmdline(':', {
  mapping = mapping_cmdline,
  -- mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }, {
    { name = 'buffer' },
  })
})
