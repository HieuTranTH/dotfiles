-- Quick fix for 'E5248: Invalid character in group name' with *.tfvars file
-- https://github.com/neovim/neovim/issues/23184
-- TODO: should be fixed after https://github.com/neovim/neovim/pull/24714 is merged. It'll be in the next release (0.9.5 or 0.10.0, whichever comes first)
vim.o.filetype = 'terraform'
