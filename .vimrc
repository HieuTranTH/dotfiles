" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" TODO: Load plugins here (pathogen or vundle)

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" TODO: Pick a leader key
" let mapleader = ","

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
" This below line is not good, because it will be overrided anyway when vim
" load filetype setting
set formatoptions=tcqrn1
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
noremap j gj
noremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap annoying F1 help key.
" Put Vim in fullscreen (only work in Mac)
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting in paragraph
map <leader>q gqip

" Toggle expandtab and autoindent (i.e. formatting will align with first line)
map <leader>t :set expandtab! autoindent!<CR>

" Toggle hybrid line number on/off
map <leader>n :set number! relativenumber!<CR>

" Toggling selecting with mouse mode (toggle line number and listchar)
map <leader>s :set number! relativenumber! list!<CR>

" Toggling cursorline and cursorcolumn
map <leader>c :set cursorline! cursorcolumn!<CR>

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

" Map creating a new vertical window keybind
map <C-W>N :vnew<CR>

" Bubling text, moving selected text up and down
" http://vimcasts.org/episodes/bubbling-text/
" Bubble single lines
nmap <leader><Up> ddkP
nmap <leader><Down> ddp
" Bubble multiple lines
vmap <leader><Up> xkP`[V`]
vmap <leader><Down> xp`[V`]

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
"let g:molokai_original = 1
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
highlight SpellBad cterm=reverse ctermbg=white ctermfg=red

" Show syntax highlighting groups for word under cursor (Ctrl-Shift-p)-Not use
" http://vimcasts.org/episodes/creating-colorschemes-for-vim/
" nmap <C-S-P> :call <SID>SynStack()<CR>
" function! <SID>SynStack()
"   if !exists("*synstack")
"     return
"   endif
"   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
" endfunc

" Save folds when exit and restore when open again (.c files only)
" Not using now, might enable later if needed
" autocmd BufWinLeave *.c mkview
" autocmd BufWinEnter *.c silent loadview

" Settings for netrw File Explorer (tree style listing, open files in a new tab, set width to 25% of the page)
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_winsize = 25
" Auto have :Vexplorer with all Vim windows (should have a dedicated tab for
" Explorer)
" augroup ProjectDrawer
"     autocmd!
"     autocmd VimEnter * :Vexplore
" augroup END

" Set tab widths of 8 spaces for C source codes
autocmd Filetype c setlocal tabstop=8 shiftwidth=8 softtabstop=8 expandtab

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

"##############################################################################
" End of Hieu's custom Configurations
"##############################################################################
