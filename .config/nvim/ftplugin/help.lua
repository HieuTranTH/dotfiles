--[[ -- Open help in ZenMode and press q to exit
vim.cmd.ZenMode()
vim.cmd.normal('zt')
-- :bd to make sure opening the same file again will rerun this script
vim.keymap.set('n', 'q', ':ZenMode<CR>:bd<CR>', { buffer = 0, desc = "[Q]uit help in ZenMode", silent = true}) ]]
