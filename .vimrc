"plug vim
set nocompatible
call plug#begin('~/.vim/plugged')
Plug 'nathanaelkane/vim-indent-guides'
Plug 'mattn/emmet-vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'lilydjwg/colorizer'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'thinca/vim-quickrun'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kaicataldo/material.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'jiangmiao/auto-pairs'
Plug 'morhetz/gruvbox'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'markdown', 'yaml'] }
Plug 'mlaursen/vim-react-snippets'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/rainbow_parentheses.vim'
call plug#end()

filetype plugin indent on

augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,javascript,scheme RainbowParentheses
augroup END

"vim-prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.md Prettier

"Airline
set guifont=Hack\ Bold\ Nerd\ Font\ Complete:h12
let g:airline#extensions#tabline#enabled = 1

"Coc 
set hidden
set nobackup
set nowritebackup
set updatetime=300
set redrawtime=10000

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-css',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-stylelint',
  \ 'coc-json',
  \ ]

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

"JavaScript
let g:javascript_plugin_jsdoc = 1

"JSX
let g:jsx_ext_required = 0

"CSS syntax
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END

"Vim-fugitive
autocmd QuickFixCmdPost *grep* cwindow

"Vim-indent-guides
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=darkgrey
let g:indent_guides_start_level=1
let g:indent_guides_guide_size=1

"Emmet trigger
let g:user_emmet_expandabbr_key='<c-t>'

"NERD tree
"autocmd vimenter * NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd vimenter * if !argc() | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


let g:NERDTreeHighlightFolders = 1 
let g:NERDTreeHighlightFoldersFullName = 1  

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeLimitedSyntax = 1

" vim-devicons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_airline_statusline = 1

let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

syntax on

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set background=dark
let g:material_theme_style = 'palenight'
"let g:material_theme_style = 'gruvbox'
colorscheme material
"colorscheme gruvbox

"Setting Vim
set ambiwidth=double
set fileencodings=utf-8,cp932,euc-jp,sjis
set encoding=utf8
set completeopt=menu,preview
"Use mouse
set mouse=a
"Spell check except for Asian language
set spelllang+=cjk
"Spell check
set spell
set expandtab
set title
set shiftwidth=2
set wrapmargin=10
set tabstop=2
set softtabstop=2
set backspace=indent,eol,start
set laststatus=2
"Repeat Searching
set wrapscan
"Highlight search result
set hlsearch
"Search increment
set incsearch
set ignorecase
"If sentence have wide more than windows, show the next line
set wrap
"Show number status line(right bottom)
set ruler
"Set line number
set number
"Highlight match parentheses
set showmatch
set matchtime=1
set smarttab
set smartcase
"set paste
set autoindent
"beautiful new line
set breakindent
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -nh
""for xterm, screen
set ttymouse=xterm2

"for slow scroll change regex engine
set regexpengine=1

"if() indent
set cindent
"command-line completion like zsh
set wildmenu
set wildmode=list:full
"Disable beep and flash
set noeb vb t_vb=
set history=1000

"Do not add end of sentence \n
set nofixeol

"Auto change directory
set autochdir

"set path
set path+=**

"leader key
let mapleader = "\<Space>"
"open file
nnoremap <Leader>o :FZF<CR>

"Move in the insert mode
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$<Right>
inoremap <C-d> <Del>
inoremap <C-k> <C-o>D<Right>
inoremap <C-u> <C-o>d^
inoremap <C-w> <C-o>db
inoremap <C-B> <Left>
inoremap <C-F> <Right>
inoremap <C-n> <UP>
inoremap <C-p> <DOWN>

"Move to new cursor
noremap <C-i> <C-i>

"shortcut for buffer moving
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

"Clear highlight of search
nnoremap <ESC><ESC> :nohlsearch<CR>

" newtrw
let g:netrw_preview=1
