vim.o.cursorline = true

-- local buf_name = vim.api.nvim_buf_get_name(0)
-- -- Set this for a vim-fugitive git commit buffer
-- if buf_name:match("^fugitive://") and buf_name:sub(-1) ~= '/' then
--   local buf_name_end = buf_name:match("/([^/]+)$")
--   if buf_name_end:match("^[0-9a-f]+$") ~= nil and #buf_name_end == 40 then
--     vim.o.cursorline = true
--   end
-- end
