require('onedark').setup  {
  style = 'cool',
  transparent = true,  -- Show/hide background
}

-- colorscheme onedark
require('onedark').load()

-- Brighter visual selection
vim.api.nvim_set_hl(0, 'Visual', { bg = '#4a4f62' })
