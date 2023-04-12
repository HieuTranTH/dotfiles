-- [[ Setting options ]]
-- See `:help vim.o`

-- Show hybrid line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Might need these settings (back port from .vimrc)
--[[ vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true ]]

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { timeout = 300 }
  end,
  group = highlight_group,
  pattern = '*',
})

-- Minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 3

-- Use % to jump between pairs
vim.o.matchpairs = vim.o.matchpairs .. ',<:>'

-- Briefly jump to matching bracket when inserting
vim.o.showmatch = true

-- Allow hidden buffers
vim.o.hidden = true

-- Visualize tabs and newlines
vim.o.listchars = vim.o.listchars .. ',eol:\\u00ac' -- show '¬' at eol
vim.o.list = true

-- New splits spawn below and right
vim.o.splitbelow = true
vim.o.splitright = true

-- display right margin (72 for git commit message, 80 for normal source code)
vim.o.colorcolumn = '72,80'

-- open completion menu on statusline
vim.o.wildmenu = true
-- Bash-like completion
vim.o.wildmode = 'longest,list,full'

-- Highlight trailing whitespaces in red, neovim no longer distinguish between cterm and gui
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = 'Red' })
-- :match command only applies to the current window. So any :split or :tabe
-- won't inherit the highlighting. Next line fix it.
vim.api.nvim_create_autocmd(
  {"VimEnter", "WinEnter"},
  {
    pattern = "*",
    -- Using double bracketed string to avoid escaping backslashes in lua regex
    command = [[match ExtraWhitespace /\s\+$/]],
  }
)

-- Function to check if there is a view file of the current file
-- Deriving from https://stackoverflow.com/a/28460676
local MyViewCheck = function()
  local path = vim.api.nvim_buf_get_name(0)
  -- vim's odd =~ escaping for /
  path = string.gsub(path, '=', '==')
  if (vim.env.HOME ~= nil or vim.env.HOME ~= '') then
    path = string.gsub(path, '^' .. vim.env.HOME, '~')
  end
  path = string.gsub(path, '/', '=+') .. '='
  path = vim.fn.stdpath 'state' .. '/view/' .. path

  if vim.fn.glob(path) ~= '' then
    return 1
  end
  return 0
end

-- Automatically load/save view file if it currently exists
vim.api.nvim_create_autocmd(
  {"BufWinEnter"},
  {
    pattern = {"*"},
    callback = function()
      if MyViewCheck() == 1 then
        vim.cmd.loadview()
      end
    end
  }
)
vim.api.nvim_create_autocmd(
  {"BufWinLeave"},
  {
    pattern = {"*"},
    callback = function()
      if MyViewCheck() == 1 then
        vim.cmd.mkview()
      end
    end
  }
)

--[[ vim.cmd.colorscheme 'molokai'
vim.api.nvim_set_hl(0, 'Normal', { bg = 'None' }) ]]
