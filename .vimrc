"plug vim
set nocompatible
call plug#begin('~/.vim/plugged')
Plug 'digitaltoad/vim-pug'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'mattn/emmet-vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'lilydjwg/colorizer'
Plug 'w0rp/ale'
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
Plug 'mxw/vim-jsx'
Plug 'fatih/vim-go'
Plug 'terryma/vim-multiple-cursors'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --go-completer --ts-completer' }
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'altercation/vim-colors-solarized'
Plug 'leafgarland/typescript-vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
call plug#end()

filetype plugin indent on

"vim-prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier


"vim-multiple-cursors
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

"Airline
set guifont=Hack\ Bold\ Nerd\ Font\ Complete:h12
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_theme = 'gruvbox'
let g:airline_enable_branch=1
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#error_symbol = ' '
let g:airline#extensions#ale#warning_symbol = ' '
let g:airline#extensions#ale#enabled = 1
nmap <Tab> <Plug>AirlineSelectPrevTab
nmap <S-Tab> <Plug>AirlineSelectNextTab

"ale
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'sass': ['stylelint'],
\   'php': ['phpcs', 'php']
\}
let g:ale_fixers = {
\ 'javascript': ['prettier','eslint']
\ }
let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 1
let g:ale_open_list = 1
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_pattern_options = {
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.html$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" PSR-1,2のチェックをおこなう
let g:ale_php_phpcs_standard = 'PSR1,PSR2'

"JavaScript
let g:javascript_plugin_jsdoc = 1

"JSX
let g:jsx_ext_required = 0

"CSS syntax
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END

"css complete
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

"html complete
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

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
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" vim-devicons
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_airline_statusline = 1

"gruvbox
syntax on
colorscheme gruvbox
set background=dark
let g:ligthline = { 'colorscheme': 'gruvbox' }

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
nnoremap <ESC><ESC> :nohlsearch<CR>
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

"Auto brackets
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap <> <><LEFT>

"Move in the insert mode
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$<Right>
inoremap <C-d> <Del>
inoremap <C-k> <C-o>D<Right>
inoremap <C-u> <C-o>d^
inoremap <C-w> <C-o>db
