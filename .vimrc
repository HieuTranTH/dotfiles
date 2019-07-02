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
nnoremap j gj
nnoremap k gk

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

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
set t_Co=256
set background=dark
" set background=light
let g:solarized_termcolors=256
let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
colorscheme solarized

"##############################################################################
" Start of Hieu's custome Configurations
"##############################################################################

" highlight current line
set cursorline
" highlight current column
set cursorcolumn
" display right margin (72 for git commit message, 80 for normal source code)
set colorcolumn=72,80

" open completion menu on statusline
set wildmenu
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
set statusline+=%#PmenuSel#
"set statusline+=%{StatuslineGit()}
" set statusline+=%#LineNr#
set statusline+=%#StatusLine#
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
" set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 
" End of customized statusline

" Highlight trailing whitespaces in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

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
autocmd BufWinLeave *.c mkview
autocmd BufWinEnter *.c silent loadview

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

"##############################################################################
" End of Hieu's custome Configurations
"##############################################################################
