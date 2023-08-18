-- Quick fix for 'E5248: Invalid character in group name' with *.tfvars file
-- https://github.com/neovim/neovim/issues/23184
-- TODO: should be fixed after https://github.com/neovim/neovim/pull/24714 is merged
vim.o.filetype = 'terraform'
