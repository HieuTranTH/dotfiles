-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- vim.keymap.set('', '', '', { desc = "" })

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- Remap annoying F1 help key.
vim.keymap.set({ 'n', 'v', 'i' }, '<F1>', '<Nop>', { silent = true })
-- Unmap annoying q: key. Only disable if typing q: quickly
vim.keymap.set('', 'q:', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
-- Remap infrequently use Q key
-- Use current line as shell command then paste back its output
vim.keymap.set('', 'Q', '!!$SHELL<CR>', { desc = "Use current line as shell command then paste back its output" })

-- Tabs and Windows
vim.keymap.set('n', '<C-J>', 'gT', { desc = ":tabprev" })
vim.keymap.set('n', '<C-K>', 'gt', { desc = ":tabnext" })
-- Map tabm -1 and tabm +1
vim.keymap.set('n', '<leader><Left>', ':tabm -1<CR>', { desc = ":tabmove -1", silent = true })
vim.keymap.set('n', '<leader><Right>', ':tabm +1<CR>', { desc = ":tabmove +1", silent = true })
-- Map creating a new vertical/horizontal window keybind
vim.keymap.set('', '<C-W>N', ':vnew<CR>:Telescope buffers<CR>', { desc = "New vertical window" , silent = true })
vim.keymap.set('', '<C-W>n', ':new<CR>:Telescope buffers<CR>', { desc = "New horizontal window", silent = true  })

-- Formatting in paragraph
vim.keymap.set('', '<leader>q', 'gqip', { desc = "Format a paragraph" })

-- Toggling settings
-- Toggle expandtab and autoindent (i.e. formatting will align with first line)
vim.keymap.set('n', '<leader>tt', ':set expandtab! autoindent!<CR>', { desc = "Toggle expandtab autoindent" })
-- Toggle hybrid line number on/off
vim.keymap.set('n', '<leader>tn', ':set number! relativenumber!<CR>', { desc = "Toggle hybrid line number" })
-- Toggling cursorline and cursorcolumn
vim.keymap.set('n', '<leader>tc', ':set cursorline! cursorcolumn!<CR>', { desc = "Toggle cursorline cursorcolumn" })
-- Bind scrolling and cursor in all windows
vim.keymap.set('n', '<leader>ts', ':windo set cursorline! cursorcolumn! scb! crb!<CR>', { desc = "Bind scrolling in all windows" })
-- Or use your leader key + l to toggle on/off
vim.keymap.set('n', '<leader>ts', ':set list!<CR>', { desc = "Toggle listchars" })

-- Zenmode
vim.keymap.set('n', '<leader>o', ':ZenMode<CR>', { desc = "Toggle Zenmode" })
-- Clear search highlight
vim.keymap.set('n', '<leader><space>', ':noh<CR>', { desc = "Clear search highlight", silent = true })

-- Bubling text, moving selected text up and down
-- http://vimcasts.org/episodes/bubbling-text/
-- Bubble single lines
vim.keymap.set('n', '<leader><Up>', 'ddkP', { desc = "Bubbling line move up" })
vim.keymap.set('n', '<leader><Down>', 'ddp', { desc = "Bubbling line move down" })
-- Bubble multiple lines
vim.keymap.set('v', '<leader><Up>', 'xkP`[V`]', { desc = "Bubbling lines move up" })
vim.keymap.set('v', '<leader><Down>', 'xp`[V`]', { desc = "Bubbling lines move down" })

-- Mappings for GNU like (bash, emacs,...) readline navigations in command mode
vim.keymap.set('c', '<C-A>', '<Home>')
vim.keymap.set('c', '<C-E>', '<End>')
vim.keymap.set('c', '<C-P>', '<Up>')
vim.keymap.set('c', '<C-N>', '<Down>')
vim.keymap.set('c', '<C-B>', '<Left>')
vim.keymap.set('c', '<C-F>', '<Right>')
vim.keymap.set('c', '<M-b>', '<S-Left>')
vim.keymap.set('c', '<M-f>', '<S-Right>')

-- Escape to Normal mode from Terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = "Escape Terminal mode" })
