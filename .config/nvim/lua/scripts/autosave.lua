-- Run commands when a file is save (BufWritePost) then write output to another buffer

-- bufnr to write commands output
local bufnr = 8

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("HieuAutoSave", { clear = true}),
  pattern = "main.go",
  callback = function()
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "output of: main.go" })
    vim.fn.jobstart({"go", "run", "main.go"}, {
      stdout_buffered = true,
      on_stdout = funciton(_, data)
        if data then
          vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
        end
      end,
      on_stderr = funciton(_, data)
        if data then
          vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
        end
      end,
    })
  end
})
