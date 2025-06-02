if string.find(vim.api.nvim_buf_get_name(0), 'COMMIT_EDITMSG$') then
  -- automatic detect work item number in branch name
  vim.cmd('/On branch')
  local current_line = vim.api.nvim_get_current_line()
  local number = current_line:match("(%d+)")
  if number then
    vim.api.nvim_buf_set_lines(0, 0, 0, false, { "" })
    vim.api.nvim_buf_set_lines(0, 1, 1, false, { "" })
    vim.api.nvim_buf_set_lines(0, 2, 2, false, { "Related work items: #" .. number })
  end

  -- yank the first changed file to the '1' register
  vim.cmd('/Changes to be committed')
  vim.cmd.normal('jf:w"1y$1G')
end
