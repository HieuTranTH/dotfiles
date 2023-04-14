-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- Remap annoying F1 help key.
vim.keymap.set({ 'n', 'v', 'i' }, '<F1>', '<Nop>', { silent = true })
-- Unmap annoying q: key. Only disable if typing q: quickly
vim.keymap.set('', 'q:', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Half page scrolls stay in middle, preventing disorienting
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
-- Search jumps also stay in middle
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "[E]Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = "Open diagnostics [Q]uickfix list" })
-- Remap infrequently use Q key
-- Use current line as shell command then paste back its output
vim.keymap.set('', 'Q', '!!$SHELL<CR>', { desc = "Use current line as shell command then paste back its output" })

-- Tabs and Windows
vim.keymap.set('n', '<C-j>', 'gT', { desc = ":tabprev" })
vim.keymap.set('n', '<C-k>', 'gt', { desc = ":tabnext" })
-- Map tabm -1 and tabm +1
vim.keymap.set('n', '<leader><Left>', ':tabm -1<CR>', { desc = ":tabmove -1", silent = true })
vim.keymap.set('n', '<leader><Right>', ':tabm +1<CR>', { desc = ":tabmove +1", silent = true })
-- Map creating a new vertical/horizontal window keybind
vim.keymap.set('', '<C-w>n', ':new<CR>:Telescope buffers<CR>', { desc = "New horizontal window", silent = true })
vim.keymap.set('', '<C-w>N', ':vnew<CR>:Telescope buffers<CR>', { desc = "New vertical window" , silent = true })
-- Move to next/prev entry in quickfix list
vim.keymap.set('n', '<leader>n', ':cn<CR>', { desc = "Next in quickfix list", silent = true })
vim.keymap.set('n', '<leader>N', ':cN<CR>', { desc = "Prev in quickfix list", silent = true })
-- Reload all buffers
vim.keymap.set('n', '<leader>l', ':checktime<CR>', { desc = "Re[L]oad all buffers"})

-- Formatting in paragraph
vim.keymap.set('', '<leader>f', 'gqip', { desc = "[F]ormat a paragraph" })

-- Toggling settings
-- Toggle expandtab and autoindent (i.e. formatting will align with first line)
vim.keymap.set('n', '<leader>tt', ':set expandtab! autoindent!<CR>', { desc = "[T]oggle expand[T]ab autoindent" })
-- Toggle hybrid line number on/off
vim.keymap.set('n', '<leader>tn', ':set number! relativenumber!<CR>', { desc = "[T]oggle hybrid line [N]umber" })
-- Toggling cursorline and cursorcolumn
vim.keymap.set('n', '<leader>tc', ':set cursorline! cursorcolumn!<CR>', { desc = "[T]oggle [C]ursorline cursorcolumn" })
-- Bind scrolling and cursor in all windows
vim.keymap.set('n', '<leader>ts', ':windo set cursorline! cursorcolumn! scb! crb!<CR>', { desc = "[T]Bind [S]crolling in all windows" })
-- Or use your leader key + l to toggle on/off
vim.keymap.set('n', '<leader>tl', ':set list!<CR>', { desc = "[T]oggle [L]istchars" })

-- Zenmode
vim.keymap.set('n', '<leader>o', ':ZenMode<CR>:<Esc>', { desc = "Zenmode", silent = true })
-- Clear search highlight
vim.keymap.set('n', '<leader><space>', ':noh<CR>', { desc = "Clear search highlight", silent = true })

-- Bubble multiple lines
vim.keymap.set('v', '<leader><Up>',  ":m '<-2<CR>gv=gv", { desc = "Bubbling lines move down" })
vim.keymap.set('v', '<leader><Down>', ":m '>+1<CR>gv=gv", { desc = "Bubbling lines move up" })

-- Join lines
vim.keymap.set({'n', 'v'}, 'J', 'J_', { desc = "Join lines but keep the cursor at front" })

-- Paste over a visual still keep the last copy text in default register
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = "[P]aste in visual keep unnamed register" })

-- Mappings for GNU like (bash, emacs,...) readline navigations in command mode
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-e>', '<End>')
vim.keymap.set('c', '<C-p>', '<Up>')
vim.keymap.set('c', '<C-n>', '<Down>')
vim.keymap.set('c', '<C-b>', '<Left>')
vim.keymap.set('c', '<C-f>', '<Right>')
vim.keymap.set('c', '<M-b>', '<S-Left>')
vim.keymap.set('c', '<M-f>', '<S-Right>')

-- Escape to Normal mode from Terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = "Escape Terminal mode" })
