" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Load plugins here (Plug)
" https://github.com/junegunn/vim-plug
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim', { 'commit': 'dc71692' }
Plug 'tpope/vim-fugitive'
Plug 'hashivim/vim-terraform'
" Initialize plugin system
call plug#end()

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" Reset cursor shape that has been set from .inputrc
let &t_ti .= "\<esc>[2 q"

" Pick space as leader key, default is backslash '\' character
let mapleader = " "

" Security
set modelines=0

" Show hybrid line numbers
set number relativenumber

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
" Use textwidth=79 when writing document
" Disable to bypass autoformatting when textwidth is reached
" set textwidth=79
set textwidth=0
" This below line for setting formatoptions is not good, because it will be
" overrided anyway when vim load filetype setting
set formatoptions=tcrqn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
noremap <expr> j v:count == 0 ? 'gj' : 'j'
noremap <expr> k v:count == 0 ? 'gk' : 'k'

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Allow :find to search down into sub-directories, simple fuzzy-finder
set path+=**

" Allow searching upward in directories for tags file, stop at root
set tags+=tags;/

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader>th :noh<cr> " Toggle search highlight

" Enable mouse
set mouse=a
" Make mouse works in WSL
set ttymouse=sgr

" Remap annoying F1 help key.
" Put Vim in fullscreen (only work in Mac)
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Unmap annoying q: key
" Cannot unmap default Vim key so map it to Noop
map q: <Nop>

" Disable OMNI SQL Completion which interfere with <C-c> key
let g:omni_sql_no_default_maps = 1

" Remap infrequently use Q key
" Use current line as shell command then paste back its output
noremap Q !!$SHELL<CR>

" Formatting in paragraph
map <leader>q gqip

" Toggle expandtab and autoindent (i.e. formatting will align with first line)
map <leader>t :set expandtab! autoindent!<CR>

" Toggle hybrid line number on/off
map <leader>n :set number! relativenumber!<CR>

" Toggling text selecting mode with mouse (toggle line number, listchar, and
" colorcolumn)
map <leader>s :set number! relativenumber! list!<CR>:let &cc = &cc == '' ? '72,80' : ''<CR>

" Git blame current line
nmap <leader>b :exe '!gitblame.sh -C' expand('%:p:h') 'blame -L' . line(".") . ',+1' '' expand('%:t')<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
" Git blame visual selection
vmap <leader>b <ESC>:let RANGE = line("'>") - line("'<") + 1<CR>:exe '!gitblame.sh -C' expand('%:p:h') 'blame -L' . line("'<") . ',+' . RANGE '' expand('%:t')<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" Toggling cursorline and cursorcolumn
map <leader>c :set cursorline! cursorcolumn!<CR>

" Bind scrolling and cursor in all windows
map <leader>m :windo set cursorline! cursorcolumn! scb! crb!<CR>

" Reload all buffers
map <leader>r :checktime<CR>

" Check for missing included files
map <leader>p :checkpath<CR>

" FuzzyFinder binds
" https://github.com/junegunn/fzf.vim#commands
" most stuff are defined in ~/.vim/plugged/fzf.vim/autoload/fzf/vim.vim
" let s:default_action = {
"  \ 'ctrl-t': 'tab split',
"  \ 'ctrl-x': 'split',
"  \ 'ctrl-v': 'vsplit' }
nmap <leader>fo :Files<CR>
nmap <leader>fe :GFiles<CR>
nmap <leader>fb :Buffers<CR>
nmap <leader>fs :GFiles?<CR>
nmap <leader>fg :if executable('rg') \| execute "Rg" \| else \| execute "RGgrep" \| endif<CR>
nmap <leader>ff :Lines<CR>
nmap <leader>f/ :BLines<CR>
nmap <leader>ft :Tags<CR>
nmap <leader>fc :Commands<CR>
nmap <leader>fm :Marks<CR>
nmap <leader>fw :Windows<CR>
nmap <leader>fl :Locate 
nmap <leader>fh :History<CR>
let g:fzf_buffers_jump = 1

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Map tabnext and tabprev to CTRL-J, CTRL-K in Normal Mode
nnoremap <C-J> gT
nnoremap <C-K> gt

" Map tabm -1 and tabm +1
nnoremap <leader><Left> :tabm -1<CR>
nnoremap <leader><Right> :tabm +1<CR>

" Map creating a new vertical/horizontal window keybind
map <C-W>N :vnew<CR>:Buffers<CR>
map <C-W>n :new<CR>:Buffers<CR>
" Zoom in the current window by creating a new tab and open that window's
" buffer, similar to CTRL-W_T but do not close the original window
map <leader>o :let current_buffer = bufnr("%")<CR>:let current_line = line('.')<CR>:tabe<CR>:execute "buffer " current_buffer<CR>:execute current_line<CR>

" Bubling text, moving selected text up and down
" http://vimcasts.org/episodes/bubbling-text/
" Bubble single lines
nmap <leader><Up> ddkP
nmap <leader><Down> ddp
" Bubble multiple lines
vmap <leader><Up> xkP`[V`]
vmap <leader><Down> xp`[V`]

" Mappings for GNU like (bash, emacs,...) readline navigations in command mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap b <S-Left>
cnoremap f <S-Right>

" Map * to search for visually selected text
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>

" Binds for modifying a list of Jira tickets
" join lines
vnoremap <leader>jj <ESC>:'<,'>sort!<CR>:'<,'>s/\n/, /g<CR>:let @/=''<CR>$xx
" split line
vnoremap <leader>js <ESC>:'<,'>s/, /\r/g<CR>

" New splits spawn below and right
set splitbelow splitright
" Remove pipe characters that act as seperators on vertical splits
set fillchars+=vert:\ 

" Color scheme (terminal)
set t_Co=256
set background=dark
" set background=light
let g:solarized_termcolors=256
" set transparency to true -> disable background color
let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
" colorscheme solarized

" Uncomment these to use molokai colorscheme
colorscheme molokai

"##############################################################################
" Start of Hieu's custom Configurations
"##############################################################################

" highlight current line
"set cursorline
" highlight current column
"set cursorcolumn
" display right margin (72 for git commit message, 80 for normal source code)
set colorcolumn=72,80

" open completion menu on statusline
set wildmenu
" Bash-like completion
set wildmenu wildmode=longest,list,full
" set wildmenu wildmode=longest:full,full

" Customized statusline
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':' no-git-repo '
endfunction

function! TotalBuffer()
  return len(getbufinfo({'buflisted':1}))
endfunction

set statusline=
" set statusline+=BUFFER:\ %n\ /\ 
" Next line show current buffer number (obsolete)
" set statusline+=%n\ /\ 
set statusline+=%{TotalBuffer()}
set statusline+=\ buf(s)\ \|
"set statusline+=%#PmenuSel#
"set statusline+=%{StatuslineGit()}
"set statusline+=%#LineNr#
"set statusline+=%#StatusLine#
set statusline+=%#Todo#
set statusline+=\ %f
set statusline+=%*
set statusline+=%m
set statusline+=%r
set statusline+=%=
" set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ [%l/%L]\ :%c
set statusline+=\ 
" End of customized statusline

" Highlight trailing whitespaces in red
highlight ExtraWhitespace ctermbg=red guibg=red
" :match command only applies to the current window. So any :split or :tabe
" won't inherit the highlighting. Next line fix it.
autocmd VimEnter,WinEnter * match ExtraWhitespace /\s\+$/

" Set spell check to F6
map <F6> :setlocal spell! spelllang=en_us<CR>

" Fix SpellBad highlight group not visible with Solarized colorscheme
" It is a VIM bug
" https://github.com/altercation/vim-colors-solarized/issues/195
" cterm=reverse makes SpellBad higher priority than CursorLine so it is more
" visible when mouse is over the line
" enable if using colorscheme solarized
" highlight SpellBad cterm=reverse ctermbg=white ctermfg=red

" Show syntax highlighting groups for word under cursor (Ctrl-Shift-p)-Not use
" http://vimcasts.org/episodes/creating-colorschemes-for-vim/
" nmap <C-S-P> :call <SID>SynStack()<CR>
" function! <SID>SynStack()
"   if !exists("*synstack")
"     return
"   endif
"   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
" endfunc

" Function to check if there is a view file of the current file
" Deriving from https://stackoverflow.com/a/28460676
function! MyViewCheck()
    let path = fnamemodify(bufname('%'),':p')
    " vim's odd =~ escaping for /
    let path = substitute(path, '=', '==', 'g')
    if empty($HOME)
    else
        let path = substitute(path, '^'.$HOME, '\~', '')
    endif
    let path = substitute(path, '/', '=+', 'g') . '='
    " view directory
    let path = &viewdir.'/'.path
    if !empty(glob(path))
        return 1
    endif
    return 0
endfunction
" # Command Viewcheck (and it's abbreviation 'viewcheck')
"command Viewcheck call MyViewCheck()
" Lower-case user commands: http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
"cabbrev viewcheck <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Viewcheck' : 'viewcheck')<CR>
" Automatically load/save view file if it currently exists
autocmd BufWinLeave * if MyViewCheck() | mkview | endif
autocmd BufWinEnter * if MyViewCheck() | silent loadview | endif

" Settings for netrw File Explorer (long listing, open files in a new
" tab, set width to 25% of the page, open split to the right)
let g:netrw_liststyle = 1
"let g:netrw_browse_split = 3
let g:netrw_winsize = 75
let g:netrw_altv = 1
" Auto have :Vexplorer with all Vim windows (should have a dedicated tab for
" Explorer)
" augroup ProjectDrawer
"     autocmd!
"     autocmd VimEnter * :Vexplore
" augroup END

" Use Ch syntax for *.h files
let ch_syntax_for_h = 1
" Set tab widths of 8 spaces for C source codes, use tab character for
" indentation. This is following Linux Kernel coding style guidelines.
autocmd Filetype c,ch setlocal tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab
" Set tab widths of 2 spaces for yaml files
autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 indentkeys-=0#
autocmd BufNewFile,BufRead Dockerfile.* setfiletype dockerfile

" Customize tabline to show tab numbers and better highlighting
" https://www.reddit.com/r/vim/comments/22ala7/vim_custom_tabline/
set showtabline=2               "always show tab line

if exists("+showtabline")

" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)

function! MyTabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
        let buflist = tabpagebuflist(i)
        let winnr = tabpagewinnr(i)
        let s .= '%' . i . 'T'
        let s .= (i == t ? '%1*' : '%2*')

        " let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
        " let s .= ' '
        let s .= (i == t ? '%#TabNumSel#' : '%#TabNum#')
        let s .= ' ' . i . ' '
        let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')

        let bufnr = buflist[winnr - 1]
        let file = bufname(bufnr)
        let buftype = getbufvar(bufnr, '&buftype')

        if buftype == 'help'
            let file = 'help:' . fnamemodify(file, ':t:r')

        elseif buftype == 'quickfix'
            let file = 'quickfix'

        elseif buftype == 'nofile'
            if file =~ '\/.'
                let file = substitute(file, '.*\/\ze.', '', '')
            endif

        else
            let file = pathshorten(fnamemodify(file, ':p:~:.'))
            if getbufvar(bufnr, '&modified')
                let file = '+' . file
            endif

        endif

        if file == ''
            let file = '[No Name]'
        endif

        let s .= ' ' . file

        let nwins = tabpagewinnr(i, '$')
        if nwins > 1
            let modified = ''
            for b in buflist
                if getbufvar(b, '&modified') && b != bufnr
                    let modified = '*'
                    break
                endif
            endfor
            let hl = (i == t ? '%#WinNumSel#' : '%#WinNum#')
            let nohl = (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let s .= ' ' . modified . '(' . hl . winnr . nohl . '/' . nwins . ')'
        endif

        if i < tabpagenr('$')
            let s .= ' %#TabLine#|'
        else
            let s .= ' '
        endif

        let i = i + 1

    endwhile

    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
endfunction

" set showtabline=1
highlight! TabNum term=bold,underline cterm=bold,underline ctermfg=1 ctermbg=7 gui=bold,underline guibg=LightGrey
highlight! TabNumSel term=bold,reverse cterm=bold,reverse ctermfg=1 ctermbg=7 gui=bold
highlight! WinNum term=bold,underline cterm=bold,underline ctermfg=11 ctermbg=7 guifg=DarkBlue guibg=LightGrey
highlight! WinNumSel term=bold cterm=bold ctermfg=7 ctermbg=14 guifg=DarkBlue guibg=LightGrey

set tabline=%!MyTabLine()

endif " exists("+showtabline")

" Delete all empty and no unsaved changes buffers
function! DeleteEmptyBuffers()
    let [i, n; empty] = [1, bufnr('$')]
    while i <= n
        if bufexists(i) && bufname(i) == ''
            call add(empty, i)
        endif
        let i += 1
    endwhile
    if len(empty) > 0
        exe 'bdelete' join(empty)
    endif
endfunction
map <leader>e :call DeleteEmptyBuffers()<CR>

" Create fold around parenthesis, brackets; or toggle fold at cursor
function! FoldCreateToggle()
    if foldlevel(line(".")) > 0
        exe 'normal za'
    else
        if !MyViewCheck()
            exe 'mkview'
        endif
        exe 'normal zf%'
    endif
endfunction
map <leader>z :call FoldCreateToggle()<CR>
"##############################################################################
" End of Hieu's custom Configurations
"##############################################################################
