vim.api.nvim_create_user_command('GenAzDoGitLink', function(t)
    local remote_url = vim.fn.system('git remote -v | head -1 | sed "s|^origin\tgit@ssh.dev.azure.com:v3/||g;s| (fetch)$||g"')
    if string.find(remote_url, '^fatal: not a git repository') then
      print(remote_url)
      return
    end

    local i, j = string.find(remote_url, '/.*$')
    local azdo_org = string.sub(remote_url, 0, i-1)
    remote_url = string.sub(remote_url, i+1)
    i, j = string.find(remote_url, '/.*$')
    local azdo_prj = string.sub(remote_url, 0, i-1)
    local azdo_repo = string.sub(remote_url, i+1, j-1)

    local file_path = vim.fn.system('git ls-files --full-name ' .. vim.api.nvim_buf_get_name(0))
    file_path = string.gsub(file_path, "\n$", "")

    local lstart, cstart, lend, cend
    if t.range == 0 then
      local start = vim.fn.getpos('v') -- [bufnum, lnum, col, off]
      lstart = start[2]
      cstart = start[3]
      local _end = vim.fn.getpos('.') -- [bufnum, lnum, col, off]
      lend = _end[2]
      cend = _end[3]
    else
      local start = vim.fn.getpos("'<") -- [bufnum, lnum, col, off]
      lstart = start[2]
      cstart = start[3]
      local _end = vim.fn.getpos("'>") -- [bufnum, lnum, col, off]
      lend = _end[2]
      cend = _end[3]
    end

    local link = "https://dev.azure.com/" .. azdo_org .. "/" .. azdo_prj
      .. "/_git/" .. azdo_repo .. "?path=/" .. file_path
      .. "&line=" .. lstart .. "&lineEnd=" .. lend
      .. "&lineStartColumn=" .. cstart .. "&lineEndColumn=" .. cend
      .. "&lineStyle=plain&_a=contents"

    vim.fn.setreg('+', link)
    print("AzDo repo link copied to clipboard")
  end
  , {range = true})
