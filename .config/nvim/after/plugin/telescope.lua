-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#change-directory
local actions = require "telescope.actions"
local action_layout = require("telescope.actions.layout")
require('telescope').setup {
  defaults = {
    mappings = {
      n = {
        ["<M-p>"] = action_layout.toggle_preview,
      },
      i = {
        ["<M-p>"] = action_layout.toggle_preview,
        -- for git_commits and git_bcommits
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
      },
    },
  },
  pickers = {
    buffers = {
      mappings = {
        i = {
          ["<c-w>"] = actions.delete_buffer + actions.move_to_top,
        }
      }
    }
  }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, { desc = 'Find existing [B]uffers' })

vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>sb', function()
    require('telescope.builtin').live_grep {
      grep_open_files=true
    }
end, { desc = '[S]earch opened [B]uffers' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })

vim.keymap.set('n', '<leader>st', require('telescope.builtin').git_files, { desc = '[S]earch git [T]racked files' })
-- Find files from project git root with fallback
-- We cache the results of "git rev-parse"
-- Process creation is expensive in Windows, so this reduces latency
local git_work_tree = {}
local file_pickers_opts = function()
  local opts = {}
  local cwd = vim.fn.getcwd()
  if git_work_tree[cwd] == nil then
    -- :sub(0,-2) for removing the last newline character from the shell command output
    git_work_tree[cwd] = vim.fn.system('git rev-parse --show-superproject-working-tree --show-toplevel | head -1'):sub(0,-2)
  end
  if not string.find(git_work_tree[cwd], '^fatal: not a git repository') then
    opts = {
      cwd = git_work_tree[cwd]
    }
  end
  return opts
end
local find_files_from_project_git_root = function()
  require("telescope.builtin").find_files(file_pickers_opts())
end
vim.keymap.set('n', '<leader>sf', find_files_from_project_git_root, { desc = '[S]earch [F]iles' })
-- Live grep from project git root with fallback
local live_grep_from_project_git_root = function()
  require("telescope.builtin").live_grep(file_pickers_opts())
end
vim.keymap.set('n', '<leader>sg', live_grep_from_project_git_root, { desc = '[S]earch by [G]rep' })
