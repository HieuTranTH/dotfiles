-- yank the first changed file to the '1' register
if string.find(vim.api.nvim_buf_get_name(0), 'COMMIT_EDITMSG$') then
  vim.cmd('/Changes to be committed')
  vim.cmd.normal('jf:w"1y$1G')
end
