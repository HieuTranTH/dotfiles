-- copy the first changed file to the clipboard
vim.cmd('/Changes to be committed')
vim.cmd.normal('jf:wy$1G')
