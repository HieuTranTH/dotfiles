-- Open help in ZenMode and press q to exit
vim.cmd.ZenMode()
vim.keymap.set('n', 'q', ':q<CR>:q<CR>', { buffer = 0, desc = "[Q]uit help in ZenMode", silent = true})
