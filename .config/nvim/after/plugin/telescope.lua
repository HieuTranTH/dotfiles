-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#change-directory
local actions = require "telescope.actions"
local action_layout = require("telescope.actions.layout")
require('telescope').setup {
  defaults = {
    layout_strategy = 'flex',
    layout_config = {
      flex = {
        flip_columns = 200,
      }
    },
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
          ["<c-j>"] = function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local dir = vim.fn.fnamemodify(selection.filename, ":p:h")
            -- Depending on what you want put `cd`, `lcd`, `tcd`
            vim.cmd(string.format("silent cd %s", dir))
            require("notify")(dir, nil, { title = "Change directory" })
            -- Hack to refresh the results pane
            require("telescope.actions").close(prompt_bufnr)
            require('telescope.builtin').buffers()
          end,
          ["<c-w>"] = actions.delete_buffer + actions.move_to_top,
        }
      }
    },
    find_files = {
      mappings = {
        i = {
          ["<c-j>"] = function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
            -- Depending on what you want put `cd`, `lcd`, `tcd`
            vim.cmd(string.format("silent cd %s", dir))
            require("notify")(dir, nil, { title = "Change directory" })
          end
        },
      },
    },
  }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').builtin, { desc = '[S]earch all Telescope [P]ickers' })
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>sb', function()
    require('telescope.builtin').live_grep {
      grep_open_files=true
    }
end, { desc = '[S]earch opened [B]uffers' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>st', require('telescope.builtin').git_files, { desc = '[S]earch git [T]racked files' })

-- Find files from project git root with fallback
-- We cache the results of "git rev-parse"
-- Process creation is expensive in Windows, so this reduces latency
local git_work_tree = {}
local file_pickers_project_opts = function(prompt, opts)
  local project_opts = {}
  local cwd = vim.fn.getcwd()
  if git_work_tree[cwd] == nil then
    -- :sub(0,-2) for removing the last newline character from the shell command output
    git_work_tree[cwd] = vim.fn.system('git rev-parse --show-superproject-working-tree --show-toplevel 2> /dev/null | head -1'):sub(0,-2)
  end
  if git_work_tree[cwd] ~= '' then
    project_opts = {
      cwd = git_work_tree[cwd],
      prompt_title = prompt .. ' (Project)'
    }
  end
  return vim.tbl_deep_extend("force", opts, project_opts)
end
local find_files_from_project_git_root = function()
  require("telescope.builtin").find_files(file_pickers_project_opts('Find Files', {}))
end
vim.keymap.set('n', '<leader>sfp', find_files_from_project_git_root, { desc = '[S]earch [F]iles in [P]roject' })
-- Live grep from project git root with fallback
local live_grep_from_project_git_root = function()
  require("telescope.builtin").live_grep(file_pickers_project_opts('Live Grep', {}))
end
vim.keymap.set('n', '<leader>sgp', live_grep_from_project_git_root, { desc = '[S]earch by [G]rep in [P]roject' })

vim.api.nvim_create_user_command('GrepMatchingFiles', function(patterns)
  local pat_list = {}
  for p in patterns.args:gmatch("%S+") do
    table.insert(pat_list,p)
  end
  require("telescope.builtin").live_grep(file_pickers_project_opts('Live Grep', { glob_pattern = pat_list }))
end, {nargs = '*'})
vim.keymap.set('n', '<leader>sgf', ':GrepMatchingFiles ', { desc = '[S]earch by [G]rep in [F]iles' })


-- Prefer these commands in fzf.vim over Telescope
vim.keymap.set('n', '<leader>b', ':FZFBuffers<CR>', { desc = 'Find [B]uffer' })
vim.keymap.set('n', '<leader>w', ':FZFWindows<CR>', { desc = 'Find [W]indow' })
