-- yank the first changed file to the '1' register
vim.cmd('/Changes to be committed')
vim.cmd.normal('jf:w"1y$1G')
