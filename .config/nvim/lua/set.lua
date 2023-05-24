-- [[ Setting options ]]
-- See `:help vim.o`

-- Always block cursor
vim.o.guicursor = "a:block"

-- Show hybrid line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Default indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

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

-- Minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 8

-- Use % to jump between pairs
vim.opt.matchpairs:append { '<:>' }

-- Briefly jump to matching bracket when inserting
vim.o.showmatch = true

-- Allow hidden buffers
vim.o.hidden = true

-- Visualize tabs and newlines
vim.opt.listchars:append { eol = '\\u00ac' } -- show '¬' at eol
vim.o.list = true

-- New splits spawn below and right
vim.o.splitbelow = true
vim.o.splitright = true

-- Keep text on the same screen line for horizontal split
vim.o.splitkeep = 'screen'

-- display right margin (72 for git commit message, 80 for normal source code)
vim.o.colorcolumn = '72,80'

-- open completion menu on statusline
vim.o.wildmenu = true
-- Bash-like completion
vim.o.wildmode = 'longest,list,full'

-- Spell check languages
vim.opt.spelllang = { 'en_us' }

-- Highlight trailing whitespaces in red, neovim no longer distinguish between cterm and gui
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = 'Red' })
-- :match command only applies to the current window. So any :split or :tabe
-- won't inherit the highlighting. Next line fix it.
vim.api.nvim_create_autocmd(
  {"VimEnter", "WinEnter"},
  {
    pattern = "*",
    callback = function()
      -- Only enable the highlight for non-floating windows
      if vim.api.nvim_win_get_config(0).relative == '' then
        -- Using double bracketed string to avoid escaping backslashes in lua regex
        vim.cmd [[match ExtraWhitespace /\s\+$/]]
      end
    end
  }
)
-- Highlight QuickFixLine
vim.api.nvim_set_hl(0, 'QuickFixLine', { bg = 'Red' })

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

-- Function to check if there is a view file of the current file
-- Deriving from https://stackoverflow.com/a/28460676
local MyViewCheck = function()
  local path = vim.api.nvim_buf_get_name(0)
  -- vim's odd =~ escaping for /
  path = string.gsub(path, '=', '==')
  if (vim.env.HOME ~= nil and vim.env.HOME ~= '') then
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

-- Jump to the last place in the file before exiting
-- vim.api.nvim_create_autocmd('BufReadPost', {
--   callback = function(data)
--     local last_pos = vim.api.nvim_buf_get_mark(data.buf, '"')
--     if last_pos[1] > 0 and last_pos[1] <= vim.api.nvim_buf_line_count(data.buf) then
--       vim.api.nvim_win_set_cursor(0, last_pos)
--       vim.cmd.normal('zz')
--     end
--   end,
-- })

-- Remove useless stuff from the terminal window and enter INSERT mode
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function(data)
    -- if not using FTerm.nvim plugin
    if not string.find(vim.bo[data.buf].filetype, '^[fF][tT]erm') then
      vim.api.nvim_set_option_value('number', false, { scope = 'local' })
      vim.api.nvim_set_option_value('relativenumber', false, { scope = 'local' })
      vim.api.nvim_set_option_value('signcolumn', 'no', { scope = 'local' })
      vim.api.nvim_command('startinsert')
    end
  end,
})

--[[ vim.cmd.colorscheme 'molokai'
vim.api.nvim_set_hl(0, 'Normal', { bg = 'None' }) ]]

-- vim.filetype.add({
--   extension = {
--     tfvars = 'terraform',
--   },
-- })
